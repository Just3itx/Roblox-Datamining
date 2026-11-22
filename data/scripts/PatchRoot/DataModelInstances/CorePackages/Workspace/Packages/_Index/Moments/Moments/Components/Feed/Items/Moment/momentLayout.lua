-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:11:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local _Foundation = require(MomentsParent.Foundation)

return {
    BOTTOM_UI_MAX_SIZE = Vector2.new(600, math.huge),
    AVATAR_SIZE = 30,
    USERNAME_SHIMMER = Vector2.new(160, 16),
    getInfoBottomGap = function(arg1, num1: number, num2: number)
        if num1 > 0 then
            return arg1.Padding.Medium
        end
        return math.max(arg1.Padding.XLarge, num2)
    end
}
