-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T01:01:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TrustedContactsParent = script:FindFirstAncestor("TrustedContacts").Parent

local React = require(TrustedContactsParent.React)
local AppPage = require(TrustedContactsParent.RobloxAppEnums).AppPage
local useLocalization = require(TrustedContactsParent.Localization).Hooks.useLocalization
local useDispatch = require(TrustedContactsParent.RoactUtils).Hooks.RoactRodux.useDispatch
local SetCurrentToastMessage = require(TrustedContactsParent.ToastRodux).Actions.SetCurrentToastMessage
local Sources = require(TrustedContactsParent.SocialLuaAnalytics).Analytics.Enums.Sources

local NavigateDown = require(TrustedContactsParent.NavigationRodux).Thunks.NavigateDown
local FFlagSignalsNavP3Dispatch = require(TrustedContactsParent.SharedFlags).FFlagSignalsNavP3Dispatch
local NavigationCommands = if FFlagSignalsNavP3Dispatch then require(TrustedContactsParent.RobloxAppNavigation).NavigationCommands else nil

return function()
    local var1 = useDispatch()

    local var2 = useLocalization({ somethingIsWrongToast = "Feature.Toast.NetworkingError.SomethingIsWrong" })

    return (React.useCallback(function(tbl1)
        local callback = tbl1 and tbl1.callback
        local senderUserid = tbl1 and tbl1.clientEventsPayload and tbl1.clientEventsPayload.sender_userid

        if not senderUserid then
            var1(SetCurrentToastMessage({ toastMessage = var2.somethingIsWrongToast, isLocalized = true }))

            return
        end

        local tbl2 = {
            name = AppPage.TrustedContactsModal,
            props = {
                userId = senderUserid,
                source = Sources.StreamNotification,
                onRequestAccepted = callback
            }
        }
        if FFlagSignalsNavP3Dispatch then
            NavigationCommands.down(NavigationCommands.fromLegacyPage(tbl2), true)
            return
        end
        var1(NavigateDown(tbl2, true))
    end, { var1, var2 }))
end
