-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:51:23Z
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
local ScrollView = Foundation.ScrollView
local Slider = Foundation.Slider
local View = Foundation.View

local useCallback = React.useCallback
local useMemo = React.useMemo
local useDeviceInsets = MomentsCommon.Hooks.useDeviceInsets
local useFormFactor = MomentsCommon.Hooks.useFormFactor
local useTokens = Foundation.Hooks.useTokens
local useSignalState = SignalsReact.useSignalState

local FormFactor = MomentsCommon.Enums.FormFactor
local ReactionType = MomentsCommon.Enums.ReactionType
local ReactionAssets = MomentsCommon.Components.ReactionAssets

local EventNames = MomentsCommon.Analytics.EventNames
local SessionManager = MomentsCommon.Analytics.SessionManager
local FunnelEventNames = MomentsCommon.Analytics.FunnelEventNames

local Constants = require(MomentsCreation.Constants)
local StickerPickerItem = require(MomentsCreation.Components.StickerOverlay.StickerPickerItem)
local fireAnalyticsEvent = require(MomentsCreation.Analytics.fireAnalyticsEvent)
local makeCreationEventFields = require(MomentsCreation.Analytics.makeCreationEventFields)
local makeDefaultStickerOverlayEdit = require(MomentsCreation.Utils.makeDefaultStickerOverlayEdit)
local useCreationFlowStrings = require(MomentsCreation.Hooks.useCreationFlowStrings)
local _CreationFlowTypes = require(MomentsCreation.Types.CreationFlowTypes)
local _MomentsTypes = require(MomentsCreationParent.MomentsTypes)

local function StickerOverlayControls(tbl1)
    local controller = tbl1.controller
    local var1 = useDeviceInsets()
    local var2 = useTokens()
    local var3 = useCreationFlowStrings()

    local var4 = useMemo(function()
        return Signals.createComputed(function(arg1)
            local activeSession = controller.getActiveSession(arg1)
            local draft = if activeSession == nil then nil else activeSession.getDraft(arg1)
            local var4 = draft and draft[1]
            return if var4 == nil then Constants.StickerOverlay.DefaultStickerSize else var4.stickerSize
        end)
    end, { controller })
    local var5 = useSignalState(var4)

    local onValueChanged = useCallback(function(stickerSize: number)
        local activeSession = controller.getActiveSession(false)
        if activeSession == nil then
            return
        end
        local draft = activeSession.getDraft(false)
        local var6 = draft and draft[1]
        if var6 == nil then
            return
        end
        activeSession.update({ Dash.joinDeep(var6, { stickerSize = stickerSize }) })
    end, { controller })

    local onActivated = useCallback(function()
        controller.discardActiveTool()
    end, { controller })

    local var6 = useCallback(function()
        controller.commitActiveTool()
    end, { controller })

    local onStickerSelected = useCallback(function(stickerUri: string)
        local activeSession = controller.getActiveSession(false)
        if activeSession == nil then
            return
        end
        local draft = activeSession.getDraft(false)
        local var9 = draft and draft[1]

        if var9 ~= nil and var9.stickerURI == stickerUri then
            activeSession.update({ Dash.join(var9, { stickerURI = Dash.None }) })
            return
        end

        local var10 = var9 or makeDefaultStickerOverlayEdit()
        activeSession.update({ Dash.join(var10, { stickerURI = stickerUri }) })

        local tbl2 = { stickerURI = stickerUri }
        for value, value2 in makeCreationEventFields.makeToolFieldFromKind("sticker") do
            tbl2[value] = value2
        end
        local sessionId = SessionManager.getSessionId(FunnelEventNames.FunnelTypes.CreationFlow)
        for value, value2 in makeCreationEventFields.makeCreationBaseFields(sessionId) do
            tbl2[value] = value2
        end
        fireAnalyticsEvent(EventNames.EditingFlowStickerSelected, tbl2)
    end, { controller })

    local bool1 = useFormFactor() == FormFactor.Wide

    local var10 = useMemo(function()
        local result = {}
        local num1 = 0
        for _, key in ReactionType do
            local stickerUri = ReactionAssets.getStickerImageUri(key)
            if stickerUri == nil then
                continue
            end

            num1 += 1
            table.insert(
                result,
                React.createElement(
                    StickerPickerItem,
                    {
                        key = key,
                        layoutOrder = num1,
                        stickerURI = stickerUri,
                        onStickerSelected = onStickerSelected
                    }
                )
            )
        end

        return result
    end, { onStickerSelected })

    local createElement = React.createElement
    local var11 = View
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
    local tbl3 = {
        StickerSizeSlider = React.createElement(Slider, {
            knob = React.createElement(Knob, { size = Foundation.Enums.InputSize.Large }),
            knobVisibility = Foundation.Enums.Visibility.Always,
            LayoutOrder = 1,
            onValueChanged = onValueChanged,
            size = Foundation.Enums.InputSize.XSmall,
            range = NumberRange.new(Constants.StickerOverlay.MinStickerSize, Constants.StickerOverlay.MaxStickerSize),
            value = math.clamp(
                var5 or Constants.StickerOverlay.DefaultStickerSize,
                Constants.StickerOverlay.MinStickerSize,
                Constants.StickerOverlay.MaxStickerSize
            ),
            variant = Foundation.Enums.SliderVariant.Standard
        }),
        Nav = 0
    }

    local createElement2 = React.createElement
    local var12 = View
    local tbl4 = {
        LayoutOrder = 2,
        tag = "row flex-x-between align-x-center align-y-center gap-medium size-full-0 auto-y"
    }

    local tbl5 = {
        BackButton = React.createElement(Button, {
            fillBehavior = Foundation.Enums.FillBehavior.Fit,
            LayoutOrder = 1,
            text = var3.GeneralCtaBack,
            variant = Foundation.Enums.ButtonVariant.Text,
            onActivated = onActivated,
            size = Foundation.Enums.InputSize.Medium
        }),
        StickerRow = React.createElement(ScrollView, {
            LayoutOrder = 2,
            flexItem = {
                FlexMode = Enum.UIFlexMode.Fill
            },
            Size = UDim2.fromOffset(0, var2.Size.Size_1000),
            layout = {
                FillDirection = Enum.FillDirection.Horizontal,
                HorizontalAlignment = if bool1 then Enum.HorizontalAlignment.Center else Enum.HorizontalAlignment.Left,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                Padding = UDim.new(0, var2.Padding.Small),
                SortOrder = Enum.SortOrder.LayoutOrder
            },
            scroll = {
                ScrollingDirection = Enum.ScrollingDirection.X,
                AutomaticCanvasSize = Enum.AutomaticSize.X,
                CanvasSize = UDim2.fromOffset(0, 0),
                scrollBarVisibility = if bool1 then Foundation.Enums.Visibility.None else Foundation.Enums.Visibility.Auto
            }
        }, var10),
        DoneButton = React.createElement(Button, {
            fillBehavior = Foundation.Enums.FillBehavior.Fit,
            LayoutOrder = 3,
            text = var3.GeneralCtaDone,
            variant = Foundation.Enums.ButtonVariant.Text,
            onActivated = var6,
            size = Foundation.Enums.InputSize.Medium
        })
    }
    tbl3.Nav = createElement2(var12, tbl4, tbl5)
    return createElement(var11, tbl2, tbl3)
end

return StickerOverlayControls
