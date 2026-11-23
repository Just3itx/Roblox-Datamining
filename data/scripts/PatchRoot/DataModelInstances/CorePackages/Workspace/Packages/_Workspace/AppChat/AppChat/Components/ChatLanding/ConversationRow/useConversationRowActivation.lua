-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:11:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local React = require(AppChatParent.React)
local Cryo = require(AppChatParent.Cryo)
local useDispatch = require(AppChatParent.RoactUtils).Hooks.RoactRodux.useDispatch
local useNavigation = require(AppChatParent.Navigation).useNavigation

local Constants = require(AppChat.Constants)
local Conversation = require(AppChat.Models.Conversation)
local EnumScreens = require(AppChat.EnumScreens)
local GetOverlayStore = require(AppChat.Stores.GetOverlayStore)
local OverlayTypes = require(AppChat.Stores.GetOverlayStore.OverlayTypes)
local RemovedConversation = require(AppChat.Conversations.Actions.RemovedConversation)
local GetConversationStore = require(AppChat.Stores.GetConversationStore)
local getConversationConsentUpdate = require(script.Parent.getConversationConsentUpdate)

local FFlagAppChatEnableU13ChatOptIn = require(AppChatParent.SharedFlags).FFlagAppChatEnableU13ChatOptIn

local FFlagFriendsChatEnableConversationConsent = require(AppChatParent.SharedFlags).FFlagFriendsChatEnableConversationConsent
local normalizeConversationForTelemetry = require(script.Parent.normalizeConversationForTelemetry)

local function deriveModalVariant(bool1: boolean, bool2: boolean) -- Luacid: Inlined by compiler; 2 call sites recovered
    return if bool1 then Constants.OptInVariant.ChatOptInInfoCard elseif bool2 then Constants.OptInVariant.OsaContextCard else nil
end

local function deriveSquadModalVariant(bool1: boolean, bool2: boolean, multiUserConversation: string?) -- Luacid: Inlined by compiler; 2 call sites recovered
    if bool1 then
        return Constants.OptInVariant.OsaContextCard
    end

    if FFlagAppChatEnableU13ChatOptIn and bool2 and multiUserConversation == Conversation.Type.MULTI_USER_CONVERSATION then
        return Constants.OptInVariant.ChatOptInInfoCard
    end

    return nil
end

local function showOsaOverlay(conversationId: string, impressionId: string?, modalVariant: string?, multiUserConversation: string?, callback: ((...any) -> (...any))?, callback2: (...any) -> (...any), arg1)
    local overlayStore = GetOverlayStore(false)

    overlayStore.showOverlay(OverlayTypes.GroupOSADialog, {
        conversationId = conversationId,
        impressionId = impressionId,
        modalVariant = modalVariant,
        onJoin = function()
            if FFlagFriendsChatEnableConversationConsent then
                local conversationConsentUpdate = getConversationConsentUpdate(modalVariant)
                if conversationConsentUpdate then
                    local var1 = GetConversationStore(false).getConversation(conversationId, false)
                    if var1 then
                        GetConversationStore(false).upsertConversation(
                            Cryo.Dictionary.join(var1, { [conversationConsentUpdate.field] = conversationConsentUpdate.value }),
                            false
                        )
                    end
                end
            end
            overlayStore.dismissOverlay()
            if callback then
                callback(conversationId)
                return
            end
            arg1.navigate(EnumScreens.ChatConversation, { conversationId = conversationId, isNavigatedFromGroupOSAJoin = true })
        end,
        onDecline = function()
            if conversationId and multiUserConversation == Conversation.Type.MULTI_USER_CONVERSATION then
                GetConversationStore(false).removeConversation(conversationId)
                callback2(RemovedConversation(conversationId))
            end
            overlayStore.dismissOverlay()
        end
    })
end

local function activateConversation(tbl1, arg1, callback: (...any) -> (...any), arg2, current)
    if not tbl1.hasConversation then
        return
    end

    local conversationId = tbl1.conversationId
    local conversation = arg1.getConversation(conversationId, false)
    if conversation == nil then
        return
    end

    local var1 = nil

    local shouldShowU13ChatOptIn = tbl1.shouldShowU13ChatOptIn
    local shouldShowOsa = tbl1.shouldShowOSA
    local modalVariant = if shouldShowU13ChatOptIn then deriveModalVariant(true, nil) else deriveModalVariant(false, shouldShowOsa)

    if modalVariant then
        var1 = HttpService:GenerateGUID(false)
        showOsaOverlay(conversationId, var1, modalVariant, tbl1.conversationType, tbl1.onActivated and function(str1: string)
            local conversation2 = arg1.getConversation(str1, false)
            if conversation2 then
                tbl1.onActivated(conversation2)
            end
        end or nil, callback, arg2)
    elseif tbl1.onActivated then
        tbl1.onActivated(conversation)
    end

    if tbl1.fireClickEvent then
        tbl1.fireClickEvent(normalizeConversationForTelemetry(conversation), current, var1)
    end
