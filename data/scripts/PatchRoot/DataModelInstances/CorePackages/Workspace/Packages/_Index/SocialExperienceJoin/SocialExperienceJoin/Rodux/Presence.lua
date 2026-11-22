-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T18:51:03Z
-- Luau bytecode version: 14 | Luau type version: 3
local SocialExperienceJoin = script:FindFirstAncestor("SocialExperienceJoin")
local SocialExperienceJoinParent = SocialExperienceJoin.Parent
local Constants = require(SocialExperienceJoin.Common.Constants)
local LuaSocialLibrariesDeps = require(SocialExperienceJoinParent.LuaSocialLibrariesDeps)

if require(SocialExperienceJoin.Flags.FFlagSocialExperienceJoinPresenceStoreMigration) then
    return nil
end

return (LuaSocialLibrariesDeps.RoduxPresence.config({ keyPath = Constants.RODUX_KEY .. ".Presence" }))
