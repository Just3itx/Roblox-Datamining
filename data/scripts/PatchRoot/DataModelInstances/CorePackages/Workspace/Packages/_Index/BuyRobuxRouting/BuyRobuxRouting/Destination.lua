-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T06:00:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuyRobuxRouting = script:FindFirstAncestor("BuyRobuxRouting")
local BuyRobuxRoutingParent = BuyRobuxRouting.Parent

local ContentProvider = game:GetService("ContentProvider")
local HttpService = game:GetService("HttpService")

local SharedFlags = require(BuyRobuxRoutingParent.SharedFlags)
local IXPServiceWrapper = require(BuyRobuxRoutingParent.IxpServiceWrapper).IXPServiceWrapper
local getAppFeaturePolicies = require(BuyRobuxRoutingParent.UniversalAppPolicy).getAppFeaturePolicies

local isSduiBuyRobuxSupported = require(BuyRobuxRouting.isSduiBuyRobuxSupported)
local FFlagBuyRobuxRoutingAppendWebContext = require(BuyRobuxRouting.Flags.FFlagBuyRobuxRoutingAppendWebContext)

local FFlagEnableBuyRobuxNextJS = SharedFlags.FFlagEnableBuyRobuxNextJS
local FFlagBuyRobuxLatencyIxpEnabled = SharedFlags.FFlagBuyRobuxLatencyIxpEnabled
local FFlagEnableBuyRobuxSdui = SharedFlags.FFlagEnableBuyRobuxSdui
local FStringPaymentsBuyRobuxLayer = SharedFlags.FStringPaymentsBuyRobuxLayer
local FFlagBypassBuyRobuxSduiSupportForWebRouting = SharedFlags.FFlagBypassBuyRobuxSduiSupportForWebRouting
local logBuyRobuxRoutingDecision = require(script.Parent.logBuyRobuxRoutingDecision)

local var1 = string.gsub(ContentProvider.BaseUrl:lower(), "/m.", "/www.")

local function isExcludedRegion() -- Luacid: Inlined by compiler; 2 call sites recovered
    local appFeaturePolicies = getAppFeaturePolicies()
    return appFeaturePolicies.useLuobuAuthentication()
        or appFeaturePolicies.getUseVNGUserAgreementPopup()
        or appFeaturePolicies.getRedirectBuyRobuxToVNG()
        or appFeaturePolicies.getShowVNGTosForRobuxUpsell()
end

local function buildUrl(str1: string, tbl1)
    local tbl2 = {}
    if tbl1.analyticId ~= nil then
        table.insert(tbl2, "analyticId=" .. HttpService:UrlEncode(tbl1.analyticId))
    end
    if tbl1.productId ~= nil then
        table.insert(tbl2, "product_id=" .. HttpService:UrlEncode(tbl1.productId))
    end

    local str2 = if #tbl2 > 0 then "?" .. table.concat(tbl2, "&") else ""
    return var1 .. str1 .. str2
end

local function appendRoutingContext(url: string, input: string?): string
    local tbl1 = {}
    if input ~= nil then
        table.insert(tbl1, "variant=" .. HttpService:UrlEncode(input))
    end
    table.insert(tbl1, "startMs=" .. tostring(DateTime.now().UnixTimestampMillis))
    return url .. (if string.find(url, "?", 1, true) then "&" else "?") .. table.concat(tbl1, "&")
end

local function webDestination(url: string, shouldExpose: boolean) -- Luacid: Inlined by compiler; 8 call sites recovered
    return { kind = "web", url = url, shouldExpose = shouldExpose }
end

local function fallbackWebUrl(tbl1) -- Luacid: Inlined by compiler; 1 call site recovered
    return (buildUrl("upgrades/robux", tbl1))
end

local function resolveDestination(tbl1)
    local var2 = fallbackWebUrl(tbl1)

    if isExcludedRegion() then
        logBuyRobuxRoutingDecision("controlWeb", "excludedRegion")
        return webDestination(var2, false)
    elseif not (FFlagBypassBuyRobuxSduiSupportForWebRouting or isSduiBuyRobuxSupported()) then
        logBuyRobuxRoutingDecision("controlWeb", "sduiNotSupported")
        return webDestination(var2, false)
    elseif FFlagEnableBuyRobuxSdui then
        logBuyRobuxRoutingDecision("nativeSdui", "experimentArm")
        return { kind = "native", shouldExpose = FFlagBuyRobuxLatencyIxpEnabled }
    elseif FFlagEnableBuyRobuxNextJS then
        logBuyRobuxRoutingDecision("nextJsWeb", "experimentArm")
        return webDestination(buildUrl("upgrades/robux/v2", tbl1), FFlagBuyRobuxLatencyIxpEnabled)
    else
        logBuyRobuxRoutingDecision("controlWeb", "experimentArm")
        return webDestination(var2, FFlagBuyRobuxLatencyIxpEnabled)
    end
end

local function logExposure(tbl1) -- Luacid: Inlined by compiler; 1 call site recovered
    if tbl1.shouldExpose and FStringPaymentsBuyRobuxLayer ~= "" then
        IXPServiceWrapper:LogFlagLinkedUserLayerExposure(FStringPaymentsBuyRobuxLayer)
    end
end

local func1 = FFlagBuyRobuxRoutingAppendWebContext and function(tbl1) -- name: resolveDestinationWithWebContext
    if isExcludedRegion() then
        logBuyRobuxRoutingDecision("controlWeb", "excludedRegion")
        return webDestination(appendRoutingContext(buildUrl("upgrades/robux", tbl1), nil), false)
    elseif not (FFlagBypassBuyRobuxSduiSupportForWebRouting or isSduiBuyRobuxSupported()) then
        logBuyRobuxRoutingDecision("controlWeb", "sduiNotSupported")
        return webDestination(appendRoutingContext(buildUrl("upgrades/robux", tbl1), nil), false)
    elseif FFlagEnableBuyRobuxSdui then
        logBuyRobuxRoutingDecision("nativeSdui", "experimentArm")
        return { kind = "native", shouldExpose = FFlagBuyRobuxLatencyIxpEnabled }
    elseif FFlagEnableBuyRobuxNextJS then
        logBuyRobuxRoutingDecision("nextJsWeb", "experimentArm")

        return webDestination(appendRoutingContext(buildUrl("upgrades/robux/v2", tbl1), "nextjs"), FFlagBuyRobuxLatencyIxpEnabled)
    else
        logBuyRobuxRoutingDecision("controlWeb", "experimentArm")

        return webDestination(appendRoutingContext(buildUrl("upgrades/robux", tbl1), "control"), FFlagBuyRobuxLatencyIxpEnabled)
    end
end or resolveDestination

return {
    fallbackWebUrl = fallbackWebUrl,
    resolveDestination = func1,
    logExposure = logExposure,
    resolveAndLogDestination = function(tbl1)
        local var2 = if FFlagBuyRobuxRoutingAppendWebContext then func1(tbl1) else resolveDestination(tbl1)
        logExposure(var2)
        return var2
    end
}
