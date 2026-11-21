-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T13:40:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FlyoutSidePanelParent = script:FindFirstAncestor("FlyoutSidePanel").Parent
local React = require(FlyoutSidePanelParent.React)
local useLocalization = require(FlyoutSidePanelParent.Localization).Hooks.useLocalization
local Foundation = require(FlyoutSidePanelParent.Foundation)
local ButtonVariant = Foundation.Enums.ButtonVariant
local ButtonSize = Foundation.Enums.ButtonSize
local FlyoutAnalytics = require(script.Parent.Parent.Analytics.FlyoutAnalytics)
local useRoactService = require(FlyoutSidePanelParent.RobloxAppHooks).useRoactService
local AppEventIngestService = require(FlyoutSidePanelParent.RoactServiceTags).AppEventIngestService
local FlyoutContentSettings = require(script.Parent.Parent.Config.FlyoutContentSettings)

local FFlagCTAChangeMorePageFlyoutButtonText = require(FlyoutSidePanelParent.SharedFlags).FFlagCTAChangeMorePageFlyoutButtonText

local function FlyoutReportLogs(tbl1)
    local var1 = useRoactService(AppEventIngestService)
    local onActivated = React.useCallback(function()
        tbl1.closeDrawer()
        if tbl1.openReportLogConfirmation then
            tbl1.openReportLogConfirmation()
        end
        local reportLogs = FlyoutContentSettings.ItemType.ReportLogs
        FlyoutAnalytics.sendMoreLegacyAndFlyoutItemClickEvent(var1, reportLogs)
    end, { tbl1.openReportLogConfirmation, tbl1.closeDrawer, var1 })
    local var3 = useLocalization({
        text = if FFlagCTAChangeMorePageFlyoutButtonText then "CommonUI.Features.Label.ReportLogsSentenceCase" else "CommonUI.Features.Label.ReportLogs"
    })

    return React.createElement(Foundation.Button, {
        testId = "--core-ui-flyout-button-report-logs",
        text = var3.text,
        variant = ButtonVariant.Standard,
        LayoutOrder = tbl1.layoutOrder,
        isDisabled = false,
        size = ButtonSize.Large,
        width = UDim.new(1, 0),
        onActivated = onActivated
    })
end

return FlyoutReportLogs
