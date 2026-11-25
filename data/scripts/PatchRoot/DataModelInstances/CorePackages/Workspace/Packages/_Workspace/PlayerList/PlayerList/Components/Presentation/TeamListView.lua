-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T03:04:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local React = require(scriptParentParentParentParent.React)
local Signals = require(scriptParentParentParentParent.Signals)
local SignalsReact = require(scriptParentParentParentParent.SignalsReact)
local View = require(scriptParentParentParentParent.Foundation).View

local _LeaderboardStore = require(scriptParentParentParentParent.LeaderboardStore)

local TeamEntryView = require(scriptParentParentParent.Components.Presentation.TeamEntryView)
local EntryView = require(scriptParentParentParent.Components.Presentation.EntryView)
local _computeStatColumns = require(scriptParentParentParent.Common.computeStatColumns)

local signal = Signals.createSignal({})
local signal2 = Signals.createSignal(0)

return React.memo(function(tbl1) -- name: TeamListView
    local teamEntry = tbl1.teamEntry
    local players = teamEntry.players

    local var1 = SignalsReact.useSignalState(if players then players.getAllData else signal)

    local var2 = SignalsReact.useSignalState(if players then players.getCount else signal2)
    local layoutOrder = SignalsReact.useSignalBinding(teamEntry.order)

    local bool1 = not not (not tbl1.isNeutral or tbl1.hasNonNeutralTeams and var2 ~= 0)

    if tbl1.isNeutral and var2 == 0 then
        return nil
    end

    local tbl2 = {}

    if bool1 then
        tbl2.TeamHeader = React.createElement(TeamEntryView, {
            name = teamEntry.name,
            color = teamEntry.color,
            order = teamEntry.order,
            teamStats = teamEntry.stats,
            statColumns = tbl1.statColumns,
            statWidth = tbl1.statWidth,
            rowHeight = tbl1.columnHeaderHeight
        })
    end

    if players then
        local teamOrder = teamEntry.order(false)

        local userId = nil
        local huge = math.huge
        for k in pairs(var1) do
            local playerEntry = tbl1.leaderboardStore.getPlayerEntry(k, false)
            local var5 = if playerEntry then playerEntry.order(false) else 0
            local bool2 = var5 == huge and userId ~= nil and k.UserId < userId

            if var5 < huge or bool2 then
                userId = k.UserId
                huge = var5
            end
        end

        for player in pairs(var1) do
            local str1 = `Player_{player.UserId}`
            tbl2[str1] = React.createElement(EntryView, {
                player = player,
                leaderboardStore = tbl1.leaderboardStore,
                statColumns = tbl1.statColumns,
                statWidth = tbl1.statWidth,
                teamOrder = teamOrder,
                onActivated = tbl1.onActivated,
                rowHeight = tbl1.rowHeight,
                isCurrentUser = not (tbl1.localPlayer == nil) and player == tbl1.localPlayer,
                rowRefForward = if player.UserId == userId then tbl1.firstRowRefForward else nil
            })
        end
    end

    return React.createElement(View, { tag = "col size-full-0 auto-y", LayoutOrder = layoutOrder }, tbl2)
end)
