-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:31:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local AppPage = require(AppChatParent.RobloxAppEnums).AppPage
local Selectors = require(AppChatParent.NavigationRodux).Selectors
local SharedFlags = require(AppChatParent.SharedFlags)
local FFlagUseNavigationSelectors = SharedFlags.FFlagUseNavigationSelectors
local FFlagSignalsNavP3hMisc = SharedFlags.FFlagSignalsNavP3hMisc
local useSelector = require(AppChatParent.RoactUtils).Hooks.RoactRodux.useSelector

local useSignalState = require(AppChatParent.SignalsReact).useSignalState
local React = require(AppChatParent.React)
local Signals = require(AppChatParent.Signals)
local GetLegacyNavigationStore = if FFlagSignalsNavP3hMisc then require(AppChatParent.NavigationRodux).GetLegacyNavigationStore else nil
local isNavigationAvailable = if FFlagSignalsNavP3hMisc then require(AppChatParent.RobloxAppNavigation).isNavigationAvailable else nil

return function()
    if FFlagSignalsNavP3hMisc then
        local legacyNavigationStore = GetLegacyNavigationStore(false)
        local var1 = React.useMemo(function()
            return Signals.createComputed(function(arg1): boolean
                return not isNavigationAvailable() or legacyNavigationStore.getCurrentPageName(arg1) == AppPage.Chat
            end)
        end, {})
        return useSignalState(var1)
    end
    return useSelector(function(arg1): boolean
        if not arg1.Navigation then
            return true
        end
        if FFlagUseNavigationSelectors then
            return Selectors.selectCurrentPageName(arg1) == AppPage.Chat
        end
        local history = arg1.Navigation.history
        if not history then
            return false
        end
        local var1 = history[#history]
        return (var1[#var1] and var1[#var1].name) == AppPage.Chat
    end)
end
