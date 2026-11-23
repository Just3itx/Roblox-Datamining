-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:50:46Z
-- Luau bytecode version: 14 | Luau type version: 3
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local NetworkingPresence = require(AppChatParent.LuaSocialLibrariesDeps).NetworkingPresence

local RoduxNetworking = require(script.Parent.RoduxNetworking)

if require(AppChat.Flags.FFlagAppChatPresenceStoreMigration) then
    return nil
end

return (NetworkingPresence.config({ roduxNetworking = RoduxNetworking }))
