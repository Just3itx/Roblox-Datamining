-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T18:51:01Z
-- Luau bytecode version: 14 | Luau type version: 3
local SocialExperienceJoin = script:FindFirstAncestor("SocialExperienceJoin")
local SocialExperienceJoinParent = SocialExperienceJoin.Parent
local Constants = require(SocialExperienceJoin.Common.Constants)
return require(SocialExperienceJoinParent.LuaSocialLibrariesDeps).RoduxGames.config(
    {
        keyPath = Constants.RODUX_KEY .. ".Games"
    }
)
