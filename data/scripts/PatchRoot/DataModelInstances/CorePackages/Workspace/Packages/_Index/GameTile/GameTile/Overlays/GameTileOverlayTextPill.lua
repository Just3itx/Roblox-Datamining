-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T22:31:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameTileParent = script:FindFirstAncestor("GameTile").Parent
local React = require(GameTileParent.React)
local normalizeFontFace = require(GameTileParent.Foundation).Utility.normalizeFontFace
local Style = require(GameTileParent.Style)
local Colors = Style.Colors
local LightTheme = Style.Themes.LightTheme
local GetTextSize = Style.GetTextSize
local useDesignTokens = Style.useDesignTokens

local function GameTileOverlayTextPill(tbl1)
    if not tbl1.text or string.len(tbl1.text) == 0 then
        return nil
    end

    local var1 = useDesignTokens()

    local size200 = var1.Size.Size_200
    local size150 = var1.Size.Size_150

    local font = var1.Typography.HeadingLarge.Font
    local fontSize300 = var1.FontSize.FontSize_300

    local var2 = React.useMemo(function()
        return GetTextSize(tbl1.text, fontSize300, font, Vector2.new(math.huge, math.huge))
    end, { tbl1.text, fontSize300, font })

    return React.createElement("Frame", {
        BackgroundColor3 = Colors.White,
        BackgroundTransparency = 0.1,
        Position = tbl1.Position,
        AnchorPoint = tbl1.AnchorPoint,
        AutomaticSize = Enum.AutomaticSize.XY
    }, {
        Corner = React.createElement("UICorner", { CornerRadius = UDim.new(1, 0) }),
        UIPadding = React.createElement("UIPadding", {
            PaddingTop = UDim.new(0, size150),
            PaddingLeft = UDim.new(0, size200),
            PaddingBottom = UDim.new(0, size150),
            PaddingRight = UDim.new(0, size200)
        }),
        TextLabel = React.createElement("TextLabel", {
            BackgroundTransparency = 1,
            Size = UDim2.fromOffset(var2.X, var2.Y),
            Text = tbl1.text,
            TextColor3 = LightTheme.TextEmphasis.Color3,
            FontFace = normalizeFontFace(font),
            TextSize = fontSize300,
            TextXAlignment = Enum.TextXAlignment.Center,
            TextYAlignment = Enum.TextYAlignment.Center,
            TextWrapped = false,
            TextTruncate = Enum.TextTruncate.AtEnd
        }, {
            UISizeConstraint = React.createElement("UISizeConstraint", {
                MaxSize = tbl1.maxWidthBinding:map(function(num1: number)
                    local x = num1 - size200 * 2
                    if x > 0 then
                        return Vector2.new(x, var2.Y)
                    end

                    return nil
                end)
            })
        })
    })
end

return GameTileOverlayTextPill
