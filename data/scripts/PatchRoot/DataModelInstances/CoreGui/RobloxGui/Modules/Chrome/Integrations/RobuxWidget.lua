-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:00:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Chrome = script:FindFirstAncestor("Chrome")

local CorePackages = game:GetService("CorePackages")

local React = require(CorePackages.Packages.React)

local Service = require(Chrome.Service)
local Constants = require(Chrome.ChromeShared.Unibar.Constants)
local Chrome2 = require(CorePackages.Workspace.Packages.Chrome)
local InExperienceShop = require(CorePackages.Workspace.Packages.InExperienceShop)
local InExperienceSideSheet = require(CorePackages.Workspace.Packages.InExperienceSideSheet)
local isSideSheetEnabled = require(CorePackages.Workspace.Packages.InExperienceSideSheetUtils.isSideSheetEnabled)
local FFlagEnableSideSheetRobuxWidget = require(Chrome.Flags.FFlagEnableSideSheetRobuxWidget)
local FFlagHideHeaderForBuyRobuxInExperienceShop = require(CorePackages.Workspace.Packages.SharedFlags).FFlagHideHeaderForBuyRobuxInExperienceShop

local function openShop()
    if not Service:isIntegrationValid(Constants.IN_EXPERIENCE_SHOP_ID) and not FFlagHideHeaderForBuyRobuxInExperienceShop then
        return
    end
    if FFlagHideHeaderForBuyRobuxInExperienceShop then
        InExperienceShop.setOpenedFromBuyRobux(true)
    end
    if not Service:isWindowOpen(Constants.IN_EXPERIENCE_SHOP_ID) then
        InExperienceShop.requestOpenToRobuxTab()
    end
    Service:activate(Constants.IN_EXPERIENCE_SHOP_ID)
end

local function RobuxWidgetIntegration(arg1)
    return React.createElement(InExperienceSideSheet.RobuxWidget, {
        layoutOrder = arg1.layoutOrder,
        placement = arg1.placement,
        onBuyActivated = openShop,
        firstIntegrationToFocusCallback = arg1.firstIntegrationToFocusCallback
    })
end

return (if FFlagEnableSideSheetRobuxWidget and isSideSheetEnabled then Service:register({
    id = "RobuxWidget",
    label = "Feature.Catalog.Label.BuyRobux",
    activated = function() end,
    initialAvailability = Service.AvailabilitySignal.Available,
    sideSheetPlacement = Chrome2.Enums.SideSheetPlacement.ScrollableContentTop,
    components = { Widget = RobuxWidgetIntegration }
}) else nil)
    or {}
