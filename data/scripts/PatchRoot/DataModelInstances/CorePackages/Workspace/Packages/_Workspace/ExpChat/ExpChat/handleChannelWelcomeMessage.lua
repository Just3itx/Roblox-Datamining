-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T08:51:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent
local Set = require(ExpChatParent.llama).Set

local getOtherDisplayNameInWhisperChannel = require(ExpChat.getOtherDisplayNameInWhisperChannel)

local tbl1 = {}

return function(arg1, arg2)
    if arg1.TextChannel and string.find(arg1.TextChannel.Name, "^RBXWhisper") and not Set.has(tbl1, arg1.TextChannel) then
        local rbxName = getOtherDisplayNameInWhisperChannel(arg1.TextChannel, arg2)
        if rbxName then
            tbl1 = Set.add(tbl1, arg1.TextChannel)
            return {
                key = "CoreScripts.TextChat.Notification.WhisperChat.Created",
                args = { RBX_NAME = rbxName },
                metadata = "Roblox.Whisper.Welcome.Sent"
            }
        end
    end

    return nil
end
