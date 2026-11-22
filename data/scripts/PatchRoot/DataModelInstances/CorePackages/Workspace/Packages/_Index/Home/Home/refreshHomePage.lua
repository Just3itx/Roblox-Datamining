-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T00:31:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Home = script:FindFirstAncestor("Home")
local HomeParent = Home.Parent

local AppPage = require(HomeParent.RobloxAppEnums).AppPage
local SduiSharedUtilities = require(HomeParent.SduiSharedUtilities)
local fetchHomePage = require(Home.fetchHomePage)
local GetSiteMessageStore = require(HomeParent.SiteMessageStore).GetSiteMessageStore

local function refreshHomePage(requestIntent: string?, contextualFeatures, bool1: boolean?)
    if bool1 ~= false then
        GetSiteMessageStore(false).refreshSiteAlertInfo()
    end

    local loadTimer = SduiSharedUtilities.SduiLoadTimer.createLoadTimer(AppPage.Home)
    loadTimer.start("refresh")
    local var1 = fetchHomePage(
        loadTimer,
        {
            forceRefresh = true,
            requestIntent = requestIntent,
            contextualFeatures = contextualFeatures
        }
    )

    if not var1 then
        return nil
    end
    return var1:finally(function()
        loadTimer.logRefreshComplete()
    end)
end

return refreshHomePage
