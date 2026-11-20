-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:11:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local StateLayerMode = require(Foundation.Enums.StateLayerMode)
local Text = require(Foundation.Components.Text)
local useTokens = require(Foundation.Providers.Style.useTokens)

local function CalendarDay(tbl1)
    local var1 = useTokens()
    local color3 = if tbl1.isSelected then var1.Inverse.Content.Emphasis.Color3 elseif tbl1.isSelectable and tbl1.emphasizeText then var1.Color.Content.Emphasis.Color3 else var1.Color.Content.Muted.Color3
    local num1 = if tbl1.isSelected or tbl1.isSelectable and tbl1.emphasizeText then 0 else 0.5

    return React.createElement(Text, {
        textStyle = { Color3 = color3, Transparency = num1 },
        backgroundStyle = if tbl1.isSelected then var1.Color.System.Contrast elseif tbl1.highlight then var1.Color.ActionStandard.Background else nil,
        LayoutOrder = tbl1.LayoutOrder,
        onActivated = if tbl1.isSelectable then tbl1.onActivated else nil,
        RichText = not tbl1.isSelectable,
        stateLayer = {
            mode = if tbl1.isSelected then StateLayerMode.Inverse else StateLayerMode.Default
        },
        Text = if tbl1.isSelectable then tbl1.Text else `<s>{tbl1.Text}</s>`,
        tag = "auto-xy text-title-small text-align-x-center text-align-y-center",
        testId = tbl1.testId
    })
end

return CalendarDay
