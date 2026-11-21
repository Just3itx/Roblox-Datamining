-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T13:20:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExperienceStoreServerDrivenUi = script:FindFirstAncestor("ExperienceStoreServerDrivenUi")
local ExperienceStoreServerDrivenUiParent = ExperienceStoreServerDrivenUi.Parent

local AppPage = require(ExperienceStoreServerDrivenUiParent.RobloxAppEnums).AppPage
local FFlagLuaAppDevStoreSeeAllForceRefreshOnNavigate = require(ExperienceStoreServerDrivenUiParent.SharedFlags).FFlagLuaAppDevStoreSeeAllForceRefreshOnNavigate
local SduiLoadTimer = require(ExperienceStoreServerDrivenUiParent.SduiSharedUtilities).SduiLoadTimer
local fetchDevStoreSeeAllPageIfNeeded = require(ExperienceStoreServerDrivenUi.Api.fetchDevStoreSeeAllPageIfNeeded)

local function navigateToDevStoreSeeAll(arg1, universeId: string)
    local pageTimer = SduiLoadTimer.createLoadTimer(AppPage.DevStoreSeeAll)
    pageTimer.start("navigate")

    local url = fetchDevStoreSeeAllPageIfNeeded(
        universeId,
        pageTimer,
        if FFlagLuaAppDevStoreSeeAllForceRefreshOnNavigate then true else nil
    )
    arg1.navigate(AppPage.DevStoreSeeAll, { universeId = universeId, pageTimer = pageTimer, url = url })
end

return navigateToDevStoreSeeAll
