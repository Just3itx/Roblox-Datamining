-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T05:11:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceUIKitParent = script:FindFirstAncestor("AvatarExperienceUIKit").Parent
local ReactOtter = require(AvatarExperienceUIKitParent.ReactOtter)
local getUserSettings = require(script.Parent.getUserSettings)

local function makeOtterSpringValue(num1: number, arg1)
    if getUserSettings().ReducedMotion then
        return ReactOtter.instant(num1)
    end
    return ReactOtter.spring(num1, arg1)
end

return makeOtterSpringValue
