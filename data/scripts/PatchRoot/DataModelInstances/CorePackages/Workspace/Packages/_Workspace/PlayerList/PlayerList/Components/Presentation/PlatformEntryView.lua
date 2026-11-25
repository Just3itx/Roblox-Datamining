-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T03:04:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local React = require(scriptParentParentParentParent.React)
local FoundationText = require(scriptParentParentParentParent.Foundation).Text
local Signals = require(scriptParentParentParentParent.Signals)
local SignalsReact = require(scriptParentParentParentParent.SignalsReact)

local LocalizationService = game:GetService("LocalizationService")
local NumberLocalization = require(scriptParentParentParentParent.Localization).NumberLocalization

local Constants = require(scriptParentParentParent.Common.Constants)
local FormatStatString = require(scriptParentParentParent.Common.FormatStatString)
local LeaderboardRowShell = require(scriptParentParentParent.Components.Presentation.LeaderboardRowShell)
local LeaderboardTextCell = require(scriptParentParentParent.Components.Presentation.LeaderboardTextCell)
local PeopleCell = require(scriptParentParentParent.Components.Presentation.PeopleCell)

local FFlagPlayerListPlatformLeaderboardAbbreviateScores = require(scriptParentParentParent.Flags.FFlagPlayerListPlatformLeaderboardAbbreviateScores)
local FFlagPlayerListContrastingTeamText = require(scriptParentParentParent.Flags.FFlagPlayerListContrastingTeamText)

local signal = Signals.createSignal(nil)
local str1 = game:DefineFastString("PlatformLeaderboardUnrankedLabel", "100+")

local signal2 = Signals.createSignal(nil)

local function formatScoreCell(num1: number?)
    if FFlagPlayerListPlatformLeaderboardAbbreviateScores then
        return FormatStatString(num1)
    elseif num1 == nil then
        return "-"
    end
    return NumberLocalization.localize(num1, LocalizationService.RobloxLocaleId)
end

local function formatRankCell(num1: number?)
    if num1 ~= nil then
        return tostring(num1)
    end

    return str1
end

local function rankToLayoutOrder(num1: number?): number
    return if num1 == nil then 1000000 else num1
end

return React.memo(function(tbl1) -- name: PlatformEntryViewImpl
    local bool1 = tbl1.isHeader == true

    local var1 = SignalsReact.useSignalBinding(tbl1.scoreGetter or signal)
    local var2 = SignalsReact.useSignalBinding(tbl1.rankGetter or signal2)

    local scoreLabel = tbl1.scoreLabel
    local text = React.useMemo(function()
        if bool1 then
            return scoreLabel or "-"
        end
        return var1:map(formatScoreCell)
    end, { bool1, var1, scoreLabel })

    local rankHeaderText = tbl1.rankHeaderText
    local var3 = React.useMemo(function()
        if bool1 then
            return rankHeaderText or "Rank"
        end
        return var2:map(formatRankCell)
    end, { bool1, var2, rankHeaderText })

    local displayName = if bool1 then tbl1.peopleHeaderText or "People" else tbl1.displayName or "-"

    local layoutOrder = React.useMemo(function()
        if tbl1.layoutOrder ~= nil then
            return tbl1.layoutOrder
        end
        return var2:map(rankToLayoutOrder)
    end, { tbl1.layoutOrder, var2 })

    local textTag = if bool1 then "size-full text-caption-small text-align-x-left content-muted" else "size-full text-body-small text-align-x-left content-default"

    local str2 = if bool1 then "size-full text-caption-small text-align-x-right content-muted" else "size-full text-body-small text-align-x-right content-default"

    local var4 = if bool1 then "size-full text-caption-small text-align-x-left content-muted" else nil

    local rowHeight = tbl1.rowHeight

    if not rowHeight then
        if bool1 then
            rowHeight = Constants.PLATFORM_HEADER_HEIGHT
        else
            rowHeight = Constants.PLATFORM_ROW_HEIGHT
        end
    end

    local width = tbl1.rankWidth or Constants.PLATFORM_RANK_WIDTH
    local xOffset2 = tbl1.scoreWidth or Constants.PLATFORM_SCORE_WIDTH

    return React.createElement(LeaderboardRowShell, {
        rowHeight = rowHeight,
        layoutOrder = layoutOrder,
        isHighlighted = tbl1.isViewer == true and tbl1.highlightViewerRow ~= false,
        showDivider = tbl1.showDivider == true,
        flexTag = Constants.PLATFORM_ROW_FLEX_TAG
    }, {
        RankCell = if FFlagPlayerListContrastingTeamText then React.createElement(FoundationText, {
            Text = var3,
            Size = UDim2.fromOffset(width, rowHeight),
            LayoutOrder = 1,
            tag = {
                ["text-align-x-left clip"] = true,
                ["text-caption-small content-muted"] = bool1,
                ["text-body-small content-default"] = not bool1
            }
        }) else React.createElement(
            LeaderboardTextCell,
            {
                text = var3,
                width = width,
                rowHeight = rowHeight,
                layoutOrder = 1,
                textTag = textTag
            }
        ),
        PeopleCell = React.createElement(PeopleCell, { displayName = displayName, layoutOrder = 2, textTag = var4, truncate = not bool1 }),
        ScoreCell = if FFlagPlayerListContrastingTeamText then React.createElement(FoundationText, {
            Text = text,
            Size = UDim2.fromOffset(xOffset2, rowHeight),
            LayoutOrder = 3,
            tag = {
                ["text-align-x-right clip"] = true,
                ["text-caption-small content-muted"] = bool1,
                ["text-body-small content-default"] = not bool1
            }
        }) else React.createElement(
            LeaderboardTextCell,
            {
                text = text,
                width = xOffset2,
                rowHeight = rowHeight,
                layoutOrder = 3,
                textTag = str2
            }
        )
    })
end)
