-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:40:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatUIPrimitivesParent = script:FindFirstAncestor("ChatUIPrimitives").Parent
local React = require(ChatUIPrimitivesParent.React)
local Foundation = require(ChatUIPrimitivesParent.Foundation)
local _Signals = require(ChatUIPrimitivesParent.Signals)
local createNextOrder = require(ChatUIPrimitivesParent.ReactUtils).createNextOrder

local _groupMessages = require(script.Parent.Parent.groupMessages)

local Sizing = require(script.Parent.Parent.Parent.Sizing)
local MessageAvatar = require(script.Parent.Parent.Parent.Adornments.MessageAvatar)
local DiscussionTopLine = require(script.Parent.DiscussionTopLine)
local useMessageDiscussionViewModel = require(script.Parent.useMessageDiscussionViewModel)
local withMessageContent = require(script.Parent.Parent.Parent.ContentKinds.withMessageContent)
local PlainTextContentModel = require(script.Parent.Parent.Parent.ContentKinds.PlainText.PlainTextContentModel)
local PlainTextInline = require(script.Parent.Parent.Parent.ContentKinds.PlainText.PlainTextInline)
local EmojiContentModel = require(script.Parent.Parent.Parent.ContentKinds.Emoji.EmojiContentModel)
local EmojiInline = require(script.Parent.Parent.Parent.ContentKinds.Emoji.EmojiInline)

local tbl1 = {
    plainText = withMessageContent(PlainTextInline, PlainTextContentModel.getDetail),
    emoji = withMessageContent(EmojiInline, EmojiContentModel.getDetail)
}

local function MessageDiscussionItem(tbl2)
    local var1 = useMessageDiscussionViewModel(tbl2.itemSignal)
    local discussion = Sizing.useSizing().discussion
    local nextOrder = createNextOrder()
    local nextOrder2 = createNextOrder()

    local tbl3 = {}
    if var1.showIdentity then
        tbl3.TopLine = React.createElement(DiscussionTopLine, {
            getIdentity = var1.getIdentity,
            getSentAtUnixMilliseconds = var1.getSentAtUnixMilliseconds,
            tag = discussion.topLineTag,
            nameTag = discussion.nameTag,
            timestampTag = discussion.timestampTag,
            LayoutOrder = nextOrder2(),
            testId = "discussion-top-line"
        })
    end

    for k, content in var1.contents do
        local var2 = tbl1[content.kind]
        if not var2 then
            continue
        end

        local var3 = "content" .. k
        tbl3[var3] = React.createElement(var2, { getContent = content.getContent, LayoutOrder = nextOrder2() })
    end

    return React.createElement(Foundation.View, {
        tag = if var1.showIdentity then discussion.headRowTag else discussion.continuationRowTag,
        testId = "message-discussion-row"
    }, {
        Avatar = React.createElement(MessageAvatar, {
            getIdentity = var1.getIdentity,
            visible = var1.showIdentity,
            sizeTag = discussion.avatarTag,
            gutterTag = discussion.gutterTag,
            LayoutOrder = nextOrder(),
            testId = "discussion-avatar"
        }),
        Column = React.createElement(Foundation.View, { tag = discussion.columnTag, LayoutOrder = nextOrder() }, tbl3)
    })
end

return MessageDiscussionItem
