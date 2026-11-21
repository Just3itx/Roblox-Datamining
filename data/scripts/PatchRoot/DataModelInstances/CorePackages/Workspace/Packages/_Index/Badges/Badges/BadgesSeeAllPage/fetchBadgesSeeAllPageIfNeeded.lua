-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T05:31:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Badges = script:FindFirstAncestor("Badges")
local BadgesParent = Badges.Parent
local AppPage = require(BadgesParent.RobloxAppEnums).AppPage
local SduiSharedUtilities = require(BadgesParent.SduiSharedUtilities)
local SduiResponseType = SduiSharedUtilities.SduiResponseType
local getSduiApiStore = SduiSharedUtilities.getSduiApiStore
local getBadgesSeeAllUrl = require(Badges.BadgesSeeAllPage.getBadgesSeeAllUrl)
local getBadgesSeeAllPageKey = require(Badges.BadgesSeeAllPage.getBadgesSeeAllPageKey)
local FFlagSduiExtendedCapabilitiesDiscovery = require(BadgesParent.SharedFlags).FFlagSduiExtendedCapabilitiesDiscovery

local function fetchBadgesSeeAllPageIfNeeded(str1: string, loadTimer, bool1: boolean?)
    if not FFlagSduiExtendedCapabilitiesDiscovery then
        local url = getBadgesSeeAllUrl(str1)
        local configKey = getBadgesSeeAllPageKey(str1)

        local badgesSeeAll = require(BadgesParent.ServiceContractsProto).apppageplatform.badges.badges_see_all

        getSduiApiStore().fetchIfNeeded({
            responseType = SduiResponseType.Protobuf,
            url = url,
            surfaceKey = AppPage.BadgesSeeAll,
            configKey = configKey,
            loadTimer = loadTimer,
            apiProto = badgesSeeAll.BadgesSeeAllV2Response,
            buildNextPageUrl = function(arg1)
                local nextCursor = arg1 and arg1.pagination and arg1.pagination.next_cursor
                if nextCursor and nextCursor ~= "" then
                    return getBadgesSeeAllUrl(str1, nextCursor)
                end
                return nil
            end
        }, bool1)

        return url
    end

    local configKey = getBadgesSeeAllPageKey(str1)

    local serviceContractsProto = require(BadgesParent.ServiceContractsProto)
    local badgesSeeAll = serviceContractsProto.apppageplatform.badges.badges_see_all
    local getBadgesSeeAllPostUrl = require(Badges.BadgesSeeAllPage.getBadgesSeeAllPostUrl)
    local badgesSeeAllPageConstants = require(Badges.BadgesSeeAllPage.BadgesSeeAllPageConstants)
    local sduiApiStorePostConfigContentType = SduiSharedUtilities.SduiApiStorePostConfigContentType
    local sduiCapabilities = SduiSharedUtilities.SduiCapabilities
    local url = getBadgesSeeAllPostUrl()
    local pageEntryFormat = serviceContractsProto.apppageplatform.shared.page_entry_content.PageEntryFormat

    local function buildBody(str2: string?)
        return (badgesSeeAll.BadgesSeeAllRequest.new({
            universe_id = tonumber(str1),
            cursor = str2 and str2 ~= "" and str2 or nil,
            page_size = badgesSeeAllPageConstants.RequestPageSize,
            page_entry_format = pageEntryFormat.toNumber("PAGE_ENTRY_FORMAT_UNIVERSAL"),
            client_capabilities = sduiCapabilities.buildClientCapabilities()
        }))
    end
    local function nextCursor(tbl1) -- Luacid: Inlined by compiler; 2 call sites recovered
        local nextCursor2 = tbl1 and tbl1.pagination and tbl1.pagination.next_cursor
        return if nextCursor2 and nextCursor2 ~= "" then nextCursor2 else nil
    end

    getSduiApiStore().fetchIfNeeded({
        responseType = SduiResponseType.Protobuf,
        url = url,
        surfaceKey = AppPage.BadgesSeeAll,
        configKey = configKey,
        loadTimer = loadTimer,
        apiProto = badgesSeeAll.BadgesSeeAllV2Response,
        postConfig = {
            contentType = sduiApiStorePostConfigContentType.Proto,
            protoMessage = badgesSeeAll.BadgesSeeAllRequest,
            body = buildBody(nil)
        },
        buildNextPageUrl = function(tbl1)
            return if nextCursor(tbl1) then url else nil
        end,
        buildNextPagePostBody = function(tbl1)
            local var1 = nextCursor(tbl1)

            if var1 then
                return (buildBody(var1))
            end

            return nil
        end
    }, bool1)

    return url
end
return fetchBadgesSeeAllPageIfNeeded
