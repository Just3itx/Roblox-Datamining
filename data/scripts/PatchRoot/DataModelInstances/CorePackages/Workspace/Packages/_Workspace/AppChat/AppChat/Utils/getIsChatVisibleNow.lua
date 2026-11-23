-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:40:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local AppPage = require(AppChatParent.RobloxAppEnums).AppPage
local FFlagSignalsNavP3hMisc = require(AppChatParent.SharedFlags).FFlagSignalsNavP3hMisc
local GetLegacyNavigationStore = if FFlagSignalsNavP3hMisc then require(AppChatParent.NavigationRodux).GetLegacyNavigationStore else nil
local isNavigationAvailable = if FFlagSignalsNavP3hMisc then require(AppChatParent.RobloxAppNavigation).isNavigationAvailable else nil

return {
    getIsChatVisibleNow = function(): boolean
        return not isNavigationAvailable() or GetLegacyNavigationStore(false).getCurrentPageName(false) == AppPage.Chat
    end,
    isChatVisible = function(arg1): boolean
        return not isNavigationAvailable() or GetLegacyNavigationStore(false).getCurrentPageName(arg1) == AppPage.Chat
    end
}
