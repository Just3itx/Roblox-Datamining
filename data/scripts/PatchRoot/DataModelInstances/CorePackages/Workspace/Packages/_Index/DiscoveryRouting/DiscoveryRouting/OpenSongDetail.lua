-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T11:01:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DiscoveryRoutingParent = script:FindFirstAncestor("DiscoveryRouting").Parent
local AppPage = require(DiscoveryRoutingParent.RobloxAppEnums).AppPage
local NavigateDown = require(DiscoveryRoutingParent.NavigationRodux).Thunks.NavigateDown
local FFlagSignalsNavP3Dispatch = require(DiscoveryRoutingParent.SharedFlags).FFlagSignalsNavP3Dispatch
local NavigationCommands = if FFlagSignalsNavP3Dispatch then require(DiscoveryRoutingParent.RobloxAppNavigation).NavigationCommands else nil

return function(songId: string)
    return function(arg1)
        local tbl1 = {
            name = AppPage.SongDetail,
            songId = songId
        }
        if FFlagSignalsNavP3Dispatch then
            NavigationCommands.down(NavigationCommands.fromLegacyPage(tbl1))
            return
        end
        arg1:dispatch(NavigateDown(tbl1))
    end
end
