-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T00:31:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Home = script:FindFirstAncestor("Home")
local HomeParent = Home.Parent

local AppPage = require(HomeParent.RobloxAppEnums).AppPage
local Promise = require(HomeParent.Promise)
local _SduiCoreSystem = require(HomeParent.SduiCoreSystem)
local SduiLoadTimer = require(HomeParent.SduiSharedUtilities).SduiLoadTimer

local fetchHomePage = require(Home.fetchHomePage)

local FFlagSduiRefreshFeedItemIsOmissionExpected = require(HomeParent.SharedFlags).FFlagSduiRefreshFeedItemIsOmissionExpected

local function refreshHomePageFeedItem(topicId: string, feedItemKey: string, requestIntent: string, reportError: (...any) -> (...any), tbl1)
    local loadTimer = SduiLoadTimer.createLoadTimer(AppPage.Home)
    loadTimer.start("feed-item-refresh")

    local var1 = fetchHomePage
    local tbl2 = {
        requestIntent = requestIntent,
        contextualFeatures = tbl1.contextFeatures,
        focusedRefresh = {
            topicId = topicId,
            feedItemKey = feedItemKey,
            reportError = reportError,
            isOmissionExpected = if FFlagSduiRefreshFeedItemIsOmissionExpected then tbl1.isOmissionExpected else nil
        }
    }

    return var1(loadTimer, tbl2):andThen(function<T>(arg1: T): T
        loadTimer.logRefreshComplete()
        return arg1
    end, function(arg1)
        loadTimer.logRefreshComplete()
        return Promise.reject(arg1)
    end)
end

return refreshHomePageFeedItem
