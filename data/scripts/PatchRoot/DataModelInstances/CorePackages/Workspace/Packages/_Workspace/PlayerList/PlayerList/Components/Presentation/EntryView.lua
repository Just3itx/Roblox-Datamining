-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T03:01:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local React = require(scriptParentParentParentParent.React)
local Signals = require(scriptParentParentParentParent.Signals)
local SignalsReact = require(scriptParentParentParentParent.SignalsReact)
local useTokens = require(scriptParentParentParentParent.Foundation).Hooks.useTokens

local _LeaderboardStore = require(scriptParentParentParentParent.LeaderboardStore)

local StatCell = require(scriptParentParentParent.Components.Presentation.StatCell)
local LeaderboardRowShell = require(scriptParentParentParent.Components.Presentation.LeaderboardRowShell)
local PeopleCell = require(scriptParentParentParent.Components.Presentation.PeopleCell)
local resolveDisplayName = require(scriptParentParentParent.Common.resolveDisplayName)
local Constants = require(scriptParentParentParent.Common.Constants)
local _computeStatColumns = require(scriptParentParentParent.Common.computeStatColumns)

local FFlagPlayerListContrastingTeamText = require(scriptParentParentParent.Flags.FFlagPlayerListContrastingTeamText)

local TEAM_LAYOUT_MULTIPLIER = Constants.TEAM_LAYOUT_MULTIPLIER

local signal = Signals.createSignal({})

local tbl1 = { Selectable = true }

local function buildEntryViewElement(tbl2, arg1, layoutOrder, onActivated: (...any) -> (...any), rowRef, selection, arg2)
    local rowHeight = tbl2.rowHeight
    local var1 = tbl2.statColumns or {}

    local tbl3 = {
        PeopleCell = React.createElement(
            PeopleCell,
            {
                displayName = resolveDisplayName(tbl2.player),
                player = tbl2.player,
                layoutOrder = 1,
                truncate = true
            }
        )
    }

    for i, value in ipairs(var1) do
        local playerStat = if arg1 then arg1.stats.getData(value.name, false) else nil
        local str1 = `Stat_{value.name}`
        tbl3[str1] = React.createElement(StatCell, {
            statName = value.name,
            playerStat = playerStat,
            statWidth = tbl2.statWidth,
            rowHeight = rowHeight,
            layoutOrder = i + 1,
            fontStyle = if FFlagPlayerListContrastingTeamText then arg2.Typography.BodySmall else nil,
            textStyle = if FFlagPlayerListContrastingTeamText then arg2.Color.Content.Default else nil
        })
    end

    return React.createElement(LeaderboardRowShell, {
        rowHeight = rowHeight,
        layoutOrder = layoutOrder,
        isHighlighted = tbl2.isCurrentUser == true,
        showDivider = true,
        onActivated = onActivated,
        rowRef = rowRef,
        selection = selection
    }, tbl3)
end

local function useEntryViewCore(tbl2)
    local var1 = React.useRef(nil)

    local var2 = React.useCallback(function()
        if tbl2.onActivated then
            local absolutePosition = if var1.current then var1.current.AbsolutePosition else nil
            tbl2.onActivated(tbl2.player, absolutePosition, var1.current)
        end
    end, { tbl2.player, tbl2.onActivated })

    local playerEntry = tbl2.leaderboardStore.getPlayerEntry(tbl2.player, false)

    SignalsReact.useSignalState(if playerEntry then playerEntry.stats.getAllData else signal)

    local var3 = React.useMemo(function()
        return Signals.createComputed(function(arg1)
            if playerEntry and tbl2.teamOrder ~= nil then
                return tbl2.teamOrder * TEAM_LAYOUT_MULTIPLIER + playerEntry.order(arg1)
            end

            return tbl2.layoutOrder or 0
        end)
    end, { playerEntry, tbl2.teamOrder, tbl2.layoutOrder })
    return var1, playerEntry, SignalsReact.useSignalBinding(var3), var2
end

return React.memo(function(tbl2) -- name: EntryView
    local var1, var2, var3, var4 = useEntryViewCore(tbl2)
    local var5 = if FFlagPlayerListContrastingTeamText then useTokens() else nil
    local rowRefForward = tbl2.rowRefForward
    local rowRef = React.useCallback(function(current)
        var1.current = current
        if not rowRefForward then
            return
        end

        if typeof(rowRefForward) == "function" then
            rowRefForward(current)
            return
        end
        rowRefForward.current = current
    end, { var1, rowRefForward })

    return buildEntryViewElement(tbl2, var2, var3, var4, rowRef, tbl1, var5)
end)
