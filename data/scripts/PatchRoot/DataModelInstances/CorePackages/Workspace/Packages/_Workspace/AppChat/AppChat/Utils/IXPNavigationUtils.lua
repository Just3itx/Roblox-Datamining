-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:41:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local IXPService = game:GetService("IXPService")
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local React = require(AppChatParent.React)
local RoactNavigation = require(AppChatParent.RoactNavigation)
local useNavigation = require(AppChatParent.Navigation).useNavigation

local module = {
    ExposureKind = {
        FlagLinked = "FlagLinked",
        BrowserTracker = "BrowserTracker",
        UserLayer = "UserLayer",
        Creator = "Creator"
    }
}

local tbl1 = {
    remove = function() end
}

local tbl2 = {
    [module.ExposureKind.FlagLinked] = "LogFlagLinkedUserLayerExposure",
    [module.ExposureKind.BrowserTracker] = "LogBrowserTrackerLayerExposure",
    [module.ExposureKind.UserLayer] = "LogUserLayerExposure",
    [module.ExposureKind.Creator] = "LogCreatorLayerExposure"
}

local ixpService = IXPService

local function normalizeLayers(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    return if type(arg1) == "string" then { arg1 } else arg1
end

local function isAnyFlagEnabled(arg1) -- Luacid: Inlined by compiler; 3 call sites recovered
    if arg1 == nil then
        return true
    end

    if type(arg1) == "boolean" then
        return arg1
    end

    for _, value in arg1 do
        if value then
            return true
        end
    end

    return false
end

local function logExposure(tbl3, arg1)
    local var1 = arg1 or module.ExposureKind.FlagLinked

    for _, value in tbl3 do
        local var2 = tbl2[var1]
        local var3 = if var2 then ixpService[var2] else nil

        if var3 then
            var3(ixpService, value)
        end
    end
end

function module.createExposureHandler(arg1, tbl3)
    local var1 = normalizeLayers(arg1)
    local flags = if tbl3 then tbl3.flags else nil
    local kind = if tbl3 then tbl3.kind else nil

    return function()
        if isAnyFlagEnabled(flags) then
            logExposure(var1, kind)
        end
    end
end

function module.useExposureOnFocus(arg1, tbl3)
    local var1 = useNavigation()
    local flags = if tbl3 then tbl3.flags else nil
    local kind = if tbl3 then tbl3.kind else nil

    React.useEffect(function()
        if not (var1 and isAnyFlagEnabled(flags)) then
            return nil
        end

        local exposureHandler = module.createExposureHandler(arg1, { flags = flags, kind = kind })

        local var2 = var1.addListener(RoactNavigation.Events.WillFocus, exposureHandler)

        if var1.isFocused and var1.isFocused() then
            exposureHandler()
        end

        return function()
            var2.remove()
        end
    end, {
        var1,
        arg1,
        flags,
        kind
    })
end

function module.registerExposureOnFocus(tbl3, arg1, tbl4)
    if not tbl3 then
        return tbl1
    end

    local flags = if tbl4 then tbl4.flags else nil

    if not isAnyFlagEnabled(flags) then
        return tbl1
    end

    return tbl3.addListener(RoactNavigation.Events.WillFocus, module.createExposureHandler(arg1, tbl4))
end

function module.setMocksForTesting(arg1)
    ixpService = arg1 or ixpService
end

function module.restoreDefaultsAfterTesting()
    ixpService = IXPService
end

return module
