-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:31:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreation = script:FindFirstAncestor("MomentsCreation")

local TextService = game:GetService("TextService")

local Constants = require(MomentsCreation.Constants)
local fitTextOverlayFontSize = require(MomentsCreation.Utils.fitTextOverlayFontSize)

local function computeEditorChipLayout(tbl1)
    local num1 = math.min(tbl1.itemWidth / 2, tbl1.maxChipWidth - tbl1.chipPadding * 2)
    local minFontSize = Constants.TextOverlay.MinFontSize
    local var1 = tbl1.keyboardTop or tbl1.viewportHeight - tbl1.keyboardHeight

    local num2 = math.max(minFontSize, var1 - tbl1.keyboardGap - tbl1.topMargin - tbl1.chipPadding * 2)
    local fontSize = fitTextOverlayFontSize(tbl1.text, tbl1.font, Constants.TextOverlay.DefaultFontSize, num1, num2, minFontSize)

    local vector2 = TextService:GetTextSize(tbl1.text, fontSize, tbl1.font, Vector2.new(num1, tbl1.viewportHeight))
    local vector2Y = vector2.Y

    if tbl1.growWidthWithText
        and TextService:GetTextSize(tbl1.text, fontSize, tbl1.font, Vector2.new(num1, 1000000)).Y <= TextService:GetTextSize(tbl1.text, fontSize, tbl1.font, Vector2.new(1000000, 1000000)).Y
    then
        local num3 = math.ceil(TextService:GetTextSize(" ", fontSize, tbl1.font, Vector2.new(1000000, 1000000)).X) + math.ceil(fontSize * (tbl1.overhangFraction or 0))
        num1 = math.clamp(math.ceil(vector2.X) + num3, math.min(fontSize, num1), num1)
    end

    local var2 = var1 - tbl1.layerTopY - tbl1.keyboardGap

    local var3 = vector2Y + tbl1.chipPadding * 2

    return {
        fontSize = fontSize,
        size = UDim2.fromOffset(num1, vector2Y),
        position = UDim2.new(0.5, 0, 0, var2 - var3 / 2)
    }
end

return computeEditorChipLayout
