-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T10:30:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")

local _types = require(script.Parent.types)

return {
    name = script.Name,
    alias = { "/mute", "/m" },
    clientRun = function(_, _, arg1, arg2)
        local str1 = string.split(arg1, " ")[2]
        local bool1 = not (str1 == nil) and string.sub(str1, 1, 1) == "@"

        if bool1 then
            str1 = string.sub(str1, 2)
        end
        if not str1 or #str1 < 3 then
            return {
                key = "CoreScripts.TextChat.Mute.Error.TargetDoesNotExist",
                args = {
                    RBX_NAME = str1 or ""
                },
                metadata = "Roblox.GlobalMute.Error.PlayerNotFound"
            }
        end

        if not (arg2 and arg2.globalMutedUsersStore) then
            return {
                key = "CoreScripts.TextChat.MessageStatus.Warning.Unknown",
                args = {},
                metadata = "Roblox.GlobalMute.Error.ContextNotAvailable"
            }
        end

        if not bool1 then
            arg2.globalMutedUsersStore.muteGlobalDisplayName(str1)
            return {
                key = "CoreScripts.TextChat.Mute.Success",
                args = { RBX_NAME = str1 },
                metadata = "Roblox.GlobalMute.Info.Success"
            }
        end

        local str2 = string.lower(str1)
        if Players.LocalPlayer and string.lower(Players.LocalPlayer.Name) == str2 then
            return {
                key = "CoreScripts.TextChat.Mute.Error.CannotMuteSelf",
                args = {},
                metadata = "Roblox.GlobalMute.Error.CannotMuteSelf"
            }
        end

        arg2.globalMutedUsersStore.muteGlobalUsername(str2)
        return {
            key = "CoreScripts.TextChat.Mute.Success",
            args = {
                RBX_NAME = "@" .. str2
            },
            metadata = "Roblox.GlobalMute.Info.Success"
        }
    end
}
