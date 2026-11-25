-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T19:01:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local React = require(scriptParentParent.React)
local Responsive = require(scriptParentParent.Responsive)
local Autocomplete = require(scriptParentParent.ChatUIPrimitives.Autocomplete)
local _MessageComposer = require(scriptParentParent.ChatUIPrimitives.MessageComposer)
local Logger = require(script.Parent.Logger)
local sendMessageDraft = require(script.Parent.TextChannelWindowExpressionTray.sendMessageDraft)

local FFlagExpChatTextChannelWindowDictationHandsFree = require(script.Parent.Flags.FFlagExpChatTextChannelWindowDictationHandsFree)

local function useTextChannelWindowComposerViewModel(tbl1)
    local canChat = tbl1.canChat
    local canChatFreely = tbl1.canChatFreely
    local targetChannel = tbl1.targetChannel
    local disabledOverlay = tbl1.disabledOverlay
    local onSend = tbl1.onSend
    local windowName = tbl1.windowName

    local chatAvailability = React.useMemo(function()
        return {
            canSend = canChat,
            upsell = if canChat then nil else disabledOverlay
        }
    end, { canChat, disabledOverlay })

    local messageDelivery = React.useMemo(function()
        return {
            sendMessageDraft = function(arg1)
                sendMessageDraft(arg1, targetChannel, canChatFreely, onSend)
            end
        }
    end, { onSend, targetChannel, canChatFreely })

    local autocomplete = React.useMemo(function()
        return {
            sources = { Autocomplete.BuiltIn.Emoji({ id = "textChannelWindowEmoji" }) }
        }
    end, {})

    local bool1 = if FFlagExpChatTextChannelWindowDictationHandsFree then Responsive.usePreferredInput() == Responsive.Input.Directional else false
    local handsFreeEnabled = FFlagExpChatTextChannelWindowDictationHandsFree and not bool1

    local dictation = React.useMemo(function()
        return { surfaceName = windowName, logger = Logger, handsFreeEnabled = handsFreeEnabled }
    end, { windowName, handsFreeEnabled })

    return {
        chatAvailability = chatAvailability,
        messageDelivery = messageDelivery,
        autocomplete = autocomplete,
        expressionTray = tbl1.expressionTray,
        dictation = dictation,
        placeholderText = tbl1.placeholderText,
        maximumCharacterLimit = 200,
        textBoxRef = tbl1.textBoxRef,
        fontFace = tbl1.fontFace
    }
end

return useTextChannelWindowComposerViewModel
