-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T05:20:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceUIKitParent = script:FindFirstAncestor("AvatarExperienceUIKit").Parent
local React = require(AvatarExperienceUIKitParent.React)

local useDesignTokens = require(AvatarExperienceUIKitParent.Style).useDesignTokens

local function WidgetLayout(tbl1)
    local var1 = useDesignTokens()
    return React.createElement("Frame", {
        Size = UDim2.fromScale(1, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        LayoutOrder = tbl1.LayoutOrder,
        BorderSizePixel = 0
    }, {
        UIPadding = if tbl1.padding then React.createElement("UIPadding", {
            PaddingLeft = tbl1.padding.left,
            PaddingRight = tbl1.padding.right,
            PaddingTop = tbl1.padding.top,
            PaddingBottom = tbl1.padding.bottom
        }) else nil,
        UIListLayout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, var1.Size.Size_300)
        }),
        TopContent = if tbl1.headerSlot then React.createElement("Frame", {
            LayoutOrder = 1,
            Size = UDim2.fromScale(1, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            BorderSizePixel = 0
        }, tbl1.headerSlot) else nil,
        ItemGroup = if tbl1.contentSlot then React.createElement("Frame", {
            LayoutOrder = 2,
            Size = UDim2.fromScale(1, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            BorderSizePixel = 0
        }, tbl1.contentSlot) else nil
    })
end

return WidgetLayout
