-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:00:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreation = script:FindFirstAncestor("MomentsCreation")
local MomentsCreationParent = MomentsCreation.Parent

local Dash = require(MomentsCreationParent.Dash)
local Foundation = require(MomentsCreationParent.Foundation)
local MomentsCommon = require(MomentsCreationParent.MomentsCommon)
local React = require(MomentsCreationParent.React)
local ReactOtter = require(MomentsCreationParent.ReactOtter)
local Signals = require(MomentsCreationParent.Signals)
local SignalsReact = require(MomentsCreationParent.SignalsReact)

local useCallback = React.useCallback
local useMemo = React.useMemo
local useRef = React.useRef
local useState = React.useState
local useSignalState = SignalsReact.useSignalState
local useTokens = Foundation.Hooks.useTokens
local useFormFactor = MomentsCommon.Hooks.useFormFactor

local FormFactor = MomentsCommon.Enums.FormFactor
local EventNames = MomentsCommon.Analytics.EventNames
local fireAnalyticsEvent = require(MomentsCreation.Analytics.fireAnalyticsEvent)
local makeCreationEventFields = require(MomentsCreation.Analytics.makeCreationEventFields)
local FFlagMomentsTextOverlayV2Redesign = MomentsCommon.Flags.FFlagMomentsTextOverlayV2Redesign

local _CreationFlowTypes = require(MomentsCreation.Types.CreationFlowTypes)
local _MomentsTypes = require(MomentsCreationParent.MomentsTypes)

local function useTextFontRowState(arg1)
    local var1 = useTokens()
    local bool1 = useFormFactor() == FormFactor.Wide

    local var2 = useMemo(function()
        return Signals.createComputed(function(arg2)
            local activeSession = arg1.getActiveSession(arg2)
            local draft = if activeSession == nil then nil else activeSession.getDraft(arg2)
            local var2 = draft and draft[1]
            return if var2 == nil then Enum.Font.BuilderSansMedium else var2.textOverlayStyle.font
        end)
    end, { arg1 })
    local font = useSignalState(var2)

    local onChipActivated = useCallback(function(font2, num1: number)
        local activeSession = arg1.getActiveSession(false)
        if activeSession == nil then
            return
        end
        local draft = activeSession.getDraft(false)
        local var4 = draft and draft[1]
        if var4 == nil then
            return
        end
        activeSession.update({ Dash.joinDeep(var4, { textOverlayStyle = { font = font2 } }) })

        if FFlagMomentsTextOverlayV2Redesign then
            fireAnalyticsEvent(
                EventNames.EditingFlowTextOverlayFontSelected,
                makeCreationEventFields.makeTextOverlayEventFields({ buttonIndex = tostring(num1), font = font2.Name })
            )
        end
    end, { arg1 })

    local scrollingFrameRef = useRef(nil)
    local var6, var7 = useState(false)
    local var8, var9 = useState(false)

    local onScrollViewportChanged = useCallback(function(arg2)
        if arg2.AbsoluteWindowSize.X == 0 then
            return
        end
        var7(arg2.CanvasPosition.X > 0)
        var9(arg2.AbsoluteWindowSize.X + arg2.CanvasPosition.X < arg2.AbsoluteCanvasSize.X - 1)
    end, {})

    local var11 = ReactOtter.useMotor(0, function(x: number?)
        local current = scrollingFrameRef.current
        if current == nil then
            return
        end
        current.CanvasPosition = Vector2.new(x, 0)
    end)

    local var12 = useCallback(function(num1: number)
        local current = scrollingFrameRef.current
        if current == nil then
            return
        end
        local num2 = math.max(current.AbsoluteCanvasSize.X - current.AbsoluteWindowSize.X, 0)
        local var12 = current.AbsoluteWindowSize.X * 0.8

        local num3 = math.clamp(current.CanvasPosition.X + num1 * var12, 0, num2)
        var11(
            ReactOtter.ease(
                num3,
                {
                    duration = var1.Time.Time_200,
                    easingStyle = Enum.EasingStyle.Quad,
                    startingValue = current.CanvasPosition.X
                }
            )
        )
    end, { var1, var11 })

    return {
        font = font,
        onChipActivated = onChipActivated,
        scrollingFrameRef = scrollingFrameRef,
        onScrollViewportChanged = onScrollViewportChanged,
        showLeftChevron = bool1 and var6,
        showRightChevron = bool1 and var8,
        onLeftChevronActivated = useCallback(function()
            var12(-1)
        end, { var12 }),
        onRightChevronActivated = useCallback(function()
            var12(1)
        end, { var12 })
    }
end

return useTextFontRowState
