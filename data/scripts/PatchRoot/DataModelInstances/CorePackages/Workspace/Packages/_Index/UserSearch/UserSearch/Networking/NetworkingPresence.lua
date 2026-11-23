-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T03:10:54Z
-- Luau bytecode version: 14 | Luau type version: 3
local UserSearch = script:FindFirstAncestor("UserSearch")
local UserSearchParent = UserSearch.Parent
local LuaSocialLibrariesDeps = require(UserSearchParent.LuaSocialLibrariesDeps)
local myRoduxNetworking = require(UserSearch.Networking.myRoduxNetworking)

if require(UserSearch.Flags.FFlagUserSearchPresenceStoreMigration) then
    return nil
end

return (LuaSocialLibrariesDeps.NetworkingPresence.config({ roduxNetworking = myRoduxNetworking }))
