-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:31:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local PurchasePromptParent = PurchasePrompt.Parent
local ContentProvider = game:GetService("ContentProvider")
local GuiService = game:GetService("GuiService")
local Base64 = require(PurchasePrompt.Utils.Base64)
local PurchaseFlow = require(PurchasePrompt.Enums.PurchaseFlow)
local Constants = require(PurchasePrompt.Misc.Constants)
local MarketplaceService = game:GetService("MarketplaceService")
local BrowserService = game:GetService("BrowserService")
local HttpService = game:GetService("HttpService")
local PlatformService = nil

pcall(function()
    PlatformService = game:GetService("PlatformService")
end)

local SharedFlags = require(PurchasePromptParent.SharedFlags)
local GetFStringVNGWebshopUrl = SharedFlags.GetFStringVNGWebshopUrl
local function isInExperienceBuyRobuxRoutingEnabled() -- Luacid: Inlined by compiler; 4 call sites recovered
    return SharedFlags.FFlagEnableBuyRobuxNewRouting and SharedFlags.FFlagEnableBuyRobuxNewRoutingInExperience
end

local UrlBuilder = require(PurchasePromptParent.PurchasePromptDeps).UrlBuilder.UrlBuilder

local var1 = string.gsub(ContentProvider.BaseUrl:lower(), "/m.", "/www.")

local module = {}

local function addContextToUrl(str1: string, tbl1): string
    for value, value2 in tbl1 do
        if not value2 then
            continue
        end

        if str1:find("?") then
            str1 ..= ("&%s=%s"):format(value, value2)
        else
            str1 ..= ("?%s=%s"):format(value, value2)
        end
    end

    return str1
end

function module.new()
    local module2 = {}

    setmetatable(module2, {
        __tostring = function(): string
            return "Service(PlatformInterface)"
        end
    })

    function module2.startRobuxUpsellWebByFlow(arg1, productId: string)
        if arg1 == PurchaseFlow.RobuxUpsellV2 or arg1 == PurchaseFlow.LargeRobuxUpsell then
            GuiService:OpenBrowserWindow(("%supgrades/paymentmethods?ap=%s"):format(var1, productId))
            return
        end

        if not isInExperienceBuyRobuxRoutingEnabled() then
            GuiService:OpenBrowserWindow(("%sUpgrades/Robux.aspx?product_id=%s"):format(var1, productId))
            return
        end

        require(PurchasePromptParent.BuyRobuxInExperience).openBuyRobux({ productId = productId }, function(url: string)
            GuiService:OpenBrowserWindow(url)
        end, "PurchasePrompt.startRobuxUpsellWebByFlow")
    end

    function module2.startRobuxUpsellWebByFlowWithContext(tbl1, arg1, productId: string)
        local bool1 = arg1 == PurchaseFlow.RobuxUpsellV2 or arg1 == PurchaseFlow.LargeRobuxUpsell

        if not isInExperienceBuyRobuxRoutingEnabled() or bool1 then
            local str1 = if bool1 then ("%supgrades/paymentmethods?ap=%s"):format(var1, productId) else ("%sUpgrades/Robux.aspx?product_id=%s"):format(var1, productId)
            local url = addContextToUrl(str1, tbl1)
            GuiService:OpenBrowserWindow(url)
            return
        end

        require(PurchasePromptParent.BuyRobuxInExperience).openBuyRobux(
            {
                productId = productId,
                analyticId = tbl1.analyticId
            },
            function(url: string)
                GuiService:OpenBrowserWindow(url)
            end,
            "PurchasePrompt.startRobuxUpsellWebByFlowWithContext"
        )
    end

    function module2.openSecuritySettings(str1: string?)
        if str1 then
            local var2 = Base64.Encode(str1)
            local url = ("%smy/account?challenge=%s#!/security"):format(var1, var2)
            GuiService:OpenBrowserWindow(url)
            return
        end
        local url = ("%smy/account#!/security"):format(var1)
        GuiService:OpenBrowserWindow(url)
    end

    function module2.openTermsOfUse()
        local url = UrlBuilder.static.about.terms()

        GuiService:OpenBrowserWindow(url)
    end

    function module2.openTermsOfUseDMCCA()
        local command = HttpService:JSONEncode({ command = "open", url = Constants.TermsOfUse.DMCCAUrl })

        BrowserService:SendCommand(command)
    end

    function module2.openRobuxStore()
        if not isInExperienceBuyRobuxRoutingEnabled() then
            GuiService:OpenBrowserWindow(("%sUpgrades/Robux.aspx"):format(var1))

            return
        end

        require(PurchasePromptParent.BuyRobuxInExperience).openBuyRobux({}, function(url: string)
            GuiService:OpenBrowserWindow(url)
        end, "PurchasePrompt.openRobuxStore")
    end
    function module2.openRobuxStoreWithContext(tbl1, productId: string?)
        if isInExperienceBuyRobuxRoutingEnabled() then
            require(PurchasePromptParent.BuyRobuxInExperience).openBuyRobux(
                {
                    productId = productId,
                    analyticId = tbl1.analyticId
                },
                function(url: string)
                    GuiService:OpenBrowserWindow(url)
                end,
                "PurchasePrompt.openRobuxStoreWithContext"
            )

            return
        end

        local str1 = ("%sUpgrades/Robux.aspx"):format(var1)
        if productId then
            str1 ..= ("?product_id=%s"):format(productId)
        end
        local url = addContextToUrl(str1, tbl1)
        GuiService:OpenBrowserWindow(url)
    end

    function module2.openPaymentsPageWithContext(tbl1, str1: string)
        local str2 = ("%supgrades/paymentmethods?ap=%s"):format(var1, str1)
        local url = addContextToUrl(str2, tbl1)
        GuiService:OpenBrowserWindow(url)
    end

    function module2.promptNativePurchaseWithLocalPlayer(productId: string)
        return MarketplaceService:PromptNativePurchaseWithLocalPlayer(productId)
    end

    function module2.promptNativePurchase(player: Instance, productId: string)
        return MarketplaceService:PromptNativePurchase(player, productId)
    end

    function module2.beginPlatformStorePurchase(arg1)
        return PlatformService:BeginPlatformStorePurchase(arg1)
    end

    function module2.openVngStore(url: string)
        url = url and url ~= "" and url or GetFStringVNGWebshopUrl()

        GuiService:OpenBrowserWindow(url)
    end

    return module2
end

return module
