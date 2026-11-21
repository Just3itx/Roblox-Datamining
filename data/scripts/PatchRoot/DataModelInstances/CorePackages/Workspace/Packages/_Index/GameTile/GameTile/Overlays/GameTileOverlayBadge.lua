-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T22:31:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameTileParent = script:FindFirstAncestor("GameTile").Parent
local Foundation = require(GameTileParent.Foundation)
local GetTextSize = require(GameTileParent.Style).GetTextSize
local Icon = Foundation.Icon
local IconSize = Foundation.Enums.IconSize
local normalizeFontFace = Foundation.Utility.normalizeFontFace
local React = require(GameTileParent.React)

local useTokens = Foundation.Hooks.useTokens

local tbl1 = {}

return React.memo(function(tbl2) -- name: GameTileOverlayBadge
    local var1 = tbl2.icons or tbl1
    local text = tbl2.text or ""

    local bool1 = #var1 > 0
    local bool2 = #text > 0

    local var2 = useTokens()
    local var3 = if tbl2.styleOptions then tbl2.styleOptions.backgroundColorStyle or var2.Color.Extended.White.White_90 else var2.Color.Extended.White.White_90
    local style = if tbl2.styleOptions then tbl2.styleOptions.contentColorStyle or var2.LightMode.Content.Emphasis else var2.LightMode.Content.Emphasis
    local cornerRadius = tbl2.styleOptions and tbl2.styleOptions.cornerRadius or UDim.new(1, 0)
    local offset = if bool2 or #var1 > 1 then var2.Size.Size_200 else var2.Size.Size_150
    local offset2 = if tbl2.styleOptions then tbl2.styleOptions.verticalPadding or var2.Size.Size_150 else var2.Size.Size_150
    local xSmall = var2.Padding.XSmall
    local titleSmall = var2.Typography.TitleSmall
    local size400 = var2.Size.Size_400

    local var6 = React.useMemo(function()
        if bool2 then
            return (GetTextSize(text, titleSmall.FontSize, titleSmall.Font, Vector2.new(math.huge, math.huge)))
        end

        return Vector2.new(0, 0)
    end, {
        text,
        bool2,
        titleSmall.FontSize,
        titleSmall.Font
    })
    if not (bool2 or bool1) then
        return nil
    end

    local tbl3 = {
        Padding = React.createElement("UIPadding", {
            PaddingTop = UDim.new(0, offset2),
            PaddingLeft = UDim.new(0, offset),
            PaddingBottom = UDim.new(0, offset2),
            PaddingRight = UDim.new(0, offset)
        }),
        Layout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, xSmall)
        })
    }

    local num1 = 0

    for layoutOrder, name in var1 do
        local str1 = `Icon{layoutOrder}`
        tbl3[str1] = React.createElement(Icon, { LayoutOrder = layoutOrder, name = name, size = IconSize.Small, style = style })

        local var7 = size400 + xSmall
        num1 += var7
    end

    if bool2 then
        tbl3.BadgeText = React.createElement("TextLabel", {
            LayoutOrder = #var1 + 1,
            BackgroundTransparency = 1,
            Size = UDim2.fromOffset(var6.X, var6.Y),
            Text = text,
            TextColor3 = style.Color3,
            FontFace = normalizeFontFace(titleSmall.Font),
            TextSize = titleSmall.FontSize,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Center,
            TextWrapped = false,
            TextTruncate = Enum.TextTruncate.AtEnd
        }, {
            UISizeConstraint = React.createElement("UISizeConstraint", {
                MaxSize = tbl2.maxWidthBinding:map(function(num2: number)
                    local x = num2 - 2 * offset - num1
                    if x > 0 then
                        return Vector2.new(x, math.huge)
                    end

                    return nil
                end)
            })
        })
    end

    return React.createElement("Frame", {
        BackgroundColor3 = var3.Color3,
        BackgroundTransparency = var3.Transparency,
        Position = tbl2.Position,
        AnchorPoint = tbl2.AnchorPoint,
        AutomaticSize = Enum.AutomaticSize.XY
    }, {
        Corner = React.createElement("UICorner", { CornerRadius = cornerRadius }),
        BadgeContent = React.createElement("Frame", { BackgroundTransparency = 1, AutomaticSize = Enum.AutomaticSize.XY }, tbl3)
    })
end)
