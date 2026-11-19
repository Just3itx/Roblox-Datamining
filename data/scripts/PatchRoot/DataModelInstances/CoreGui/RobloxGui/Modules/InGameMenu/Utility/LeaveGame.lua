-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:51:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RunService = game:GetService("RunService")
local GuiService = game:GetService("GuiService")
local CorePackages = game:GetService("CorePackages")
local scriptParentParent = script.Parent.Parent

local GetDefaultQualityLevel = require(CorePackages.Workspace.Packages.AppCommonLib).GetDefaultQualityLevel
local SendAnalytics = require(scriptParentParent.Utility.SendAnalytics)
local Constants = require(scriptParentParent.Resources.Constants)

return function()
    SendAnalytics(
        Constants.AnalyticsInGameMenuName,
        Constants.AnalyticsLeaveGameName,
        {
            confirmed = Constants.AnalyticsConfirmedName
        }
    )
    GuiService.SelectedCoreObject = nil

    RunService.RenderStepped:Wait()
    RunService.RenderStepped:Wait()

    game:Shutdown()
    settings().Rendering.QualityLevel = GetDefaultQualityLevel()
end
