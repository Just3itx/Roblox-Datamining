-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:51:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreation = script:FindFirstAncestor("MomentsCreation")
local MomentsCreationParent = MomentsCreation.Parent

local BuilderIcons = require(MomentsCreationParent.BuilderIcons)
local Dash = require(MomentsCreationParent.Dash)
local Foundation = require(MomentsCreationParent.Foundation)
local MomentsCommon = require(MomentsCreationParent.MomentsCommon)
local React = require(MomentsCreationParent.React)
local Signals = require(MomentsCreationParent.Signals)

local Button = Foundation.Button
local Icon = Foundation.Icon
local ScrollBarVisibility = Foundation.Enums.ScrollBarVisibility
local ScrollView = Foundation.ScrollView
local FoundationText = Foundation.Text
local TextInput = Foundation.TextInput
local View = Foundation.View

local MagnifyingGlass = BuilderIcons.Icon.MagnifyingGlass

local useAudioPlayback = require(MomentsCreation.Hooks.useAudioPlayback)
local MusicEditor = require(MomentsCreation.Components.MusicEditor)
local MusicPreviewItem = require(MomentsCreation.Components.MusicPreviewItem)
local GetMusicStore = require(MomentsCreation.Stores.GetMusicStore)

local GetFFlagMomentsCreationMusicSearchStateFix = require(MomentsCreation.Flags.GetFFlagMomentsCreationMusicSearchStateFix)
local fireAnalyticsEvent = require(MomentsCreation.Analytics.fireAnalyticsEvent)
local makeCreationEventFields = require(MomentsCreation.Analytics.makeCreationEventFields)

local EventNames = MomentsCommon.Analytics.EventNames
local SessionManager = MomentsCommon.Analytics.SessionManager
local FunnelEventNames = MomentsCommon.Analytics.FunnelEventNames

local useCallback = React.useCallback
local useEffect = React.useEffect

local useState = React.useState
local useDeviceInsets = MomentsCommon.Hooks.useDeviceInsets
local useTokens = Foundation.Hooks.useTokens

local useCreationFlowStrings = require(MomentsCreation.Hooks.useCreationFlowStrings)
local _CreationFlowTypes = require(MomentsCreation.Types.CreationFlowTypes)
local _MomentsTypes = require(MomentsCreationParent.MomentsTypes)

