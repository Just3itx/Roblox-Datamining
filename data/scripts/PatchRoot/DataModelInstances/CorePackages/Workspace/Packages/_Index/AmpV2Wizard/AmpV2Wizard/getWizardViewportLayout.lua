-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T21:40:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function getWizardViewportLayout(rect: Rect, rect2: Rect, tbl1)
    local var1 = rect2.Min + Vector2.new(tbl1.left, tbl1.top)
    local var2 = rect2.Max - Vector2.new(tbl1.right, tbl1.bottom)
    local var3 = rect.Max - rect.Min
    local xOffset = math.clamp(var1.X - rect.Min.X, 0, var3.X)
    local yOffset = math.clamp(var1.Y - rect.Min.Y, 0, var3.Y)
    local num1 = math.clamp(rect.Max.X - var2.X, 0, var3.X - xOffset)
    local num2 = math.clamp(rect.Max.Y - var2.Y, 0, var3.Y - yOffset)
    local var4 = if rect.Min.X <= var1.X then math.max(0, rect.Min.X - rect2.Min.X) else 0
    local var5 = if rect.Min.Y <= var1.Y then math.max(0, rect.Min.Y - rect2.Min.Y) else 0
    local var6 = if rect.Max.X >= var2.X then math.max(0, rect2.Max.X - rect.Max.X) else 0
    local var7 = if rect.Max.Y >= var2.Y then math.max(0, rect2.Max.Y - rect.Max.Y) else 0
    return {
        contentPosition = UDim2.fromOffset(xOffset, yOffset),
        contentSize = UDim2.new(1, -xOffset - num1, 1, -yOffset - num2),
        backgroundPosition = UDim2.fromOffset(-var4, -var5),
        backgroundSize = UDim2.new(1, var4 + var6, 1, var5 + var7)
    }
end

return getWizardViewportLayout
