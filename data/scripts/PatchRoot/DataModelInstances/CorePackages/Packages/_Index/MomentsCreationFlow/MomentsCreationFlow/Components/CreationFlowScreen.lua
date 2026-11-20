-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:20:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreationFlow = script:FindFirstAncestor("MomentsCreationFlow")
local MomentsCreationFlowParent = MomentsCreationFlow.Parent

local Foundation = require(MomentsCreationFlowParent.Foundation)
local MomentsCommon = require(MomentsCreationFlowParent.MomentsCommon)
local React = require(MomentsCreationFlowParent.React)

local Icon = Foundation.Icon
local View = Foundation.View

local CaptureView = require(MomentsCreationFlow.Components.CaptureView)
local DescriptionView = require(MomentsCreationFlow.Components.DescriptionView)
local EditCTABar = require(MomentsCreationFlow.Components.EditCTABar)
local GalleryView = require(MomentsCreationFlow.Components.GalleryView)
local MusicChip = require(MomentsCreationFlow.Components.MusicChip)
local MusicOverlay = require(MomentsCreationFlow.Components.MusicOverlay)
local PlaybackControls = require(MomentsCreationFlow.Components.PlaybackControls)
local PreviewView = require(MomentsCreationFlow.Components.PreviewView)
local TextOverlayDisplay = MomentsCommon.TextOverlayDisplay
local ExitConfirmationDialog = require(MomentsCreationFlow.Components.Dialogs.ExitConfirmationDialog)
local TextFilteredDialog = require(MomentsCreationFlow.Components.Dialogs.TextFilteredDialog)
local TextOverlayEditor = require(MomentsCreationFlow.Components.TextOverlay.TextOverlayEditor)
local TextOverlayView = require(MomentsCreationFlow.Components.TextOverlay.TextOverlayView)
local TrimmingView = require(MomentsCreationFlow.Components.TrimmingView)

local ClearEdits = require(MomentsCreationFlow.Actions.ClearEdits)
local CreationFlowStateUpdated = require(MomentsCreationFlow.Actions.CreationFlowStateUpdated)
local MusicEditUpdated = require(MomentsCreationFlow.Actions.MusicEditUpdated)
local SelectedCaptureUpdated = require(MomentsCreationFlow.Actions.SelectedCaptureUpdated)
local TextOverlayEditsUpdated = require(MomentsCreationFlow.Actions.TextOverlayEditsUpdated)
local TrimEditUpdated = require(MomentsCreationFlow.Actions.TrimEditUpdated)

local useAutoDismissState = require(MomentsCreationFlow.Hooks.useAutoDismissState)
local useCallback = React.useCallback
local useDeviceInsets = MomentsCommon.Hooks.useDeviceInsets
local useDispatch = MomentsCommon.Hooks.useDispatch
local useFormFactor = MomentsCommon.Hooks.useFormFactor
local useMemo = React.useMemo
local useRef = React.useRef
local useSelector = MomentsCommon.Hooks.useSelector
local useToggleState = MomentsCommon.Hooks.useToggleState
local useTokens = Foundation.Hooks.useTokens
local useUnifiedPlayback = MomentsCommon.Hooks.useUnifiedPlayback

local CreationFlowContext = require(MomentsCreationFlow.Context.CreationFlowContext)

local getContentFromCapture = require(MomentsCreationFlow.Utils.getContentFromCapture)
local makeMomentMetadata = require(MomentsCreationFlow.Utils.makeMomentMetadata)
local makeRegistrationInfo = require(MomentsCreationFlow.Utils.makeRegistrationInfo)

local CreationFlowState = require(MomentsCreationFlow.Enums.CreationFlowState)
local DialogType = require(MomentsCreationFlow.Enums.DialogType)
local FormFactor = MomentsCommon.Enums.FormFactor

local Constants = require(MomentsCreationFlow.Constants)
local CreationFlowLocalization = require(MomentsCreationFlow.Enums.CreationFlowLocalization)
local EventNames = require(MomentsCreationFlow.Analytics.EventNames)

