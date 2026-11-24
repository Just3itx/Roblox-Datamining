-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T22:40:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local ArgCheck = require(scriptParentParent.ArgCheck)
local Display = require(scriptParentParent.Display)
local FFlagExtendScrollingFramesBySafeInsets = require(scriptParentParent.SharedFlags).FFlagExtendScrollingFramesBySafeInsets

local function getSafeAreaSize(vector2: Vector2, arg1, bool1: boolean?): UDim2
    assert(typeof(vector2) == "Vector2", "getSafeAreaSize expects screenSize to be a Vector2")
    assert(type(arg1) == "table", "getSafeAreaSize expects guiInset to be a table")
    ArgCheck.isNonNegativeNumber(arg1.left, "getSafeAreaSize: guiInset.left")
    ArgCheck.isNonNegativeNumber(arg1.right, "getSafeAreaSize: guiInset.right")
    ArgCheck.isNonNegativeNumber(arg1.top, "getSafeAreaSize: guiInset.top")
    ArgCheck.isNonNegativeNumber(arg1.bottom, "getSafeAreaSize: guiInset.bottom")

    local xOffset = vector2.X - arg1.left - arg1.right
    local yOffset = vector2.Y - arg1.top - arg1.bottom

    if bool1 then
        ArgCheck.isNonNegativeNumber(xOffset, "getSafeAreaSize: safeAreaWidth")
        ArgCheck.isNonNegativeNumber(yOffset, "getSafeAreaSize: safeAreaHeight")
        return UDim2.new(0, xOffset, 0, yOffset)
    end

    if FFlagExtendScrollingFramesBySafeInsets then
        local var1 = Display.GetDisplayStore().getDeviceSafePadding()
        xOffset -= var1.left + var1.right
        yOffset -= var1.top + var1.bottom
    end

    ArgCheck.isNonNegativeNumber(xOffset, "getSafeAreaSize: safeAreaWidth")
    ArgCheck.isNonNegativeNumber(yOffset, "getSafeAreaSize: safeAreaHeight")

    return UDim2.new(0, xOffset, 0, yOffset)
end

return getSafeAreaSize
