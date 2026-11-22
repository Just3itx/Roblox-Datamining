-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T15:41:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local ServerTriggeredModals = script:FindFirstAncestor("ServerTriggeredModals")
local ServerTriggeredModalsParent = ServerTriggeredModals.Parent

local PromptsEntryPoint = require(script.Parent.PromptsEntryPoint)
local _PromptsTypes = require(script.Parent.Types.PromptsTypes)
local SduiSharedUtilities = require(ServerTriggeredModalsParent.SduiSharedUtilities)
local UrlBuilder = require(ServerTriggeredModalsParent.UrlBuilder).UrlBuilder
local UrlBase = require(ServerTriggeredModalsParent.UrlBuilder).UrlBase

local NativePushNotificationPermissionPrompt = require(ServerTriggeredModalsParent.NotificationsUpsell).NativePushNotificationPermissionPrompt
local ChatPushUpsellLegacyPrompt = require(ServerTriggeredModalsParent.NotificationsUpsell).ChatPushUpsellLegacyPrompt

local SduiResponseType = SduiSharedUtilities.SduiResponseType
local getSduiApiStore = SduiSharedUtilities.getSduiApiStore
local parsePageEntriesFromResponse = SduiSharedUtilities.SduiProtobufResponseHelpers.parsePageEntriesFromResponse

local FFlagSduiAllowNoConfigsBuilt = require(ServerTriggeredModalsParent.SharedFlags).FFlagSduiAllowNoConfigsBuilt
local FFlagEdpGameLeavePromptsHandlerEnabled = require(ServerTriggeredModalsParent.SharedFlags).FFlagEdpGameLeavePromptsHandlerEnabled
local FFlagEdpOpenPromptsHandlerEnabled = require(ServerTriggeredModalsParent.SharedFlags).FFlagEdpOpenPromptsHandlerEnabled

local FFlagNotificationStreamPromptsHandlerEnabled = require(ServerTriggeredModalsParent.SharedFlags).FFlagNotificationStreamPromptsHandlerEnabled

local FFlagHomepagePromptsHandlerPassClientAttributes = require(ServerTriggeredModalsParent.SharedFlags).FFlagHomepagePromptsHandlerPassClientAttributes
local FFlagSduiExtendedCapabilitiesPrompts = require(ServerTriggeredModalsParent.SharedFlags).FFlagSduiExtendedCapabilitiesPrompts

local FFlagPushNotificationsUpsellHomePromptsExperiment = require(ServerTriggeredModalsParent.SharedFlags).FFlagPushNotificationsUpsellHomePromptsExperiment
local FFlagSplitPaneEducationalTour = require(ServerTriggeredModalsParent.SharedFlags).FFlagSplitPaneEducationalTour
local SplitPaneTourPrompt = if FFlagSplitPaneEducationalTour then require(script.Parent.SplitPaneTourPrompt) else nil
local FFlagPlusUpsellSheetHomePrompt = require(ServerTriggeredModals.Flags.FFlagPlusUpsellSheetHomePrompt)
local PlusUpsellSheetPrompt = if FFlagPlusUpsellSheetHomePrompt then require(script.Parent.PlusUpsellSheetPrompt) else nil
local FFlagPromptsEdpOpenReplaceOnFetch = require(ServerTriggeredModalsParent.SharedFlags).FFlagPromptsEdpOpenReplaceOnFetch
local FFlagChatPushUpsellPromptsEnabled = require(ServerTriggeredModalsParent.SharedFlags).FFlagChatPushUpsellPromptsEnabled

local function getPromptsUrl(entryPoint, input, promptStyles)
    local query = { entryPoint = entryPoint }

    if promptStyles ~= nil then
        query.promptStyle = table.concat(promptStyles, ",")
    end
    local var1 = UrlBuilder.new({ base = UrlBase.APIS, path = "modals-api/v1/prompts", query = query })()
    if input == nil then
        return var1
    end

    return `{var1}&clientAttributes={HttpService:UrlEncode(HttpService:JSONEncode(input))}`
end

