-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:21:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreationFlow = script:FindFirstAncestor("MomentsCreationFlow")
local MomentsCreationFlowParent = MomentsCreationFlow.Parent

local BuilderIcons = require(MomentsCreationFlowParent.BuilderIcons)
local Dash = require(MomentsCreationFlowParent.Dash)
local Foundation = require(MomentsCreationFlowParent.Foundation)
local MomentsCommon = require(MomentsCreationFlowParent.MomentsCommon)
local React = require(MomentsCreationFlowParent.React)

local Icon = Foundation.Icon
local ScrollBarVisibility = Foundation.Enums.ScrollBarVisibility
local ScrollView = Foundation.ScrollView
local FoundationText = Foundation.Text
local TextInput = Foundation.TextInput
local View = Foundation.View

local MagnifyingGlass = BuilderIcons.Icon.MagnifyingGlass

local MusicEditor = require(MomentsCreationFlow.Components.MusicEditor)
local MusicPreviewItem = require(MomentsCreationFlow.Components.MusicPreviewItem)

local SearchMusic = require(MomentsCreationFlow.Thunks.SearchMusic)

local useAudioPlayback = MomentsCommon.Hooks.useAudioPlayback
local useCallback = React.useCallback
local useDeviceInsets = MomentsCommon.Hooks.useDeviceInsets
local useDispatch = MomentsCommon.Hooks.useDispatch
local useEffect = React.useEffect
local useMemo = React.useMemo
local useSelector = MomentsCommon.Hooks.useSelector
local useTokens = Foundation.Hooks.useTokens

local CreationFlowContext = require(MomentsCreationFlow.Context.CreationFlowContext)

local Constants = require(MomentsCreationFlow.Constants)
local CreationFlowLocalization = require(MomentsCreationFlow.Enums.CreationFlowLocalization)

local EventNames = require(MomentsCreationFlow.Analytics.EventNames)

