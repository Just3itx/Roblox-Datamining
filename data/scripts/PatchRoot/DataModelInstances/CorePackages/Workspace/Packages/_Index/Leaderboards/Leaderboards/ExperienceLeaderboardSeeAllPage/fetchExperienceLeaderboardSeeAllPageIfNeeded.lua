-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T02:40:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Leaderboards = script:FindFirstAncestor("Leaderboards")
local LeaderboardsParent = Leaderboards.Parent

local AppPage = require(LeaderboardsParent.RobloxAppEnums).AppPage
local SduiSharedUtilities = require(LeaderboardsParent.SduiSharedUtilities)
local SduiResponseType = SduiSharedUtilities.SduiResponseType
local getSduiApiStore = SduiSharedUtilities.getSduiApiStore
local getSduiTemplateStore = SduiSharedUtilities.getSduiTemplateStore
local SduiApiStorePostConfigContentType = SduiSharedUtilities.SduiApiStorePostConfigContentType
local SduiCapabilities = SduiSharedUtilities.SduiCapabilities

local getExperienceLeaderboardSeeAllUrl = require(Leaderboards.ExperienceLeaderboardSeeAllPage.getExperienceLeaderboardSeeAllUrl)

local getExperienceLeaderboardSeeAllPageKey = require(Leaderboards.ExperienceLeaderboardSeeAllPage.getExperienceLeaderboardSeeAllPageKey)

local tbl1 = ({})

local function fetchExperienceLeaderboardSeeAllPageIfNeeded(str1: string, initialTab: string?, loadTimer, bool1: boolean?)
    local url = getExperienceLeaderboardSeeAllUrl()
    local configKey = getExperienceLeaderboardSeeAllPageKey(str1)
    local bool2 = not (initialTab == nil) and tbl1[configKey] ~= initialTab
    tbl1[configKey] = initialTab or false

    local seeAll = require(LeaderboardsParent.ServiceContractsProto).apppageplatform.experienceleaderboard.see_all

    getSduiApiStore().fetchIfNeeded({
        responseType = SduiResponseType.Protobuf,
        url = url,
        surfaceKey = AppPage.ExperienceLeaderboardSeeAll,
        configKey = configKey,
        loadTimer = loadTimer,
        apiProto = seeAll.ExperienceLeaderboardSeeAllResponse,
        postConfig = {
            contentType = SduiApiStorePostConfigContentType.Proto,
            protoMessage = seeAll.ExperienceLeaderboardSeeAllRequest,
            body = seeAll.ExperienceLeaderboardSeeAllRequest.new({
                universe_id = tonumber(str1),
                initial_tab = initialTab,
                client_capabilities = SduiCapabilities.buildClientCapabilities(),
                cached_roblox_component_to_template_id = getSduiTemplateStore().getCachedRobloxComponentToTemplateId(AppPage.ExperienceLeaderboardSeeAll)
            })
        },
        enableTemplateCache = true
    }, bool1 or bool2)

    return url
end

return fetchExperienceLeaderboardSeeAllPageIfNeeded
