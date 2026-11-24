-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T22:51:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InterventionShared = script:FindFirstAncestor("InterventionShared")
local InterventionSharedParent = InterventionShared.Parent

local React = require(InterventionSharedParent.React)
local UIBlox = require(InterventionSharedParent.UIBlox)
local Foundation = require(InterventionSharedParent.Foundation)
local FoundationText = Foundation.Text
local ModalWindow = UIBlox.App.Dialog.Modal.ModalWindow
local useLayerCollector = UIBlox.Core.Layout.LayerCollector.useLayerCollector
local useLocalization = require(InterventionSharedParent.Localization).Hooks.useLocalization
local useStyle = UIBlox.Core.Style.useStyle
local Constants = require(InterventionShared.Utils.Constants)
local InterventionAnalytics = require(InterventionShared.InterventionAnalytics)
local Icon = Foundation.Icon
local View = Foundation.View
local ScrollView = Foundation.ScrollView
local ScrollBarVisibility = Foundation.Enums.ScrollBarVisibility
local useTokens = Foundation.Hooks.useTokens
local NotificationModalsManager = require(InterventionSharedParent.NotificationModalsManager)
local iconsActionsAccept = UIBlox.App.ImageSet.Images["icons/actions/accept"]
local ButtonStack = UIBlox.App.Button.ButtonStack
local ButtonType = UIBlox.App.Button.Enum.ButtonType
local useScrollFrameHeightCalculation = require(InterventionShared.Hooks.useScrollFrameHeightCalculation)
local useCursor = UIBlox.App.SelectionCursor.useCursor
local useInterventionPlacement = require(InterventionShared.Hooks.useInterventionPlacement)
local useDeviceInsets = require(InterventionSharedParent.Responsive).useDeviceInsets
local FFlagLuaAppSupportDeviceSafeInsets = require(InterventionSharedParent.SharedFlags).FFlagLuaAppSupportDeviceSafeInsets
local bool1 = game:DefineFastFlag("AppChatInterventionDeviceSafeInsets", false)

local FocusNavigationUtils = require(InterventionSharedParent.FocusNavigationUtils)
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum
local FocusRoot = FocusNavigationUtils.FocusRoot

