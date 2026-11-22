-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T05:40:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local _Foundation = require(MomentsParent.Foundation)

local function getColorStyleWithTransparency(arg1, num1: number)
    return {
        Color3 = arg1.Color3,
        Transparency = 1 - (1 - (arg1.Transparency or 0)) * (1 - num1)
    }
end

return getColorStyleWithTransparency
