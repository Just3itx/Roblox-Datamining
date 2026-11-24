-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:40:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReporting = script:FindFirstAncestor("GenericAbuseReporting")
local GenericAbuseReportingParent = GenericAbuseReporting.Parent

local FocusNavigationUtils = require(GenericAbuseReportingParent.FocusNavigationUtils)
local Foundation = require(GenericAbuseReportingParent.Foundation)
local React = require(GenericAbuseReportingParent.React)

local ButtonVariant = Foundation.Enums.ButtonVariant
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum
local IconButton = Foundation.IconButton
local InputSize = Foundation.Enums.InputSize
local Sheet = Foundation.Sheet
local View = Foundation.View

local AbuseReportTooltip = require(GenericAbuseReporting.BeduiV2.Components.AbuseReportTooltip)
local _AbuseSheetFlowTypes = require(GenericAbuseReporting.BeduiV2.Hooks.AbuseSheetFlow.AbuseSheetFlowTypes)
local _AbuseVector = require(GenericAbuseReporting.Enums.AbuseVector)
local useFocusNavigationRefs = require(GenericAbuseReporting.BeduiV2.Hooks.FocusNavigation.useFocusNavigationRefs)

return React.memo(function(tbl1)
    local abuseReportFlow = tbl1.abuseReportFlow
    local config = abuseReportFlow.config
    local currentPageElement = abuseReportFlow.currentPageElement
    local canGoBack = abuseReportFlow.canGoBack

    local isOpen, var2 = React.useState(if config.display.titleDisclosure then config.display.titleDisclosure.openByDefault or false else false)

    local ref = useFocusNavigationRefs(FocusNavigableSurfaceIdentifierEnum.CentralOverlay, function()
        var2(false)
    end)

    React.useEffect(function()
        if isOpen then
            tbl1.takeoverFocus(true)
            return
        end
        tbl1.takeoverFocus(false)
    end, { tbl1.takeoverFocus, isOpen })

    local var4 = React.useCallback(function()
        var2(function(arg1): boolean
            return not arg1
        end)
    end, {})

    local createElement = React.createElement
    local fragment = React.Fragment
    local var5 = nil
    local tbl2 = { Header = 0, Content = 0 }
    local createElement2 = React.createElement
    local header = Sheet.Header
    local var6 = nil
    local createElement3 = React.createElement
    local var7 = View
    local tbl3 = { tag = "row flex-between align-y-center gap-small size-full-0 auto-y" }

    local tbl4 = {
        [1] = nil,
        (React.createElement(View, { tag = "row align-y-center gap-small auto-xy" }, {
            BackIcon = if canGoBack then React.createElement(IconButton, {
                size = InputSize.Medium,
                icon = Foundation.Enums.IconName.ChevronLargeLeft,
                variant = ButtonVariant.Utility,
                onActivated = abuseReportFlow.goBack,
                LayoutOrder = 1
            }) else nil
        }))
    }
    local element

    if config.display.titleDisclosure then
        element = React.createElement(
            AbuseReportTooltip,
            {
                tooltipTitle = config.display.titleDisclosure.tooltipTitle,
                tooltipText = config.display.titleDisclosure.tooltipText,
                buttonLabel = config.display.titleDisclosure.buttonLabel,
                layoutOrder = 3,
                isOpen = isOpen,
                onClose = var4,
                ref = ref
            },
            React.createElement(IconButton, {
                size = InputSize.Medium,
                icon = Foundation.Enums.IconName.CircleI,
                variant = ButtonVariant.Utility,
                onActivated = var4,
                LayoutOrder = 3
            })
        )
    else
        element = nil
    end

    tbl4.AbuseReportTooltip = element
    tbl2.Header = createElement2(header, var6, createElement3(var7, tbl3, tbl4))

    tbl2.Content = currentPageElement
    return createElement(fragment, var5, tbl2)
end)
