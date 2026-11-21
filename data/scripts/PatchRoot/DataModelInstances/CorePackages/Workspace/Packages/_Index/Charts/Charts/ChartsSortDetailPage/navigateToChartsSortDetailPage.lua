-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T06:30:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Charts = script:FindFirstAncestor("Charts")
local ChartsParent = Charts.Parent

local AppPage = require(ChartsParent.RobloxAppEnums).AppPage
local SduiSharedUtilities = require(ChartsParent.SduiSharedUtilities)
local SduiSurfaceLoadTimeTracker = SduiSharedUtilities.SduiSurfaceLoadTimeTracker
local getSduiClientPageScope = SduiSharedUtilities.getSduiClientPageScope
local ChartsConstants = require(Charts.ChartsPage.ChartsConstants)
local ChartsPageScopeFields = require(Charts.ChartsPage.ChartsPageScopeFields)
local ChartsSortDetailConstants = require(Charts.ChartsSortDetailPage.ChartsSortDetailConstants)
local fetchChartsSortDetail = require(Charts.ChartsSortDetailPage.fetchChartsSortDetail)
local getChartsSortDetailPageKey = require(Charts.ChartsSortDetailPage.getChartsSortDetailPageKey)

local function navigateToChartsSortDetailPage(arg1, tbl1)
    local var1 = getSduiClientPageScope(ChartsConstants.ConfigKey).get(ChartsPageScopeFields.FilterSelections)
    local chartsSortDetailPageKey = getChartsSortDetailPageKey(tbl1.sortId, nil, var1)
    local pageTimer = SduiSurfaceLoadTimeTracker.createLoadTimerWithSurfaceLoadTime(
        chartsSortDetailPageKey,
        {
            eventName = ChartsSortDetailConstants.SurfaceLoadTimeEventName,
            metadata = { page = "navigate" }
        }
    )

    pageTimer.start("navigate")

    fetchChartsSortDetail(tbl1.sortId, pageTimer)

    arg1.navigate(
        AppPage.GamesList,
        {
            detail = tbl1.sortId,
            extraProps = {
                pageContext = tbl1.pageContext,
                pageTimer = pageTimer
            }
        }
    )
end
return navigateToChartsSortDetailPage
