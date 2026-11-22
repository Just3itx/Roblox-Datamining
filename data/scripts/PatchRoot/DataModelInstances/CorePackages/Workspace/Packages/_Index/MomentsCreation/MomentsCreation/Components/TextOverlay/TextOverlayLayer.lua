-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:00:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreation = script:FindFirstAncestor("MomentsCreation")
local MomentsCreationParent = MomentsCreation.Parent

local BuilderIcons = require(MomentsCreationParent.BuilderIcons)
local Dash = require(MomentsCreationParent.Dash)
local Foundation = require(MomentsCreationParent.Foundation)
local MomentsCommon = require(MomentsCreationParent.MomentsCommon)
local React = require(MomentsCreationParent.React)
local ReactOtter = require(MomentsCreationParent.ReactOtter)
local Signals = require(MomentsCreationParent.Signals)
local SignalsReact = require(MomentsCreationParent.SignalsReact)

local GuiService = game:GetService("GuiService")
local TextService = game:GetService("TextService")

local engineFeature = game:GetEngineFeature("UIDragDetectorFixEventPositionEnabled")

local Button = Foundation.Button
local View = Foundation.View

local useAnimatedBinding = ReactOtter.useAnimatedBinding
local useBinding = React.useBinding
local useCallback = React.useCallback
local useEffect = React.useEffect
local useMemo = React.useMemo
local useRef = React.useRef
local useSignalState = SignalsReact.useSignalState
local useTokens = Foundation.Hooks.useTokens
local useDeviceInsets = MomentsCommon.Hooks.useDeviceInsets
local useIsMultiTouchActive = MomentsCommon.Hooks.useIsMultiTouchActive

local OverlayDisplay = MomentsCommon.Components.OverlayDisplay
local TextOverlay = MomentsCommon.Components.TextOverlay
local TextOverlayDisplay = MomentsCommon.Components.TextOverlayDisplay
local getScale = MomentsCommon.Utils.getScale

local GetFFlagMomentsStickerButton = MomentsCommon.Flags.GetFFlagMomentsStickerButton
local GetFFlagEnableMomentTextGeneration = MomentsCommon.Flags.GetFFlagEnableMomentTextGeneration
local FFlagMomentsTextOverlayV2Redesign = MomentsCommon.Flags.FFlagMomentsTextOverlayV2Redesign
local EventNames = MomentsCommon.Analytics.EventNames
local fireAnalyticsEvent = require(MomentsCreation.Analytics.fireAnalyticsEvent)
local makeCreationEventFields = require(MomentsCreation.Analytics.makeCreationEventFields)

local CreationFlowState = require(MomentsCreation.Enums.CreationFlowState)
local Constants = require(MomentsCreation.Constants)
local _CreationFlowTypes = require(MomentsCreation.Types.CreationFlowTypes)
local _MomentsTypes = require(MomentsCreationParent.MomentsTypes)
local TextOverlayTrashZone = require(MomentsCreation.Components.TextOverlay.TextOverlayTrashZone)
local useOnScreenKeyboardHeight = require(MomentsCreation.Hooks.useOnScreenKeyboardHeight)
local useOnScreenKeyboardTop = require(MomentsCreation.Hooks.useOnScreenKeyboardTop)
local useCreationFlowStrings = require(MomentsCreation.Hooks.useCreationFlowStrings)
local GetFFlagMomentsGenerateTextInTextOverlay = require(MomentsCreation.Flags.GetFFlagMomentsGenerateTextInTextOverlay)
local makeDefaultTextOverlayEdit = require(MomentsCreation.Utils.makeDefaultTextOverlayEdit)
local makeTextOverlayEditsForEditor = require(MomentsCreation.Utils.makeTextOverlayEditsForEditor)
local fitTextOverlayFontSize = require(MomentsCreation.Utils.fitTextOverlayFontSize)
local computeEditorChipLayout = require(MomentsCreation.Utils.computeEditorChipLayout)
local isPointOverTrashTarget = require(MomentsCreation.Utils.isPointOverTrashTarget)
local playDragToDeleteHaptic = require(MomentsCreation.Utils.playDragToDeleteHaptic)
local FFlagMomentsTextOverlayChipGrowAboveKeyboard = MomentsCommon.Flags.FFlagMomentsTextOverlayChipGrowAboveKeyboard

