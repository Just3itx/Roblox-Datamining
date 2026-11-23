-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:21:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local Foundation = require(AppChatParent.Foundation)
local React = require(AppChatParent.React)
local ViewRecycler = require(AppChatParent.ViewRecycler)

local ConversationMessageSkeletonList = require(AppChat.Components.ChatConversation.ConversationMessageSkeletonList)
local MessageListContext = require(script.Parent.MessageListContext)

local function renderLoading(bool1: boolean) -- Luacid: Inlined by compiler; 2 call sites recovered
    if bool1 then
        return React.createElement(ConversationMessageSkeletonList, { size = UDim2.fromScale(1, 1) })
    end

    return nil
end

return React.memo(function(tbl1) -- name: MessageListV2View
    local createElement = React.createElement
    local provider = MessageListContext.Provider
    local tbl2 = {
        value = tbl1.contextValue
    }
    local tbl3 = { Content = 0 }
    local element

    if tbl1.isLoading then
        if tbl1.showLoadingSkeleton then
            element = renderLoading(true)
        else
            element = nil
        end
    else
        element = React.createElement(Foundation.View, {
            Size = UDim2.fromScale(1, 1)
        }, {
            List = React.createElement(ViewRecycler.VirtualList, tbl1.listProps),
            Loading = if tbl1.isListVisible or not tbl1.showLoadingSkeleton then nil else renderLoading(true)
        })
    end

    tbl3.Content = element
    return createElement(provider, tbl2, tbl3)
end)
