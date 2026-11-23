-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:30:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local React = require(AppChatParent.React)
local useNavigation = require(AppChatParent.Navigation).useNavigation

local MessageContextMenuContainer = require(script.Parent.MessageContextMenuContainer)

function MessageContextMenuScreen()
    local var1 = useNavigation()

    return React.createElement(MessageContextMenuContainer, {
        messageId = var1.getParam("messageId"),
        conversationId = var1.getParam("conversationId"),
        inputBoxRef = var1.getParam("inputBoxRef")
    })
end

return MessageContextMenuScreen
