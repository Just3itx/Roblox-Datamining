-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:51:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreation = script:FindFirstAncestor("MomentsCreation")
local MomentsCreationParent = MomentsCreation.Parent

local BuilderIcons = require(MomentsCreationParent.BuilderIcons)
local MusicPicker = require(MomentsCreationParent.MusicPicker)
local MomentsCommon = require(MomentsCreationParent.MomentsCommon)
local React = require(MomentsCreationParent.React)
local Signals = require(MomentsCreationParent.Signals)

local useAudioPlayback = require(MomentsCreation.Hooks.useAudioPlayback)
local MusicEditor = require(MomentsCreation.Components.MusicEditor)
local GetMusicStore = require(MomentsCreation.Stores.GetMusicStore)
local useCreationFlowStrings = require(MomentsCreation.Hooks.useCreationFlowStrings)
local _CreationFlowTypes = require(MomentsCreation.Types.CreationFlowTypes)
local _Music = require(MomentsCreation.Types.Music)
local _MomentsTypes = require(MomentsCreationParent.MomentsTypes)
local fireAnalyticsEvent = require(MomentsCreation.Analytics.fireAnalyticsEvent)
local makeCreationEventFields = require(MomentsCreation.Analytics.makeCreationEventFields)
local FFlagMomentsCreationMusicPickerTabs = require(MomentsCreation.Flags.FFlagMomentsCreationMusicPickerTabs)
local FFlagMomentsAudioSaveButton = MomentsCommon.Flags.FFlagMomentsAudioSaveButton

local EventNames = MomentsCommon.Analytics.EventNames
local SessionManager = MomentsCommon.Analytics.SessionManager
local FunnelEventNames = MomentsCommon.Analytics.FunnelEventNames
local useDeviceInsets = MomentsCommon.Hooks.useDeviceInsets

local MusicPicker2 = MusicPicker.MusicPicker
local MusicPickerContext = MusicPicker.MusicPickerContext

local useCallback = React.useCallback
local useEffect = React.useEffect
local useMemo = React.useMemo
local useState = React.useState

