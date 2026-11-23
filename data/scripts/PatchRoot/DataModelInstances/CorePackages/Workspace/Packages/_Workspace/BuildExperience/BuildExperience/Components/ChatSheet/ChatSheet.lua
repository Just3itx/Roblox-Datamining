-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:40:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")

local BuildExperienceParent = BuildExperience.Parent

local React = require(BuildExperienceParent.React)

local _chatTypes = require(BuildExperience.Chat.chatTypes)
local ChatSheetView = require(script.Parent.ChatSheetView)
local useChatSheetViewModel = require(script.Parent.useChatSheetViewModel)

local function ChatSheet(arg1)
    local var1 = useChatSheetViewModel(arg1)
    return React.createElement(ChatSheetView, var1)
end

return ChatSheet
