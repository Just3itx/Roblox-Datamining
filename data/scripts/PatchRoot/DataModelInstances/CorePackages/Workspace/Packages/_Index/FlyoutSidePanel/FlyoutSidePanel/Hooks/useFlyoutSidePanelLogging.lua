-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T13:50:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FlyoutSidePanel = script:FindFirstAncestor("FlyoutSidePanel")
local FlyoutSidePanelParent = FlyoutSidePanel.Parent

local useFlyoutTradesEntryExposureLogging = require(FlyoutSidePanel.Hooks.useFlyoutTradesEntryExposureLogging)
local useFlyoutProfileEntryExposureLogging = require(FlyoutSidePanel.Hooks.useFlyoutProfileEntryExposureLogging)

local useCTAChangeMorePageFlyoutButtonTextExposureLogging = require(FlyoutSidePanel.Hooks.useCTAChangeMorePageFlyoutButtonTextExposureLogging)
local useFlyoutTradesEntryImpressionLogging = require(FlyoutSidePanel.Hooks.useFlyoutTradesEntryImpressionLogging)
local useFlyoutSidePanelExposureLogging = require(FlyoutSidePanel.Hooks.useFlyoutSidePanelExposureLogging)

local FFlagFlyoutTradesEntryExposureLogging = require(FlyoutSidePanel.Flags.FFlagFlyoutTradesEntryExposureLogging)
local FFlagFlyoutProfileEntryExposureLogging = require(FlyoutSidePanel.Flags.FFlagFlyoutProfileEntryExposureLogging)
local FFlagFlyoutTradesEntryImpressionLogging = require(FlyoutSidePanel.Flags.FFlagFlyoutTradesEntryImpressionLogging)
local FFlagFlyoutSidePanelIxpEnabled = require(FlyoutSidePanel.Flags.FFlagFlyoutSidePanelIxpEnabled)

local SharedFlags = require(FlyoutSidePanelParent.SharedFlags)
local FFlagEnableMeTabProfile = SharedFlags.FFlagEnableMeTabProfile
local FFlagCTAChangeMorePageFlyoutButtonTextIxpEnabled = SharedFlags.FFlagCTAChangeMorePageFlyoutButtonTextIxpEnabled

local function useFlyoutSidePanelLogging(tbl1)
    if FFlagFlyoutTradesEntryExposureLogging then
        useFlyoutTradesEntryExposureLogging()
    end
    if FFlagFlyoutProfileEntryExposureLogging and FFlagEnableMeTabProfile then
        useFlyoutProfileEntryExposureLogging()
    end
    if FFlagCTAChangeMorePageFlyoutButtonTextIxpEnabled then
        useCTAChangeMorePageFlyoutButtonTextExposureLogging()
    end
    if FFlagFlyoutTradesEntryImpressionLogging then
        useFlyoutTradesEntryImpressionLogging(tbl1)
    end
    if FFlagFlyoutSidePanelIxpEnabled then
        useFlyoutSidePanelExposureLogging()
    end
end

return useFlyoutSidePanelLogging
