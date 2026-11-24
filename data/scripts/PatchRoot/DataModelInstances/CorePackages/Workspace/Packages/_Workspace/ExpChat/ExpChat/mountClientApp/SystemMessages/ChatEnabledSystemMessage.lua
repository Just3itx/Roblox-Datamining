-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:11:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent
local ExpChatShared = require(ExpChatParent.ExpChatShared)

local displaySystemMessage = require(ExpChat.displaySystemMessage)

local str1 = if ExpChatShared.Flags.FFlagExpChatUseUpdatedUserCountStrings then "CoreScripts.TextChat.ChatWindow.ChatEnabled.ChatWithOnlinePlayers.BelowThreshold" else "CoreScripts.TextChat.ChatWindow.ChatEnabled.ChatWithOnlinePlayers.V3"

local function createDisplayChatEnabledMessage(tbl1)
    local translator = tbl1.translator
    local defaultSystemTextChannel = tbl1.defaultSystemTextChannel
    local displayVirtualSystemMessage = tbl1.displayVirtualSystemMessage

    return function()
        if displayVirtualSystemMessage then
            displayVirtualSystemMessage(str1, nil, "👋 Say hi to everyone playing now!")
            return
        end
        displaySystemMessage(
            str1,
            nil,
            "Roblox.ChatEnabled.Info",
            translator,
            defaultSystemTextChannel,
            "👋 Say hi to everyone playing now!"
        )
    end
end

return createDisplayChatEnabledMessage
