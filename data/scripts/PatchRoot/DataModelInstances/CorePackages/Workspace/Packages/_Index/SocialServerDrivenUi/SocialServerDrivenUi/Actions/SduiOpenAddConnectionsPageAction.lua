-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T19:50:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialServerDrivenUiParent = script:FindFirstAncestor("SocialServerDrivenUi").Parent
local AppPage = require(SocialServerDrivenUiParent.RobloxAppEnums).AppPage
local NavigateDown = require(SocialServerDrivenUiParent.NavigationRodux).Thunks.NavigateDown
local _SduiCoreSystem = require(SocialServerDrivenUiParent.SduiCoreSystem)

local FFlagCreateConnectionsHub = require(SocialServerDrivenUiParent.SharedFlags).FFlagCreateConnectionsHub
local FFlagSignalsNavP3Dispatch = require(SocialServerDrivenUiParent.SharedFlags).FFlagSignalsNavP3Dispatch
local NavigationCommands = if FFlagSignalsNavP3Dispatch then require(SocialServerDrivenUiParent.RobloxAppNavigation).NavigationCommands else nil

return function(_, _, arg1, _)
    if FFlagCreateConnectionsHub then
        arg1.dependencies.getNavigation().navigate(AppPage.CoHubAddConnections)
        return
    end
    local tbl1 = {
        name = AppPage.AddFriendsPage
    }
    if FFlagSignalsNavP3Dispatch then
        NavigationCommands.down(NavigationCommands.fromLegacyPage(tbl1))
        return
    end
    arg1.dependencies.dispatch(NavigateDown(tbl1))
end
