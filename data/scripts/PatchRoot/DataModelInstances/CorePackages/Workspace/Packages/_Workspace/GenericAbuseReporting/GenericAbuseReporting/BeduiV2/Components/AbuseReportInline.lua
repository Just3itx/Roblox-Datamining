-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:40:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReporting = script:FindFirstAncestor("GenericAbuseReporting")
local GenericAbuseReportingParent = GenericAbuseReporting.Parent

local FocusNavigationUtils = require(GenericAbuseReportingParent.FocusNavigationUtils)
local Foundation = require(GenericAbuseReportingParent.Foundation)
local Motion = require(GenericAbuseReportingParent.Motion)
local React = require(GenericAbuseReportingParent.React)

local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum
local useInExpFocusNavigationRefs = require(GenericAbuseReporting.BeduiV2.Hooks.FocusNavigation.useInExpFocusNavigationRefs)
local useScrollNavigationBindings = require(GenericAbuseReporting.BeduiV2.Hooks.FocusNavigation.useScrollNavigationBindings)

local AnimatePresence = Motion.AnimatePresence
local Icon = Foundation.Icon
local IconName = Foundation.Enums.IconName
local InputSize = Foundation.Enums.InputSize
local useTokens = Foundation.Hooks.useTokens
local View = Foundation.View

local AbuseReportTooltip = require(GenericAbuseReporting.BeduiV2.Components.AbuseReportTooltip)
local _AbuseSheetFlowTypes = require(GenericAbuseReporting.BeduiV2.Hooks.AbuseSheetFlow.AbuseSheetFlowTypes)
local Feedback = require(GenericAbuseReporting.BeduiV2.Components.Feedback)
local LayoutSlots = require(GenericAbuseReporting.BeduiV2.Components.LayoutSlots)
local SlideTransition = require(GenericAbuseReporting.BeduiV2.Components.SlideTransition)
local useArTranslation = require(GenericAbuseReporting.BeduiV2.Utils.Translate.arTranslation).useArTranslation

local INLINE_LANDSCAPE_WIDTH = LayoutSlots.INLINE_LANDSCAPE_WIDTH

return React.memo(function(tbl1) -- name: AbuseReportInline
    local var1 = useTokens()
    local translateIntoString = useArTranslation().translateIntoString

    local abuseReportFlow = tbl1.abuseReportFlow
    local config = abuseReportFlow.config
    local currentPageElement = abuseReportFlow.currentPageElement
    local pendingInlineAlert = abuseReportFlow.pendingInlineAlert

    local createElement = React.createElement
    local var2 = AnimatePresence
    local var3 = nil
    local tbl2

    if pendingInlineAlert then
        tbl2 = { Alert = 0 }
        local createElement2 = React.createElement
        local var4 = Feedback
        local tbl3 = {
            severity = pendingInlineAlert.type,
            title = translateIntoString(pendingInlineAlert.title),
            subtitle = if pendingInlineAlert.subtitle then translateIntoString(pendingInlineAlert.subtitle) else nil,
            onClose = abuseReportFlow.dismissInlineAlert,
            bottomMargin = if tbl1.shouldUseOverlaidControls then nil else var1.Padding.Medium,
            maxWidth = if tbl1.shouldUseOverlaidControls then INLINE_LANDSCAPE_WIDTH * var1.Config.UI.Scale else nil,
            layoutOrder = 1
        }
        tbl2.Alert = createElement2(var4, tbl3)
    else
        tbl2 = nil
    end

    local feedbackAlertElement = createElement(var2, var3, tbl2)

    local element2 = React.createElement(SlideTransition, {
        nodeContent = React.createElement(View, { tag = "col align-x-center size-full" }, {
            FeedbackAlertElement = feedbackAlertElement,
            PageContent = React.createElement(View, { tag = "col fill size-full-0", LayoutOrder = 2 }, currentPageElement)
        }),
        nodeId = abuseReportFlow.currentNodeId,
        nodeType = abuseReportFlow.currentNodeType,
        direction = abuseReportFlow.navigationDirection
    })

    local isOpen, var5 = React.useState(if config.display.titleDisclosure then config.display.titleDisclosure.openByDefault or false else false)

    local var6 = React.useCallback(function()
        var5(function(arg1): boolean
            return not arg1
        end)
    end, {})

    local ref = useScrollNavigationBindings()

    local var8 = React.useCallback(function()
        var5(false)
    end, {})

    local var4 = useInExpFocusNavigationRefs(FocusNavigableSurfaceIdentifierEnum.CentralOverlay, var8, isOpen, isOpen)

    local backButtonContainer = React.useMemo(function()
        return React.createElement(
            View,
            {
                tag = {
                    ["align-x-center auto-xy padding-y-small"] = true,
                    ["position-top-left anchor-top-left"] = tbl1.shouldUseOverlaidControls
                },
                LayoutOrder = 1
            },
            React.createElement(
                View,
                {
                    isDisabled = not abuseReportFlow.canGoBack,
                    selection = {
                        Selectable = abuseReportFlow.canGoBack
                    },
                    onActivated = abuseReportFlow.goBack,
                    tag = "auto-xy padding-small radius-circle"
                },
                React.createElement(Icon, {
                    name = IconName.ChevronLargeLeft,
                    size = InputSize.Medium,
                    style = {
                        Transparency = if abuseReportFlow.canGoBack then 0 else 1
                    }
                })
            )
        )
    end, { abuseReportFlow.canGoBack, abuseReportFlow.goBack, tbl1.shouldUseOverlaidControls })

    local abuseReportTooltipContainer = React.useMemo(function()
        if not config.display.titleDisclosure then
            return nil
        end

        return (React.createElement(
            View,
            {
                tag = {
                    ["align-x-center auto-xy padding-y-small"] = true,
                    ["position-top-right anchor-top-right"] = tbl1.shouldUseOverlaidControls
                },
                LayoutOrder = 3,
                ZIndex = 2
            },
            React.createElement(
                View,
                { onActivated = var6, tag = "auto-xy padding-small radius-circle" },
                React.createElement(
                    AbuseReportTooltip,
                    {
                        tooltipTitle = config.display.titleDisclosure.tooltipTitle,
                        tooltipText = config.display.titleDisclosure.tooltipText,
                        buttonLabel = config.display.titleDisclosure.buttonLabel,
                        isOpen = isOpen,
                        onClose = var6,
                        ref = var4
                    },
                    React.createElement(Icon, { name = IconName.CircleI, size = InputSize.Medium })
                )
            )
        ))
    end, {
        config.display.titleDisclosure,
        var4,
        var6,
        isOpen,
        tbl1.shouldUseOverlaidControls
    })

    return React.createElement(View, {
        tag = {
            ["size-full"] = tbl1.shouldUseOverlaidControls,
            ["col size-full"] = not tbl1.shouldUseOverlaidControls
        },
        ref = ref
    }, {
        TopControlsContainer = React.createElement(
            View,
            {
                tag = {
                    ["size-full"] = tbl1.shouldUseOverlaidControls,
                    ["row flex-between size-full-0 auto-y"] = not tbl1.shouldUseOverlaidControls
                },
                LayoutOrder = 1
            },
            {
                BackButtonContainer = backButtonContainer,
                AbuseReportTooltipContainer = abuseReportTooltipContainer
            }
        ),
        Content = React.createElement(View, {
            tag = {
                ["col gap-xlarge size-full"] = tbl1.shouldUseOverlaidControls,
                ["col fill size-full-0 margin-bottom-medium"] = not tbl1.shouldUseOverlaidControls
            },
            LayoutOrder = 2
        }, element2)
    })
end)
