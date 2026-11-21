-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T13:20:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExperienceStoreServerDrivenUi = script:FindFirstAncestor("ExperienceStoreServerDrivenUi")
local ExperienceStoreServerDrivenUiParent = ExperienceStoreServerDrivenUi.Parent

local AppPage = require(ExperienceStoreServerDrivenUiParent.RobloxAppEnums).AppPage
local SduiSharedUtilities = require(ExperienceStoreServerDrivenUiParent.SduiSharedUtilities)
local SduiResponseType = SduiSharedUtilities.SduiResponseType
local getSduiApiStore = SduiSharedUtilities.getSduiApiStore
local getDevStoreSeeAllUrl = require(ExperienceStoreServerDrivenUi.Api.getDevStoreSeeAllUrl)
local getDevStoreSeeAllPageKey = require(ExperienceStoreServerDrivenUi.Utils.getDevStoreSeeAllPageKey)

local function fetchDevStoreSeeAllPageIfNeeded(str1: string, loadTimer, bool1: boolean?)
    local url = getDevStoreSeeAllUrl(str1)
    local configKey = getDevStoreSeeAllPageKey(str1)

    local devStoreSeeAll = require(ExperienceStoreServerDrivenUiParent.ServiceContractsProto).apppageplatform.devstore.dev_store_see_all

    getSduiApiStore().fetchIfNeeded({
        responseType = SduiResponseType.Protobuf,
        url = url,
        surfaceKey = AppPage.DevStoreSeeAll,
        configKey = configKey,
        loadTimer = loadTimer,
        apiProto = devStoreSeeAll.DevStoreSeeAllResponse
    }, bool1)

    return url
end

return fetchDevStoreSeeAllPageIfNeeded
