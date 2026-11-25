-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T03:01:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local React = require(scriptParentParentParentParent.React)
local FoundationText = require(scriptParentParentParentParent.Foundation).Text

local LeaderboardRowShell = require(scriptParentParentParent.Components.Presentation.LeaderboardRowShell)
local PeopleCell = require(scriptParentParentParent.Components.Presentation.PeopleCell)
local LeaderboardTextCell = require(scriptParentParentParent.Components.Presentation.LeaderboardTextCell)
local FFlagPlayerListContrastingTeamText = require(scriptParentParentParent.Flags.FFlagPlayerListContrastingTeamText)

local _computeStatColumns = require(scriptParentParentParent.Common.computeStatColumns)

local GameTextTranslatorContext = require(scriptParentParentParent.Common.GameTextTranslatorContext)
local getPeopleHeaderLabel = require(scriptParentParentParent.Common.getPeopleHeaderLabel)
local FFlagPlayerListLocalizeGameText = require(scriptParentParentParent.Flags.FFlagPlayerListLocalizeGameText)

return React.memo(function(tbl1) -- name: ColumnHeaderRow
    local var1 = if FFlagPlayerListLocalizeGameText then React.useContext(GameTextTranslatorContext) else nil
    local displayName = if FFlagPlayerListLocalizeGameText then getPeopleHeaderLabel() else "People"
    local var3 = tbl1.statColumns or {}

    local tbl2 = {
        PeopleHeader = React.createElement(PeopleCell, {
            displayName = displayName,
            layoutOrder = 1,
            textTag = "size-full text-caption-small text-align-x-left content-emphasis"
        })
    }

    for i, value in ipairs(var3) do
        if FFlagPlayerListContrastingTeamText then
            local str1 = `StatHeader_{value.name}`
            tbl2[str1] = React.createElement(FoundationText, {
                Text = if var1 then var1(value.name) else value.name,
                Size = UDim2.fromOffset(tbl1.statWidth, tbl1.headerHeight),
                LayoutOrder = i + 1,
                tag = "text-caption-small text-align-x-left clip content-emphasis"
            })
        else
            local str1 = `StatHeader_{value.name}`
            tbl2[str1] = React.createElement(LeaderboardTextCell, {
                text = if var1 then var1(value.name) else value.name,
                width = tbl1.statWidth,
                rowHeight = tbl1.headerHeight,
                layoutOrder = i + 1,
                textTag = "size-full text-caption-small text-align-x-left content-emphasis"
            })
        end
    end

    return React.createElement(LeaderboardRowShell, { rowHeight = tbl1.headerHeight, layoutOrder = tbl1.layoutOrder }, tbl2)
end)
