-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T06:01:20Z
-- Luau bytecode version: 14 | Luau type version: 3
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent
local LuaSocialLibrariesDeps = require(ProfilePlatformParent.LuaSocialLibrariesDeps)
local myRoduxNetworking = require(ProfilePlatform.Networking.myRoduxNetworking)

if require(ProfilePlatform.Flags.FFlagProfilePlatformPresenceStoreMigration) then
    return nil
end

return (LuaSocialLibrariesDeps.NetworkingPresence.config({ roduxNetworking = myRoduxNetworking }))
