-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:21:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUi = script:FindFirstAncestor("ServerDrivenUi")

local ServerDrivenUiParent = ServerDrivenUi.Parent
local React = require(ServerDrivenUiParent.React)
local Foundation = require(ServerDrivenUiParent.Foundation)
local useTokens = Foundation.Hooks.useTokens
local normalizeFontFace = Foundation.Utility.normalizeFontFace

local FFlagLuaAppAlignHeroUnitBottomRowCtaButton = require(ServerDrivenUiParent.SharedFlags).FFlagLuaAppAlignHeroUnitBottomRowCtaButton
local FFlagLuaAppHeroUnitSecondaryLabelText = require(ServerDrivenUi.FFlagLuaAppHeroUnitSecondaryLabelText)

return React.memo(function(tbl1) -- name: SduiHeroUnitBottomRow
    local layoutOrder = tbl1.layoutOrder
    local zIndex = tbl1.zIndex
    local position = tbl1.position

    local var1 = useTokens()
    local var2 = if FFlagLuaAppHeroUnitSecondaryLabelText then var1.Typography.CaptionSmall else var1.Typography.BodySmall
    local color3 = if FFlagLuaAppHeroUnitSecondaryLabelText then var1.DarkMode.Content.Muted.Color3 else var1.Color.Extended.Gray.Gray_400.Color3
    local fontSize = nil
    local size400 = nil
    local var3 = nil
    local var4 = nil
    local var5 = nil
    if FFlagLuaAppHeroUnitSecondaryLabelText then
        fontSize = var2.FontSize
        size400 = var1.Size.Size_400
        var3 = var1.Size.Size_2500 * 3
        var4 = React.useMemo(function()
            return (normalizeFontFace(var2.Font))
        end, { var2.Font })
        var5 = React.useMemo(function(): Font
            local var6 = var4
            return Font.new(var6.Family, Enum.FontWeight.SemiBold, var6.Style)
        end, { var4 })
    end

    local useMemo = React.useMemo
    local function func1()
        if tbl1.rightLabelContent then
            return React.createElement("Frame", {
                AutomaticSize = Enum.AutomaticSize.XY,
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                AnchorPoint = Vector2.new(1, 1),
                Position = UDim2.new(1, 0, 1, 0)
            }, {
                Content = tbl1.rightLabelContent
            })
        end
        if (not tbl1.labelText or tbl1.labelText == "")
            and (not FFlagLuaAppHeroUnitSecondaryLabelText or not tbl1.secondaryLabelText or tbl1.secondaryLabelText == "")
        then
            return nil
        end

        if not FFlagLuaAppHeroUnitSecondaryLabelText then
            return React.createElement("TextLabel", {
                AutomaticSize = Enum.AutomaticSize.X,
                Size = UDim2.new(0, 0, 0, var2.FontSize * var2.LineHeight),
                BackgroundTransparency = 1,
                Text = tbl1.labelText,
                TextSize = var2.FontSize,
                FontFace = normalizeFontFace(var2.Font),
                TextColor3 = color3,
                TextXAlignment = Enum.TextXAlignment.Right,
                TextTruncate = Enum.TextTruncate.SplitWord,
                AnchorPoint = Vector2.new(1, 1),
                Position = UDim2.new(1, 0, 1, 0)
            })
        end

        local labelText = tbl1.labelText
        local secondaryLabelText = tbl1.secondaryLabelText
        local textSize = fontSize
        local yOffset = size400
        local createElement = React.createElement
        local str1 = "Frame"
        local tbl2 = {
            AutomaticSize = Enum.AutomaticSize.Y,
            Size = UDim2.new(1, 0, 0, 0),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            AnchorPoint = Vector2.new(1, 1),
            Position = UDim2.new(1, 0, 1, 0)
        }
        local tbl3 = {
            UIListLayout = React.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Vertical,
                HorizontalAlignment = Enum.HorizontalAlignment.Right,
                SortOrder = Enum.SortOrder.LayoutOrder
            }),
            MaturityLabel = 0,
            SecondaryLabel = 0
        }
        local element

        if labelText and labelText ~= "" then
            element = React.createElement("TextLabel", {
                AutomaticSize = Enum.AutomaticSize.X,
                Size = UDim2.new(0, 0, 0, var2.FontSize * var2.LineHeight),
                BackgroundTransparency = 1,
                LayoutOrder = 1,
                Text = labelText,
                TextSize = var2.FontSize,
                FontFace = var5,
                TextColor3 = color3,
                TextXAlignment = Enum.TextXAlignment.Right,
                TextTruncate = Enum.TextTruncate.SplitWord
            })
        else
            element = nil
        end

        tbl3.MaturityLabel = element
        local var7

        if secondaryLabelText and secondaryLabelText ~= "" then
            local createElement2 = React.createElement
            local tbl4 = {
                AutomaticSize = Enum.AutomaticSize.Y,
                Size = UDim2.new(1, 0, 0, yOffset),
                BackgroundTransparency = 1,
                LayoutOrder = 2,
                Text = secondaryLabelText,
                TextSize = textSize,
                LineHeight = var2.LineHeight,
                FontFace = var4,
                TextColor3 = color3,
                TextXAlignment = Enum.TextXAlignment.Right,
                TextWrapped = true,
                TextTruncate = Enum.TextTruncate.SplitWord
            }
            local tbl5 = {
                UISizeConstraint = React.createElement(
                    "UISizeConstraint",
                    {
                        MaxSize = Vector2.new(var3, math.max(yOffset, textSize * var2.LineHeight * 2))
                    }
                )
            }
            var7 = createElement2("TextLabel", tbl4, tbl5)
        else
            var7 = nil
        end

        tbl3.SecondaryLabel = var7
        return createElement(str1, tbl2, tbl3)
    end

    local rightLabelContent = tbl1.rightLabelContent
    local labelText = tbl1.labelText
    local secondaryLabelText = if FFlagLuaAppHeroUnitSecondaryLabelText then tbl1.secondaryLabelText else nil
    local var6 = if FFlagLuaAppHeroUnitSecondaryLabelText then fontSize else nil
    local var7 = if FFlagLuaAppHeroUnitSecondaryLabelText then size400 else nil
    local var8 = if FFlagLuaAppHeroUnitSecondaryLabelText then var3 else nil
    local var9 = if FFlagLuaAppHeroUnitSecondaryLabelText then var4 else nil
    local var10 = if FFlagLuaAppHeroUnitSecondaryLabelText then var5 else nil
    local label = useMemo(func1, { rightLabelContent, labelText, var2, color3, secondaryLabelText, var6, var7, var8, var9, var10 })

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        Size = UDim2.new(1, 0, 0, var1.Size.Size_1000),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        LayoutOrder = layoutOrder,
        ZIndex = zIndex,
        Position = position,
        [React.Tag] = if tbl1.testId then `data-testid={tbl1.testId}` else nil
    }
    local tbl3 = {
        UIListLayout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            VerticalAlignment = Enum.VerticalAlignment.Bottom,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            SortOrder = Enum.SortOrder.LayoutOrder,
            ItemLineAlignment = if FFlagLuaAppAlignHeroUnitBottomRowCtaButton then Enum.ItemLineAlignment.Automatic else Enum.ItemLineAlignment.Center
        }),
        CTAButtonContainer = if FFlagLuaAppAlignHeroUnitBottomRowCtaButton then tbl1.ctaButton else React.createElement(
            "Frame",
            {
                AutomaticSize = Enum.AutomaticSize.XY,
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                LayoutOrder = 1
            },
            {
                ButtonContent = tbl1.ctaButton
            }
        ),
        LabelContainer = React.createElement(
            "Frame",
            {
                LayoutOrder = 2,
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Size = UDim2.new(1, 0, 1, 0)
            },
            {
                UIFlexItem = React.createElement("UIFlexItem", { FlexMode = Enum.UIFlexMode.Fill }),
                Label = label
            }
        )
    }
    return createElement(str1, tbl2, tbl3)
end)