local function toItem(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    return {
        id = arg1.AssetId,
        title = arg1.Title,
        artist = arg1.Artist,
        thumbnailAssetId = arg1.AssetId
    }
end

local function mapStatus(str1: string): string -- Luacid: Inlined by compiler; 1 call site recovered
    return if str1 == "loading" then "loading" elseif str1 == "error" then "error" else "success"
end

local function useStoreContent()
    local musicStore = GetMusicStore()
    local var1 = useCreationFlowStrings()

    local var2, var3 = useState(musicStore.getResults(false))
    local var4, var5 = useState(musicStore.getSearchStatus(false))
    local isLoadingMore, var7 = useState(false)

    useEffect(function()
        return Signals.createEffect(function(arg1)
            var3(musicStore.getResults(arg1))
            var5(musicStore.getSearchStatus(arg1))
            var7(musicStore.getIsLoadingMore(arg1))
        end)
    end, {})

    return useMemo(function()
        local items = ({})
        for value, value2 in var2 do
            local tbl2 = toItem(value2)

            items[value] = tbl2
        end
        return {
            items = items,
            status = mapStatus(var4),
            emptyText = var1.MusicNoResults,
            errorText = var1.MusicSearchError,
            retryText = var1.GeneralCtaRetry,
            onRetry = musicStore.retry,
            onLoadMore = musicStore.loadMore,
            isLoadingMore = isLoadingMore
        }
    end, {
        var2,
        var4,
        var1,
        musicStore,
        isLoadingMore
    })
end

local function useSavedContent() -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = useCreationFlowStrings()
    return useMemo(function()
        return {
            items = {},
            status = "success",
            emptyState = {
                title = var1.MusicSavedEmptyTitle,
                subtitle = var1.MusicSavedEmptySubtitle,
                icon = BuilderIcons.Icon.Bookmark
            }
        }
    end, { var1 })
end

local function MusicPickerV2Container(tbl1)
    local controller = tbl1.controller
    local playback = controller.preview.playback
    local var1 = useCreationFlowStrings()
    local musicStore = GetMusicStore()
    local var2 = useDeviceInsets()
    local var3 = useStoreContent()
    local content = useSavedContent()
    local previewingId, var6 = useState(nil)
    local var7, var8 = useState(false)
    local savedIds, var10 = useState({})

    local initialQuery, var12 = useState("")

    local var13, var14 = useState(playback.getTimeLength(false))
    useEffect(function()
        return Signals.createEffect(function(arg1)
            var14(playback.getTimeLength(arg1))
        end)
    end, { playback })

    local musicEdit, var16 = useState(nil)
    useEffect(function()
        return Signals.createEffect(function(arg1)
            local activeSession = controller.getActiveSession(arg1)
            var16(if activeSession == nil then nil else activeSession.getDraft(arg1))
        end)
    end, { controller })

    local var17 = useAudioPlayback(previewingId ~= nil, previewingId, { autoplay = true, looping = false })

    useEffect(function()
        playback.pause()
        musicStore.search("", var13)
    end, { var13 })

    useEffect(function()
        if not var17.playback.isPlaying then
            var6(nil)
        end
    end, { var17.playback.isPlaying })

    local onClose = useCallback(function()
        playback.play()
        playback.setMuted(false)
        controller.discardActiveTool()
    end, { controller, playback })

    local onSelect = useCallback(function(assetId: number)
        local activeSession = controller.getActiveSession(false)
        if activeSession ~= nil then
            activeSession.update({ assetId = assetId, startTime = 0 })
        end
        var6(nil)
        var8(true)

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
        var8(false)
        playback.pause()
    end, { controller, playback })

    local onDone = useCallback(function()
        var8(false)
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

    local togglePreview = useCallback(function(num1: number)
        if previewingId == num1 then
            var6(nil)
            return
        end
        var6(num1)
        var17.playback.play()
    end, { previewingId or 0 })

    local toggleSaved = useCallback(function(num1: number)
        var10(function(arg1)
            local result = ({})
            for value, value2 in arg1 do
                if value ~= num1 then
                    result[value] = value2
                end
            end
            if not arg1[num1] then
                result[num1] = true
            end
            return result
        end)
    end, {})

    local onQueryChanged = useCallback(function(str1: string)
        var6(nil)
        var12(str1)
        musicStore.search(str1, var13)
    end, { musicStore, var13 })

    local onTabChanged = useCallback(function(_: string)
        var6(nil)
    end, {})

    local tabs = useMemo(function()
        local tbl2 = {{
            id = "trending",
            label = var1.MusicTabTrending,
            content = var3
        }}

        if FFlagMomentsAudioSaveButton then
            table.insert(tbl2, { id = "saved", label = "Saved", content = content })
        end

        return tbl2
    end, { var1, var3, content })

    local value = useMemo(function()
        return {
            previewingId = previewingId,
            togglePreview = togglePreview,
            savedIds = savedIds,
            toggleSaved = toggleSaved,
            showSaveButton = FFlagMomentsAudioSaveButton
        }
    end, {
        previewingId or 0,
        savedIds,
        togglePreview,
        toggleSaved
    })
    if var7 and musicEdit ~= nil then
        return React.createElement(MusicEditor, {
            controller = controller,
            musicEdit = musicEdit,
            onBack = onBack,
            onDone = onDone,
            onStartTimeChanged = onStartTimeChanged
        })
    end

    return React.createElement(MusicPickerContext.Provider, { value = value }, {
        Picker = React.createElement(MusicPicker2, {
            titleText = var1.EditingCtaMusic,
            searchPlaceholder = var1.GeneralSearchPlaceholder,
            showTabs = FFlagMomentsCreationMusicPickerTabs and FFlagMomentsAudioSaveButton,
            tabs = tabs,
            searchContent = var3,
            onQueryChanged = onQueryChanged,
            initialQuery = initialQuery,
            onTabChanged = onTabChanged,
            onSelect = onSelect,
            onClose = onClose,
            safeAreaInsets = {
                left = var2.left,
                right = var2.right
            },
            source = "moments"
        })
    })
end

return MusicPickerV2Container
