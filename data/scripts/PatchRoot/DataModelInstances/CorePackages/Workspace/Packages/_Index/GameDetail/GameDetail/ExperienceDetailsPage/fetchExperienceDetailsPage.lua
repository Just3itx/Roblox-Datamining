-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T17:51:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameDetailParent = script:FindFirstAncestor("GameDetail").Parent
local AppPage = require(GameDetailParent.RobloxAppEnums).AppPage
local SduiSharedUtilities = require(GameDetailParent.SduiSharedUtilities)
local SduiResponseType = SduiSharedUtilities.SduiResponseType
local getSduiApiStore = SduiSharedUtilities.getSduiApiStore
local getSduiTemplateStore = SduiSharedUtilities.getSduiTemplateStore
local SduiApiStorePostConfigContentType = SduiSharedUtilities.SduiApiStorePostConfigContentType
local SduiCapabilities = SduiSharedUtilities.SduiCapabilities
local getExperienceDetailsUrl = require(script.Parent.getExperienceDetailsUrl)
local getExperienceDetailsPageKey = require(script.Parent.getExperienceDetailsPageKey)
local SharedFlags = require(GameDetailParent.SharedFlags)
local FFlagSduiEdpClientTemplateCache = SharedFlags.FFlagSduiEdpClientTemplateCache
local FFlagSduiEdpTemplatePrewarm = SharedFlags.FFlagSduiEdpTemplatePrewarm
local FFlagSduiAdvertiseRuntimeSupportSets = SharedFlags.FFlagSduiAdvertiseRuntimeSupportSets
local FFlagInfoTableStableItemKeys = SharedFlags.FFlagInfoTableStableItemKeys
local FFlagLuaAppEdpMomentVideo = SharedFlags.FFlagLuaAppEdpMomentVideo

local function fetchExperienceDetailsPage(str1: string, loadTimer, bool1: boolean?)
    local url = getExperienceDetailsUrl(str1)

    local serviceContractsProto = require(GameDetailParent.ServiceContractsProto)
    local experienceDetailsPage = serviceContractsProto.apppageplatform.experiencedetails.experience_details_page
    local tbl1

    if FFlagSduiEdpClientTemplateCache then
        local clientCapabilities = serviceContractsProto.apppageplatform.shared.client_capabilities.ClientCapabilities
        local clientCapabilities2

        if FFlagSduiAdvertiseRuntimeSupportSets then
            clientCapabilities2 = SduiCapabilities.buildClientCapabilities()
        else
            local enabledCapabilityNumbers

            if FFlagSduiEdpTemplatePrewarm then
                enabledCapabilityNumbers = SduiCapabilities.getEnabledCapabilityNumbers((SduiCapabilities.getEnabledCapabilities()))
            else
                local tbl2 = {
                    "CAPABILITY_SUPPORTS_EDP_PERSISTENT_ACTION_BAR_PLAY_BUTTON",
                    "CAPABILITY_SUPPORTS_EDP_COMMUNITY_SECTION",
                    "CAPABILITY_SUPPORTS_EDP_BUILD_TAG",
                    "CAPABILITY_SUPPORTS_OPEN_EXPERIENCE_STORE_SEE_ALL_WITH_WEBVIEW_FALLBACK_ACTION",
                    "CAPABILITY_SUPPORTS_PIN_SHORTCUT_ACTION",
                    "CAPABILITY_SUPPORTS_SCALED_PLAY_BUTTON_AND_IMAGE_SIZES",
                    "CAPABILITY_SUPPORTS_CONTAINER_QUERIES",
                    "CAPABILITY_SUPPORTS_EDP_EARLY_ACCESS_UPSELL",
                    if FFlagLuaAppEdpMomentVideo then "CAPABILITY_SUPPORTS_EDP_MEDIA_GALLERY_MOMENT_VIDEO" else nil
                }

                if FFlagInfoTableStableItemKeys then
                    table.insert(tbl2, "CAPABILITY_SUPPORTS_EDP_INFO_TABLE_STABLE_ITEM_KEYS")
                end
                enabledCapabilityNumbers = SduiCapabilities.getEnabledCapabilityNumbers(tbl2)
            end
            clientCapabilities2 = clientCapabilities.new({ enabled_capabilities = enabledCapabilityNumbers })
        end

        local cachedRobloxComponentToTemplateId = getSduiTemplateStore().getCachedRobloxComponentToTemplateId(AppPage.ExperienceDetail)

        tbl1 = {
            contentType = SduiApiStorePostConfigContentType.Proto,
            protoMessage = experienceDetailsPage.ExperienceDetailsPageRequest,
            body = {
                cached_roblox_component_to_template_id = cachedRobloxComponentToTemplateId,
                client_capabilities = clientCapabilities2
            }
        }
    else
        tbl1 = nil
    end

    local fetchIfNeeded = getSduiApiStore().fetchIfNeeded
    local tbl2 = {
        responseType = SduiResponseType.Protobuf,
        url = url,
        surfaceKey = AppPage.ExperienceDetail,
        configKey = getExperienceDetailsPageKey(str1),
        loadTimer = loadTimer,
        apiProto = experienceDetailsPage.ExperienceDetailsPageResponse,
        postConfig = 0,
        enableTemplateCache = 0
    }

    if not FFlagSduiEdpClientTemplateCache then
        tbl1 = nil
    end

    tbl2.postConfig = tbl1
    tbl2.enableTemplateCache = if FFlagSduiEdpClientTemplateCache then true else nil
    fetchIfNeeded(tbl2, bool1)
end

return fetchExperienceDetailsPage
