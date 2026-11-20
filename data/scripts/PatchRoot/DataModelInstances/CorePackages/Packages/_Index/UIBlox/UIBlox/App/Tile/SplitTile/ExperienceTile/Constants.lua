-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:10:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent

local _StyleTypes = require(scriptParentParentParentParent.Style.StyleTypes)
local _Fonts = require(scriptParentParentParentParent.Style.Fonts)

return {
    getDefaultStyleProps = function(arg1)
        assert(arg1.Tokens ~= nil, "Design token support is not enabled!")
        return {
            backgroundColor = {
                Color = arg1.Tokens.Color.Surface.Surface_200.Color3,
                Transparency = arg1.Tokens.Color.Surface.Surface_200.Transparency
            },
            border = {
                BorderColor = {
                    Color = arg1.Tokens.Color.Stroke.Emphasis.Color3,
                    Transparency = arg1.Tokens.Color.Stroke.Emphasis.Transparency
                },
                CornerRadius = UDim.new(0, arg1.Tokens.Radius.Medium),
                Width = arg1.Tokens.Stroke.Standard
            },
            topContentPadding = {
                Left = arg1.Tokens.Padding.None,
                Right = arg1.Tokens.Padding.None,
                Top = arg1.Tokens.Padding.None,
                Bottom = arg1.Tokens.Padding.None
            },
            bottomContentPadding = {
                Left = arg1.Tokens.Padding.Small,
                Right = arg1.Tokens.Padding.Small,
                Top = arg1.Tokens.Padding.Small,
                Bottom = arg1.Tokens.Padding.Small
            },
            overlayColors = {},
            selectionCursorPadding = { Left = 0, Right = 0, Top = 0, Bottom = 0 },
            dropShadow = {
                Position = UDim2.new(0.5, 0, 0.5, 2),
                AnchorPoint = Vector2.new(0.5, 0.5),
                Size = UDim2.new(1, 10, 1, 12),
                ImageColor = {
                    Color = arg1.Tokens.Color.Common.Shadow.Color3,
                    Transparency = arg1.Tokens.Color.Common.Shadow.Transparency
                },
                ImageAssetName = "component_assets/dropshadow_24_6",
                SliceCenter = Rect.new(18, 18, 18, 18)
            },
            contentTitlePadding = arg1.Tokens.Size.Size_200,
            contentTitleFont = arg1.Font.Header2
        }
    end,
    DEFAULT_FOOTER_HEIGHT = 22,
    DEFAULT_TEXT_LINE_COUNT = 2
}
