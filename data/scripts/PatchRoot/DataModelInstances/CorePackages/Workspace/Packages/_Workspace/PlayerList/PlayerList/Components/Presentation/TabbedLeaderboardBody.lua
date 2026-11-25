-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T03:04:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local React = require(scriptParentParentParentParent.React)
local Cryo = require(scriptParentParentParentParent.Cryo)
local Signals = require(scriptParentParentParentParent.Signals)
local View = require(scriptParentParentParentParent.Foundation).View

local LeaderboardTabsBody = require(scriptParentParentParent.Components.Presentation.LeaderboardTabsBody)
local usePlatformLeaderboard = require(scriptParentParentParent.Hooks.usePlatformLeaderboard)
local FallbackSignals = require(scriptParentParentParent.Common.FallbackSignals)
local FFlagPlayerListReskin = require(scriptParentParentParent.Flags.FFlagPlayerListReskin)

local LeaderboardViewChangeTelemetry = nil
local function getLeaderboardViewChangeTelemetry() -- Luacid: Inlined by compiler; 3 call sites recovered
    if LeaderboardViewChangeTelemetry == nil then
        LeaderboardViewChangeTelemetry = require(scriptParentParentParent.Common.LeaderboardViewChangeTelemetry)
    end
    return LeaderboardViewChangeTelemetry
end

return React.memo(function(tbl1) -- name: TabbedLeaderboardBody
    local activeTabId, var2 = React.useState("server")
    local var3

    if FFlagPlayerListReskin then
        local var4 = usePlatformLeaderboard()
        local getHasActiveLeaderboard = if var4 ~= nil then var4.getHasActiveLeaderboard else FallbackSignals.getHasActiveLeaderboard

        React.useEffect(function()
            return Signals.createEffect(function(arg1)
                local hasActiveLeaderboard = getHasActiveLeaderboard(arg1)
                getLeaderboardViewChangeTelemetry().setCurrentTab(if hasActiveLeaderboard then activeTabId else nil)
            end)
        end, { activeTabId, getHasActiveLeaderboard })

        React.useEffect(function()
            return function()
                getLeaderboardViewChangeTelemetry().clearCurrentTab()
            end
        end, {})

        var3 = React.useCallback(function(str1: string)
            if str1 ~= activeTabId then
                getLeaderboardViewChangeTelemetry().logSwitchTab(str1)
            end
            var2(str1)
        end, { activeTabId })
    else
        var3 = var2
    end

    local onPlatformTabsUnavailable = React.useCallback(function()
        var2("server")
    end, {})

    local tbl2 = {
        Header = tbl1.panelHeader,
        HeaderDivider = tbl1.panelDivider,
        LeaderboardTabsBody = React.createElement(LeaderboardTabsBody, {
            activeTabId = activeTabId,
            onActivated = var3,
            onPlatformTabsUnavailable = onPlatformTabsUnavailable,
            serverBody = tbl1.serverBody
        })
    }
    if tbl1.children then
        tbl2 = Cryo.Dictionary.join(tbl2, tbl1.children)
    end
    return React.createElement(View, tbl1.panelProps, tbl2)
end)
