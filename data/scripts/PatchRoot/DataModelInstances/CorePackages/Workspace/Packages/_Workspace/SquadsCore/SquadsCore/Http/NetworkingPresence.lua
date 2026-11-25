-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T18:01:07Z
-- Luau bytecode version: 14 | Luau type version: 3
local SquadsCore = script:FindFirstAncestor("SquadsCore")
local SquadsCoreParent = SquadsCore.Parent

local RoduxNetworking = require(script.Parent.RoduxNetworking)

local LuaSocialLibrariesDeps = require(SquadsCoreParent.LuaSocialLibrariesDeps)

if require(SquadsCore.Flags.FFlagSquadsPresenceStoreMigration) then
    return nil
end

return (LuaSocialLibrariesDeps.NetworkingPresence.config({ roduxNetworking = RoduxNetworking }))
