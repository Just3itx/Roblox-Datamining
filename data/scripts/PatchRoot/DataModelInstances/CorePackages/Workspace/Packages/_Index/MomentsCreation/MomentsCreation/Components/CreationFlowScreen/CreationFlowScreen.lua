-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:50:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreation = script:FindFirstAncestor("MomentsCreation")
local MomentsCreationParent = MomentsCreation.Parent

local Cryo = require(MomentsCreationParent.Cryo)
local Foundation = require(MomentsCreationParent.Foundation)
local MomentsCommon = require(MomentsCreationParent.MomentsCommon)
local React = require(MomentsCreationParent.React)
local Signals = require(MomentsCreationParent.Signals)
local SignalsReact = require(MomentsCreationParent.SignalsReact)

local FoundationProvider = Foundation.FoundationProvider
local Icon = Foundation.Icon
local View = Foundation.View

local ColorMode = Foundation.Enums.ColorMode

local useCallback = React.useCallback
local useEffect = React.useEffect
local useMemo = React.useMemo
local useRef = React.useRef
local useTokens = Foundation.Hooks.useTokens

local useDeviceInsets = MomentsCommon.Hooks.useDeviceInsets
local useFormFactor = MomentsCommon.Hooks.useFormFactor
local useToggleState = MomentsCommon.Hooks.useToggleState
local FormFactor = MomentsCommon.Enums.FormFactor
local GradientBackdrop = MomentsCommon.Components.GradientBackdrop

local EventNames = MomentsCommon.Analytics.EventNames
local SessionManager = MomentsCommon.Analytics.SessionManager
local FunnelEventNames = MomentsCommon.Analytics.FunnelEventNames
local fireAnalyticsEvent = require(MomentsCreation.Analytics.fireAnalyticsEvent)
local makeCreationEventFields = require(MomentsCreation.Analytics.makeCreationEventFields)
local isAvatarMoment = require(MomentsCreation.Utils.isAvatarMoment)
local GetFFlagEnableMomentTextGeneration = MomentsCommon.Flags.GetFFlagEnableMomentTextGeneration
local GetFFlagMomentsCreationSaveDraft = MomentsCommon.Flags.GetFFlagMomentsCreationSaveDraft

local useSignalState = SignalsReact.useSignalState

local CreationController = require(MomentsCreation.CreationController)
local CreationControllerProvider = CreationController.CreationControllerProvider
local useCreationController = CreationController.useCreationController

local useAutoDismissState = require(MomentsCreation.Hooks.useAutoDismissState)
local useDraftRestoreEffect = require(MomentsCreation.Hooks.useDraftRestoreEffect)
local useDraftSaveEffect = require(MomentsCreation.Hooks.useDraftSaveEffect)
local useRestoredVoiceoverCheck = require(MomentsCreation.Hooks.useRestoredVoiceoverCheck)
local useDescriptionKeyboardInset = require(MomentsCreation.Hooks.useDescriptionKeyboardInset)
local GetFFlagMomentsStickerButton = MomentsCommon.Flags.GetFFlagMomentsStickerButton
local GetFFlagMomentsTTSAudioOverlay = require(MomentsCreation.Flags.GetFFlagMomentsTTSAudioOverlay)
local GetFFlagMomentsTTSCoachmark = require(MomentsCreation.Flags.GetFFlagMomentsTTSCoachmark)
local FFlagMomentsTTSDraftRestore = require(MomentsCreation.Flags.FFlagMomentsTTSDraftRestore)

local GetFFlagMomentsCreationCloseButtonZIndexFix = require(MomentsCreation.Flags.GetFFlagMomentsCreationCloseButtonZIndexFix)
local FFlagMomentsCreationToolsIxpEnabled = require(MomentsCreation.Flags.FFlagMomentsCreationToolsIxpEnabled)

local FFlagMomentsCreationMusicChipRemoveButton = require(MomentsCreation.Flags.FFlagMomentsCreationMusicChipRemoveButton)
local FFlagMomentsCreationMusicEditorRedesign = require(MomentsCreation.Flags.FFlagMomentsCreationMusicEditorRedesign)
local FFlagMomentsTextOverlayTopNav = require(MomentsCreation.Flags.FFlagMomentsTextOverlayTopNav)

