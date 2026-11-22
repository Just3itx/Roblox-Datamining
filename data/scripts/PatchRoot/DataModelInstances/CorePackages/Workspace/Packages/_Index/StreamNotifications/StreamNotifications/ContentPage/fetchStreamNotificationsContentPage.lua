-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T23:30:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local StreamNotificationsParent = script:FindFirstAncestor("StreamNotifications").Parent

local Url = require(StreamNotificationsParent.Http).Url
local UrlBuilder = require(StreamNotificationsParent.UrlBuilder).UrlBuilder
local SduiSharedUtilities = require(StreamNotificationsParent.SduiSharedUtilities)
local FFlagSduiAllowNoConfigsBuilt = require(StreamNotificationsParent.SharedFlags).FFlagSduiAllowNoConfigsBuilt

local ContentPageConstants = require(script.Parent.ContentPageConstants)

local getSduiApiStore = SduiSharedUtilities.getSduiApiStore
local SduiLoadTimer = SduiSharedUtilities.SduiLoadTimer
local SduiResponseType = SduiSharedUtilities.SduiResponseType
local SduiApiStorePostConfigContentType = SduiSharedUtilities.SduiApiStorePostConfigContentType
local SduiCapabilities = SduiSharedUtilities.SduiCapabilities

local ConfigKey = ContentPageConstants.ConfigKey

local urlBuilder = UrlBuilder.new({ base = Url.NOTIFICATION_URL, path = ContentPageConstants.ApiPath })

local function fetchStreamNotificationsContentPage(clientAttributes)
    local streamPage = require(StreamNotificationsParent.ServiceContractsProto).apppageplatform.notifications.stream_page
    local clientCapabilities = SduiCapabilities.buildClientCapabilities()

    return getSduiApiStore().fetchIfNeeded({
        responseType = SduiResponseType.Protobuf,
        url = urlBuilder(),
        surfaceKey = ConfigKey,
        configKey = ConfigKey,
        clearOnEmptyResponse = true,
        replaceOnFetch = true,
        allowNoConfigsBuilt = if FFlagSduiAllowNoConfigsBuilt then true else nil,
        loadTimer = SduiLoadTimer.createLoadTimer(ConfigKey),
        apiProto = streamPage.StreamPageResponse,
        postConfig = {
            contentType = SduiApiStorePostConfigContentType.Proto,
            protoMessage = streamPage.StreamPageRequest,
            body = streamPage.StreamPageRequest.new({ client_capabilities = clientCapabilities, client_attributes = clientAttributes })
        }
    }, true)
end

return fetchStreamNotificationsContentPage
