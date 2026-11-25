-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T03:04:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local React = require(scriptParentParentParentParent.React)
local Signals = require(scriptParentParentParentParent.Signals)
local SignalsReact = require(scriptParentParentParentParent.SignalsReact)
local Foundation = require(scriptParentParentParentParent.Foundation)
local View = Foundation.View
local FoundationText = Foundation.Text

local _LeaderboardStore = require(scriptParentParentParentParent.LeaderboardStore)

local StatCell = require(scriptParentParentParent.Components.Presentation.StatCell)
local Constants = require(scriptParentParentParent.Common.Constants)
local _computeStatColumns = require(scriptParentParentParent.Common.computeStatColumns)

local GameTextTranslatorContext = require(scriptParentParentParent.Common.GameTextTranslatorContext)
local FFlagPlayerListLocalizeGameText = require(scriptParentParentParent.Flags.FFlagPlayerListLocalizeGameText)
local usePreferredTransparencyBinding = require(scriptParentParentParent.Hooks.usePreferredTransparencyBinding)
local getContrastingContentStyle = require(scriptParentParentParent.Common.getContrastingContentStyle)
local FFlagPlayerListContrastingTeamText = require(scriptParentParentParent.Flags.FFlagPlayerListContrastingTeamText)

local useTokens = Foundation.Hooks.useTokens
local usePreferences = Foundation.Hooks.usePreferences

local ROW_FLEX_TAG = Constants.ROW_FLEX_TAG
local TEAM_LAYOUT_MULTIPLIER = Constants.TEAM_LAYOUT_MULTIPLIER

return React.memo(function(tbl1) -- name: TeamEntryView
    local var1 = if FFlagPlayerListLocalizeGameText then React.useContext(GameTextTranslatorContext) else nil
    local var2 = SignalsReact.useSignalBinding(tbl1.name)

    local var3 = if FFlagPlayerListLocalizeGameText then React.useMemo(function()
        if var1 then
            return (var2:map(var1))
        end

        return var2
    end, { var1, var2 }) else var2

    local color = SignalsReact.useSignalBinding(tbl1.color)
    local var5 = if FFlagPlayerListContrastingTeamText then usePreferences() else nil
    local var6 = if var5 then if var5.preferredTransparency == nil then 1 else var5.preferredTransparency else nil
    local pt = if FFlagPlayerListContrastingTeamText then nil else usePreferredTransparencyBinding()
    local var8 = if FFlagPlayerListContrastingTeamText then useTokens() else nil

    local textStyle = if FFlagPlayerListContrastingTeamText then React.useMemo(function()
        local overMedia200 = var8.Color.OverMedia.OverMedia_200
        return color:map(function(color3: Color3)
            return getContrastingContentStyle(
                color3,
                0.5,
                {
                    Color3 = overMedia200.Color3,
                    Transparency = overMedia200.Transparency * var6
                },
                var8.DarkMode.Content.Emphasis,
                var8.LightMode.Content.Emphasis
            )
        end)
    end, { color, var6, var8 }) else nil

    local rowHeight = tbl1.rowHeight

    local var10 = React.useMemo(function()
        return Signals.createComputed(function(arg1)
            if tbl1.order then
                return tbl1.order(arg1) * TEAM_LAYOUT_MULTIPLIER
            end

            return tbl1.layoutOrder or 0
        end)
    end, { tbl1.order, tbl1.layoutOrder })
    local layoutOrder = SignalsReact.useSignalBinding(var10)

    local tbl2 = {
        NameLabel = if FFlagPlayerListContrastingTeamText then React.createElement(FoundationText, {
            Text = var3,
            LayoutOrder = 1,
            tag = "fill size-0-full text-label-small text-align-x-left clip",
            textStyle = textStyle
        }) else React.createElement(View, { LayoutOrder = 1, tag = "fill size-0-full clip" }, {
            Label = React.createElement(
                FoundationText,
                {
                    Text = var3,
                    tag = "size-full text-label-small text-align-x-left content-emphasis"
                }
            )
        })
    }

    if tbl1.statColumns then
        for i, statColumn in ipairs(tbl1.statColumns) do
            local playerStat = if tbl1.teamStats then tbl1.teamStats.getData(statColumn.name, false) else nil
            local str1 = `TeamStat_{statColumn.name}`
            tbl2[str1] = React.createElement(StatCell, {
                statName = statColumn.name,
                playerStat = playerStat,
                statWidth = tbl1.statWidth,
                rowHeight = rowHeight,
                layoutOrder = i + 1,
                textTag = if FFlagPlayerListContrastingTeamText then nil else "text-label-small content-emphasis",
                fontStyle = if FFlagPlayerListContrastingTeamText then var8.Typography.LabelSmall else nil,
                textStyle = textStyle
            })
        end
    end

    local backgroundStyle = if FFlagPlayerListContrastingTeamText then React.useMemo(function()
        return color:map(function(color3: Color3)
            return { Color3 = color3, Transparency = 0.5 }
        end)
    end, { color }) else React.useMemo(function()
        return React.joinBindings({ color = color, pt = pt }):map(function(arg1)
            return {
                Color3 = arg1.color,
                Transparency = 0.5 * arg1.pt
            }
        end)
    end, { color, pt })

    if FFlagPlayerListContrastingTeamText then
        return React.createElement(View, {
            Size = UDim2.new(1, 0, 0, rowHeight),
            backgroundStyle = backgroundStyle,
            LayoutOrder = layoutOrder,
            selection = Constants.NOT_SELECTABLE,
            testId = "team-entry-view",
            tag = ROW_FLEX_TAG
        }, tbl2)
    end

    return React.createElement(
        View,
        {
            Size = UDim2.new(1, 0, 0, rowHeight),
            backgroundStyle = backgroundStyle,
            LayoutOrder = layoutOrder,
            selection = Constants.NOT_SELECTABLE,
            testId = "team-entry-view"
        },
        {
            RowContent = React.createElement(View, { tag = `size-full {ROW_FLEX_TAG}` }, tbl2)
        }
    )
end)
