-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:51:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local Cryo = require(AppChatParent.Cryo)
local Rodux = require(AppChatParent.Rodux)
local Logger = require(AppChat.Logger)

local RemovedConversation = require(AppChat.Conversations.Actions.RemovedConversation)
local FriendConversationCreated = require(AppChat.Conversations.Actions.FriendConversationCreated)
local ConversationChannels = require(AppChat.Models.ConversationChannels)
local DismissedChatModal = require(AppChat.Conversations.Actions.DismissedChatModal)

local DismissedAllConversationModalsForSequence = require(AppChat.Conversations.Actions.DismissedAllConversationModalsForSequence)
local FFlagDebugAppChatFae = require(AppChat.Flags.FFlagDebugAppChatFae)
local FFlagDebugAEGIS1AppChatBanner = require(AppChat.Flags.FFlagDebugAEGIS1AppChatBanner)
local FFlagTCUpsellModalEnabled_DEV = require(AppChatParent.SharedFlags).FFlagTCUpsellModalEnabled_DEV
local FFlagDebugEnableTCDoubleOptIn_DEV = require(AppChatParent.SharedFlags).FFlagDebugEnableTCDoubleOptIn_DEV

local FFlagEnableAEGIS2AppChatConversationBanner = require(AppChatParent.SharedFlags).FFlagEnableAEGIS2AppChatConversationBanner

local AppChatNetworking = require(AppChatParent.AppChatNetworking)
local ModalSequence = AppChatNetworking.Constants.ModalSequence

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[AppChatNetworking.rodux.GetChatLandingModal.Succeeded.name] = function(tbl2, arg1)
    local responseBody = arg1.responseBody

    return Cryo.Dictionary.join(tbl2, { chatLandingModal = responseBody })
end

tbl1[AppChatNetworking.rodux.GetModalSequence.Succeeded.name] = function(tbl2, arg1)
    local conversationId = arg1.postBody and arg1.postBody.conversation_id
    local friendId = arg1.postBody and arg1.postBody.friend_id
    if friendId and not conversationId then
        conversationId = ConversationChannels.getFriendConversationId({ friendId })
    end
    if arg1.postBody.modal_sequence == ModalSequence.ConversationOverlay then
        if not conversationId then
            return tbl2
        end
        return Cryo.Dictionary.join(
            tbl2,
            {
                conversationOverlays = Cryo.Dictionary.join(tbl2.conversationOverlays, { [conversationId] = arg1.responseBody })
            }
        )
    elseif arg1.postBody.modal_sequence == ModalSequence.ConversationTopModal then
        if not conversationId then
            return tbl2
        end
        return Cryo.Dictionary.join(
            tbl2,
            {
                conversationTopModals = Cryo.Dictionary.join(tbl2.conversationTopModals, { [conversationId] = arg1.responseBody })
            }
        )
    elseif arg1.postBody.modal_sequence == ModalSequence.ConversationBottomModal then
        if not conversationId then
            return tbl2
        end
        return Cryo.Dictionary.join(tbl2, {
            conversationBottomModals = Cryo.Dictionary.join(tbl2.conversationBottomModals, { [conversationId] = arg1.responseBody })
        })
    else
        Logger:warning(`GetModalSequence.Succeeded with unsupported modal sequence: {arg1.postBody.modal_sequence}`)

        return tbl2
    end
end

tbl1[DismissedChatModal.name] = function(tbl2, arg1)
    local key = arg1.key
    local modalSequence = arg1.modalSequence

    if modalSequence == ModalSequence.ConversationOverlay then
        if not key then
            return tbl2
        end
        return Cryo.Dictionary.join(
            tbl2,
            {
                conversationOverlays = Cryo.Dictionary.join(tbl2.conversationOverlays, { [key] = Cryo.None })
            }
        )
    elseif modalSequence == ModalSequence.ConversationTopModal then
        if not key then
            return tbl2
        end
        return Cryo.Dictionary.join(
            tbl2,
            {
                conversationTopModals = Cryo.Dictionary.join(tbl2.conversationTopModals, { [key] = Cryo.None })
            }
        )
    else
        return tbl2
    end
end

tbl1[DismissedAllConversationModalsForSequence.name] = function(tbl2, arg1)
    local modalSequence = arg1.modalSequence

    if not FFlagEnableAEGIS2AppChatConversationBanner or modalSequence ~= ModalSequence.ConversationBottomModal then
        Logger:warning(
            `DismissedAllConversationModalsForSequence received unsupported modal sequence: {modalSequence} `
        )
        return tbl2
    end

    Logger:debug("Removing all modals of sequence:ConversationBottomModal from the store")
    local tbl3 = ({})
    for k, _ in tbl2.conversationBottomModals do
        tbl3[k] = Cryo.None
    end
    return Cryo.Dictionary.join(tbl2, { conversationBottomModals = Cryo.Dictionary.join(tbl2.conversationBottomModals, tbl3) })
end

tbl1[AppChatNetworking.rodux.GetPendingStateModal.Succeeded.name] = function(tbl2, arg1)
    local conversationId = arg1.postBody and arg1.postBody.conversation_id
    if not conversationId then
        return tbl2
    end

    return Cryo.Dictionary.join(
        tbl2,
        {
            pendingStateModals = Cryo.Dictionary.join(tbl2.pendingStateModals, { [conversationId] = arg1.responseBody })
        }
    )
end