local FFlagMomentsTextOverlayToolbarWhileTyping = require(MomentsCreation.Flags.FFlagMomentsTextOverlayToolbarWhileTyping)
local FFlagMomentsTextOverlayEdgeClipFix = MomentsCommon.Flags.FFlagMomentsTextOverlayEdgeClipFix
local FFlagMomentsTextOverlayChipGrowWidth = require(MomentsCreation.Flags.FFlagMomentsTextOverlayChipGrowWidth)
local FFlagMomentsTextOverlayModalTextFix = require(MomentsCreation.Flags.FFlagMomentsTextOverlayModalTextFix)

local FFlagMomentsTextOverlayDragToDeleteRefinement = require(MomentsCreation.Flags.FFlagMomentsTextOverlayDragToDeleteRefinement)
local FFlagMomentsTextOverlayTopNav = require(MomentsCreation.Flags.FFlagMomentsTextOverlayTopNav)
local VerticalFontSizeSlider = require(MomentsCreation.Components.TextOverlay.VerticalFontSizeSlider)
local TextOverlayToolbar = require(MomentsCreation.Components.TextOverlay.TextOverlayToolbar)
local EditorTopNav = require(MomentsCreation.Components.EditorTopNav)

local tbl1 = { dampingRatio = 0.85, frequency = 12 }

local numberSequence = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 0.2) })

local function resolveKeyboardTop(num1: number?, num2: number, num3: number): number -- Luacid: Inlined by compiler; 2 call sites recovered
    return num1 or num2 - num3
end

local var1 = FFlagMomentsTextOverlayV2Redesign
    and FFlagMomentsTextOverlayChipGrowAboveKeyboard
    and FFlagMomentsTextOverlayToolbarWhileTyping

local function useToolbarWhileTyping(arg1, tbl2)
    local var2, var3, var4

    if FFlagMomentsTextOverlayV2Redesign
        and FFlagMomentsTextOverlayChipGrowAboveKeyboard
        and FFlagMomentsTextOverlayToolbarWhileTyping
    then
        var2 = useOnScreenKeyboardTop()
        local var5
        var3, var5 = React.useState(0)
        var4 = useCallback(function(arg2)
            var5(arg2.AbsoluteSize.Y)
        end, {})

        local textOverlayStyle = if arg1 == nil then nil else arg1.textOverlayStyle
        local var6

        if textOverlayStyle == nil then
            var6 = nil
        else
            local str1 = tostring(textOverlayStyle.font)
            local str2 = tostring(textOverlayStyle.fontColor)
            local textXAlignment = textOverlayStyle.textXAlignment
            var6 = `{str1}|{str2}|{tostring(textXAlignment)}`
        end
        local var7 = useRef(var6)
        useEffect(function()
            local current = var7.current
            var7.current = var6
            if current == nil or var6 == nil or current == var6 then
                return
            end
            local current2 = tbl2.current
            if current2 ~= nil and current2:IsFocused() then
                current2:ReleaseFocus()
            end
        end, { var6 })
    else
        var3 = 0
        var4 = nil
        var2 = nil
    end

    return var3, var4, var2
end