end

local function activateSquad(tbl1, str1: string, bool1: boolean, callback: (...any) -> (...any), arg1)
    if bool1 then
        str1 = tbl1.conversationId
    end

    if not tbl1.hasConversation then
        if tbl1.onSquadJoinButtonActivated then
            tbl1.onSquadJoinButtonActivated(str1)
        end
        return
    end

    local shouldShowOsa = tbl1.shouldShowOSA
    local shouldShowU13ChatOptIn = tbl1.shouldShowU13ChatOptIn
    local conversationType = tbl1.conversationType
    local modalVariant = if shouldShowOsa then deriveSquadModalVariant(true, nil, nil) else deriveSquadModalVariant(false, shouldShowU13ChatOptIn, conversationType)

    if modalVariant then
        local impressionId = HttpService:GenerateGUID(false)
        showOsaOverlay(str1, impressionId, modalVariant, tbl1.conversationType, tbl1.onSquadJoinButtonActivated, callback, arg1)

        return
    end

    if tbl1.onSquadJoinButtonActivated then
        tbl1.onSquadJoinButtonActivated(str1)
    end
end

local function useConversationRowActivation(arg1)
    local getCurrentOptions = arg1.getCurrentOptions
    local conversationId = arg1.conversationId
    local hasConversation = arg1.hasConversation
    local shouldShowOsa = arg1.shouldShowOSA
    local shouldShowU13ChatOptIn = arg1.shouldShowU13ChatOptIn
    local conversationType = arg1.conversationType
    local onActivated = arg1.onActivated
    local onSquadJoinButtonActivated = arg1.onSquadJoinButtonActivated
    local fireClickEvent = arg1.fireClickEvent
    local telemetry = arg1.telemetry
    local var1 = React.useRef(telemetry)
    var1.current = telemetry

    local var2 = useNavigation()
    local var3 = useDispatch()
    local conversationStore = GetConversationStore(false)

    local var4 = React.useCallback(function()
        activateConversation({
            conversationId = conversationId,
            hasConversation = hasConversation,
            shouldShowOSA = shouldShowOsa,
            shouldShowU13ChatOptIn = shouldShowU13ChatOptIn,
            conversationType = conversationType,
            onActivated = onActivated,
            fireClickEvent = fireClickEvent
        }, conversationStore, var3, var2, var1.current)
    end, {
        hasConversation,
        conversationId,
        conversationType,
        shouldShowOsa,
        shouldShowU13ChatOptIn,
        onActivated,
        fireClickEvent,
        var3,
        var2,
        conversationStore
    })

    local onSquadActivated = React.useCallback(function(str1: string)
        activateSquad({
            conversationId = conversationId,
            hasConversation = hasConversation,
            shouldShowOSA = shouldShowOsa,
            shouldShowU13ChatOptIn = shouldShowU13ChatOptIn,
            conversationType = conversationType,
            onSquadJoinButtonActivated = onSquadJoinButtonActivated
        }, str1, false, var3, var2)
    end, {
        hasConversation,
        conversationId,
        conversationType,
        shouldShowOsa,
        shouldShowU13ChatOptIn,
        onSquadJoinButtonActivated,
        var3,
        var2,
        conversationStore.getConversation
    })

    local var5 = React.useCallback(function()
        if getCurrentOptions == nil then
            return
        end
        activateConversation(getCurrentOptions(), conversationStore, var3, var2, var1.current)
    end, {
        var3,
        var2,
        conversationStore,
        getCurrentOptions
    })

    local var6 = React.useCallback(function(str1: string)
        if getCurrentOptions == nil then
            return
        end
        activateSquad(getCurrentOptions(), str1, true, var3, var2)
    end, { var3, var2, getCurrentOptions })

    return if getCurrentOptions == nil then {
        onActivated = var4,
        onSquadActivated = onSquadActivated
    } else { onActivated = var5, onSquadActivated = var6 }
end

return useConversationRowActivation
