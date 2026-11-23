-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:21:23Z
-- Luau bytecode version: 14 | Luau type version: 3
local AvatarExperienceCommonParent = script:FindFirstAncestor("AvatarExperienceCommon").Parent

return require(AvatarExperienceCommonParent.enumerate)(
    script.Name,
    {
        All = 1,
        Characters = 2,
        Accessories = 11,
        Heads = 5,
        AllAnimations = 12,
        Body = 18,
        Clothing = 3
    }
)