local function GenerateTextButton(tbl2)
    local controller = tbl2.controller
    local var2 = useTokens()
    local var3 = useCreationFlowStrings()
    local isLoading = useSignalState(controller.getIsGenerating)

    local onActivated = useCallback(function()
        controller.beginTool("generateText")
    end, { controller })

    return React.createElement(View, {
        tag = "position-bottom-right anchor-bottom-right auto-xy",
        ZIndex = 10,
        padding = {
            bottom = UDim.new(0, var2.Padding.Large),
            right = UDim.new(0, var2.Padding.Large)
        }
    }, {
        Button = React.createElement(Button, {
            fillBehavior = Foundation.Enums.FillBehavior.Fit,
            icon = BuilderIcons.Icon.TagSparkle,
            text = var3.GenerateTextCta,
            variant = Foundation.Enums.ButtonVariant.Emphasis,
            onActivated = onActivated,
            isLoading = isLoading,
            size = Foundation.Enums.InputSize.Medium
        })
    })
end

local function TextOverlayLayer(tbl2)
    local controller = tbl2.controller

    local var2 = useSignalState(controller.getStep)
    local itemSize = useSignalState(tbl2.ctx.getItemSize)
    local itemResolution = useSignalState(tbl2.ctx.getItemResolution)
    local textOverlays = useSignalState(controller.getComposedEdits).textOverlays
    local scale = getScale(itemSize, itemResolution, Enum.ScaleType.Crop)

    local var5 = useMemo(function()
        return Signals.createComputed(function(arg1)
            local activeSession = controller.getActiveSession(arg1)
            if activeSession ~= nil then
                return (activeSession.getDraft(arg1))
            end

            return nil
        end)
    end, { controller })
    local var6 = useSignalState(var5)

    local bool1 = var2 == CreationFlowState.TextOverlay
    local var7 = var6 and var6[1]

    local textBoxRef = useRef(nil)
    local ref = useRef(nil)
    local var10, var11 = useBinding(UDim2.fromOffset(0, 0))
    local keyboardHeight = useOnScreenKeyboardHeight()

    local var13 = var1
    local var14, onAbsoluteSizeChanged, keyboardTop = useToolbarWhileTyping(var7, textBoxRef)
    local var17 = if FFlagMomentsTextOverlayModalTextFix then useSignalState(controller.getActiveModal) else nil
    local var18 = FFlagMomentsTextOverlayModalTextFix and var17 ~= nil
    local var3 = if FFlagMomentsTextOverlayModalTextFix then if FFlagMomentsTextOverlayV2Redesign then if scale > 0 then 1 / scale else 1 else 1 else nil

    local fontSize = if FFlagMomentsTextOverlayV2Redesign then useMemo(function()
        if var7 == nil then
            return Constants.TextOverlay.DefaultFontSize
        end
        local fontSize = var7.textOverlayStyle.fontSize
        if keyboardHeight > 0 then
            return Constants.TextOverlay.DefaultFontSize
        end
        local num1 = math.min(300, itemSize.X * 0.9)

        if FFlagMomentsTextOverlayEdgeClipFix then
            local textSizeX = TextService:GetTextSize(" ", fontSize, var7.textOverlayStyle.font, Vector2.new(1000000, 1000000)).X
            num1 = math.min(276 - (math.ceil(fontSize * 0.08) + math.ceil(textSizeX) * 2), itemSize.X * 0.9)
        end

        local var20 = itemSize.Y * 0.8
        return fitTextOverlayFontSize(var7.text, var7.textOverlayStyle.font, fontSize, num1, var20, Constants.TextOverlay.MinFontSize)
    end, { var7, keyboardHeight, itemSize }) elseif var7 ~= nil then var7.textOverlayStyle.fontSize else Constants.TextOverlay.DefaultFontSize

    local onActivated = useCallback(function()
        if textBoxRef.current then
            textBoxRef.current:CaptureFocus()
        end
    end, {})

    local var21 = useCallback(function()
        if textBoxRef.current then
            textBoxRef.current:ReleaseFocus()
        end
    end, {})

    local onTextChanged = useCallback(function(arg1)
        local activeSession = controller.getActiveSession(false)
        if activeSession == nil then
            return
        end
        local draft = activeSession.getDraft(false)
        local var22 = draft and draft[1]
        if var22 == nil then
            return
        end

        local var23 = utf8.len(arg1.Text)
        if var23 ~= nil and var23 >= 100 then
            local num1 = utf8.offset(arg1.Text, 101)
            if not GetFFlagMomentsStickerButton() or num1 then
                arg1.Text = string.sub(arg1.Text, 1, num1 - 1)
            end
        end

        activeSession.update({ Dash.joinDeep(var22, { text = arg1.Text }) })
    end, { controller })

    local var23 = useCallback(function()
        if GetFFlagEnableMomentTextGeneration() and controller.getIsGenerating(false) then
            controller.onDisabledToolActivated("text")
            return
        end
        controller.beginTool("text")
    end, { controller })

    local var24 = useCallback(function(tbl3)
        controller.updateCommittedEdit("text", tbl3)
    end, { controller })

    local var25 = nil
    local var26 = nil
    local var27 = nil
    local var28 = nil
    local var29 = nil
    if FFlagMomentsTextOverlayV2Redesign then
        var27 = useRef(false)
        var28 = useRef(false)
        var29 = useRef(false)

        var25 = useCallback(function(scale2: number)
            local textOverlays2 = controller.getComposedEdits(false).textOverlays
            local textOverlay = textOverlays2 and textOverlays2[1]
            if textOverlay == nil then
                return
            end
            controller.updateCommittedEdit("text", { Dash.joinDeep(textOverlay, { scale = scale2 }) })

            if not var27.current then
                var27.current = true
                fireAnalyticsEvent(EventNames.EditingFlowTextOverlayRescaleUsed, makeCreationEventFields.makeTextOverlayEventFields())
            end
        end, { controller })

        var26 = useCallback(function(rotation: number)
            local textOverlays2 = controller.getComposedEdits(false).textOverlays
            local textOverlay = textOverlays2 and textOverlays2[1]
            if textOverlay == nil then
                return
            end
            controller.updateCommittedEdit("text", { Dash.joinDeep(textOverlay, { rotation = rotation }) })

            if not var28.current then
                var28.current = true
                fireAnalyticsEvent(EventNames.EditingFlowTextOverlayRotateUsed, makeCreationEventFields.makeTextOverlayEventFields())
            end
        end, { controller })
    end

    local var30 = if FFlagMomentsTextOverlayV2Redesign then useDeviceInsets() else nil

    local var31 = FFlagMomentsTextOverlayTopNav
    local var32, var33, var34

    if FFlagMomentsTextOverlayTopNav then
        var32 = useTokens()
        var33 = useCallback(function()
            controller.discardActiveTool()
        end, { controller })
        var34 = useCallback(function()
            controller.commitActiveTool()
        end, { controller })
    else
        var33 = nil
        var34 = nil
        var32 = nil
    end
    local var4 = useRef(nil)

    local var36 = nil
    local var37 = nil
    local textOverlayDragHereToDelete

    if FFlagMomentsTextOverlayDragToDeleteRefinement then
        var36 = useRef(nil)
        var37 = useRef(nil)
        textOverlayDragHereToDelete = useCreationFlowStrings().TextOverlayDragHereToDelete
    else
        textOverlayDragHereToDelete = nil
    end
    local var38 = useRef(false)

    local visible, var40 = useBinding(false)
    local highlightScale, var42 = useAnimatedBinding(1)
    local var43, var44 = useAnimatedBinding(1)

    local bool2 = if FFlagMomentsTextOverlayV2Redesign then useIsMultiTouchActive(var2 == CreationFlowState.Preview) else false

    local var45 = useCallback(function(vector2: Vector2)
        local current = var4.current
        if current == nil then
            return false
        end

        local zero = Vector2.zero
        local num1 = 0
        if FFlagMomentsTextOverlayV2Redesign and not engineFeature and var30 ~= nil then
            zero = GuiService:GetGuiInset() + Vector2.new(var30.left, var30.top)
        end
        if FFlagMomentsTextOverlayV2Redesign then
            num1 = 24
        end

        if not (FFlagMomentsTextOverlayV2Redesign and FFlagMomentsTextOverlayDragToDeleteRefinement) then
            return isPointOverTrashTarget(vector2, zero, current.AbsolutePosition, current.AbsoluteSize, num1)
        end

        local current2 = if var36 then var36.current else nil

        if current2 == nil or var37 == nil then
            return false
        end
        local var45 = vector2 - zero
        local radius = current2.AbsoluteSize.X / 2
        local center = current2.AbsolutePosition + current2.AbsoluteSize / 2

        if not var38.current and math.abs(highlightScale:getValue() - 1) < 0.01 then
            var37.current = { center = center, radius = radius }
        end
        local current3 = var37.current

        if not current3 then
            current3 = { center = center, radius = 0 }
            local value = highlightScale:getValue()
            current3.radius = radius / math.max(value, 1)
        end

        if var38.current then
            return (var45 - current3.center).Magnitude <= current3.radius * 1.15 + 8 or (var45 - center).Magnitude <= radius + 8
        end

        return (var45 - current3.center).Magnitude <= current3.radius
    end, { var30, highlightScale })

    local var46 = useCallback(function()
        if not FFlagMomentsTextOverlayV2Redesign then
            return
        end
        if tbl2.ctx.setIsOverlayDragging then
            tbl2.ctx.setIsOverlayDragging(true)
        end
        var38.current = false
        var42(ReactOtter.instant(1))
        var44(ReactOtter.instant(1))
        var40(true)

        if not var29.current then
            var29.current = true
            fireAnalyticsEvent(
                EventNames.EditingFlowTextOverlayRepositionUsed,
                makeCreationEventFields.makeTextOverlayEventFields()
            )
        end
    end, {
        tbl2.ctx,
        var42,
        var44,
        var40
    })
    local var47 = useCallback(function(vector2: Vector2)
        if not FFlagMomentsTextOverlayV2Redesign then
            return
        end
        local current = var45(vector2)
        if current == var38.current then
            return
        end
        var38.current = current
        if FFlagMomentsTextOverlayDragToDeleteRefinement and current then
            playDragToDeleteHaptic()
        end

        var42((ReactOtter.spring(if current then 1.15 else 1, tbl1)))

        var44((ReactOtter.spring(if current then 0.45 else 1, tbl1)))
    end, { var45, var42, var44 })

    local var48 = useCallback(function(tbl3)
        if not FFlagMomentsTextOverlayV2Redesign then
            var24(tbl3)
            return
        end
        if tbl2.ctx.setIsOverlayDragging then
            tbl2.ctx.setIsOverlayDragging(false)
        end
        local current = var38.current
        var38.current = false
        var40(false)
        var42(ReactOtter.instant(1))

        if current then
            fireAnalyticsEvent(
                EventNames.EditingFlowTextOverlayDeletedViaTrash,
                makeCreationEventFields.makeTextOverlayEventFields()
            )
            controller.updateCommittedEdit("text", nil)
            return
        end

        var44(ReactOtter.instant(1))

        var24(tbl3)
    end, {
        tbl2.ctx,
        controller,
        var24,
        var40,
        var42,
        var44
    })

    useEffect(function()
        if not FFlagMomentsTextOverlayV2Redesign then
            return
        end
        if textOverlays == nil or #textOverlays == 0 then
            var44(ReactOtter.instant(1))
        end
    end, { textOverlays })

    if FFlagMomentsTextOverlayV2Redesign then
        useEffect(function()
            if not (FFlagMomentsTextOverlayV2Redesign and bool2) then
                return
            end
            var38.current = false
            var40(false)
            var42(ReactOtter.instant(1))
            var44(ReactOtter.instant(1))
            if tbl2.ctx.setIsOverlayDragging then
                tbl2.ctx.setIsOverlayDragging(false)
            end
        end, {
            bool2,
            tbl2.ctx,
            var40,
            var42,
            var44
        })
    end

    useEffect(function()
        if not bool1 then
            return
        end
        local activeSession = controller.getActiveSession(false)
        if activeSession == nil or activeSession.getDraft(false) ~= nil then
            return
        end
        activeSession.update(makeTextOverlayEditsForEditor(textOverlays, makeDefaultTextOverlayEdit(), scale))
    end, {
        bool1,
        textOverlays,
        controller,
        scale
    })

    local var49 = useRef(false)
    useEffect(function()
        if not bool1 then
            var49.current = false
            if textBoxRef.current then
                textBoxRef.current:ReleaseFocus()
            end
        elseif not var49.current and textBoxRef.current ~= nil and var7 ~= nil then
            onActivated()
            var49.current = true
        end
    end, { bool1, var7, onActivated })

    if FFlagMomentsTextOverlayModalTextFix then
        local var50 = useRef(false)
        useEffect(function()
            local current = textBoxRef.current
            if var18 then
                if current ~= nil and current:IsFocused() then
                    var50.current = true
                    current:ReleaseFocus()
                end
            elseif var50.current then
                var50.current = false
                if bool1 then
                    onActivated()
                end
            end
        end, { var18, bool1, onActivated })
    end

    useEffect(function()
        if not bool1 or var7 == nil then
            return
        end

        if FFlagMomentsTextOverlayV2Redesign and FFlagMomentsTextOverlayChipGrowAboveKeyboard then
            return
        end

        if keyboardHeight == 0 then
            var11(UDim2.fromOffset(0, 0))
        else
            local textOverlayStyle = var7.textOverlayStyle

            local vector2 = TextService:GetTextSize("W", fontSize, textOverlayStyle.font, Vector2.new(itemSize.X, itemSize.Y))
            var11(UDim2.fromOffset(math.min(vector2.X * 30, itemSize.X / 2), math.min(vector2.Y * 5, itemSize.Y / 2)))
        end
    end, {
        bool1,
        var7,
        fontSize,
        keyboardHeight,
        itemSize
    })

    local bool3 = not FFlagMomentsTextOverlayV2Redesign or keyboardHeight == 0

    if bool1 then
        if var7 == nil then
            return nil
        end

        local uDim2 = UDim2.fromScale(0.5, 0.5)
        local var50 = fontSize
        local var51 = FFlagMomentsTextOverlayV2Redesign and FFlagMomentsTextOverlayChipGrowAboveKeyboard and keyboardHeight > 0
        local var52, size

        if var51 then
            local currentCamera = workspace.CurrentCamera
            local y = if currentCamera then currentCamera.ViewportSize.Y else itemSize.Y
            local layerTopY = if ref.current then ref.current.AbsolutePosition.Y else 0
            var52 = resolveKeyboardTop(false, resolveKeyboardTop(keyboardTop, y, keyboardHeight), layerTopY)
            local var54 = computeEditorChipLayout({
                text = var7.text,
                font = var7.textOverlayStyle.font,
                itemWidth = itemSize.X,
                maxChipWidth = 300,
                viewportHeight = y,
                keyboardHeight = keyboardHeight,
                keyboardTop = keyboardTop,
                layerTopY = layerTopY,
                keyboardGap = if var13 then if var14 > 0 then var14 + 16 + 12 else 48 else 48,
                topMargin = if var31 then layerTopY + var30.top + var32.Padding.Medium + var32.Size.Size_1000 else 48,
                chipPadding = 12,
                growWidthWithText = FFlagMomentsTextOverlayChipGrowWidth,
                overhangFraction = 0.08
            })

            var50 = var54.fontSize
            size = var54.size
            uDim2 = var54.position
        else
            size = nil
            var52 = nil
        end

        local createElement = React.createElement
        local var53 = View
        local tbl3 = {
            onActivated = 0,
            ref = 0,
            stateLayer = 0,
            tag = "size-full bg-over-media-0",
            ZIndex = 0
        }

        if not (FFlagMomentsTextOverlayV2Redesign and FFlagMomentsTextOverlayChipGrowAboveKeyboard) then
            var21 = nil
        end

        tbl3.onActivated = var21

        tbl3.ref = ref
        tbl3.stateLayer = {
            affordance = Foundation.Enums.StateLayerAffordance.None
        }
        tbl3.ZIndex = tbl2.zIndex or 1
        local tbl4 = {
            TextOverlay = 0,
            GenerateText = 0,
            VerticalFontSizeSlider = 0,
            BottomScrim = 0,
            TopNav = 0,
            TextOverlayToolbar = 0
        }

        local createElement2 = React.createElement
        local var54 = TextOverlay
        local tbl5 = {
            additionalScale = if FFlagMomentsTextOverlayV2Redesign then scale else nil,
            editable = true,
            fitToContent = keyboardHeight == 0,
            onActivated = onActivated,
            size = 0,
            textOverlayEdit = 0,
            onTextChanged = 0,
            textBoxRef = 0,
            textVisible = 0
        }

        if not var51 then
            size = var10
        end

        tbl5.size = size
        tbl5.textOverlayEdit = Dash.joinDeep(var7, { position = uDim2, rotation = 0, scale = var3, textOverlayStyle = { fontSize = var50 } })

        tbl5.onTextChanged = onTextChanged
        tbl5.textBoxRef = textBoxRef
        tbl5.textVisible = not var18 and nil
        tbl4.TextOverlay = createElement2(var54, tbl5)

        tbl4.GenerateText = if GetFFlagMomentsGenerateTextInTextOverlay() and controller.getCanGenerateText(false) then React.createElement(GenerateTextButton, { controller = controller }) else nil

        tbl4.VerticalFontSizeSlider = if FFlagMomentsTextOverlayV2Redesign and bool3 then React.createElement(VerticalFontSizeSlider, { controller = controller, mediaHeight = itemSize.Y }) else nil

        tbl4.BottomScrim = if FFlagMomentsTextOverlayV2Redesign then React.createElement(
            View,
            {
                ZIndex = 5,
                tag = "position-bottom-center anchor-bottom-center",
                Size = UDim2.new(1, 0, 0, 200),
                backgroundStyle = {
                    Color3 = Color3.new(0, 0, 0)
                }
            },
            {
                UIGradient = React.createElement("UIGradient", { Rotation = 90, Transparency = numberSequence })
            }
        ) else nil

        tbl4.TopNav = if var31 then React.createElement(EditorTopNav, {
            onBack = var33,
            onSave = var34,
            backTestId = "--moments-creation-view-textoverlay-back",
            saveTestId = "--moments-creation-button-textoverlay-save",
            zIndex = 5
        }) else nil
        local element

        if var13 then
            element = React.createElement(View, {
                Size = if var52 ~= nil then UDim2.new(1, 0, 0, var52 - 16) else UDim2.fromScale(1, 1),
                tag = "position-top-left anchor-top-left",
                ZIndex = 10
            }, {
                Toolbar = React.createElement(
                    TextOverlayToolbar,
                    {
                        controller = controller,
                        isKeyboardVisible = false,
                        onAbsoluteSizeChanged = onAbsoluteSizeChanged
                    }
                )
            })
        elseif FFlagMomentsTextOverlayV2Redesign then
            element = React.createElement(TextOverlayToolbar, { controller = controller, isKeyboardVisible = keyboardHeight > 0 })
        else
            element = nil
        end

        tbl4.TextOverlayToolbar = element
        return createElement(var53, tbl3, tbl4)
    elseif textOverlays == nil or #textOverlays == 0 then
        return nil
    else
        local bool4 = var2 == CreationFlowState.Preview

        local draggable = bool4 and not bool2
        local var50 = FFlagMomentsTextOverlayV2Redesign and bool4

        local selected = FFlagMomentsTextOverlayV2Redesign and bool4
        local var52 = FFlagMomentsTextOverlayV2Redesign and FFlagMomentsTextOverlayDragToDeleteRefinement
        local var53

        if GetFFlagMomentsStickerButton() then
            local createElement = React.createElement
            local var54 = OverlayDisplay
            local tbl3 = {
                clampToBoundsEnabled = not var52,
                unboundedDragEnabled = if var52 then true else nil,
                draggable = draggable,
                editable = false,
                itemResolution = itemResolution,
                itemSize = itemSize,
                scaleType = Enum.ScaleType.Crop,
                onOverlayActivated = 0,
                onOverlayDragBegin = 0,
                onOverlayDragContinue = 0,
                onOverlayDragEnd = 0,
                onOverlayRotationChanged = 0,
                onOverlayScaleChanged = 0,
                overlayEdits = 0,
                overlayComponent = 0,
                selected = 0,
                visualScale = 0,
                zIndex = 0
            }

            if not bool4 then
                var23 = nil
            end

            tbl3.onOverlayActivated = var23
            if not bool4 then
                var46 = nil
            end

            tbl3.onOverlayDragBegin = var46
            if not var50 then
                var47 = nil
            end

            tbl3.onOverlayDragContinue = var47
            if not bool4 then
                var48 = nil
            end

            tbl3.onOverlayDragEnd = var48
            if not selected then
                var26 = nil
            end

            tbl3.onOverlayRotationChanged = var26
            if not selected then
                var25 = nil
            end

            tbl3.onOverlayScaleChanged = var25
            tbl3.overlayEdits = textOverlays
            tbl3.overlayComponent = TextOverlay
            tbl3.selected = selected
            if not var50 then
                var43 = nil
            end

            tbl3.visualScale = var43
            tbl3.zIndex = tbl2.zIndex
            var53 = createElement(var54, tbl3)
        else
            local createElement = React.createElement
            local var54 = TextOverlayDisplay
            local tbl3 = {
                clampToBoundsEnabled = not var52,
                unboundedDragEnabled = if var52 then true else nil,
                draggable = draggable,
                editable = false,
                itemResolution = itemResolution,
                itemSize = itemSize,
                scaleType = Enum.ScaleType.Crop,
                onTextOverlayActivated = 0,
                onTextOverlayDragBegin = 0,
                onTextOverlayDragContinue = 0,
                onTextOverlayDragEnd = 0,
                onTextOverlayRotationChanged = 0,
                onTextOverlayScaleChanged = 0,
                selected = 0,
                textOverlayEdits = 0,
                visualScale = 0,
                zIndex = 0
            }

            if not bool4 then
                var23 = nil
            end

            tbl3.onTextOverlayActivated = var23
            if not bool4 then
                var46 = nil
            end

            tbl3.onTextOverlayDragBegin = var46
            if not var50 then
                var47 = nil
            end

            tbl3.onTextOverlayDragContinue = var47
            if not bool4 then
                var48 = nil
            end

            tbl3.onTextOverlayDragEnd = var48
            if not selected then
                var26 = nil
            end

            tbl3.onTextOverlayRotationChanged = var26
            if not selected then
                var25 = nil
            end

            tbl3.onTextOverlayScaleChanged = var25
            tbl3.selected = selected
            tbl3.textOverlayEdits = textOverlays
            if not var50 then
                var43 = nil
            end

            tbl3.visualScale = var43
            tbl3.zIndex = tbl2.zIndex
            var53 = createElement(var54, tbl3)
        end

        if not var50 then
            return var53
        end

        return React.createElement(View, {
            tag = "size-full",
            ZIndex = tbl2.zIndex or 1
        }, {
            Overlay = var53,
            TrashZone = React.createElement(TextOverlayTrashZone, {
                circleRef = var36,
                highlightScale = highlightScale,
                label = textOverlayDragHereToDelete,
                ref = var4,
                visible = visible,
                ZIndex = (tbl2.zIndex or 1) + 10
            })
        })
    end
end
return TextOverlayLayer