local FFlagMomentsCreationCompactPanelSquareCorners = require(MomentsCreation.Flags.FFlagMomentsCreationCompactPanelSquareCorners)
local FStringMomentsCreationToolsIxpLayer = require(MomentsCreation.Flags.FStringMomentsCreationToolsIxpLayer)
local FFlagMomentsCreationToolsIxpEnabled2 = require(MomentsCreation.Flags.FFlagMomentsCreationToolsIxpEnabled2)
local FStringMomentsCreationToolsIxpLayer2 = require(MomentsCreation.Flags.FStringMomentsCreationToolsIxpLayer2)
local FFlagMomentsCreationToolsIxpEnabled3 = require(MomentsCreation.Flags.FFlagMomentsCreationToolsIxpEnabled3)
local FStringMomentsCreationToolsIxpLayer3 = require(MomentsCreation.Flags.FStringMomentsCreationToolsIxpLayer3)

local FFlagMomentsTextOverlayDragToDeleteRefinement = require(MomentsCreation.Flags.FFlagMomentsTextOverlayDragToDeleteRefinement)
local FFlagMomentsCreateAvatarPosts = require(MomentsCreationParent.SharedFlags).FFlagMomentsCreateAvatarPosts
local FFlagMomentsRenderCreatePostStatus = require(MomentsCreationParent.SharedFlags).FFlagMomentsRenderCreatePostStatus
local logMomentsLayerExposure = MomentsCommon.Utils.logMomentsLayerExposure
local StepStub = require(script.Parent.StepStub)

local CreationFlowState = require(MomentsCreation.Enums.CreationFlowState)
local DialogType = require(MomentsCreation.Enums.DialogType)
local DockedEditorContext = require(MomentsCreation.Contexts.DockedEditorContext)
local _CreationFlowTypes = require(MomentsCreation.Types.CreationFlowTypes)

local CaptureView = require(MomentsCreation.Components.CaptureView)
local CreationMediaProvider = require(MomentsCreation.Components.CreationMediaProvider)
local DescriptionView = require(MomentsCreation.Components.DescriptionView)
local EditCTABar = require(MomentsCreation.Components.EditCTABar)
local GalleryView = require(MomentsCreation.Components.GalleryView)
local PlaybackControls = require(MomentsCreation.Components.PlaybackControls)
local PreviewView = require(MomentsCreation.Components.PreviewView)
local ExitConfirmationDialog = require(MomentsCreation.Components.Dialogs.ExitConfirmationDialog)
local TextFilteredDialog = require(MomentsCreation.Components.Dialogs.TextFilteredDialog)
local GenerateTextOptionsDialog = require(MomentsCreation.Components.Dialogs.GenerateTextOptionsDialog)
local VoiceoverErrorDialog = require(MomentsCreation.Components.Dialogs.VoiceoverErrorDialog)
local VoiceoverDeleteConfirmDialog = require(MomentsCreation.Components.Dialogs.VoiceoverDeleteConfirmDialog)
local VoiceSelectorDialog = require(MomentsCreation.Components.Dialogs.VoiceSelectorDialog)
local VoiceBackControls = require(MomentsCreation.Components.Voice.VoiceBackControls)

local sampleCaptures = require(MomentsCreation.Capture.sampleCaptures)
local publishMoment = require(MomentsCreation.Upload.publishMoment)
local isTextFiltered = require(MomentsCreation.Moderation.isTextFiltered)

local MusicChip = require(MomentsCreation.Components.MusicChip)

local var1 = require(MomentsCreationParent.MomentsCommon.isStudio)()
local captures = not var1 and {} or sampleCaptures

local function noopActivated() end
local stateLayer = {
    affordance = Foundation.Enums.StateLayerAffordance.None
}

local function GallerySourceView(tbl2)
    local captureSource = tbl2.captureSource
    local var2 = useSignalState(captureSource.getCaptures)
    local var4 = useSignalState(captureSource.getIsFinished)
    return React.createElement(GalleryView, {
        captures = var2,
        layoutOrder = tbl2.layoutOrder,
        onCaptureSelected = tbl2.onCaptureSelected,
        onNextCallback = tbl2.onNextCallback,
        selectedCapture = tbl2.selectedCapture,
        hasMoreCaptures = not var4,
        onShowMore = captureSource.fetchMore
    })
