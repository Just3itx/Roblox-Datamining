-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T10:20:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _types = require(script.Parent.types)

local engineFeature = game:GetEngineFeature("ExpChatLocalUserCountEnabled")
local bool1 = game:DefineFastFlag("ExpChatEnableVirtualLocalOnlineCommand", false)

return {
    name = script.Name,
    alias = { "/help", "/?" },
    clientRun = function()
        if engineFeature and bool1 then
            return {
                key = {
                    "CoreScripts.TextChat.Help.FirstLine",
                    "CoreScripts.TextChat.Clear.Help.Description",
                    "InGame.UnknownNamespace.GameChat_ChatCommandsTeller_MuteCommand",
                    "CoreScripts.TextChat.Online.Help.Description3",
                    "InGame.UnknownNamespace.GameChat_ChatCommandsTeller_TeamCommand",
                    "InGame.UnknownNamespace.GameChat_ChatCommandsTeller_UnMuteCommand",
                    "InGame.UnknownNamespace.GameChat_ChatCommandsTeller_WhisperCommand"
                },
                metadata = "Roblox.Help.Info",
                args = nil
            }
        end

        return {
            key = {
                "CoreScripts.TextChat.Help.FirstLine",
                "InGame.UnknownNamespace.GameChat_ChatCommandsTeller_WhisperCommand",
                "InGame.UnknownNamespace.GameChat_ChatCommandsTeller_TeamCommand",
                "InGame.UnknownNamespace.GameChat_ChatCommandsTeller_MuteCommand",
                "InGame.UnknownNamespace.GameChat_ChatCommandsTeller_UnMuteCommand",
                "CoreScripts.TextChat.Clear.Help.Description"
            },
            metadata = "Roblox.Help.Info",
            args = nil
        }
    end
}
