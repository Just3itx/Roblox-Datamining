-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:51:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local CorePackages = game:GetService("CorePackages")

local Dash = require(CorePackages.Packages.Dash)

local SetActiveTab = require(script.Parent.Parent.Actions.SetActiveTab)
local SetDevConsoleVisibility = require(script.Parent.Parent.Actions.SetDevConsoleVisibility)
local SetDevConsoleMinimized = require(script.Parent.Parent.Actions.SetDevConsoleMinimized)

local throttlingPercentage = game:DefineFastInt("ReportDevConsoleTabEventsThrottleHundredthsPercent", 0)

function ReportDevConsoleOpenClose(arg1, arg2)
    if arg2.type ~= SetDevConsoleVisibility.name then
        return
    end

    local isVisible = arg1:getState().DisplayOptions.isVisible
    local visibleStartTime = arg1:getState().DisplayOptions.visibleStartTime

    if arg2.isVisible == isVisible then
        return
    end

    if arg2.isVisible then
        RbxAnalyticsService:ReportCounter("DevConsoleStartVisible", 1)
        return
    end
    local var1 = tick() - visibleStartTime
    RbxAnalyticsService:ReportStats("DevConsoleSessionTime", var1)
end

function getTabAnalyticsKeyName(arg1, isClientView): string
    if isClientView ~= nil then
        return string.format("%s_%s", arg1, if isClientView then "Client" else "Server")
    end
    return string.format("%s", arg1)
end

function dispatchTabAnalytics(arg1)
    local points = Dash.join({ placeId = game.PlaceId, calledFrom = "devConsoleTabChange" }, arg1)

    RbxAnalyticsService:ReportInfluxSeries("devConsoleMetric", points, throttlingPercentage)
end

function ReportTabChange(arg1, arg2)
    if arg2.type == SetActiveTab.name then
        local mainView = arg1:getState().MainView

        local newTabIndex = arg2.newTabIndex
        local isClientView = arg2.isClientView

        if newTabIndex ~= mainView.currTabIndex or isClientView ~= nil and isClientView ~= mainView.isClientView then
            local tbl1 = {
                initTab = getTabAnalyticsKeyName(mainView.currTabIndex, mainView.isClientView),
                endTab = getTabAnalyticsKeyName(newTabIndex, isClientView)
            }

            dispatchTabAnalytics(tbl1)
        end

        return
    end
    if arg2.type == SetDevConsoleVisibility.name then
        local mainView = arg1:getState().MainView
        local displayOptions = arg1:getState().DisplayOptions

        local var1 = arg2.isVisible
            and {
                initTab = "StartVisible",
                endTab = getTabAnalyticsKeyName(mainView.currTabIndex, mainView.isClientView)
            }
            or displayOptions.isMinimized and { initTab = "Minimized", endTab = "EndVisible" }
            or {
                initTab = getTabAnalyticsKeyName(mainView.currTabIndex, mainView.isClientView),
                endTab = "EndVisible"
            }

        dispatchTabAnalytics(var1)
        return
    end

    if arg2.type ~= SetDevConsoleMinimized.name then
        return
    end

    local mainView = arg1:getState().MainView

    local var1 = arg2.isMinimized
        and {
            initTab = getTabAnalyticsKeyName(mainView.currTabIndex, mainView.isClientView),
            endTab = "Minimized"
        }
        or {
            initTab = "Minimized",
            endTab = getTabAnalyticsKeyName(mainView.currTabIndex, mainView.isClientView)
        }

    dispatchTabAnalytics(var1)
end

return function(callback, arg1)
    return function(arg2)
        ReportTabChange(arg1, arg2)
        ReportDevConsoleOpenClose(arg1, arg2)
        callback(arg2)
    end
end