tbl1[RemovedConversation.name] = function(tbl2, arg1)
    local conversationId = arg1.conversationId
    if not conversationId then
        return tbl2
    end
    return Cryo.Dictionary.join(tbl2, {
        conversationTopModals = Cryo.Dictionary.join(tbl2.conversationTopModals, { [conversationId] = Cryo.None }),
        pendingStateModals = Cryo.Dictionary.join(tbl2.pendingStateModals, { [conversationId] = Cryo.None }),
        conversationBottomModals = Cryo.Dictionary.join(tbl2.conversationBottomModals, { [conversationId] = Cryo.None })
    })
end

tbl1[FriendConversationCreated.name] = function(tbl2, arg1)
    local oldFriendConversationId = arg1.oldFriendConversationId
    local newConversationId = arg1.newConversationId

    if not (oldFriendConversationId and newConversationId) then
        return tbl2
    end

    local var1 = if tbl2.conversationTopModals[oldFriendConversationId] then Cryo.Dictionary.join(tbl2, {
        conversationTopModals = Cryo.Dictionary.join(
            tbl2.conversationTopModals,
            {
                [newConversationId] = tbl2.conversationTopModals[oldFriendConversationId],
                [oldFriendConversationId] = Cryo.None
            }
        )
    }) else tbl2

    if tbl2.conversationOverlays[oldFriendConversationId] then
        var1 = Cryo.Dictionary.join(var1, {
            conversationOverlays = Cryo.Dictionary.join(
                var1.conversationOverlays,
                {
                    [newConversationId] = tbl2.conversationOverlays[oldFriendConversationId],
                    [oldFriendConversationId] = Cryo.None
                }
            )
        })
    end
    if tbl2.conversationBottomModals[oldFriendConversationId] then
        var1 = Cryo.Dictionary.join(var1, {
            conversationBottomModals = Cryo.Dictionary.join(
                var1.conversationBottomModals,
                {
                    [newConversationId] = tbl2.conversationBottomModals[oldFriendConversationId],
                    [oldFriendConversationId] = Cryo.None
                }
            )
        })
    end

    return var1
end
tbl1.DEBUG_ShowChatLandingAgeVerifiedTimedModal = FFlagDebugAEGIS1AppChatBanner and function(tbl2)
    return Cryo.Dictionary.union(tbl2, {
        chatLandingModal = {
            modal_variant = AppChatNetworking.Constants.ChatLandingModalVariant.ChatLandingAgeVerifiedCommsTimedModal,
            modal_layout = {
                id = "asdf",
                header = {
                    text = "FAE Title",
                    additional_content = {{
                        type = AppChatNetworking.Constants.ModalContentType.Countdown,
                        text = "14 days left"
                    }}
                },
                body = {
                    text = "FAE debug Body",
                    additional_content = {{
                        type = AppChatNetworking.Constants.ModalContentType.Link,
                        text = "Learn more"
                    }}
                },
                buttons = {
                    {
                        text = "Continue",
                        action = { type = "open_fae_upsell" }
                    },
                    {
                        text = "View Details",
                        action = { type = "open_fae_view_details" }
                    }
                },
                dismissible = true,
                seen_record_action = "none",
                dismissed_record_action = "none"
            }
        }
    })
end or nil

tbl1.DEBUG_ShowAppChatFaeUpsell = FFlagDebugAppChatFae and function(tbl2)
    return Cryo.Dictionary.union(tbl2, {
        chatLandingModal = {
            modal_variant = AppChatNetworking.Constants.ChatLandingModalVariant.AgeAssuranceUpsell,
            modal_layout = {
                id = "asdf",
                label = { text = "New" },
                header = { text = "FAE Title" },
                body = {
                    text = "FAE debug Body",
                    additional_content = {{
                        type = AppChatNetworking.Constants.ModalContentType.Link,
                        text = "Learn more"
                    }}
                },
                buttons = {{ text = "Continue" }},
                seen_record_action = "none",
                dismissed_record_action = "none"
            }
        }
    })
end or nil

tbl1.DEBUG_ShowNewTCOverlay = (FFlagTCUpsellModalEnabled_DEV or FFlagDebugEnableTCDoubleOptIn_DEV) and function(tbl2, arg1)
    local join = Cryo.Dictionary.join
    local tbl3 = {
        conversationOverlays = Cryo.Dictionary.join(tbl2.conversationOverlays, {
            [arg1.conversationId] = {
                modal_variant = arg1.modalVariant,
                modal_layout = {
                    id = "asdf",
                    seen_record_action = "none",
                    dismissed_record_action = "none"
                }
            }
        })
    }
    return join(tbl2, tbl3)
end or nil

tbl1.DEBUG_ShowNewTopModal = FFlagDebugEnableTCDoubleOptIn_DEV and function(tbl2, arg1)
    local join = Cryo.Dictionary.join
    local tbl3 = {
        conversationTopModals = Cryo.Dictionary.join(tbl2.conversationTopModals, {
            [arg1.conversationId] = {
                modal_variant = arg1.modalVariant,
                modal_layout = {
                    id = "",
                    body = { text = "Add Trusted Connection" },
                    buttons = {{ text = "Add" }},
                    seen_record_action = "none",
                    dismissed_record_action = "none"
                }
            }
        })
    }
    return join(tbl2, tbl3)
end or nil

tbl1.DEBUG_DismissChatLandingModal = (FFlagDebugAppChatFae or FFlagDebugAEGIS1AppChatBanner) and function(tbl2)
    return Cryo.Dictionary.join(tbl2, { chatLandingModal = Cryo.None })
end or nil

return createReducer({
    chatLandingModal = {},
    conversationTopModals = {},
    conversationOverlays = {},
    pendingStateModals = {},
    conversationBottomModals = {}
}, tbl1)