end

local function CreationFlowContent(arg1)
    local var3 = useCreationController()

    if GetFFlagMomentsCreationSaveDraft() then
        useDraftRestoreEffect(arg1.captureSource, arg1.disableDrafts)
        useDraftSaveEffect(arg1.disableDrafts)
        if FFlagMomentsTTSDraftRestore then
            useRestoredVoiceoverCheck(var3)
        end
    end

    local var4 = useDeviceInsets()
    local var5 = useTokens()
    local var6 = useFormFactor()
    local var7 = useToggleState(false)
    local showText, onActivated = useAutoDismissState()

    local current = useSignalState(var3.getStep)
    local selectedCapture = useSignalState(var3.getSelectedCapture)
    local avatarMoment = if FFlagMomentsCreateAvatarPosts then if isAvatarMoment(selectedCapture) then selectedCapture else nil else nil
    local var13 = useSignalState(var3.getComposedEdits)
    local tools = useSignalState(var3.getAvailableTools)
    local var15 = useSignalState(var3.getActiveTool)
    local var16 = useSignalState(var3.getActiveModal)
    local var17 = useSignalState(var3.getIsGenerating)
    local var18 = if FFlagMomentsRenderCreatePostStatus then useSignalState(var3.getIsPublishing) else nil
    local music = var13.music

    local var19, onAbsoluteSizeChanged = useDescriptionKeyboardInset(
        current == CreationFlowState.Description or GetFFlagMomentsTTSAudioOverlay and current == CreationFlowState.Voice
    )

    local num1 = 0
    local var21

    if FFlagMomentsCreationMusicEditorRedesign then
        local var22, setDockedEditorHeight = React.useState(0)
        num1 = var22
        var21 = useMemo(function()
            return { setDockedEditorHeight = setDockedEditorHeight }
        end, { setDockedEditorHeight })
    else
        var21 = nil
    end

    local captureSource = arg1.captureSource

    local onCaptureSelected = useCallback(function(arg2)
        var3.selectCapture(arg2)
        onActivated()
    end, { var3, onActivated })

    local function withCreationSession(tbl2)
        local sessionId = SessionManager.getSessionId(FunnelEventNames.FunnelTypes.CreationFlow)
        return Cryo.Dictionary.join(tbl2, makeCreationEventFields.makeCreationBaseFields(sessionId))
    end

    local function flowStepFields()
        return withCreationSession(makeCreationEventFields.makeStepFieldFromState((var3.getStep(false))))
    end

    local onNextCallback = useCallback(function()
        fireAnalyticsEvent(EventNames.EditingFlowNextButtonPressed, flowStepFields())
        var3.navigate(CreationFlowState.Preview)
        onActivated()
        fireAnalyticsEvent(
            EventNames.MomentsEditingFlowContinueToEditButtonPressed,
            withCreationSession(makeCreationEventFields.makeStepField(EventNames.MomentsEditingFlowContinueToEditButtonPressed))
        )
    end, { var3, onActivated })

    local onContinueCallback = useCallback(function()
        fireAnalyticsEvent(EventNames.EditingFlowNextButtonPressed, flowStepFields())
        var3.navigate(CreationFlowState.Description)
        var7.disable()
        fireAnalyticsEvent(
            EventNames.MomentsEditingFlowContinueToDescriptionButtonPressed,
            withCreationSession(
                makeCreationEventFields.makeStepField(EventNames.MomentsEditingFlowContinueToDescriptionButtonPressed)
            )
        )
    end, { var3, var7.disable })

    local onReturnToEditing = useCallback(function()
        fireAnalyticsEvent(EventNames.EditingFlowReturnButtonPressed, flowStepFields())
        var3.navigate(CreationFlowState.Preview)
    end, { var3 })

    local onToolSelected = useCallback(function(str1: string)
        var3.beginTool(str1)
    end, { var3 })

    local var2 = useCallback(function()
        var3.beginTool("music")
    end, { var3 })

    local var28 = useCallback(function()
        var3.updateCommittedEdit("music", nil)
    end, { var3 })

    local var29 = useCallback(function()
        fireAnalyticsEvent(EventNames.EditingFlowReturnButtonPressed, flowStepFields())
        var3.showModal({
            modalType = DialogType.ExitCreationConfirmation,
            modalProps = {
                onCancel = var3.dismissModal,
                onConfirm = function()
                    var3.dismissModal()
                    var3.returnToGallery()
                    var7.disable()
                end
            }
        })
    end, { var3, var7.disable })

    local onPublish = useCallback(function()
        var3.publish()
    end, { var3 })

    local var8 = useCallback(function()
        if not selectedCapture then
            var3.exit()

            return
        end

        var3.showModal({
            modalType = DialogType.ExitCreationConfirmation,
            modalProps = {
                onCancel = var3.dismissModal,
                onConfirm = var3.exit
            }
        })
    end, { var3, selectedCapture })

    local var32 = useRef(nil)
    useEffect(function()
        local current2 = var32.current
        var32.current = current

        if current == CreationFlowState.Gallery then
            fireAnalyticsEvent(
                EventNames.EditingFlowGalleryPageAppear,
                withCreationSession(makeCreationEventFields.makeStepField(EventNames.EditingFlowGalleryPageAppear))
            )
            return
        end
        if current ~= CreationFlowState.Preview then
            if current == CreationFlowState.Description then
                fireAnalyticsEvent(
                    EventNames.EditingFlowPreviewPageAppear,
                    withCreationSession(makeCreationEventFields.makeStepField(EventNames.EditingFlowPreviewPageAppear))
                )
            end

            return
        end

        if current2 == CreationFlowState.Trimming
            or current2 == CreationFlowState.Music
            or current2 == CreationFlowState.TextOverlay
            or GetFFlagMomentsStickerButton() and current2 == CreationFlowState.StickerOverlay
            or GetFFlagMomentsTTSAudioOverlay and current2 == CreationFlowState.Voice
        then
            return
        end

        fireAnalyticsEvent(
            EventNames.EditingFlowEditPageAppear,
            withCreationSession(makeCreationEventFields.makeStepField(EventNames.EditingFlowEditPageAppear))
        )

        if FFlagMomentsCreationToolsIxpEnabled and not arg1.disableExperimentExposure then
            logMomentsLayerExposure(FStringMomentsCreationToolsIxpLayer)
        end

        if FFlagMomentsCreationToolsIxpEnabled2 and not arg1.disableExperimentExposure then
            logMomentsLayerExposure(FStringMomentsCreationToolsIxpLayer2)
        end
        if FFlagMomentsCreationToolsIxpEnabled3 and not arg1.disableExperimentExposure then
            logMomentsLayerExposure(FStringMomentsCreationToolsIxpLayer3)
        end
    end, { current, arg1.disableExperimentExposure })

    useEffect(function()
        if current == CreationFlowState.Gallery or current == CreationFlowState.Music or current == CreationFlowState.Description then
            var7.disable()
        end
    end, { current, var7.disable })

    local var33 = useCallback

    local function func1()
        if not (var16 and var16.modalType) then
            return nil
        elseif var16.modalType == DialogType.ExitCreationConfirmation then
            return React.createElement(
                ExitConfirmationDialog,
                if FFlagMomentsCreateAvatarPosts and avatarMoment ~= nil then Cryo.Dictionary.join(
                    var16.modalProps,
                    {
                        bodyLocalizationKey = "Feature.Moments.Description.LeaveAvatarMomentsCreation"
                    }
                ) else var16.modalProps
            )
        elseif var16.modalType == DialogType.TextFiltered then
            return React.createElement(TextFilteredDialog, var16.modalProps)
        elseif var16.modalType == DialogType.GenerateTextOptions then
            return React.createElement(GenerateTextOptionsDialog, var16.modalProps)
        elseif var16.modalType == DialogType.VoiceoverError then
            return React.createElement(VoiceoverErrorDialog, var16.modalProps)
        elseif var16.modalType == DialogType.VoiceoverDelete then
            return React.createElement(VoiceoverDeleteConfirmDialog, var16.modalProps)
        elseif var16.modalType == DialogType.VoiceSelector then
            return React.createElement(VoiceSelectorDialog, var16.modalProps)
        end
        return nil
    end

    local var34 = if FFlagMomentsCreateAvatarPosts then avatarMoment else nil
    local var35 = var33(func1, { var16, var34 })

    local var36 = useCallback(function(presentation: string)
        if var15 == nil or var15.presentation ~= presentation or current ~= var15.step then
            return nil
        end
        if var15.renderEditor ~= nil then
            local var36 = var15.renderEditor(var3)
            if var36 ~= nil then
                return var36
            end
        end
        return React.createElement(StepStub(var15.kind), {})
    end, { var15, current, var3 })

    local var37 = useMemo(function()
        local getItemSize, setItemSize = Signals.createSignal(Vector2.zero)
        return { getItemSize = getItemSize, setItemSize = setItemSize }
    end, {})

    local var38 = useMemo(function()
        local getItemResolution, setItemResolution = Signals.createSignal(Vector2.zero)
        return { getItemResolution = getItemResolution, setItemResolution = setItemResolution }
    end, {})

    local var39 = useMemo(function()
        local get, set = Signals.createSignal(false)
        return { get = get, set = set }
    end, {})
    local var40 = useSignalState(var39.get)

    if FFlagMomentsTextOverlayDragToDeleteRefinement then
        useEffect(function()
            var39.set(false)
        end, { current, var39 })
    end

    local var41 = useMemo(function()
        return {
            getItemSize = var37.getItemSize,
            getItemResolution = var38.getItemResolution,
            setIsOverlayDragging = var39.set
        }
    end, { var37, var38, var39 })

    local var9 = useCallback(function(arg2)
        var37.setItemSize(arg2.AbsoluteSize)
    end, { var37 })

    local onResolutionChanged = useCallback(function(vector2: Vector2)
        var38.setItemResolution(vector2)
    end, { var38 })

    local var44 = useMemo(function()
        local result = {}
        for _, value in tools do
            if value.renderPreviewLayer ~= nil then
                result[value.kind .. "PreviewLayer"] = value.renderPreviewLayer(var3, var41)
            end
        end
        return result
    end, { tools, var3, var41 })

    local scaleType = if var7.enabled then Enum.ScaleType.Fit else Enum.ScaleType.Crop
    local avatarMomentContainer = require(MomentsCreation.Components.AvatarMomentContainer)

    local createElement = React.createElement
    local var45 = View
    local tbl2 = {
        backgroundStyle = var5.Color.Common.Scrim,
        tag = "position-center-center anchor-center-center size-full-full",
        onActivated = var8,
        stateLayer = stateLayer,
        testId = "moments-creation-background-scrim"
    }
    local tbl3 = { CreationFlowView = 0, Modal = 0 }
    local createElement2 = React.createElement
    local var46 = View
    local tbl4 = {
        tag = {
            ["position-center-center anchor-center-center size-full-full bg-surface-0"] = true,
            ["radius-large"] = not FFlagMomentsCreationCompactPanelSquareCorners or var6 == FormFactor.Wide
        },
        sizeConstraint = {
            MaxSize = if var6 == FormFactor.Wide then Vector2.new(600, 700) else nil
        },
        onActivated = noopActivated,
        stateLayer = stateLayer,
        testId = "moments-creation-panel"
    }
    local tbl5 = {
        VoiceBackControls = if GetFFlagMomentsTTSAudioOverlay and current == CreationFlowState.Voice then React.createElement(VoiceBackControls) else nil,
        CloseButtonContainer = 0,
        MainViewContainer = 0
    }
    local element

    if GetFFlagMomentsTTSAudioOverlay and current == CreationFlowState.Voice
        or num1 > 0
        or FFlagMomentsTextOverlayDragToDeleteRefinement and var40
        or FFlagMomentsTextOverlayTopNav and current == CreationFlowState.TextOverlay
    then
        element = nil
    else
        element = React.createElement(View, {
            padding = {
                top = UDim.new(0, var4.top + var5.Padding.Medium),
                right = UDim.new(0, var4.right + var5.Padding.Medium)
            },
            tag = "position-top-right anchor-top-right auto-xy",
            ZIndex = if GetFFlagMomentsCreationCloseButtonZIndexFix then 10 else nil
        }, {
            CloseButton = React.createElement(
                View,
                {
                    LayoutOrder = 1,
                    onActivated = var8,
                    tag = "size-1100-1100 padding-medium radius-circle bg-over-media-0"
                },
                {
                    CloseIcon = React.createElement(Icon, {
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        Position = UDim2.fromScale(0.5, 0.5),
                        name = "icons/navigation/close_small",
                        size = Foundation.Enums.IconSize.Small,
                        style = var5.Color.ActionEmphasis.Foreground,
                        ZIndex = 2
                    })
                }
            )
        })
    end

    tbl5.CloseButtonContainer = element

    local createElement3 = React.createElement
    local var47 = View
    local tbl6 = {
        tag = "size-full",
        ZIndex = if GetFFlagMomentsCreationCloseButtonZIndexFix then 1 else nil,
        onAbsoluteSizeChanged = onAbsoluteSizeChanged
    }
    local tbl7 = { MainView = 0, MusicView = 0 }
    local createElement4 = React.createElement
    local var48 = View

    local tbl8 = {
        tag = "col align-x-center",
        Size = var19:map(function(num2: number): UDim2
            return UDim2.new(1, 0, 1, -(num2 + num1))
        end)
    }

    local tbl9 = {
        PreviewContainer = 0,
        GalleryView = 0,
        PreviewView = 0,
        ActiveStepEditor = 0,
        DescriptionView = 0
    }
    local createElement5 = React.createElement
    local str1 = "CanvasGroup"
    local tbl10 = {
        LayoutOrder = 1,
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = var5.Color.None.Transparency
    }
    local tbl11 = {
        UIFlexItem = React.createElement("UIFlexItem", { FlexMode = Enum.UIFlexMode.Custom, ShrinkRatio = if selectedCapture then 1 else 2 }),
        UICorner = React.createElement("UICorner", { CornerRadius = UDim.new(0, var5.Radius.Large) }),
        ClickCapture = React.createElement(View, {
            tag = "size-full",
            onActivated = onActivated,
            stateLayer = {
                affordance = Foundation.Enums.StateLayerAffordance.None
            },
            ZIndex = 0
        }),
        CaptureView = if avatarMoment == nil then React.createElement(CaptureView, {
            preview = var3.preview,
            scaleType = scaleType,
            onAbsoluteSizeChanged = var9,
            onResolutionChanged = onResolutionChanged,
            ttsAudio = var3.ttsAudio
        }, var44) else nil,
        AvatarMomentView = if avatarMoment == nil then nil else React.createElement(avatarMomentContainer, {
            preview = var3.preview,
            avatarMoment = avatarMoment,
            onAbsoluteSizeChanged = var9,
            onResolutionChanged = onResolutionChanged,
            ttsAudio = var3.ttsAudio
        }, var44),
        VoiceTopScrim = if GetFFlagMomentsTTSAudioOverlay and current == CreationFlowState.Voice then React.createElement(
            GradientBackdrop,
            {
                color3 = var5.Color.Common.Scrim.Color3,
                rotation = 90,
                size = UDim2.new(1, 0, 0.25, 0),
                zIndex = 2
            }
        ) else nil,
        PreviewMediaOverlay = 0,
        EditCTABar = 0
    }

    local createElement6 = React.createElement
    local var49 = View
    local tbl12 = {
        tag = "col position-bottom-center anchor-bottom-center size-full-0 auto-y",
        ZIndex = 5
    }

    local tbl13 = { OtherControls = 0, PlaybackControls = 0 }
    local createElement7 = React.createElement
    local var50 = View
    local tbl14 = {
        padding = {
            bottom = UDim.new(0, var5.Padding.Large),
            left = UDim.new(0, math.max(var4.left, var5.Padding.Large)),
            right = UDim.new(0, math.max(var4.right, var5.Padding.Large))
        },
        tag = "size-full-0 auto-y",
        LayoutOrder = 1
    }

    local tbl15 = { MusicIndicator = 0 }
    local var51

    if music
        and (current == CreationFlowState.Preview or current == CreationFlowState.Description)
        and not (FFlagMomentsTextOverlayDragToDeleteRefinement and var40)
    then
        local createElement8 = React.createElement
        local var52 = View
        local tbl16 = { tag = "position-bottom-left anchor-bottom-left auto-xy" }

        local tbl17 = { MusicChip = 0 }
        local createElement9 = React.createElement
        local var53 = MusicChip
        local tbl18 = {
            musicAssetId = music.assetId,
            onActivated = var2,
            onRemove = 0
        }

        if not FFlagMomentsCreationMusicChipRemoveButton then
            var28 = nil
        end

        tbl18.onRemove = var28
        tbl17.MusicChip = createElement9(var53, tbl18)
        var51 = createElement8(var52, tbl16, tbl17)
    else
        var51 = nil
    end

    tbl15.MusicIndicator = var51
    tbl13.OtherControls = createElement7(var50, tbl14, tbl15)
    local var52

    if selectedCapture
        and selectedCapture.CaptureType == Enum.CaptureType.Video
        and (current == CreationFlowState.Gallery
            or current == CreationFlowState.Preview
            or GetFFlagMomentsTTSAudioOverlay and current == CreationFlowState.Voice)
        and (showText or GetFFlagMomentsTTSAudioOverlay and current == CreationFlowState.Voice)
        and not var40
    then
        local createElement8 = React.createElement
        local var53 = PlaybackControls

        local tbl16 = {
            layoutOrder = 2,
            preview = var3.preview,
            toggleFitMode = var7.toggle,
            isFitMode = var7.enabled,
            onSeek = if GetFFlagMomentsTTSAudioOverlay then current == CreationFlowState.Voice and function(num2: number)
                local ttsAudio = var3.ttsAudio
                if ttsAudio == nil then
                    return
                end
                local timeLength = ttsAudio.getTimeLength(false)
                if timeLength > 0 and num2 >= 0 and num2 < timeLength then
                    ttsAudio.seek(num2)
                end
            end or nil else nil
        }

        var52 = createElement8(var53, tbl16)
    else
        var52 = nil
    end

    tbl13.PlaybackControls = var52
    tbl11.PreviewMediaOverlay = createElement6(var49, tbl12, tbl13)
    local var53

    if current == CreationFlowState.Preview then
        local createElement8 = React.createElement
        local var54 = EditCTABar
        local tbl16 = {
            tools = tools,
            onToolSelected = onToolSelected,
            showText = showText,
            zIndex = 4,
            isLoadingMap = var17 and { generateText = true } or nil,
            isDisabledMap = if GetFFlagEnableMomentTextGeneration() then var17 and { text = true } or nil else nil,
            onDisabledToolActivated = var3.onDisabledToolActivated,
            hidden = 0,
            coachmark = 0
        }

        if not FFlagMomentsTextOverlayDragToDeleteRefinement then
            var40 = nil
        end

        tbl16.hidden = var40

        tbl16.coachmark = if GetFFlagMomentsTTSAudioOverlay and GetFFlagMomentsTTSCoachmark() then require(script.Parent.makeVoiceCoachmarkConfig)(GetFFlagMomentsTTSAudioOverlay, GetFFlagMomentsTTSCoachmark()) else nil
        var53 = createElement8(var54, tbl16)
    else
        var53 = nil
    end

    tbl11.EditCTABar = var53
    tbl9.PreviewContainer = createElement5(str1, tbl10, tbl11)

    tbl9.GalleryView = if current ~= CreationFlowState.Gallery then nil elseif captureSource ~= nil then React.createElement(
        GallerySourceView,
        {
            captureSource = captureSource,
            layoutOrder = 2,
            onCaptureSelected = onCaptureSelected,
            onNextCallback = onNextCallback,
            selectedCapture = selectedCapture
        }
    ) else React.createElement(GalleryView, {
        captures = captures,
        layoutOrder = 2,
        onCaptureSelected = onCaptureSelected,
        onNextCallback = onNextCallback,
        selectedCapture = selectedCapture,
        hasMoreCaptures = false,
        onShowMore = nil
    })
    local var54

    if current == CreationFlowState.Preview then
        local createElement8 = React.createElement
        local var55 = PreviewView
        local tbl16 = {
            layoutOrder = 2,
            onContinueCallback = onContinueCallback,
            onReturnToGalleryCallback = 0
        }

        if arg1.excludeGallery then
            var29 = nil
        end

        tbl16.onReturnToGalleryCallback = var29
        var54 = createElement8(var55, tbl16)
    else
        var54 = nil
    end

    tbl9.PreviewView = var54

    tbl9.ActiveStepEditor = var36("Step")
    local var55

    if current == CreationFlowState.Description then
        local createElement8 = React.createElement
        local var56 = DescriptionView
        local tbl16 = { layoutOrder = 2, isPublishing = 0, onPublish = 0, onReturnToEditing = 0 }

        if not FFlagMomentsRenderCreatePostStatus then
            var18 = nil
        end

        tbl16.isPublishing = var18
        tbl16.onPublish = onPublish
        tbl16.onReturnToEditing = onReturnToEditing
        var55 = createElement8(var56, tbl16)
    else
        var55 = nil
    end

    tbl9.DescriptionView = var55
    tbl7.MainView = createElement4(var48, tbl8, tbl9)

    tbl7.MusicView = if FFlagMomentsCreationMusicEditorRedesign then React.createElement(DockedEditorContext.Provider, { value = var21 }, { MusicView = var36("Overlay") }) else var36("Overlay")
    tbl5.MainViewContainer = createElement3(var47, tbl6, tbl7)
    tbl3.CreationFlowView = createElement2(var46, tbl4, tbl5)

    tbl3.Modal = var35()
    local element2 = createElement(var45, tbl2, tbl3)

    return React.createElement(
        CreationMediaProvider,
        {
            preview = var3.preview,
            getSelectedCapture = var3.getSelectedCapture
        },
        element2
    )