local function MusicOverlay(tbl1)
    local controller = tbl1.controller
    local playback = controller.preview.playback

    local var1 = useDeviceInsets()
    local var2 = useTokens()
    local var3 = useCreationFlowStrings()
    local musicStore = GetMusicStore()

    local text, onChanged = useState("")
    local var6, var7 = useState(nil)
    local var8, var9 = useState(false)

    local var10, var11 = useState(playback.getTimeLength(false))
    local var12, var13 = useState(musicStore.getResults(false))
    local var14, var15 = useState(musicStore.getSearchStatus(false))

    useEffect(function()
        return Signals.createEffect(function(arg1)
            var11(playback.getTimeLength(arg1))
            var13(musicStore.getResults(arg1))
            var15(musicStore.getSearchStatus(arg1))
        end)
    end, { playback, musicStore })

    local musicEdit, var17 = useState(nil)
    useEffect(function()
        return Signals.createEffect(function(arg1)
            local activeSession = controller.getActiveSession(arg1)
            var17(if activeSession == nil then nil else activeSession.getDraft(arg1))
        end)
    end, { controller })

    local var18 = useAudioPlayback(var6 ~= nil, var6, { autoplay = true, looping = false })

    useEffect(function()
        playback.pause()
        musicStore.search("", var10)
    end, { var10 })

    useEffect(function()
        if not var18.playback.isPlaying then
            var7(nil)
        end
    end, { var18.playback.isPlaying })

    local onActivated = useCallback(function()
        playback.play()
        playback.setMuted(false)
        controller.discardActiveTool()
    end, { controller, playback })

    local onMusicSelected = useCallback(function(assetId: number)
        local activeSession = controller.getActiveSession(false)
        if activeSession ~= nil then
            activeSession.update({ assetId = assetId, startTime = 0 })
        end
        var7(nil)
        var9(true)

        local tbl2 = {
            musicAssetId = tostring(assetId)
        }

        for value, value2 in makeCreationEventFields.makeToolFieldFromKind("music") do
            tbl2[value] = value2
        end

        local sessionId = SessionManager.getSessionId(FunnelEventNames.FunnelTypes.CreationFlow)
        for value, value2 in makeCreationEventFields.makeCreationBaseFields(sessionId) do
            tbl2[value] = value2
        end
        fireAnalyticsEvent(EventNames.EditingFlowMusicSelected, tbl2)
    end, { controller })

    local onBack = useCallback(function()
        local activeSession = controller.getActiveSession(false)
        if activeSession ~= nil then
            activeSession.update(nil)
        end
        var9(false)
        playback.pause()
    end, { controller, playback })

    local onDone = useCallback(function()
        var9(false)
        playback.play()
        playback.setMuted(false)
        controller.commitActiveTool()
    end, { controller, playback })

    local onStartTimeChanged = useCallback(function(startTime: number)
        local activeSession = controller.getActiveSession(false)
        local draft = if activeSession == nil then nil else activeSession.getDraft(false)

        if activeSession ~= nil and draft ~= nil then
            activeSession.update({ assetId = draft.assetId, startTime = startTime })
        end
    end, { controller })

    local togglePreviewMusic = useCallback(function(num1: number)
        if var6 == num1 then
            var7(nil)
            return
        end
        var7(num1)
        var18.playback.play()
    end, { var6 })

    local var25 = useCallback(function()
        if var6 ~= nil then
            var7(nil)
        end
        musicStore.search(text, var10)
    end, { var6, text, var10 })

    local var4 = useCallback(function()
        musicStore.search(text, var10)
    end, { musicStore, text, var10 })

    if var8 and musicEdit ~= nil then
        return React.createElement(MusicEditor, {
            controller = controller,
            musicEdit = musicEdit,
            onBack = onBack,
            onDone = onDone,
            onStartTimeChanged = onStartTimeChanged
        })
    end

    local duration = var18.timeline.duration
    local var27 = if duration > 0 then var18.timeline.elapsed / duration else 0

    local fFlagMomentsCreationMusicSearchStateFix = GetFFlagMomentsCreationMusicSearchStateFix()
    local var28

    if #var12 > 0 then
        var28 = Dash.map(var12, function(arg1, layoutOrder)
            return React.createElement(MusicPreviewItem, {
                key = arg1.AssetId,
                layoutOrder = layoutOrder,
                musicAssetId = arg1.AssetId,
                onMusicSelected = onMusicSelected,
                togglePreviewMusic = togglePreviewMusic,
                progress = if var6 == arg1.AssetId then var27 else nil,
                isPreviewing = var6 == arg1.AssetId
            })
        end)
    elseif fFlagMomentsCreationMusicSearchStateFix and var14 == "loading" then
        var28 = nil
    else
        var28 = fFlagMomentsCreationMusicSearchStateFix
            and var14 == "error"
            and {
                SearchError = React.createElement(FoundationText, {
                    LayoutOrder = 1,
                    Text = var3.MusicSearchError,
                    tag = "auto-y text-body-medium text-align-x-center content-action-emphasis"
                }),
                Retry = React.createElement(Button, {
                    LayoutOrder = 2,
                    onActivated = var4,
                    size = Foundation.Enums.InputSize.Small,
                    text = var3.GeneralCtaRetry,
                    variant = Foundation.Enums.ButtonVariant.Standard
                })
            }
            or {
                NoResults = React.createElement(FoundationText, {
                    LayoutOrder = if fFlagMomentsCreationMusicSearchStateFix then 1 else nil,
                    Text = var3.MusicNoResults,
                    tag = {
                        ["auto-y padding-top-large text-body-medium text-align-x-center content-action-emphasis"] = fFlagMomentsCreationMusicSearchStateFix,
                        ["text-body-medium text-align-x-center content-action-emphasis"] = not fFlagMomentsCreationMusicSearchStateFix
                    }
                })
            }
    end

    local createElement = React.createElement
    local var29 = View
    local tbl2 = {
        onActivated = function() end,
        Size = UDim2.fromScale(1, 2 / 3),
        stateLayer = {
            affordance = Foundation.Enums.StateLayerAffordance.None
        },
        tag = "col align-x-center align-y-top gap-small position-bottom-center anchor-bottom-center size-full-0 radius-medium bg-surface-100",
        ZIndex = 5,
        padding = {
            top = UDim.new(0, var2.Padding.Medium),
            left = UDim.new(0, math.max(var1.left, var2.Padding.XLarge)),
            right = UDim.new(0, math.max(var1.right, var2.Padding.XLarge))
        }
    }
    return createElement(var29, tbl2, {
        ModalHeaderBar = React.createElement(
            View,
            {
                LayoutOrder = 1,
                tag = "row flex-x-between align-x-center align-y-center size-full-0 auto-y"
            },
            {
                Title = React.createElement(FoundationText, {
                    LayoutOrder = 1,
                    tag = "auto-xy text-heading-small text-align-x-left text-align-y-top text-truncate-end content-action-emphasis",
                    Text = var3.EditingCtaMusic
                }),
                CloseButton = React.createElement(
                    View,
                    {
                        onActivated = onActivated,
                        tag = "auto-xy padding-medium radius-medium",
                        LayoutOrder = 2
                    },
                    {
                        CloseIcon = React.createElement(Icon, {
                            AnchorPoint = Vector2.new(0.5, 0.5),
                            name = "icons/navigation/close",
                            Position = UDim2.fromScale(0.5, 0.5),
                            style = var2.Color.ActionEmphasis.Foreground,
                            ZIndex = 2
                        })
                    }
                )
            }
        ),
        SearchBar = React.createElement(TextInput, {
            iconLeading = MagnifyingGlass,
            text = text,
            placeholder = var3.GeneralSearchPlaceholder,
            label = "",
            onChanged = onChanged,
            onReturnPressed = var25,
            onFocusLost = var25,
            LayoutOrder = 2,
            width = UDim.new(1, 0)
        }),
        ScrollView = React.createElement(ScrollView, {
            flexItem = {
                FlexMode = Enum.UIFlexMode.Shrink
            },
            layout = {
                FillDirection = Enum.FillDirection.Vertical,
                VerticalAlignment = Enum.VerticalAlignment.Top,
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                Padding = UDim.new(0, var2.Gap.Small)
            },
            LayoutOrder = 3,
            scroll = {
                AutomaticCanvasSize = Enum.AutomaticSize.Y,
                scrollBarVisibility = ScrollBarVisibility.None,
                ScrollingDirection = Enum.ScrollingDirection.Y
            },
            tag = "col align-x-left align-y-top size-full"
        }, var28)
    })
end

return MusicOverlay
