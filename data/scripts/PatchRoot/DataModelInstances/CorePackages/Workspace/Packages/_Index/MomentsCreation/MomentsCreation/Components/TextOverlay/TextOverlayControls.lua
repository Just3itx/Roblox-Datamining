-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:00:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreation = script:FindFirstAncestor("MomentsCreation")
local MomentsCreationParent = MomentsCreation.Parent

local Dash = require(MomentsCreationParent.Dash)
local Foundation = require(MomentsCreationParent.Foundation)
local MomentsCommon = require(MomentsCreationParent.MomentsCommon)
local React = require(MomentsCreationParent.React)
local Signals = require(MomentsCreationParent.Signals)
local SignalsReact = require(MomentsCreationParent.SignalsReact)

local Button = Foundation.Button
local Knob = Foundation.Knob
local Slider = Foundation.Slider
local View = Foundation.View

local useCallback = React.useCallback
local useMemo = React.useMemo
local useDeviceInsets = MomentsCommon.Hooks.useDeviceInsets
local useTokens = Foundation.Hooks.useTokens
local useSignalState = SignalsReact.useSignalState

local Constants = require(MomentsCreation.Constants)
local useCreationFlowStrings = require(MomentsCreation.Hooks.useCreationFlowStrings)
local _CreationFlowTypes = require(MomentsCreation.Types.CreationFlowTypes)
local _MomentsTypes = require(MomentsCreationParent.MomentsTypes)
local FFlagMomentsTextOverlayV2Redesign = MomentsCommon.Flags.FFlagMomentsTextOverlayV2Redesign
local FFlagMomentsTextOverlayTopNav = require(MomentsCreation.Flags.FFlagMomentsTextOverlayTopNav)

local function TextOverlayControls(tbl1)
    local controller = tbl1.controller
    local var1 = useDeviceInsets()
    local var2 = useTokens()
    local var3 = useCreationFlowStrings()

    local var4 = FFlagMomentsTextOverlayV2Redesign
    local var5 = useMemo(function()
        return Signals.createComputed(function(arg1)
            if var4 then
                return Constants.TextOverlay.DefaultFontSize
            end
            local activeSession = controller.getActiveSession(arg1)
            local draft = if activeSession == nil then nil else activeSession.getDraft(arg1)
            local var5 = draft and draft[1]
            return if var5 == nil then Constants.TextOverlay.DefaultFontSize else var5.textOverlayStyle.fontSize
        end)
    end, { controller, var4 })
    local var6 = useSignalState(var5)

    local onValueChanged = useCallback(function(fontSize: number)
        local activeSession = controller.getActiveSession(false)
        if activeSession == nil then
            return
        end
        local draft = activeSession.getDraft(false)
        local var7 = draft and draft[1]
        if var7 == nil then
            return
        end
        activeSession.update({ Dash.joinDeep(var7, { textOverlayStyle = { fontSize = fontSize } }) })
    end, { controller })

    local onActivated = useCallback(function()
        controller.discardActiveTool()
    end, { controller })

    local var7 = useCallback(function()
        controller.commitActiveTool()
    end, { controller })

    if FFlagMomentsTextOverlayTopNav then
        return nil
    end

    local createElement = React.createElement
    local var10 = View
    local tbl2 = {
        LayoutOrder = tbl1.layoutOrder,
        tag = "col align-x-center align-y-bottom gap-large position-bottom-center anchor-bottom-center size-full-0 auto-y",
        padding = {
            top = UDim.new(0, var2.Padding.Small),
            bottom = UDim.new(0, math.max(var1.bottom, var2.Padding.Small)),
            left = UDim.new(0, math.max(var1.left, var2.Padding.XLarge)),
            right = UDim.new(0, math.max(var1.right, var2.Padding.XLarge))
        }
    }
    local tbl3 = { FontSizeSlider = 0, Nav = 0 }
    local element

    if var4 then
        element = nil
    else
        element = React.createElement(Slider, {
            knob = React.createElement(Knob, { size = Foundation.Enums.InputSize.Large }),
            knobVisibility = Foundation.Enums.Visibility.Always,
            LayoutOrder = 1,
            onValueChanged = onValueChanged,
            size = Foundation.Enums.InputSize.XSmall,
            range = NumberRange.new(Constants.TextOverlay.MinFontSize, Constants.TextOverlay.MaxFontSize),
            value = math.clamp(var6, Constants.TextOverlay.MinFontSize, Constants.TextOverlay.MaxFontSize),
            variant = Foundation.Enums.SliderVariant.Standard
        })
    end

    tbl3.FontSizeSlider = element

    tbl3.Nav = React.createElement(
        View,
        {
            LayoutOrder = 2,
            tag = "row flex-x-between align-x-center align-y-center gap-small size-full-0 auto-y"
        },
        {
            BackButton = React.createElement(Button, {
                fillBehavior = Foundation.Enums.FillBehavior.Fit,
                LayoutOrder = 1,
                text = var3.GeneralCtaBack,
                variant = Foundation.Enums.ButtonVariant.Text,
                onActivated = onActivated,
                size = Foundation.Enums.InputSize.Medium
            }),
            DoneButton = React.createElement(Button, {
                fillBehavior = Foundation.Enums.FillBehavior.Fit,
                LayoutOrder = 2,
                text = var3.GeneralCtaDone,
                variant = Foundation.Enums.ButtonVariant.Text,
                onActivated = var7,
                size = Foundation.Enums.InputSize.Medium
            })
        }
    )
    return createElement(var10, tbl2, tbl3)
end

return TextOverlayControls
