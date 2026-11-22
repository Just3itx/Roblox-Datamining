-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T16:11:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SettingsSdui = script:FindFirstAncestor("SettingsSdui")
local SettingsSduiParent = SettingsSdui.Parent

local AppPage = require(SettingsSduiParent.RobloxAppEnums).AppPage
local SduiSharedUtilities = require(SettingsSduiParent.SduiSharedUtilities)
local SduiResponseType = SduiSharedUtilities.SduiResponseType
local getSduiApiStore = SduiSharedUtilities.getSduiApiStore
local getSduiTemplateStore = SduiSharedUtilities.getSduiTemplateStore
local SduiApiStorePostConfigContentType = SduiSharedUtilities.SduiApiStorePostConfigContentType
local SduiCapabilities = SduiSharedUtilities.SduiCapabilities

local SettingsSduiConstants = require(SettingsSdui.SettingsSduiConstants)
local SettingsPageSession = require(SettingsSdui.SettingsPageSession)
local getSettingsPageUrl = require(SettingsSdui.getSettingsPageUrl)
local buildSettingsPageRequest = require(SettingsSdui.buildSettingsPageRequest)
local FFlagSduiAdvertiseRuntimeSupportSets = require(SettingsSduiParent.SharedFlags).FFlagSduiAdvertiseRuntimeSupportSets

local function fetchSettingsPage(loadTimer, bool1: boolean?)
    local configKey = SettingsSduiConstants.ConfigKey
    local sduiApiStore = getSduiApiStore()

    local _, var1 = sduiApiStore.getData(configKey)
    if (bool1 or var1) and not sduiApiStore.isInFlight(configKey) then
        SettingsPageSession:Refresh()
    end

    local serviceContractsProto = require(SettingsSduiParent.ServiceContractsProto)
    local settingsPage = serviceContractsProto.apppageplatform.settings.settings_page
    local clientCapabilities = serviceContractsProto.apppageplatform.shared.client_capabilities.ClientCapabilities
    local enabledCapabilities = if FFlagSduiAdvertiseRuntimeSupportSets then SduiCapabilities.getEnabledCapabilityNumbersWithoutExtendedMarker() else SduiCapabilities.getEnabledCapabilityNumbers(SduiCapabilities.getEnabledCapabilities())
    local clientCapabilities2 = clientCapabilities.new({ enabled_capabilities = enabledCapabilities })

    local cachedRobloxComponentToTemplateId = getSduiTemplateStore().getCachedRobloxComponentToTemplateId(AppPage.Settings)
    local url = getSettingsPageUrl()
    local body = buildSettingsPageRequest(settingsPage, {
        sessionId = SettingsPageSession:Get(),
        cachedRobloxComponentToTemplateId = cachedRobloxComponentToTemplateId,
        clientCapabilities = clientCapabilities2
    })

    return sduiApiStore.fetchIfNeeded({
        responseType = SduiResponseType.Protobuf,
        url = url,
        surfaceKey = AppPage.Settings,
        configKey = configKey,
        loadTimer = loadTimer,
        apiProto = settingsPage.SettingsPageResponse,
        postConfig = {
            contentType = SduiApiStorePostConfigContentType.Json,
            body = body
        },
        enableTemplateCache = true,
        refresh = function(arg1)
            return fetchSettingsPage(arg1, true)
        end
    }, bool1)
end

return fetchSettingsPage
