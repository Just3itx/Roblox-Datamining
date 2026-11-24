-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T13:10:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsChat = script:FindFirstAncestor("FriendsChat")
local FriendsChatParent = FriendsChat.Parent

local React = require(FriendsChatParent.React)
local _Foundation = require(FriendsChatParent.Foundation)
local ExpChatShared = require(FriendsChatParent.ExpChatShared)
local Autocomplete = require(FriendsChatParent.ChatUIPrimitives.Autocomplete)
local _MessageComposer = require(FriendsChatParent.ChatUIPrimitives.MessageComposer)
local MessageDraftModel = require(FriendsChatParent.ChatUIPrimitives.MessageDraftModel)
local FFlagFriendsChatVoiceTyping = require(FriendsChat.Flags.FFlagFriendsChatVoiceTyping)

local logger = ExpChatShared.Logger:new(script.Name)

local function useFriendsChatComposerViewModel(tbl1)
    local canLocalUserChat = tbl1.canLocalUserChat
    local timeoutOverlay = tbl1.timeoutOverlay
    local onSend = tbl1.onSend
    local onFocusGained = tbl1.onFocusGained
    local onFocusLost = tbl1.onFocusLost

    local chatAvailability = React.useMemo(function()
        return {
            canSend = canLocalUserChat,
            reason = if canLocalUserChat then nil else "timedOut",
            upsell = timeoutOverlay
        }
    end, { canLocalUserChat, timeoutOverlay })

    local messageDelivery = React.useMemo(function()
        return {
            sendMessageDraft = function(arg1)
                local var3 = MessageDraftModel.toPlainText(arg1)
                if var3 ~= nil then
                    onSend(var3)
                end
            end
        }
    end, { onSend })

    local autocomplete = React.useMemo(function()
        return {
            sources = { Autocomplete.BuiltIn.Emoji({ id = "friendsChatEmoji" }) }
        }
    end, {})

    local onFocusChanged = React.useCallback(function(bool1: boolean)
        if bool1 then
            onFocusGained()
            return
        end
        onFocusLost()
    end, { onFocusGained, onFocusLost })

    local dictation = if FFlagFriendsChatVoiceTyping then React.useMemo(function()
        return { surfaceName = "FriendsChat", logger = logger }
    end, {}) else nil

    return {
        chatAvailability = chatAvailability,
        messageDelivery = messageDelivery,
        autocomplete = autocomplete,
        dictation = dictation,
        onFocusChanged = onFocusChanged,
        placeholderText = tbl1.placeholderText,
        maximumCharacterLimit = tbl1.maximumCharacterLimit,
        textBoxRef = tbl1.textBoxRef,
        navigationTargetRef = tbl1.navigationTargetRef,
        transparency = tbl1.transparency
    }
end

return useFriendsChatComposerViewModel
