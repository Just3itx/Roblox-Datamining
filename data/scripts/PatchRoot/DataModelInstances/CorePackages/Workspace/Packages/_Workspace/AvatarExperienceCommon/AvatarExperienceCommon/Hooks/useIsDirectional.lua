-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:31:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommonParent = script:FindFirstAncestor("AvatarExperienceCommon").Parent

local Responsive = require(AvatarExperienceCommonParent.Responsive)

local function useIsDirectional(): boolean
    local var1 = Responsive.useLastInput()
    return Responsive.usePreferredInput() == Responsive.Input.Directional or var1 == Responsive.Input.Directional
end

return useIsDirectional
