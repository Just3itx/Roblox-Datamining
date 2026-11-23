-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:21:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local React = require(AppChatParent.React)

local MessageListV2View = require(script.Parent.MessageListV2View)
local useMessageListV2ViewModel = require(script.Parent.useMessageListV2ViewModel)

local function ConversationMessageList(arg1)
    local var1 = useMessageListV2ViewModel(arg1)
    return React.createElement(MessageListV2View, var1)
end

return React.memo(function(arg1) -- name: MessageListV2Container
    local var1 = table.clone(arg1)
    var1.key = arg1.conversationId
    return React.createElement(ConversationMessageList, var1)
end)
