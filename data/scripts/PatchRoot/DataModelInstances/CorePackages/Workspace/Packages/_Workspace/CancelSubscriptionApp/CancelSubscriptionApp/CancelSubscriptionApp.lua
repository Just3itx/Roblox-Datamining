-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T23:10:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GuiService = game:GetService("GuiService")

local CancelSubscriptionApp = script:FindFirstAncestor("CancelSubscriptionApp")
local CancelSubscriptionAppParent = CancelSubscriptionApp.Parent
local React = require(CancelSubscriptionAppParent.React)
local useSelector = require(CancelSubscriptionAppParent.RoactUtils).Hooks.RoactRodux.useSelector

local CancelUserSubscriptionRequestContainer = require(CancelSubscriptionApp.Features.CancelSubscriptionRequest.CancelUserSubscriptionRequestContainer)

local CancelUserSubscriptionErrorContainer = require(CancelSubscriptionApp.Features.CancelSubscriptionError.CancelUserSubscriptionErrorContainer)

local CancelUserSubscriptionSuccessContainer = require(CancelSubscriptionApp.Features.CancelSubscriptionSuccess.CancelUserSubscriptionSuccessContainer)
local ScreenSizeContext = require(CancelSubscriptionAppParent.EconomyCommonCoreScriptHooks).ScreenSizeContext
local useCancelSubscriptionRequestedListenerEffect = require(CancelSubscriptionApp.Hooks.useCancelSubscriptionRequestedListenerEffect)
local selectPromptState = require(CancelSubscriptionApp.Store.Selectors.selectPromptState)
local CancelUserSubscriptionAsyncPromptStateEnum = require(CancelSubscriptionApp.Enums.CancelUserSubscriptionAsyncPromptStateEnum)
local FocusNavigationModalSurface = require(CancelSubscriptionAppParent.EconomyCommonCoreScriptHooks).FocusNavigationModalSurface

local function CancelSubscriptionApp2()
    local value, var2 = React.useState(Vector2.new(0, 0))
    local var3 = useSelector(selectPromptState)

    useCancelSubscriptionRequestedListenerEffect(var3)

    React.useEffect(function()
        if var3 == CancelUserSubscriptionAsyncPromptStateEnum.None then
            GuiService.SelectedCoreObject = nil
        end
    end, { var3 })
    if var3 == CancelUserSubscriptionAsyncPromptStateEnum.None then
        return nil
    end

    local createElement = React.createElement
    local provider = ScreenSizeContext.Provider
    local tbl1 = { value = value }
    local createElement2 = React.createElement
    local str1 = "ScreenGui"
    local tbl2 = {}
    tbl2[React.Change.AbsoluteSize] = function(arg1)
        var2(arg1.AbsoluteSize)
    end
    tbl2.ScreenInsets = Enum.ScreenInsets.None
    local tbl3 = {
        FocusNavigationEffects = React.createElement(
            FocusNavigationModalSurface,
            { selectionGroupName = "CancelSubscriptionApp" },
            {
                Error = if var3 == CancelUserSubscriptionAsyncPromptStateEnum.Error then React.createElement(CancelUserSubscriptionErrorContainer) else nil,
                Success = if var3 == CancelUserSubscriptionAsyncPromptStateEnum.Success then React.createElement(CancelUserSubscriptionSuccessContainer) else nil,
                Request = if var3 == CancelUserSubscriptionAsyncPromptStateEnum.Request then React.createElement(CancelUserSubscriptionRequestContainer) else nil
            }
        )
    }
    return (createElement(provider, tbl1, createElement2(str1, tbl2, tbl3)))
end

return CancelSubscriptionApp2