local function isChatLandingRequest(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    return FFlagChatPushUpsellPromptsEnabled and arg1.entryPoint == PromptsEntryPoint.ChatLandingOpen
end

local function getParsePageEntriesFromResponse(arg1)
    if isChatLandingRequest(arg1) then
        return function(arg2)
            ChatPushUpsellLegacyPrompt.handlePromptsResponse(arg2)
            return parsePageEntriesFromResponse(arg2)
        end
    end

    if arg1.entryPoint ~= PromptsEntryPoint.HomepageLaunch
        or not (FFlagPushNotificationsUpsellHomePromptsExperiment and NativePushNotificationPermissionPrompt.isEnabled()
            or FFlagSplitPaneEducationalTour
            or FFlagPlusUpsellSheetHomePrompt)
    then
        return nil
    end

    return function(arg2)
        if FFlagPushNotificationsUpsellHomePromptsExperiment and NativePushNotificationPermissionPrompt.isEnabled() then
            NativePushNotificationPermissionPrompt.handlePromptsResponse(arg2)
        end
        if FFlagSplitPaneEducationalTour then
            SplitPaneTourPrompt.handlePromptsResponse(arg2)
        end
        if FFlagPlusUpsellSheetHomePrompt then
            PlusUpsellSheetPrompt.handlePromptsResponse(arg2)
        end
        return parsePageEntriesFromResponse(arg2)
    end
end

local function fetchPrompts(arg1, bool1: boolean?)
    local serviceContractsProto = require(ServerTriggeredModalsParent.ServiceContractsProto)
    local getEligiblePromptsResponse = serviceContractsProto.apppageplatform.prompts.prompts.GetEligiblePromptsResponse
    local getEligiblePromptsRequest = serviceContractsProto.apppageplatform.prompts.prompts.GetEligiblePromptsRequest
    local clientCapabilities = if FFlagSduiExtendedCapabilitiesPrompts then SduiSharedUtilities.SduiCapabilities.buildClientCapabilities() else nil
    local tbl1 = {
        entry_points = { arg1.entryPoint },
        client_attributes = arg1.clientAttributes,
        client_capabilities = clientCapabilities,
        prompt_styles = arg1.promptStyles
    }

    local fetchIfNeeded = getSduiApiStore().fetchIfNeeded
    local tbl2 = {
        responseType = SduiResponseType.ProtobufJson,
        url = 0,
        surfaceKey = 0,
        configKey = 0,
        clearOnEmptyResponse = 0,
        replaceOnFetch = 0,
        allowNoConfigsBuilt = 0,
        loadTimer = 0,
        apiProto = 0,
        parsePageEntriesFromResponse = 0,
        postConfig = 0
    }
    local promptsUrl

    if FFlagSduiExtendedCapabilitiesPrompts then
        promptsUrl = UrlBuilder.new({ base = UrlBase.APIS, path = "modals-api/v1/prompts" })()
    elseif FFlagEdpGameLeavePromptsHandlerEnabled
        or FFlagEdpOpenPromptsHandlerEnabled
        or FFlagHomepagePromptsHandlerPassClientAttributes
        or isChatLandingRequest(arg1)
        or FFlagNotificationStreamPromptsHandlerEnabled and arg1.entryPoint == PromptsEntryPoint.NotificationStreamOpen
    then
        promptsUrl = getPromptsUrl(arg1.entryPoint, arg1.clientAttributes, arg1.promptStyles)
    else
        promptsUrl = getPromptsUrl(arg1.entryPoint, nil, arg1.promptStyles)
    end

    tbl2.url = promptsUrl

    tbl2.surfaceKey = arg1.surfaceKey
    tbl2.configKey = arg1.configKey
    tbl2.clearOnEmptyResponse = arg1.clearOnEmptyResponse
    tbl2.replaceOnFetch = if FFlagPromptsEdpOpenReplaceOnFetch then arg1.replaceOnFetch else nil
    tbl2.allowNoConfigsBuilt = if FFlagSduiAllowNoConfigsBuilt then arg1.allowNoConfigsBuilt else nil
    tbl2.loadTimer = arg1.loadTimer
    tbl2.apiProto = getEligiblePromptsResponse
    tbl2.parsePageEntriesFromResponse = getParsePageEntriesFromResponse(arg1)
    tbl2.postConfig = FFlagSduiExtendedCapabilitiesPrompts
        and {
            contentType = SduiSharedUtilities.SduiApiStorePostConfigContentType.Proto,
            protoMessage = getEligiblePromptsRequest,
            body = getEligiblePromptsRequest.new(tbl1)
        }
        or nil
    fetchIfNeeded(tbl2, bool1)
end

return fetchPrompts
