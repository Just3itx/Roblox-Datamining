-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:31:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local AvatarChatService = game:GetService("AvatarChatService")
local eventName = game:DefineFastString("MicrophoneDevicePermissionsLoggingEventName", "microphoneDevicePermissionPrompted")

local module = {
    _initialized = false,
    placeId = 0,
    universeId = 0,
    placeVoiceEnabled = false,
    universeVoiceEnabled = false,
    clientSessionId = "",
    UIType = { EXPERIENCE_JOIN = 0, PROMPT_IMPRESSION = 1, PROMPT_INTERACTION = 2 }
}

function module._init(arg1, mask: number, didAuthorize)
    arg1._initialized = true
    arg1.placeId = game.PlaceId
    arg1.universeId = game.GameId
    arg1.placeVoiceEnabled = AvatarChatService:IsEnabled(mask, Enum.AvatarChatServiceFeature.PlaceAudio)
    arg1.universeVoiceEnabled = AvatarChatService:IsEnabled(mask, Enum.AvatarChatServiceFeature.UniverseAudio)

    arg1:logExperienceJoin({ didAuthorize = didAuthorize })
end

function module._getEventPayload(arg1, uiType, arg2)
    return {
        uiType = uiType,
        uiContext = arg2.uiContext,
        didAuthorize = arg2.didAuthorize,
        placeId = arg1.placeId,
        universeId = arg1.universeId,
        placeVoiceEnabled = arg1.placeVoiceEnabled,
        universeVoiceEnabled = arg1.universeVoiceEnabled,
        clientSessionId = arg1.clientSessionId
    }
end

function module._isReady(arg1)
    return arg1._initialized
end

function module.init(arg1, arg2)
    if AvatarChatService.ClientFeaturesInitialized then
        arg1:_init(AvatarChatService.ClientFeatures, arg2)
        return
    end
    local connection = nil
    connection = AvatarChatService:GetPropertyChangedSignal("ClientFeatures"):Connect(function()
        arg1:_init(AvatarChatService.ClientFeatures, arg2)
        connection:Disconnect()
    end)
end

function module.logExperienceJoin(arg1, arg2)
    if not arg1:_isReady() then
        return
    end

    RbxAnalyticsService:SendEventDeferred(
        "client",
        "voice",
        eventName,
        arg1:_getEventPayload(arg1.UIType.EXPERIENCE_JOIN, arg2)
    )
end

function module.logPromptImpression(arg1, arg2)
    if not arg1:_isReady() then
        return
    end

    RbxAnalyticsService:SendEventDeferred(
        "client",
        "voice",
        eventName,
        arg1:_getEventPayload(arg1.UIType.PROMPT_IMPRESSION, arg2)
    )
end

function module.logPromptInteraction(arg1, arg2)
    if not arg1:_isReady() then
        return
    end

    RbxAnalyticsService:SendEventDeferred(
        "client",
        "voice",
        eventName,
        arg1:_getEventPayload(arg1.UIType.PROMPT_INTERACTION, arg2)
    )
end

function module.setClientSessionId(arg1, clientSessionId)
    if not arg1:_isReady() or arg1.clientSessionId == clientSessionId then
        return
    end

    arg1.clientSessionId = clientSessionId
end

return module
