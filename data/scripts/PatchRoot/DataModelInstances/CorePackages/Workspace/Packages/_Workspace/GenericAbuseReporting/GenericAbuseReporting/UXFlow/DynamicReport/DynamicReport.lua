-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T16:01:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReporting = script:FindFirstAncestor("GenericAbuseReporting")
local GenericAbuseReportingParent = GenericAbuseReporting.Parent

local Foundation = require(GenericAbuseReportingParent.Foundation)
local React = require(GenericAbuseReportingParent.React)
local SharedFlags = require(GenericAbuseReportingParent.SharedFlags)
local UIBlox = require(GenericAbuseReportingParent.UIBlox)
local useLocalization = require(GenericAbuseReportingParent.Localization).Hooks.useLocalization
local useSelector = require(GenericAbuseReportingParent.RoactUtils).Hooks.RoactRodux.useSelector

local FFlagAddThumbnailSelectorReport = SharedFlags.FFlagAddThumbnailSelectorReport
local PartialPageModal = UIBlox.App.Dialog.Modal.PartialPageModal
local ScrollView = Foundation.ScrollView
local View = Foundation.View
local useLayerCollector = UIBlox.Core.Layout.LayerCollector.useLayerCollector

local _AbuseReportBeduiTypes = require(GenericAbuseReporting.Bedui.Provider.AbuseReportBeduiTypes)
local _AbuseVector = require(GenericAbuseReporting.Enums.AbuseVector)
local BeduiAnalytics = require(GenericAbuseReporting.Bedui.Utils.BeduiAnalytics)
local ReportFlowHandler = require(GenericAbuseReporting.Bedui.ReportFlowHandler)
local useAnalyticsContext = require(GenericAbuseReporting.Bedui.Provider.useAnalyticsContext)
local useOnScreenKeyboardHeight = require(GenericAbuseReporting.Common.useOnScreenKeyboardHeight)
local useScrollbarOffset = require(GenericAbuseReporting.Common.useScrollbarOffset)

local sendAnalyticsEvent = BeduiAnalytics.sendAnalyticsEvent
local TelemetryEventType = BeduiAnalytics.TelemetryEventType

return React.memo(function(tbl1) -- name: DynamicReport
    local absoluteSize = useLayerCollector().absoluteSize
    local var1, var2 = React.useBinding(Vector2.new(0, 0))
    local var3, var4 = React.useState(Vector2.new(0, 0))
    local var5, var6 = React.useState(Vector2.new(0, 0))
    local var7 = useScrollbarOffset(var3, var5)
    local var8 = useOnScreenKeyboardHeight()
    local isKeyboardShowing = var8.isKeyboardShowing
    local onScreenKeyboardHeight = var8.onScreenKeyboardHeight
    local keyboardPositionY = var8.keyboardPositionY

    local var9 = useLocalization({ reportTitle = "Feature.ReportAbuse.Label.Report" })

    local context = useAnalyticsContext()
    local isReportSubmitted = context.isReportSubmitted

    local var11 = useSelector(function(arg1)
        return if arg1.GlobalGuiInset then arg1.GlobalGuiInset.top else 0
    end)

    local var12 = React.useMemo(function(): number
        if not isKeyboardShowing then
            return 0
        end

        local var12 = keyboardPositionY - var11

        local var13 = absoluteSize.Y - var12
        if var13 <= 0 then
            return 0
        end

        return math.min(var13, onScreenKeyboardHeight)
    end, {
        isKeyboardShowing,
        keyboardPositionY,
        onScreenKeyboardHeight,
        absoluteSize.Y,
        var11
    })

    local yOffset = React.useMemo(function()
        return if isKeyboardShowing then -var12 else 0
    end, { isKeyboardShowing, var12 })

    React.useEffect(function()
        sendAnalyticsEvent({ eventType = TelemetryEventType.Rendered, context = { abuseVector = tbl1.abuseVector } })
    end, { sendAnalyticsEvent, tbl1.abuseVector })

    local onCloseClicked = React.useCallback(function()
        if not isReportSubmitted then
            sendAnalyticsEvent({ eventType = TelemetryEventType.Abandoned, context = context })
        end

        tbl1.onClose()
    end, {
        isReportSubmitted,
        sendAnalyticsEvent,
        context,
        tbl1.onClose
    })
    local createElement = React.createElement
    local var14 = PartialPageModal
    local tbl2 = {
        title = var9.reportTitle,
        screenSize = Vector2.new(absoluteSize.X, absoluteSize.Y),
        position = if isKeyboardShowing then UDim2.new(0.5, 0, 1, yOffset) else nil,
        anchorPoint = if isKeyboardShowing then Vector2.new(0.5, 1) else nil,
        onCloseClicked = onCloseClicked
    }
    local tbl3 = { View = 0 }
    local createElement2 = React.createElement
    local var15 = View
    local tbl4 = { tag = "size-full-0 auto-y" }

    local tbl5 = { ScrollView = 0 }
    local createElement3 = React.createElement
    local var16 = ScrollView

    local tbl6 = {
        Size = var1:map(function(vector2: Vector2)
            return UDim2.new(1, 0, 0, math.min(absoluteSize.Y - var12 - 100, math.ceil(vector2.Y)))
        end),
        scroll = {
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
            CanvasSize = UDim2.new(1, 0, 0, 0),
            ScrollingDirection = Enum.ScrollingDirection.Y,
            VerticalScrollBarInset = if FFlagAddThumbnailSelectorReport then Enum.ScrollBarInset.ScrollBar else nil
        },
        onAbsoluteCanvasSizeChanged = 0,
        onAbsoluteWindowSizeChanged = 0
    }

    function tbl6.onAbsoluteCanvasSizeChanged(arg1)
        var4(arg1.AbsoluteCanvasSize)
    end
    function tbl6.onAbsoluteWindowSizeChanged(arg1)
        var6(arg1.AbsoluteWindowSize)
    end
    local tbl7 = { Content = 0 }
    local createElement4 = React.createElement
    local var17 = View
    local tbl8 = {
        Size = if FFlagAddThumbnailSelectorReport then UDim2.new(0, 0, 0, 0) else UDim2.new(0, -var7, 0, 0),
        onAbsoluteSizeChanged = 0,
        tag = "auto-xy padding-x-xxsmall padding-top-medium"
    }

    function tbl8.onAbsoluteSizeChanged(arg1)
        var2(arg1.AbsoluteSize)
    end

    tbl7.Content = createElement4(var17, tbl8, {
        ReportFlowHandler = React.createElement(
            ReportFlowHandler,
            {
                targetId = tbl1.targetId,
                abuseVector = tbl1.abuseVector,
                onSubmit = tbl1.onSubmit,
                custom = tbl1.custom
            }
        )
    })
    tbl5.ScrollView = createElement3(var16, tbl6, tbl7)
    tbl3.View = createElement2(var15, tbl4, tbl5)
    return createElement(var14, tbl2, tbl3)
end)
