-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T10:20:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TextChatService = game:GetService("TextChatService")

local ExpChatShared = script:FindFirstAncestor("ExpChatShared")
local var1 = require(ExpChatShared.Logger):new("ExpChat/Command/Online")

local _types = require(script.Parent.types)

local FFlagExpChatUseUpdatedUserCountStrings = require(ExpChatShared.Flags.FFlagExpChatUseUpdatedUserCountStrings)

return {
    name = script.Name,
    alias = { "/online" },
    clientRun = function(_, userId: number | User, _, _)
        local success, result = pcall(function(): number
            return TextChatService:GetChatableUserCountAsync(userId, "local")
        end)

        if not success then
            var1:warning("GetChatableUserCountAsync ({}) failed: {}", "local", tostring(result))
            return nil
        end

        return {
            key = FFlagExpChatUseUpdatedUserCountStrings
                and (if result == 1 then "CoreScripts.TextChat.Online.Success.Singular3" else "CoreScripts.TextChat.Online.Success.Plural2")
                or (if result == 1 then "CoreScripts.TextChat.Online.Success.Singular" else "CoreScripts.TextChat.Online.Success.Plural"),
            metadata = "Roblox.Online.Info",
            args = { RBX_COUNT = result }
        }
    end
}
