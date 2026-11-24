-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T10:20:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChatShared = script:FindFirstAncestor("ExpChatShared")
local Version = require(ExpChatShared.Version)
local _types = require(script.Parent.types)

return {
    name = script.Name,
    alias = { "/version", "/v" },
    clientRun = function()
        return {
            key = "CoreScripts.TextChat.Version.Success",
            metadata = "Roblox.Version.Info.Success",
            args = {
                RBX_VERSION = string.format("%s (%s)", Version[1], Version[2])
            }
        }
    end
}
