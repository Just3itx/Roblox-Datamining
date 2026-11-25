-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T03:04:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local React = require(scriptParentParentParentParent.React)
local FoundationText = require(scriptParentParentParentParent.Foundation).Text

local LeaderboardTextCell = require(script.Parent.LeaderboardTextCell)
local Signals = require(scriptParentParentParentParent.Signals)
local SignalsReact = require(scriptParentParentParentParent.SignalsReact)

local _LeaderboardStore = require(scriptParentParentParentParent.LeaderboardStore)

local FormatStatString = require(scriptParentParentParent.Common.FormatStatString)
local FFlagPlayerListContrastingTeamText = require(scriptParentParentParent.Flags.FFlagPlayerListContrastingTeamText)

return React.memo(function(tbl1) -- name: StatCell
    local var1 = React.useMemo(function()
        return Signals.createComputed(function(arg1)
            if not tbl1.playerStat then
                return "-"
            end

            local var1 = tbl1.playerStat(arg1)
            return FormatStatString(var1)
        end)
    end, { tbl1.playerStat })
    local text = SignalsReact.useSignalBinding(var1)

    if FFlagPlayerListContrastingTeamText then
        return React.createElement(FoundationText, {
            Text = text,
            Size = UDim2.fromOffset(tbl1.statWidth, tbl1.rowHeight),
            LayoutOrder = tbl1.layoutOrder,
            tag = "text-align-x-left text-truncate-end clip",
            fontStyle = tbl1.fontStyle,
            textStyle = tbl1.textStyle
        })
    end

    return React.createElement(LeaderboardTextCell, {
        text = text,
        width = tbl1.statWidth,
        rowHeight = tbl1.rowHeight,
        layoutOrder = tbl1.layoutOrder,
        textTag = `size-full text-align-x-left text-truncate-end {tbl1.textTag or "text-body-small content-default"}`
    })
end)
