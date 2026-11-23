-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T16:40:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceInspectAndBuy = script:FindFirstAncestor("AvatarExperienceInspectAndBuy")
local ViewType = require(AvatarExperienceInspectAndBuy.Enums.ViewType)

local num1 = game:DefineFastInt("MobileBreakpointInspectAndBuy", 850)

local function getViewType(vector2: Vector2)
    local wide = ViewType.Wide

    if vector2.X > vector2.Y and vector2.X < num1 then
        return ViewType.WideLandscape
    end

    if vector2.X < num1 then
        wide = ViewType.Compact
    end

    return wide
end

return getViewType
