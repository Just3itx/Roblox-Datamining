-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:41:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AbuseReportMenu = script:FindFirstAncestor("AbuseReportMenu")
local CorePackages = game:GetService("CorePackages")
local React = require(CorePackages.Packages.React)
local getMenuItemsFromConfigs = require(AbuseReportMenu.MenuConfigs.getMenuItemsFromConfigs)
local getMenuItemSizings = require(AbuseReportMenu.Utility.getMenuItemSizings)
local ReportExperienceMenuItemConfigList = require(AbuseReportMenu.MenuConfigs.Experience.ReportExperienceMenuItemConfigList)
local _Types = require(AbuseReportMenu.Components.Types)
local Constants = require(AbuseReportMenu.Components.Constants)
local Cryo = require(CorePackages.Packages.Cryo)
local reportExperienceUIStateReducer = require(AbuseReportMenu.Reducers.reportExperienceUIStateReducer)

local function ReportExperienceMenuItemsContainer(tbl1)
    local menuItemSizings = getMenuItemSizings()

    local var1, var2 = React.useReducer(reportExperienceUIStateReducer, Constants.InitExperienceUIState)
    React.useEffect(function()
        if tbl1.utilityProps.isReportTabVisible then
            tbl1.utilityProps.analyticsDispatch({ type = Constants.AnalyticsActions.SwitchToExperienceInitialSelections })
        end
    end, { tbl1.utilityProps.isReportTabVisible })

    local menuItemsFromConfigs = getMenuItemsFromConfigs(var1, var2, tbl1.utilityProps, ReportExperienceMenuItemConfigList, tbl1.isSmallPortraitViewport)

    local var3 = Cryo.Dictionary.join({
        Layout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, menuItemSizings.ItemPadding)
        })
    }, menuItemsFromConfigs)

    return React.createElement(
        "Frame",
        {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1
        },
        {
            MenuItems = React.createElement("Frame", { Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1 }, var3)
        }
    )
end

return ReportExperienceMenuItemsContainer