end

local function CreationFlowScreen(tbl2)
    local onExit = tbl2.onExit
    local host = tbl2.host
    local captureSource = tbl2.captureSource
    local canDismissCreationFlow = if FFlagMomentsRenderCreatePostStatus then tbl2.canDismissCreationFlow else nil
    local var3 = nil
    if FFlagMomentsRenderCreatePostStatus then
        var3 = React.useRef(tbl2.onPublishFinished)
        local onPublishFinished = tbl2.onPublishFinished
        var3.current = onPublishFinished
    end

    local useMemo2 = React.useMemo

    local function func1()
        if host ~= nil then
            return host
        end
        return {
            exitCreationFlow = onExit,
            canDismissCreationFlow = if FFlagMomentsRenderCreatePostStatus then canDismissCreationFlow else nil,
            onPublishFinished = FFlagMomentsRenderCreatePostStatus and function(bool1: boolean)
                local current = var3.current
                if current ~= nil then
                    current(bool1)
                end
            end or nil,
            captureSource = captureSource,
            isTextFiltered = isTextFiltered,
            createMoment = var1 and function(_, _, str1: string)
                print(`[moments-creation] dev publish (not uploaded): "{str1}"`)
            end or publishMoment
        }
    end

    local var4 = if FFlagMomentsRenderCreatePostStatus then canDismissCreationFlow else nil
    local var2 = useMemo2(func1, { host, onExit, captureSource, var4 })

    local createElement = React.createElement
    local var6 = FoundationProvider
    local tbl3 = {
        colorMode = ColorMode.Dark
    }
    local tbl4 = {
        Root = React.createElement(CreationControllerProvider, {
            host = var2,
            excludeGallery = tbl2.excludeGallery,
            initialAvatarMoment = if FFlagMomentsCreateAvatarPosts then tbl2.initialAvatarMoment else nil
        }, {
            Content = React.createElement(CreationFlowContent, {
                excludeGallery = tbl2.excludeGallery,
                captureSource = var2.captureSource,
                disableDrafts = var2.disableDrafts,
                disableExperimentExposure = var2.disableExperimentExposure
            })
        })
    }
    return createElement(var6, tbl3, tbl4)
end

return CreationFlowScreen
