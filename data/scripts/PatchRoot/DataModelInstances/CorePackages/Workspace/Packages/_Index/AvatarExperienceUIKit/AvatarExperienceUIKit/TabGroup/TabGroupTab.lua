-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T05:11:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceUIKit = script:FindFirstAncestor("AvatarExperienceUIKit")
local AvatarExperienceUIKitParent = AvatarExperienceUIKit.Parent
local React = require(AvatarExperienceUIKitParent.React)
local Foundation = require(AvatarExperienceUIKitParent.Foundation)
local useTokens = Foundation.Hooks.useTokens

local getFixedTabHeight = require(AvatarExperienceUIKit.Utils.getFixedTabHeight)

local FFlagAXCategoryMenuVisualFixes = require(AvatarExperienceUIKitParent.AvatarExperienceFlags).FFlagAXCategoryMenuVisualFixes

local FoundationText = Foundation.Text
local View = Foundation.View

local backgroundStyle = { Transparency = 1 }

local tbl2 = {
    FillDirection = Enum.FillDirection.Vertical,
    HorizontalAlignment = Enum.HorizontalAlignment.Left,
    VerticalAlignment = Enum.VerticalAlignment.Center,
    SortOrder = Enum.SortOrder.LayoutOrder
}

local tbl1 = { Transparency = 1 }

return (React.forwardRef(function(tbl4, ref) -- name: TabGroupTabComponent
    local var1 = useTokens()
    local textStyle = if tbl4.isActive then tbl4.activeTextStyle or var1.Color.Content.Emphasis else tbl4.textStyle or var1.Color.Content.Muted
    local fontStyle = tbl4.fontStyle or var1.Typography.TitleLarge
    local var4 = tbl4.padding or Vector2.new(var1.Padding.Small, var1.Padding.Medium)

    local createElement = React.createElement
    local var5 = View
    local tbl5 = {
        ref = ref,
        onActivated = tbl4.onActivated,
        backgroundStyle = backgroundStyle,
        padding = 0,
        Size = 0,
        AutomaticSize = 0,
        layout = 0,
        LayoutOrder = 0
    }

    if FFlagAXCategoryMenuVisualFixes then
        var4 = Vector2.new(var4.X, 0)
    end

    tbl5.padding = var4
    tbl5.Size = if FFlagAXCategoryMenuVisualFixes then UDim2.fromOffset(0, getFixedTabHeight(var1)) else UDim2.fromScale(0, 0)

    tbl5.AutomaticSize = if FFlagAXCategoryMenuVisualFixes then Enum.AutomaticSize.X else Enum.AutomaticSize.XY
    tbl5.layout = if FFlagAXCategoryMenuVisualFixes then tbl2 else nil
    tbl5.LayoutOrder = tbl4.LayoutOrder
    return createElement(var5, tbl5, {
        Text = React.createElement(FoundationText, {
            Text = tbl4.text,
            textStyle = textStyle,
            fontStyle = fontStyle,
            Size = UDim2.fromScale(0, 0),
            AutomaticSize = Enum.AutomaticSize.XY,
            backgroundStyle = tbl1
        })
    })
end))
