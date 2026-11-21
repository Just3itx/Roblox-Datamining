-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:40:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatUIPrimitives = script:FindFirstAncestor("ChatUIPrimitives")
local ChatUIPrimitivesParent = ChatUIPrimitives.Parent
local React = require(ChatUIPrimitivesParent.React)
local Foundation = require(ChatUIPrimitivesParent.Foundation)
local _Signals = require(ChatUIPrimitivesParent.Signals)
local createNextOrder = require(ChatUIPrimitivesParent.ReactUtils).createNextOrder

local _groupMessages = require(script.Parent.Parent.groupMessages)

local IdentityInline = require(script.Parent.Parent.Parent.Identity.IdentityInline)
local ReplyQuote = require(script.Parent.Parent.Reply.ReplyQuote)
local useMessageInlineViewModel = require(script.Parent.useMessageInlineViewModel)
local useFinishMessageRenderIntervals = require(script.Parent.Parent.useFinishMessageRenderIntervals)
local FFlagExpChatMessageListScrollParity = require(ChatUIPrimitives.Flags.FFlagExpChatMessageListScrollParity)
local withMessageContent = require(script.Parent.Parent.Parent.ContentKinds.withMessageContent)
local PlainTextContentModel = require(script.Parent.Parent.Parent.ContentKinds.PlainText.PlainTextContentModel)
local PlainTextInline = require(script.Parent.Parent.Parent.ContentKinds.PlainText.PlainTextInline)
local PresetContentModel = require(script.Parent.Parent.Parent.ContentKinds.Preset.PresetContentModel)
local PresetInline = require(script.Parent.Parent.Parent.ContentKinds.Preset.PresetInline)
local EmojiContentModel = require(script.Parent.Parent.Parent.ContentKinds.Emoji.EmojiContentModel)
local EmojiInline = require(script.Parent.Parent.Parent.ContentKinds.Emoji.EmojiInline)

local tbl1 = {
    plainText = withMessageContent(PlainTextInline, PlainTextContentModel.getDetail),
    preset = withMessageContent(PresetInline, PresetContentModel.getDetail),
    emoji = withMessageContent(EmojiInline, EmojiContentModel.getDetail)
}

local function MessageInlineItem(tbl2)
    local var1 = useMessageInlineViewModel(tbl2.itemSignal)
    if FFlagExpChatMessageListScrollParity then
        useFinishMessageRenderIntervals(tbl2.itemSignal)
    end
    local nextOrder = createNextOrder()

    local tbl3 = ({})
    for layoutOrder, content in var1.contents do
        local var2 = tbl1[content.kind]
        if not var2 then
            continue
        end

        local var3 = "content" .. layoutOrder
        tbl3[var3] = React.createElement(var2, { getContent = content.getContent, LayoutOrder = layoutOrder })
    end

    local tbl4 = {}
    if var1.hasIdentity then
        tbl4.Identity = React.createElement(IdentityInline, { getIdentity = var1.getIdentity, LayoutOrder = nextOrder() })
    end

    tbl4.Message = React.createElement(Foundation.View, { tag = "col grow size-0 auto-y", LayoutOrder = nextOrder() }, tbl3)

    return React.createElement(Foundation.View, { tag = "col size-full-0 auto-y" }, {
        Reply = if var1.replyText == nil then nil else React.createElement(ReplyQuote.Inline, { text = var1.replyText, LayoutOrder = 1 }),
        Row = React.createElement(Foundation.View, { tag = "row align-x-left gap-xsmall size-full-0 auto-y", LayoutOrder = 2 }, tbl4)
    })
end

return MessageInlineItem
