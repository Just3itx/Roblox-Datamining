-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:51:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")

local useProfileWrapperContext = require(ProfilePlatform.Contexts.useProfileWrapperContext)
local Enums = require(ProfilePlatform.Common.Enums)

local function useIsMeTab(): boolean
    return useProfileWrapperContext().headerVariant == Enums.ProfileTabVariants.MeTab
end

return useIsMeTab
