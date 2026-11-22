-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T21:11:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialToastParent = script:FindFirstAncestor("SocialToast").Parent
local NavigationRodux = require(SocialToastParent.NavigationRodux)
local React = require(SocialToastParent.React)
local RoactUtils = require(SocialToastParent.RoactUtils)
local AppPage = require(SocialToastParent.RobloxAppEnums).AppPage
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local NavigateDown = NavigationRodux.Thunks.NavigateDown
local FFlagSignalsNavP3Dispatch = require(SocialToastParent.SharedFlags).FFlagSignalsNavP3Dispatch
local NavigationCommands = if FFlagSignalsNavP3Dispatch then require(SocialToastParent.RobloxAppNavigation).NavigationCommands else nil

return function()
    local var1 = useDispatch()

    return React.useCallback(function(toastContent)
        local tbl1 = {
            name = AppPage.SocialToast,
            extraProps = { toastContent = toastContent }
        }

        if FFlagSignalsNavP3Dispatch then
            NavigationCommands.down(NavigationCommands.fromLegacyPage(tbl1))
            return
        end
        var1(NavigateDown(tbl1, nil))
    end, {})
end
