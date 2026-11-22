-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T00:30:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Home = script:FindFirstAncestor("Home")
local HomeParent = Home.Parent

local SduiSharedUtilities = require(HomeParent.SduiSharedUtilities)

local buildHomeSortDetailPageEntry = require(Home.HomeSortDetailPage.buildHomeSortDetailPageEntry)
local getHomeSortDetailPageKey = require(Home.HomeSortDetailPage.getHomeSortDetailPageKey)
local HomeSortDetailConstants = require(Home.HomeSortDetailPage.HomeSortDetailConstants)

local function fetchHomeSortDetail(str1: string, num1: number?, loadTimer)
    local configKey = getHomeSortDetailPageKey(str1, num1)
    local homeSortDetailPageEntry = buildHomeSortDetailPageEntry(str1, num1)
    if homeSortDetailPageEntry == nil then
        return nil, configKey
    end

    local createTemplateApiRequestConfig = SduiSharedUtilities.createTemplateApiRequestConfig
    if createTemplateApiRequestConfig == nil then
        return nil, configKey
    end
    local templateApiRequestConfig = createTemplateApiRequestConfig({
        surfaceKey = HomeSortDetailConstants.SurfaceKey,
        configKey = configKey,
        loadTimer = loadTimer,
        pageEntries = { homeSortDetailPageEntry }
    })
    if templateApiRequestConfig == nil then
        return nil, configKey
    end

    return SduiSharedUtilities.getSduiApiStore().fetchIfNeeded(templateApiRequestConfig), configKey
end

return fetchHomeSortDetail
