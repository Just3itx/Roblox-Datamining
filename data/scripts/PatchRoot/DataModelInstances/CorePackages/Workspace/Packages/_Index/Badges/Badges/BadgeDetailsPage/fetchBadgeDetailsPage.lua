-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T05:31:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")
local Badges = script:FindFirstAncestor("Badges")
local BadgesParent = Badges.Parent
local AppPage = require(BadgesParent.RobloxAppEnums).AppPage
local SduiSharedUtilities = require(BadgesParent.SduiSharedUtilities)
local SduiResponseType = SduiSharedUtilities.SduiResponseType
local getSduiApiStore = SduiSharedUtilities.getSduiApiStore
local getBadgeDetailsUrl = require(Badges.BadgesSeeAllPage.getBadgeDetailsUrl)
local getBadgeDetailsPageKey = require(script.Parent.getBadgeDetailsPageKey)

local FFlagSduiExtendedCapabilitiesDiscovery = require(BadgesParent.SharedFlags).FFlagSduiExtendedCapabilitiesDiscovery

local function getLocalPlayerUserId() -- Luacid: Inlined by compiler; 1 call site recovered
    local localPlayer = Players.LocalPlayer
    if not localPlayer then
        return nil
    end
    local userId = localPlayer.UserId
    if userId <= 0 then
        return nil
    end
    return tostring(userId)
end

local function fetchBadgeDetailsPage(str1: string, loadTimer)
    local localPlayerUserId = getLocalPlayerUserId()

    if not FFlagSduiExtendedCapabilitiesDiscovery then
        local url = getBadgeDetailsUrl(str1, localPlayerUserId)

        local badgeDetailsPage = require(BadgesParent.ServiceContractsProto).apppageplatform.badges.badge_details_page

        getSduiApiStore().fetchIfNeeded({
            responseType = SduiResponseType.Protobuf,
            url = url,
            surfaceKey = AppPage.BadgeDetails,
            configKey = getBadgeDetailsPageKey(str1),
            loadTimer = loadTimer,
            apiProto = badgeDetailsPage.BadgeDetailsPageV2Response
        })
        return
    end

    local serviceContractsProto = require(BadgesParent.ServiceContractsProto)
    local badgeDetailsPage = serviceContractsProto.apppageplatform.badges.badge_details_page
    local getBadgeDetailsPostUrl = require(Badges.BadgesSeeAllPage.getBadgeDetailsPostUrl)
    local sduiApiStorePostConfigContentType = SduiSharedUtilities.SduiApiStorePostConfigContentType
    local sduiCapabilities = SduiSharedUtilities.SduiCapabilities
    local url = getBadgeDetailsPostUrl()
    local pageEntryFormat = serviceContractsProto.apppageplatform.shared.page_entry_content.PageEntryFormat
    local badgeDetailsPageRequest = badgeDetailsPage.BadgeDetailsPageRequest.new({
        badge_id = tonumber(str1),
        user_id = if localPlayerUserId then tonumber(localPlayerUserId) else nil,
        page_entry_format = pageEntryFormat.toNumber("PAGE_ENTRY_FORMAT_UNIVERSAL"),
        client_capabilities = sduiCapabilities.buildClientCapabilities()
    })
    getSduiApiStore().fetchIfNeeded({
        responseType = SduiResponseType.Protobuf,
        url = url,
        surfaceKey = AppPage.BadgeDetails,
        configKey = getBadgeDetailsPageKey(str1),
        loadTimer = loadTimer,
        apiProto = badgeDetailsPage.BadgeDetailsPageV2Response,
        postConfig = {
            contentType = sduiApiStorePostConfigContentType.Proto,
            protoMessage = badgeDetailsPage.BadgeDetailsPageRequest,
            body = badgeDetailsPageRequest
        }
    })
end

return fetchBadgeDetailsPage