return function(tbl1)
    local var1 = useDeviceInsets()
    local var2 = useDispatch()
    local var3 = useTokens()
    local text, onChanged = React.useState("")
    local var6, var7 = React.useState(false)
    local var8, var9 = React.useState(nil)
    local var10 = React.useContext(CreationFlowContext)

    local var11 = useSelector(function(arg1)
        return arg1[Constants.RoduxKey].CreationFlow.musicList
    end)

    local var12 = useMemo(function()
        if var8 then
            return tostring(var8)
        end

        return nil
    end, { var8 })

    local var13 = useAudioPlayback(var8 ~= nil, var12, { autoplay = true, looping = false })

    useEffect(function()
        tbl1.playbackController.playback.pause()
        var2(SearchMusic("", tbl1.playbackController.timeline.timeLength))
    end, { tbl1.playbackController.timeline.timeLength })

    useEffect(function()
        if not var13.playback.isPlaying then
            var9(nil)
        end
    end, { var13.playback.isPlaying })

    local onMusicSelected = useCallback(function(assetId: number)
        tbl1.onMusicUpdate({ assetId = assetId, startTime = 0 })
        tbl1.playbackController.timeline.seek(0)
        var9(nil)
        var7(true)

        var10.fireEvent(EventNames.EditingFlowMusicSelected, { musicAssetId = tostring(assetId) })
    end, { tbl1.onMusicUpdate })

    local onActivated = useCallback(function()
        tbl1.onMusicDiscard()
        tbl1.playbackController.playback.play()
        tbl1.playbackController.volume.unmute()
    end, { tbl1.onMusicDiscard })

    local onBack = useCallback(function()
        tbl1.onMusicUpdate(nil)
        var7(false)
        tbl1.playbackController.playback.pause()
    end, { tbl1.onMusicUpdate })

    local onDone = useCallback(function()
        tbl1.onMusicSave()
        var7(false)
        tbl1.playbackController.playback.play()
        tbl1.playbackController.volume.unmute()
    end, { tbl1.onMusicSave })

    local togglePreviewMusic = useCallback(function(num1: number)
        if var8 and var8 == num1 then
            var9(nil)
            return
        end
        var9(num1)
        var13.playback.play()
    end, { var8 })

    local var19 = useCallback(function()
        if var8 then
            var9(nil)
        end
        var2(SearchMusic(text, tbl1.playbackController.timeline.timeLength))
    end, { var8, text, tbl1.playbackController.timeline.timeLength })

    local onStartTimeChanged = useCallback(function(startTime: number)
        if not tbl1.musicEdit then
            return
        end

        tbl1.onMusicUpdate({ assetId = tbl1.musicEdit.assetId, startTime = startTime })
    end, { tbl1.musicEdit, tbl1.onMusicUpdate })

    if var6 then
        return React.createElement(MusicEditor, {
            playbackController = tbl1.playbackController,
            musicEdit = tbl1.musicEdit,
            onBack = onBack,
            onStartTimeChanged = onStartTimeChanged,
            onDone = onDone
        })
    end

    local createElement = React.createElement
    local var21 = View
    local tbl2 = {
        onActivated = function() end,
        Size = UDim2.fromScale(1, 2 / 3),
        stateLayer = {
            affordance = Foundation.Enums.StateLayerAffordance.None
        },
        tag = "align-x-center align-y-top anchor-bottom-center bg-surface-100 col gap-small position-bottom-center radius-medium size-full-0",
        ZIndex = 5
    }

    local tbl3 = {
        Padding = React.createElement("UIPadding", {
            PaddingTop = UDim.new(0, var3.Padding.Medium),
            PaddingLeft = UDim.new(0, math.max(var1.left, var3.Padding.XLarge)),
            PaddingRight = UDim.new(0, math.max(var1.right, var3.Padding.XLarge))
        }),
        ModalHeaderBar = React.createElement(
            View,
            {
                LayoutOrder = 1,
                tag = "align-x-center align-y-center auto-y flex-between row size-full-0"
            },
            {
                InspectTitle = React.createElement(FoundationText, {
                    LayoutOrder = 1,
                    tag = "text-heading-small content-action-emphasis text-truncate-end text-align-x-left text-align-y-top auto-xy",
                    Text = var10.getLocalization(CreationFlowLocalization.EditingCtaMusic)
                }),
                CloseButton = React.createElement(View, {
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    onActivated = onActivated,
                    Position = UDim2.fromScale(0.5, 0.5),
                    tag = "auto-xy padding-medium radius-medium",
                    LayoutOrder = 2
                }, {
                    CloseIcon = React.createElement(Icon, {
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        name = "icons/navigation/close",
                        Position = UDim2.fromScale(0.5, 0.5),
                        style = var3.Color.ActionEmphasis.Foreground,
                        ZIndex = 2
                    })
                })
            }
        ),
        SearchBar = React.createElement(
            View,
            {
                LayoutOrder = 2,
                tag = "align-x-center align-y-center col gap-small size-full-0 auto-y"
            },
            {
                Input = React.createElement(TextInput, {
                    iconLeading = MagnifyingGlass,
                    text = text,
                    placeholder = var10.getLocalization(CreationFlowLocalization.GeneralSearchPlaceholder),
                    label = "",
                    onChanged = onChanged,
                    onReturnPressed = var19,
                    onFocusLost = var19,
                    LayoutOrder = 1,
                    width = UDim.new(1, 0)
                })
            }
        ),
        ScrollView = React.createElement(
            ScrollView,
            {
                flexItem = {
                    FlexMode = Enum.UIFlexMode.Shrink
                },
                layout = {
                    FillDirection = Enum.FillDirection.Vertical,
                    VerticalAlignment = Enum.VerticalAlignment.Top,
                    HorizontalAlignment = Enum.HorizontalAlignment.Center,
                    Padding = UDim.new(0, var3.Gap.Small)
                },
                LayoutOrder = 3,
                scroll = {
                    AutomaticCanvasSize = Enum.AutomaticSize.Y,
                    scrollBarVisibility = ScrollBarVisibility.None,
                    ScrollingDirection = Enum.ScrollingDirection.Y
                },
                tag = "align-x-left align-y-top col size-full"
            },
            not (var11 and #var11 > 0)
                and {
                    NoResults = React.createElement(FoundationText, {
                        Text = var10.getLocalization(CreationFlowLocalization.MusicNoResults),
                        tag = "text-body-medium content-action-emphasis text-align-x-center"
                    })
                }
                or Dash.map(var11, function(arg1, layoutOrder)
                    return React.createElement(MusicPreviewItem, {
                        key = arg1,
                        layoutOrder = layoutOrder,
                        musicAssetId = arg1,
                        onMusicSelected = onMusicSelected,
                        togglePreviewMusic = togglePreviewMusic,
                        progress = if var8 == arg1 then var13.timeline.elapsed / var13.timeline.duration else nil,
                        isPreviewing = var8 == arg1
                    })
                end)
        )
    }

    return createElement(var21, tbl2, tbl3)
end
