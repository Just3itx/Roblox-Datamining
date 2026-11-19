-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:10:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local Constants = require(scriptParentParent.Constants)

local function GetSegmentIndexFromPosition(arg1)
    local num1 = math.deg(math.atan2(arg1.X, arg1.Y))
    if num1 < 0 then
        num1 += 360
    end

    local var1 = 360 / Constants.EmotesPerPage
    local num2 = math.ceil(math.ceil(math.fmod(num1 + math.ceil(var1 / 2), 360) / var1) + (Constants.SegmentsStartRotation + 90) / var1)

    if Constants.EmotesPerPage < num2 then
        return num2 - Constants.EmotesPerPage
    end

    if num2 < 1 then
        num2 += Constants.EmotesPerPage
    end

    return num2
end

return GetSegmentIndexFromPosition
