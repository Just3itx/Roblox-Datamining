-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T10:30:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _types = require(script.Parent.types)

local bool1 = game:DefineFastFlag("ExpChatEnableGlobalOnlineCommand", false)
local engineFeature = game:GetEngineFeature("ExpChatGlobalUserCountEnabled")

return {
    name = script.Name,
    alias = { "/help" },
    clientRun = function()
        if engineFeature and bool1 then
            return {
                key = {
                    "CoreScripts.TextChat.Help.FirstLine",
                    "CoreScripts.TextChat.Clear.Help.Description",
                    "CoreScripts.TextChat.ChatCommands.Mute.Description",
                    "CoreScripts.TextChat.Online.Help.Description3",
                    "CoreScripts.TextChat.ChatCommands.Unmute.Description"
                },
                metadata = "Roblox.GlobalHelp.Info",
                args = nil
            }
        end

        return {
            key = {
                "CoreScripts.TextChat.Help.FirstLine",
                "CoreScripts.TextChat.ChatCommands.Mute.Description",
                "CoreScripts.TextChat.ChatCommands.Unmute.Description",
                "CoreScripts.TextChat.Clear.Help.Description"
            },
            metadata = "Roblox.GlobalHelp.Info",
            args = nil
        }
    end
}
