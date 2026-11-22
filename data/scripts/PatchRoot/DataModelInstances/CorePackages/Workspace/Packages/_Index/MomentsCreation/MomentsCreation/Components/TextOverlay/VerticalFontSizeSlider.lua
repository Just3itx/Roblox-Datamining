-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:01:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreation = script:FindFirstAncestor("MomentsCreation")
local MomentsCreationParent = MomentsCreation.Parent

local GuiService = game:GetService("GuiService")

local Dash = require(MomentsCreationParent.Dash)
local Foundation = require(MomentsCreationParent.Foundation)
local MomentsCommon = require(MomentsCreationParent.MomentsCommon)
local React = require(MomentsCreationParent.React)
local Signals = require(MomentsCreationParent.Signals)
local SignalsReact = require(MomentsCreationParent.SignalsReact)

local Knob = Foundation.Knob
local Slider = Foundation.Slider
local View = Foundation.View

local useCallback = React.useCallback
local useMemo = React.useMemo
local useRef = React.useRef
local useDeviceInsets = MomentsCommon.Hooks.useDeviceInsets
local useTokens = Foundation.Hooks.useTokens
local useSignalState = SignalsReact.useSignalState

local EventNames = MomentsCommon.Analytics.EventNames
local fireAnalyticsEvent = require(MomentsCreation.Analytics.fireAnalyticsEvent)
local makeCreationEventFields = require(MomentsCreation.Analytics.makeCreationEventFields)
local FFlagMomentsTextOverlayV2Redesign = MomentsCommon.Flags.FFlagMomentsTextOverlayV2Redesign

local FFlagMomentsTextOverlayFontSliderTouchArea = require(MomentsCreation.Flags.FFlagMomentsTextOverlayFontSliderTouchArea)

local FontSizeTouchArea = require(MomentsCreation.Components.TextOverlay.FontSizeTouchArea)
local computeRotatedTrackFraction = require(MomentsCreation.Utils.computeRotatedTrackFraction)

local Constants = require(MomentsCreation.Constants)
local _CreationFlowTypes = require(MomentsCreation.Types.CreationFlowTypes)
local _MomentsTypes = require(MomentsCreationParent.MomentsTypes)

local MinFontSize = Constants.TextOverlay.MinFontSize

local TreatmentMaxFontSize = Constants.TextOverlay.TreatmentMaxFontSize

local function toGuiInputPosition(vector2: Vector2, current)
    local screenGui = current:FindFirstAncestorWhichIsA("ScreenGui")
    if screenGui == nil or not screenGui.IgnoreGuiInset then
        return vector2
    end

    local screenInsets = if screenGui.ScreenInsets == Enum.ScreenInsets.DeviceSafeInsets then Enum.ScreenInsets.DeviceSafeInsets else Enum.ScreenInsets.None
    return vector2 + GuiService:GetInsetArea(screenInsets).Min
end

local function VerticalFontSizeSlider(tbl1)
    local controller = tbl1.controller
    local var1 = useTokens()
    local var2 = useDeviceInsets()

    local var3 = useMemo(function()
        return Signals.createComputed(function(arg1)
            local activeSession = controller.getActiveSession(arg1)
            local draft = if activeSession == nil then nil else activeSession.getDraft(arg1)
            local var3 = draft and draft[1]
            return if var3 == nil then Constants.TextOverlay.DefaultFontSize else var3.textOverlayStyle.fontSize
        end)
    end, { controller })
    local var4 = useSignalState(var3)

    local onValueChanged = useCallback(function(fontSize: number)
        local activeSession = controller.getActiveSession(false)
        if activeSession == nil then
            return
        end
        local draft = activeSession.getDraft(false)
        local var5 = draft and draft[1]
        if var5 == nil then
            return
        end
        activeSession.update({ Dash.joinDeep(var5, { textOverlayStyle = { fontSize = fontSize } }) })
    end, { controller })

    local onDragStarted = useCallback(function()
        if FFlagMomentsTextOverlayV2Redesign then
            fireAnalyticsEvent(
                EventNames.EditingFlowTextOverlayFontSizeSliderUsed,
                makeCreationEventFields.makeTextOverlayEventFields()
            )
        end
    end, {})

    local var7, var8, var9

    if FFlagMomentsTextOverlayFontSliderTouchArea then
        local var10 = useRef(nil)

        local var11 = useCallback(function(vector2: Vector2)
            local current = var10.current
            if current == nil then
                return
            end
            local var11 = computeRotatedTrackFraction(
                toGuiInputPosition(vector2, current),
                current.AbsolutePosition + current.AbsoluteSize / 2,
                current.AbsoluteSize.X,
                current.AbsoluteRotation
            )
            onValueChanged(MinFontSize + var11 * (TreatmentMaxFontSize - MinFontSize))
        end, { onValueChanged })

        var7 = useCallback(function(_, vector2: Vector2)
            onDragStarted()
            var11(vector2)
        end, { onDragStarted, var11 })
        var8 = useCallback(function(_, vector2: Vector2)
            var11(vector2)
        end, { var11 })

        var9 = var10
    else
        var9 = nil
        var7 = nil
        var8 = nil
    end

    local num1 = math.clamp(tbl1.mediaHeight * 0.45, 140, 320)

    local createElement = React.createElement
    local var10 = View
    local tbl2 = {
        tag = {
            ["anchor-center-center"] = true,
            ["auto-xy"] = not FFlagMomentsTextOverlayFontSliderTouchArea
        },
        Size = if FFlagMomentsTextOverlayFontSliderTouchArea then UDim2.fromOffset(num1, 48) else nil,
        Position = UDim2.new(1, -(math.max(var2.right, var1.Padding.XLarge) + var1.Padding.Medium), 0.5, 0),
        Rotation = -90,
        ZIndex = 10
    }

    local tbl3 = {
        Slider = React.createElement(Slider, {
            knob = React.createElement(Knob, { size = Foundation.Enums.InputSize.Large }),
            knobVisibility = Foundation.Enums.Visibility.Always,
            onDragStarted = onDragStarted,
            onValueChanged = onValueChanged,
            size = Foundation.Enums.InputSize.XSmall,
            range = NumberRange.new(MinFontSize, TreatmentMaxFontSize),
            value = math.clamp(var4, MinFontSize, TreatmentMaxFontSize),
            variant = Foundation.Enums.SliderVariant.Standard,
            width = UDim.new(0, num1),
            AnchorPoint = if FFlagMomentsTextOverlayFontSliderTouchArea then Vector2.new(0.5, 0.5) else nil,
            Position = if FFlagMomentsTextOverlayFontSliderTouchArea then UDim2.fromScale(0.5, 0.5) else nil,
            testId = "--social-moments-creation-slider-font-size"
        }),
        TouchArea = if FFlagMomentsTextOverlayFontSliderTouchArea then React.createElement(FontSizeTouchArea, { touchAreaRef = var9, onDragStarted = var7, onDrag = var8, ZIndex = 2 }) else nil
    }
    return createElement(var10, tbl2, tbl3)
end

return VerticalFontSizeSlider