local tbl1 = {
    position = UDim2.fromScale(0.5, 0.5),
    rotation = 0,
    scale = 1,
    text = "",
    textOverlayStyle = {
        font = Enum.Font.BuilderSansMedium,
        fontColor = Color3.new(0, 0, 0),
        fontSize = 16,
        textXAlignment = Enum.TextXAlignment.Center
    },
    zIndex = 1
}

return function(tbl2)
    local var1 = useDispatch()
    local var2 = useDeviceInsets()
    local var3 = useTokens()
    local var4 = useFormFactor()
    local var5 = useToggleState(false)
    local showText, onActivated = useAutoDismissState()
    local var8 = React.useContext(CreationFlowContext)

    local itemResolution, onResolutionChanged = React.useState(Vector2.new(0, 0))
    local itemSize, var12 = React.useState(Vector2.new(0, 0))
    local var13, var14 = React.useState({ modalType = nil, modalProps = nil })

    local onAbsoluteSizeChanged = useCallback(function(arg1)
        var12(arg1.AbsoluteSize)
    end, {})

    local captures = var8.captures

    local var16 = useRef(0)

    local editFlowState = useSelector(function(arg1)
        return arg1[Constants.RoduxKey].CreationFlow.currentState
    end)

    local var18 = useSelector(function(arg1)
        return arg1[Constants.RoduxKey].CreationFlow.capture
    end)

    local var19 = useSelector(function(arg1)
        return arg1[Constants.RoduxKey].CreationFlow.textOverlayEdits
    end)

    local trim = useSelector(function(arg1)
        return arg1[Constants.RoduxKey].CreationFlow.trimEdit
    end)

    local music = useSelector(function(arg1)
        return arg1[Constants.RoduxKey].CreationFlow.musicEdit
    end)

    local var22 = useSelector(function(arg1)
        return arg1[Constants.RoduxKey].CreationFlow.description
    end)

    local textOverlayEdits, var24 = React.useState(nil)
    local var25, var26 = React.useState(nil)
    local var27, var28 = React.useState(nil)

    local var29 = useMemo(function()
        return var27 or music
    end, { var27, music })

    local var30 = useMemo(function()
        return var25 or trim
    end, { var25, trim })

    local playbackController = useUnifiedPlayback(true, {
        autoplay = true,
        edits = { trim = var30, music = var29 },
        looping = true,
        content = if var18 then getContentFromCapture(var18) else nil,
        captureType = if var18 then var18.CaptureType else nil
    })

    local onNextCallback = useCallback(function()
        var8.fireEvent(EventNames.EditingFlowNextButtonPressed, { editFlowState = editFlowState })

        var1(CreationFlowStateUpdated(CreationFlowState.Preview))
        onActivated()
        var8.fireEvent(EventNames.MomentsEditingFlowContinueToEditButtonPressed)
    end, { onActivated, editFlowState })

    local onContinueCallback = useCallback(function()
        var8.fireEvent(EventNames.EditingFlowNextButtonPressed, { editFlowState = editFlowState })

        var1(CreationFlowStateUpdated(CreationFlowState.Description))
        var5.disable()

        var8.fireEvent(EventNames.MomentsEditingFlowContinueToDescriptionButtonPressed)
    end, { editFlowState })

    local var34 = useCallback(function(str1: string)
        local var34 = var8.isTextFiltered(str1)
        if var34 then
            var14({
                modalType = DialogType.TextFiltered,
                modalProps = {
                    onConfirm = function()
                        var14(nil)
                    end
                }
            })
        end
        return var34
    end, {})

    local onPublish = useCallback(function()
        if var34(var22) then
            return
        end

        local current = os.clock()
        if current - var16.current < 0.5 then
            return
        end

        var16.current = current

        local momentMetadata = makeMomentMetadata(var18, var22, { trim = trim, music = music, textOverlays = var19 })
        local registrationInfo = makeRegistrationInfo(var18, momentMetadata)

        var8.createMoment(var18, momentMetadata, registrationInfo)

        if tbl2.excludeGallery then
            var1(ClearEdits(CreationFlowState.Preview))
        else
            var1(ClearEdits(CreationFlowState.Gallery))
        end

        var8.fireEvent(EventNames.MomentsEditingFlowPublished)

        var8.exitCreationFlow()
    end, {
        var18,
        var22,
        music,
        var8,
        var19,
        trim,
        tbl2.excludeGallery
    })

    local onReturnToEditing = useCallback(function()
        var8.fireEvent(EventNames.EditingFlowReturnButtonPressed, { editFlowState = editFlowState })

        var1(CreationFlowStateUpdated(CreationFlowState.Preview))
    end, { editFlowState })

    local var37 = useCallback(function()
        var8.fireEvent(EventNames.EditingFlowReturnButtonPressed, { editFlowState = editFlowState })

        var14({
            modalType = DialogType.ExitCreationConfirmation,
            modalProps = {
                onCancel = function()
                    var14(nil)
                end,
                onConfirm = function() -- name: onExitCreation
                    var14(nil)
                    var1(ClearEdits(CreationFlowState.Gallery))
                    var5.disable()
                end
            }
        })
    end, { editFlowState })

    local onTrimDiscard = useCallback(function()
        var26(nil)
        var1(CreationFlowStateUpdated(CreationFlowState.Preview))
        var8.fireEvent(EventNames.EditingFlowTrimBackButtonPressed)
    end, { var8 })

    local onTrimSave = useCallback(function()
        var1(TrimEditUpdated(var25))
        var26(nil)
        var1(CreationFlowStateUpdated(CreationFlowState.Preview))
        var8.fireEvent(EventNames.EditingFlowTrimDoneButtonPressed)
    end, { var25, var8 })

    local onTrimUpdate = useCallback(function(arg1)
        var26(arg1)
    end, {})

    local onMusicDiscard = useCallback(function()
        var28(nil)
        var1(CreationFlowStateUpdated(CreationFlowState.Preview))
        var8.fireEvent(EventNames.EditingFlowMusicBackButtonPressed)
    end, {})

    local onMusicSave = useCallback(function()
        var1(MusicEditUpdated(var27))
        var28(nil)
        var1(CreationFlowStateUpdated(CreationFlowState.Preview))
        var8.fireEvent(EventNames.EditingFlowMusicDoneButtonPressed)
    end, { var27 })

    local onMusicUpdate = useCallback(function(arg1)
        var28(arg1)
    end, {})

    local onTextOverlayDiscard = useCallback(function()
        var24(nil)
        var1(CreationFlowStateUpdated(CreationFlowState.Preview))
        var8.fireEvent(EventNames.EditingFlowTextOverlayBackButtonPressed)
    end, { textOverlayEdits, var8 })

    local onTextOverlaySave = useCallback(function()
        local text = textOverlayEdits and textOverlayEdits[1] and textOverlayEdits[1].text
        if text == "" then
            var1(TextOverlayEditsUpdated(nil))
        else
            if var34(text) then
                return
            end
            var1(TextOverlayEditsUpdated(textOverlayEdits))
        end

        var1(CreationFlowStateUpdated(CreationFlowState.Preview))
        var8.fireEvent(EventNames.EditingFlowTextOverlayDoneButtonPressed)
        var24(nil)
    end, { textOverlayEdits, var8, var34 })

    local onTextOverlayUpdated = useCallback(function(tbl3)
        var24(tbl3)
    end, {})

    local onTextOverlayDragEnd = useCallback(function(tbl3)
        var1(TextOverlayEditsUpdated(tbl3))
    end, {})

    local onTextOverlayActivated = useCallback(function()
        var24(var19)
        var1(CreationFlowStateUpdated(CreationFlowState.TextOverlay))
    end, { var19 })

    React.useEffect(function()
        if editFlowState == CreationFlowState.TextOverlay then
            var24(var19 or { tbl1 })
        end
    end, { var19, editFlowState })

    local var6 = useCallback(function()
        var1(CreationFlowStateUpdated(CreationFlowState.Music))
        var8.fireEvent(EventNames.EditingFlowMusicButtonPressed)
    end, {})

    local onCaptureSelected = useCallback(function(arg1)
        var1(SelectedCaptureUpdated(arg1))
        onActivated()
        var8.fireEvent(EventNames.EditingFlowGalleryItemSelected)
    end, { onActivated, var8 })

    local onRenderFailed = React.useCallback(function()
        return (React.createElement(
            View,
            {
                Size = UDim2.fromScale(1, 1),
                stateLayer = {
                    affordance = Foundation.Enums.StateLayerAffordance.None
                }
            },
            {
                ModeratedText = React.createElement("TextLabel", {
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    BackgroundTransparency = 1,
                    Position = UDim2.fromScale(0.5, 0.5),
                    Size = UDim2.fromScale(1, 1),
                    Text = var8.getLocalization(CreationFlowLocalization.PostRemovedTitle),
                    TextColor3 = var3.Color.Extended.White.White_70
                })
            }
        ))
    end, {})

    local var7 = useCallback(function()
        local function onExitCreation()
            var8.fireEvent(EventNames.MomentsEditingFlowExited)
            var14(nil)
            if tbl2.excludeGallery then
                var1(ClearEdits(CreationFlowState.Preview))
            else
                var1(ClearEdits(CreationFlowState.Gallery))
            end
            var8.exitCreationFlow()
        end

        if not var18 then
            onExitCreation()

            return
        end

        var14({
            modalType = DialogType.ExitCreationConfirmation,
            modalProps = {
                onCancel = function()
                    var14(nil)
                end,
                onConfirm = onExitCreation
            }
        })
    end, { var18, var8, tbl2.excludeGallery })

    React.useEffect(function()
        var8.setScreenOrientation(Enum.ScreenOrientation.Portrait)

        return function()
            var8.setScreenOrientation(Enum.ScreenOrientation.Sensor)
        end
    end, {})

    React.useEffect(function()
        if editFlowState == CreationFlowState.Gallery
            or editFlowState == CreationFlowState.Music
            or editFlowState == CreationFlowState.Description
        then
            var5.disable()
        end
    end, { editFlowState })

    local var53 = React.useCallback(function()
        if not var13 then
            return nil
        elseif var13.modalType == DialogType.ExitCreationConfirmation then
            return React.createElement(ExitConfirmationDialog, var13.modalProps)
        elseif var13.modalType == DialogType.TextFiltered then
            return React.createElement(TextFilteredDialog, var13.modalProps)
        end
        return nil
    end, { var13 })

    local createElement = React.createElement
    local var54 = View
    local tbl3 = {
        backgroundStyle = var3.Color.Common.Scrim,
        tag = "anchor-center-center position-center-center size-full-full"
    }
    local tbl4 = { CreationFlowView = 0, Modal = 0 }
    local createElement2 = React.createElement
    local var55 = View
    local tbl5 = {
        tag = "anchor-center-center bg-surface-0 position-center-center radius-large size-full-full",
        sizeConstraint = {
            MaxSize = if var4 == FormFactor.Wide then Vector2.new(600, 700) else nil
        }
    }
    local tbl6 = {
        CloseButtonContainer = React.createElement(View, {
            tag = "auto-xy anchor-top-right position-top-right"
        }, {
            Padding = React.createElement("UIPadding", {
                PaddingTop = UDim.new(0, var2.top + var3.Padding.Medium),
                PaddingRight = UDim.new(0, var2.right + var3.Padding.Medium)
            }),
            CloseButton = React.createElement(
                View,
                {
                    LayoutOrder = 1,
                    onActivated = var7,
                    tag = "size-1100-1100 bg-over-media-0 padding-medium radius-circle"
                },
                {
                    CloseIcon = React.createElement(Icon, {
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        Position = UDim2.fromScale(0.5, 0.5),
                        name = "icons/navigation/close_small",
                        size = Foundation.Enums.IconSize.Small,
                        style = var3.Color.ActionEmphasis.Foreground,
                        ZIndex = 2
                    })
                }
            )
        }),
        MainViewContainer = 0
    }

    local createElement3 = React.createElement
    local var56 = View
    local tbl7 = { tag = "size-full" }

    local tbl8 = { MainView = 0, MusicView = 0 }
    local createElement4 = React.createElement
    local var57 = View
    local tbl9 = { tag = "size-full col align-x-center" }

    local tbl10 = {
        PreviewContainer = 0,
        GalleryView = 0,
        PreviewView = 0,
        TrimmingView = 0,
        TextOverlayView = 0,
        DescriptionView = 0
    }
    local createElement5 = React.createElement
    local str1 = "CanvasGroup"
    local tbl11 = {
        LayoutOrder = 1,
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = var3.Color.None.Transparency
    }
    local tbl12 = {
        UIFlexItem = React.createElement("UIFlexItem", { FlexMode = Enum.UIFlexMode.Custom, ShrinkRatio = if var18 then 1 else 2 }),
        UICorner = React.createElement("UICorner", { CornerRadius = UDim.new(0, var3.Radius.Large) }),
        ClickCapture = React.createElement(View, {
            tag = "size-full",
            onActivated = onActivated,
            stateLayer = {
                affordance = Foundation.Enums.StateLayerAffordance.None
            },
            ZIndex = 0
        }),
        PreviewMediaOverlay = 0,
        TextOverlayEditor = 0,
        CaptureView = 0,
        EditCTABar = 0
    }

    local createElement6 = React.createElement
    local var58 = View
    local tbl13 = {
        tag = "auto-y anchor-bottom-center col position-bottom-center size-full-0",
        ZIndex = 5
    }

    local tbl14 = { OtherControls = 0, PlaybackControls = 0 }
    local createElement7 = React.createElement
    local var59 = View
    local tbl15 = {
        tag = "auto-y padding-x-large padding-bottom-large size-full-0",
        LayoutOrder = 1
    }

    local tbl16 = {
        Padding = React.createElement("UIPadding", {
            PaddingLeft = UDim.new(0, math.max(var2.right, var3.Padding.Large)),
            PaddingRight = UDim.new(0, math.max(var2.right, var3.Padding.Large))
        }),
        MusicIndicator = if music and (editFlowState == CreationFlowState.Preview or editFlowState == CreationFlowState.Description) then React.createElement(
            View,
            { tag = "anchor-bottom-left auto-xy position-bottom-left" },
            {
                MusicChip = React.createElement(MusicChip, { musicAssetId = music.assetId, onActivated = var6 })
            }
        ) else nil
    }
    tbl14.OtherControls = createElement7(var59, tbl15, tbl16)

    tbl14.PlaybackControls = if var18
        and var18.CaptureType == Enum.CaptureType.Video
        and showText
        and (editFlowState == CreationFlowState.Gallery or editFlowState == CreationFlowState.Preview) then React.createElement(
        PlaybackControls,
        {
            layoutOrder = 2,
            playbackController = playbackController,
            toggleFitMode = var5.toggle,
            isFitMode = var5.enabled
        }
    ) else nil
    tbl12.PreviewMediaOverlay = createElement6(var58, tbl13, tbl14)

    tbl12.TextOverlayEditor = if editFlowState == CreationFlowState.TextOverlay then React.createElement(
        TextOverlayEditor,
        {
            layoutOrder = 2,
            onTextOverlayDiscard = onTextOverlayDiscard,
            onTextOverlaySave = onTextOverlaySave,
            onTextOverlayUpdated = onTextOverlayUpdated,
            textOverlayEdits = textOverlayEdits
        }
    ) else nil

    local createElement8 = React.createElement
    local var60 = CaptureView
    local tbl17 = {
        capture = var18,
        playbackController = playbackController,
        onAbsoluteSizeChanged = onAbsoluteSizeChanged,
        onRenderFailed = onRenderFailed,
        onResolutionChanged = onResolutionChanged,
        scaleType = if var5.enabled then Enum.ScaleType.Fit else Enum.ScaleType.Crop
    }
    local tbl18 = {
        TextOverlayDisplay = React.createElement(TextOverlayDisplay, {
            draggable = editFlowState == CreationFlowState.Preview,
            editable = editFlowState == CreationFlowState.TextOverlay,
            itemResolution = itemResolution,
            itemSize = itemSize,
            scaleType = if var5.enabled then Enum.ScaleType.Fit else Enum.ScaleType.Crop,
            onTextOverlayActivated = onTextOverlayActivated,
            onTextOverlayDragEnd = onTextOverlayDragEnd,
            textOverlayEdits = var19,
            zIndex = 3
        })
    }
    tbl12.CaptureView = createElement8(var60, tbl17, tbl18)
    local element = if editFlowState == CreationFlowState.Preview then React.createElement(
        EditCTABar,
        {
            captureType = if var18 then var18.CaptureType else nil,
            showText = showText,
            zIndex = 4
        }
    ) else nil
    tbl12.EditCTABar = element
    tbl10.PreviewContainer = createElement5(str1, tbl11, tbl12)

    tbl10.GalleryView = if editFlowState == CreationFlowState.Gallery then React.createElement(GalleryView, {
        layoutOrder = 2,
        captures = captures,
        selectedCapture = var18,
        onCaptureSelected = onCaptureSelected,
        onNextCallback = onNextCallback
    }) else nil
    local var61

    if editFlowState == CreationFlowState.Preview then
        local createElement9 = React.createElement
        local var62 = PreviewView
        local tbl19 = {
            layoutOrder = 2,
            onContinueCallback = onContinueCallback,
            onReturnToGalleryCallback = 0
        }

        if tbl2.excludeGallery then
            var37 = nil
        end

        tbl19.onReturnToGalleryCallback = var37
        var61 = createElement9(var62, tbl19)
    else
        var61 = nil
    end

    tbl10.PreviewView = var61

    tbl10.TrimmingView = if editFlowState == CreationFlowState.Trimming then React.createElement(TrimmingView, {
        layoutOrder = 2,
        playbackController = playbackController,
        onTrimDiscard = onTrimDiscard,
        onTrimSave = onTrimSave,
        onTrimUpdate = onTrimUpdate,
        selectedCapture = var18,
        trimEdit = var30
    }) else nil

    tbl10.TextOverlayView = if editFlowState == CreationFlowState.TextOverlay then React.createElement(
        TextOverlayView,
        {
            layoutOrder = 2,
            onTextOverlayDiscard = onTextOverlayDiscard,
            onTextOverlaySave = onTextOverlaySave
        }
    ) else nil

    tbl10.DescriptionView = if editFlowState == CreationFlowState.Description then React.createElement(DescriptionView, { layoutOrder = 2, onPublish = onPublish, onReturnToEditing = onReturnToEditing }) else nil
    tbl8.MainView = createElement4(var57, tbl9, tbl10)

    tbl8.MusicView = if editFlowState == CreationFlowState.Music then React.createElement(
        View,
        {
            Size = UDim2.fromScale(1, 1),
            LayoutOrder = 2
        },
        {
            MusicOverlay = React.createElement(MusicOverlay, {
                musicEdit = var29,
                playbackController = playbackController,
                onMusicDiscard = onMusicDiscard,
                onMusicSave = onMusicSave,
                onMusicUpdate = onMusicUpdate
            })
        }
    ) else nil
    tbl6.MainViewContainer = createElement3(var56, tbl7, tbl8)
    tbl4.CreationFlowView = createElement2(var55, tbl5, tbl6)

    tbl4.Modal = var53()
    return createElement(var54, tbl3, tbl4)
end
