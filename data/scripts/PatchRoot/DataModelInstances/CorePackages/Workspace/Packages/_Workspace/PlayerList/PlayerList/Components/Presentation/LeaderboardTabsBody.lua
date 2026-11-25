-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T03:01:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local React = require(scriptParentParentParentParent.React)
local _Signals = require(scriptParentParentParentParent.Signals)
local SignalsReact = require(scriptParentParentParentParent.SignalsReact)

local PlayerListVisibilityStore = require(scriptParentParentParent.Common.PlayerListVisibilityStore)
local LeaderboardTabs = require(scriptParentParentParent.Components.Presentation.LeaderboardTabs)
local PlatformLeaderboardView = require(scriptParentParentParent.Components.Presentation.PlatformLeaderboardView)

return React.memo(function(tbl1) -- name: LeaderboardTabsBody
    local getEffectiveVisible = tbl1.getEffectiveVisible or PlayerListVisibilityStore.getEffectiveVisible

    local var1 = SignalsReact.useSignalState(getEffectiveVisible)
    local var2

    if tbl1.activeTabId == "server" or not var1 then
        var2 = tbl1.serverBody
    else
        local tab = if tbl1.activeTabId == "friends" then "Friends" else "Global"
        var2 = React.createElement(PlatformLeaderboardView, { tab = tab, layoutOrder = tbl1.bodyLayoutOrder or 4 })
    end

    return React.createElement(React.Fragment, nil, {
        LeaderboardTabs = React.createElement(LeaderboardTabs, {
            activeTabId = tbl1.activeTabId,
            onActivated = tbl1.onActivated,
            onPlatformTabsUnavailable = tbl1.onPlatformTabsUnavailable,
            layoutOrder = tbl1.tabsLayoutOrder or 3
        }),
        LeaderboardBody = var2
    })
end)
