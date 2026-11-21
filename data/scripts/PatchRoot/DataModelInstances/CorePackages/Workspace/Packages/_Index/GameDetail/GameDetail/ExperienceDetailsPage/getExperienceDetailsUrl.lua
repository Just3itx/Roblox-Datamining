-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T18:00:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameDetailParent = script:FindFirstAncestor("GameDetail").Parent

local UrlBuilder = require(GameDetailParent.UrlBuilder).UrlBuilder
local Url = require(GameDetailParent.Http).Url
local SduiCapabilities = require(GameDetailParent.SduiSharedUtilities).SduiCapabilities
local FFlagSduiCapabilityBindings = require(GameDetailParent.SharedFlags).FFlagSduiCapabilityBindings
local FFlagSduiEdpClientTemplateCache = require(GameDetailParent.SharedFlags).FFlagSduiEdpClientTemplateCache
local FFlagInfoTableStableItemKeys = require(GameDetailParent.SharedFlags).FFlagInfoTableStableItemKeys
local FFlagLuaAppEdpMomentVideo = require(GameDetailParent.SharedFlags).FFlagLuaAppEdpMomentVideo

local function getExperienceDetailsUrl(universeId: string)
    local var1 = UrlBuilder.new({ base = Url.APIS_URL, path = "experience-details-api/v2/universes/{universeId}/experience-details" })(
        { universeId = universeId }
    )

    if FFlagSduiCapabilityBindings and not FFlagSduiEdpClientTemplateCache then
        local _serviceContractsProto = require(GameDetailParent.ServiceContractsProto)

        local tbl1 = {
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
            table.insert(tbl1, "CAPABILITY_SUPPORTS_EDP_INFO_TABLE_STABLE_ITEM_KEYS")
        end
        local tbl2 = {}

        SduiCapabilities.addToQueryParams(tbl2, tbl1)
        if next(tbl2) ~= nil then
            var1 = UrlBuilder.addQueryString(var1, tbl2)
        end
    end

    return var1
end

return getExperienceDetailsUrl
