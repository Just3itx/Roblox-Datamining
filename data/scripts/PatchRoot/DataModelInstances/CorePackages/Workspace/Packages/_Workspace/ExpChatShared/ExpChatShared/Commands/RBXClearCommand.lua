-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T10:20:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _types = require(script.Parent.types)

return {
    name = script.Name,
    alias = { "/clear", "/cls" },
    clientRun = function(_, _, _, arg1)
        if not (arg1 and arg1.messagesStore) then
            return {
                key = "CoreScripts.TextChat.MessageStatus.Warning.Unknown",
                args = {},
                metadata = "Roblox.Clear.Error.ContextNotAvailable"
            }
        end

        arg1.messagesStore.clearWindowMessages()

        return { key = "", metadata = "Roblox.Clear.Info.Success" }
    end
}
