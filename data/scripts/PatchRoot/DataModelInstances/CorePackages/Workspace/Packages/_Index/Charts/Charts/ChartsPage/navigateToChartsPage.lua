-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T06:30:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Charts = script:FindFirstAncestor("Charts")
local ChartsParent = Charts.Parent

local AppPage = require(ChartsParent.RobloxAppEnums).AppPage
local SduiSurfaceLoadTimeTracker = require(ChartsParent.SduiSharedUtilities).SduiSurfaceLoadTimeTracker
local fetchChartsPage = require(Charts.ChartsPage.fetchChartsPage)
local ChartsConstants = require(Charts.ChartsPage.ChartsConstants)

local function navigateToChartsPage(arg1)
    local pageTimer = SduiSurfaceLoadTimeTracker.createLoadTimerWithSurfaceLoadTime(
        ChartsConstants.ConfigKey,
        {
            eventName = ChartsConstants.SurfaceLoadTimeEventName,
            metadata = { page = "navigate" }
        }
    )

    pageTimer.start("navigate")

    fetchChartsPage(pageTimer)

    arg1.navigate(AppPage.Games, { pageTimer = pageTimer })
end

return navigateToChartsPage
