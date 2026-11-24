-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:10:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")

local Actions = ExpChat.Actions
local MarkChannelUnreadForSystemMessage = require(Actions.MarkChannelUnreadForSystemMessage)
local shouldSuppressUnreadForTabMetadata = require(ExpChat.shouldSuppressUnreadForTabMetadata)

local FFlagExpChatUnreadTabIndicatorV2Window = require(ExpChat.Flags.FFlagExpChatUnreadTabIndicatorV2Window)

local function writeVirtualSystemMessage(tbl1, tbl2)
    tbl1.messagesStore.addSystemMessage(
        tbl2.text,
        tbl2.channelName,
        tbl2.metadata,
        tbl2.postProcessMessage,
        tbl2.isError,
        tbl2.textChannel
    )
    tbl1.resetTextTransparency(tbl2.channelName)

    if tbl1.suppressWelcomeMessageTabUnread and shouldSuppressUnreadForTabMetadata(tbl2.metadata) then
        return
    end

    if tbl1.channelTabsStore then
        tbl1.channelTabsStore.markChannelUnread(tbl2.channelName)
    elseif FFlagExpChatUnreadTabIndicatorV2Window then
        tbl1.store:dispatch(MarkChannelUnreadForSystemMessage(tbl2.text, tbl2.channelName, tbl2.metadata))
    end
end

return writeVirtualSystemMessage
