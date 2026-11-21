-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:40:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatUIPrimitives = script:FindFirstAncestor("ChatUIPrimitives")
local ChatUIPrimitivesParent = ChatUIPrimitives.Parent
local React = require(ChatUIPrimitivesParent.React)
local Foundation = require(ChatUIPrimitivesParent.Foundation)
local _Signals = require(ChatUIPrimitivesParent.Signals)
local createNextOrder = require(ChatUIPrimitivesParent.ReactUtils).createNextOrder

local _groupMessages = require(script.Parent.Parent.groupMessages)

local FFlagExpChatMessageAvatarAdornment = require(ChatUIPrimitives.Flags.FFlagExpChatMessageAvatarAdornment)
local MessageAvatar = require(script.Parent.Parent.Parent.Adornments.MessageAvatar)
local BubbleAvatar = require(script.Parent.BubbleAvatar)
local Sizing = require(script.Parent.Parent.Parent.Sizing)
local BubbleStyleContext = require(script.Parent.BubbleStyleContext)
local BubbleUsername = require(script.Parent.BubbleUsername)
local BubbleView = require(script.Parent.BubbleView)
local ReplyQuote = require(script.Parent.Parent.Reply.ReplyQuote)
local getBubbleTone = require(script.Parent.getBubbleTone)
local useMessageBubbleViewModel = require(script.Parent.useMessageBubbleViewModel)
local useFinishMessageRenderIntervals = require(script.Parent.Parent.useFinishMessageRenderIntervals)
local FFlagExpChatMessageListScrollParity = require(ChatUIPrimitives.Flags.FFlagExpChatMessageListScrollParity)
local withMessageContent = require(script.Parent.Parent.Parent.ContentKinds.withMessageContent)
local PlainTextContentModel = require(script.Parent.Parent.Parent.ContentKinds.PlainText.PlainTextContentModel)
local PlainTextBubble = require(script.Parent.Parent.Parent.ContentKinds.PlainText.PlainTextBubble)
local PresetContentModel = require(script.Parent.Parent.Parent.ContentKinds.Preset.PresetContentModel)
local PresetBubble = require(script.Parent.Parent.Parent.ContentKinds.Preset.PresetBubble)
local EmojiContentModel = require(script.Parent.Parent.Parent.ContentKinds.Emoji.EmojiContentModel)
local EmojiBubble = require(script.Parent.Parent.Parent.ContentKinds.Emoji.EmojiBubble)

local tbl1 = {
    plainText = withMessageContent(PlainTextBubble, PlainTextContentModel.getDetail),
    preset = withMessageContent(PresetBubble, PresetContentModel.getDetail),
    emoji = withMessageContent(EmojiBubble, EmojiContentModel.getDetail)
}

local function MessageBubbleItem(tbl2)
    local var1 = useMessageBubbleViewModel(tbl2.itemSignal)
    if FFlagExpChatMessageListScrollParity then
        useFinishMessageRenderIntervals(tbl2.itemSignal)
    end
    local var2 = Foundation.Hooks.useTokens()
    local var3 = Sizing.useSizing()
    local bool1 = var3.density == "compact"
    local nextOrder = createNextOrder()
    local bool2 = var1.deliveryState == "sending"
    local var4 = React.useMemo(function()
        local bubbleTone = getBubbleTone(var1.isObservingUser, var2, bool2)
        return {
            backgroundStyle = bubbleTone.backgroundStyle,
            style = {
                textStyle = bubbleTone.textStyle
            }
        }
    end, { var1.isObservingUser, var2, bool2 })

    local tbl3 = ({})

    for layoutOrder, content in var1.contents do
        local var5 = tbl1[content.kind]
        if not var5 then
            continue
        end

        local var6 = "content" .. layoutOrder
        tbl3[var6] = React.createElement(var5, { getContent = content.getContent, LayoutOrder = layoutOrder })
    end

    local bool3 = var1.alignment == "right"
    local isFirst = var1.groupPosition.isFirst
    local nextOrder2 = createNextOrder()
    local tbl4 = {}
    if var1.replyText ~= nil then
        tbl4.Reply = React.createElement(
            ReplyQuote.Bubble,
            {
                text = var1.replyText,
                label = var1.replyLabel,
                isObservingUser = var1.isObservingUser,
                LayoutOrder = nextOrder2()
            }
        )
    end

    if var1.showUsername then
        tbl4.Username = React.createElement(
            BubbleUsername,
            {
                getIdentity = var1.getIdentity,
                LayoutOrder = nextOrder2(),
                testId = "bubble-username"
            }
        )
    end
    tbl4.Bubble = React.createElement(BubbleView, {
        backgroundStyle = var4.backgroundStyle,
        cornerRadii = var1.cornerRadii,
        LayoutOrder = nextOrder2(),
        testId = "message-bubble"
    }, tbl3)

    local tbl5 = {}
    if not var1.isObservingUser then
        if FFlagExpChatMessageAvatarAdornment then
            tbl5.Avatar = React.createElement(MessageAvatar, {
                getIdentity = var1.getIdentity,
                visible = var1.showAvatar,
                sizeTag = var3.avatar.tag,
                LayoutOrder = nextOrder(),
                testId = "bubble-avatar"
            })
        else
            tbl5.Avatar = React.createElement(
                BubbleAvatar,
                {
                    getIdentity = var1.getIdentity,
                    visible = var1.showAvatar,
                    LayoutOrder = nextOrder(),
                    testId = "bubble-avatar"
                }
            )
        end
    end
    tbl5.Stack = React.createElement(Foundation.View, {
        tag = {
            ["col align-x-right gap-xxsmall auto-xy"] = bool3,
            ["col align-x-left gap-xxsmall auto-xy"] = not bool3
        },
        LayoutOrder = nextOrder()
    }, tbl4)

    return React.createElement(BubbleStyleContext.Context.Provider, {
        value = var4.style
    }, {
        Row = React.createElement(Foundation.View, {
            tag = {
                ["size-full-0 auto-y"] = true,
                ["col align-x-right"] = bool3,
                ["row align-x-left align-y-bottom"] = not bool3,
                ["gap-xsmall"] = not (bool3 or bool1),
                ["gap-xxsmall"] = not bool3 and bool1,
                ["padding-top-small"] = isFirst,
                ["padding-top-xxsmall"] = not isFirst
            },
            testId = "message-bubble-row"
        }, tbl5)
    })
end

return MessageBubbleItem