function InterventionDialog(tbl1)
    local absoluteSize = useLayerCollector().absoluteSize
    local var1 = React.useRef(DateTime.now().UnixTimestampMillis)
    local var2 = useTokens()
    local var3 = useStyle()
    local placement = useInterventionPlacement()
    local var5 = nil
    if bool1 and FFlagLuaAppSupportDeviceSafeInsets then
        local var6 = useDeviceInsets()
        if placement == Constants.InterventionPlacementType.InApp then
            absoluteSize = Vector2.new(math.max(0, absoluteSize.X - var6.left - var6.right), math.max(0, absoluteSize.Y - var6.top - var6.bottom))
            var5 = var6
        end
    end

    local var6 = useLocalization(Constants.localizationKeys)

    local onActivated = React.useCallback(function()
        InterventionAnalytics.sendAnalyticsEvent(InterventionAnalytics.TelemetryConfigs.DialogCtaClicked, {
            eventType = InterventionAnalytics.Constants.EventTypes.CtaClicked,
            counterNamespace = tbl1.namespaceForAnalytics,
            interventionType = tbl1.interventionTypeForAnalytics,
            placement = placement,
            renderedTimestamp = var1.current,
            eventId = tbl1.eventId,
            evidence = tbl1.evidence,
            duration = tbl1.durationForAnalytics
        })
        tbl1.onDismiss()
    end, {
        var1,
        tbl1.interventionTypeForAnalytics,
        tbl1.eventId,
        tbl1.evidence,
        tbl1.durationForAnalytics,
        tbl1.onDismiss
    })

    local var4 = React.useCallback(function()
        tbl1.onDismiss()
        NotificationModalsManager.SetUIBloxToast({
            iconImage = iconsActionsAccept,
            toastTitle = var6.TakeALookText,
            toastSubtitle = var6.FeedbackHelpsText,
            sequenceNumber = DateTime.now().UnixTimestamp,
            iconColorStyle = {
                Color = var3.Tokens.Color.System.Success.Color3,
                Transparency = 0
            }
        })

        InterventionAnalytics.sendAnalyticsEvent(InterventionAnalytics.TelemetryConfigs.DialogAppealClicked, {
            eventType = InterventionAnalytics.Constants.EventTypes.AppealClicked,
            counterNamespace = tbl1.namespaceForAnalytics,
            interventionType = tbl1.interventionTypeForAnalytics,
            placement = placement,
            renderedTimestamp = var1.current,
            eventId = tbl1.eventId,
            evidence = tbl1.evidence,
            duration = tbl1.durationForAnalytics
        })
    end, {
        tbl1.onDismiss,
        tbl1.interventionTypeForAnalytics,
        tbl1.eventId,
        tbl1.evidence,
        tbl1.durationForAnalytics
    })

    React.useEffect(function()
        InterventionAnalytics.sendAnalyticsEvent(InterventionAnalytics.TelemetryConfigs.DialogRendered, {
            eventType = InterventionAnalytics.Constants.EventTypes.ModalAppeared,
            counterNamespace = tbl1.namespaceForAnalytics,
            interventionType = tbl1.interventionTypeForAnalytics,
            placement = placement,
            renderedTimestamp = var1.current,
            eventId = tbl1.eventId,
            evidence = tbl1.evidence,
            duration = tbl1.durationForAnalytics
        })
    end, { var1, tbl1.eventId })

    local var9 = useScrollFrameHeightCalculation({ screenSize = if var5 then absoluteSize else nil })

    local str1 = if absoluteSize.X > 540 then "gap-xlarge" else "gap-medium"

    local cursor = useCursor(UDim.new(0, var3.Tokens.Radius.Medium), var3.Tokens.Size.Size_100, var3.Tokens.Size.Size_50)

    local createElement = React.createElement
    local var11 = ModalWindow
    local tbl2 = { screenSize = absoluteSize, isFullHeight = false }

    local tbl3 = { ContentContainer = 0 }
    local createElement2 = React.createElement
    local var12 = View
    local tbl4 = {
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        tag = "padding-x-xlarge padding-y-large"
    }
    local tbl5 = { ScrollView = 0 }
    local createElement3 = React.createElement
    local var13 = ScrollView
    local tbl6 = {
        Size = UDim2.new(1, 0, 0, var9.scrollFrameContainerHeight),
        scroll = {
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
            CanvasSize = UDim2.new(1, 0, 1, 0),
            scrollBarVisibility = ScrollBarVisibility.Always,
            ScrollingDirection = Enum.ScrollingDirection.Y
        }
    }
    local tbl7 = { FocusNavigationCoreScriptsWrapper = 0 }
    local createElement4 = React.createElement
    local var14 = FocusRoot
    local tbl8 = {
        surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.PopUp,
        isIsolated = true,
        isAutoFocusRoot = placement ~= Constants.InterventionPlacementType.InApp,
        frameProps = {
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y
        }
    }
    local tbl9 = { InnerContent = 0 }
    local createElement5 = React.createElement
    local var15 = View
    local tbl10 = {
        Size = UDim2.new(1, if var9.shouldShowScrollBar then -Constants.SCROLL_BAR_WIDTH else 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        tag = `col {str1} align-x-center align-y-center` .. (if var9.shouldShowScrollBar then " padding-right-xsmall" else ""),
        onAbsoluteSizeChanged = var9.onInnerContentSizeChanged
    }
    local tbl11 = { IconAndText = 0, ButtonContainer = 0 }
    local createElement6 = React.createElement
    local var16 = View
    local tbl12 = {
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        tag = if absoluteSize.X > 540 then `col {str1} align-x-center` else `row {str1} align-x-center align-y-center`,
        LayoutOrder = 1
    }

    local tbl13 = {
        Icon = if tbl1.iconName then React.createElement(Icon, { size = tbl1.iconSize, name = tbl1.iconName, style = tbl1.iconStyle, LayoutOrder = 1 }) else nil,
        TextContent = 0
    }

    local createElement7 = React.createElement
    local var17 = View
    local tbl14 = {
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        LayoutOrder = 2,
        tag = "col fill"
    }

    local tbl15 = { TitleText = 0, BodyText = 0 }
    local element

    if tbl1.titleText then
        element = React.createElement(FoundationText, {
            LayoutOrder = 1,
            Text = tbl1.titleText,
            textStyle = var2.Color.Content.Emphasis,
            fontStyle = var2.Typography.TitleLarge,
            TextXAlignment = if absoluteSize.X > 540 then Enum.TextXAlignment.Center else Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Center,
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            TextWrapped = true
        })
    else
        element = nil
    end

    tbl15.TitleText = element
    local element2

    if tbl1.bodyText then
        element2 = React.createElement(FoundationText, {
            LayoutOrder = 2,
            Text = tbl1.bodyText,
            textStyle = var2.Color.Content.Default,
            fontStyle = var2.Typography.BodyMedium,
            TextXAlignment = if absoluteSize.X > 540 then Enum.TextXAlignment.Center else Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Center,
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            TextWrapped = true
        })
    else
        element2 = nil
    end

    tbl15.BodyText = element2
    tbl13.TextContent = createElement7(var17, tbl14, tbl15)
    tbl11.IconAndText = createElement6(var16, tbl12, tbl13)

    tbl11.ButtonContainer = React.createElement(
        View,
        {
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            tag = "padding-x-xxsmall",
            LayoutOrder = 2
        },
        {
            ButtonStack = React.createElement(ButtonStack, {
                buttons = {
                    {
                        buttonType = ButtonType.PrimarySystem,
                        props = {
                            cursor = cursor,
                            text = var6.IUnderstandText,
                            onActivated = onActivated,
                            layoutOrder = 1
                        }
                    },
                    {
                        buttonType = ButtonType.Secondary,
                        props = {
                            cursor = cursor,
                            text = var6.MistakeText,
                            onActivated = var4,
                            layoutOrder = 2
                        }
                    }
                }
            })
        }
    )
    tbl9.InnerContent = createElement5(var15, tbl10, tbl11)
    tbl7.FocusNavigationCoreScriptsWrapper = createElement4(var14, tbl8, tbl9)
    tbl5.ScrollView = createElement3(var13, tbl6, tbl7)
    tbl3.ContentContainer = createElement2(var12, tbl4, tbl5)
    local dialog = createElement(var11, tbl2, tbl3)

    if not var5 then
        return dialog
    end

    return React.createElement(View, {
        Position = UDim2.fromOffset(var5.left, var5.top),
        Size = UDim2.new(1, -var5.left - var5.right, 1, -var5.top - var5.bottom),
        testId = "intervention-dialog-safe-area"
    }, { Dialog = dialog })
end

return React.memo(InterventionDialog)
