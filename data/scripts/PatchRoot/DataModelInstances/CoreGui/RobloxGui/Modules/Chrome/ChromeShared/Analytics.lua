-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:30:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChromeShared = script:FindFirstAncestor("ChromeShared")

local CorePackages = game:GetService("CorePackages")

local ViewportUtil = require(ChromeShared.Service.ViewportUtil)
local useObservableValue = require(ChromeShared.Hooks.useObservableValue)
local ChromeAnalytics = require(script.ChromeAnalytics)
local React = require(CorePackages.Packages.React)

local var1 = require(CorePackages.Workspace.Packages.SharedFlags).GetFFlagUnibarLuaOcclusionMetrics()
local OcclusionMetricsManager = require(script.OcclusionMetricsManager)

local function ChromeAnalyticsListener(_)
    ChromeAnalytics.default:setScreenSize((useObservableValue(ViewportUtil.screenSize)))

    if var1 then
        return React.createElement(OcclusionMetricsManager)
    end
    return nil
end

return ChromeAnalyticsListener
