-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:21:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCommon = script:FindFirstAncestor("MomentsCommon")
local MomentsCommonParent = MomentsCommon.Parent

local Cryo = require(MomentsCommonParent.Cryo)
local Signals = require(MomentsCommonParent.Signals)

local _MomentsTypes = require(MomentsCommonParent.MomentsTypes)
local _MediaTypes = require(MomentsCommon.Media.MediaTypes)
local createAudioGraph = require(MomentsCommon.Media.createAudioGraph)
local mediaRoot = require(MomentsCommon.Media.mediaRoot)
local _mediaNodeRegistry = require(MomentsCommon.Media.mediaNodeRegistry)
local defaultMediaNodeRegistry = require(MomentsCommon.Media.defaultMediaNodeRegistry)
local preloadConstants = require(MomentsCommon.Media.Preload.preloadConstants)
local FFlagMomentsVideoPermissionContextFix = require(MomentsCommon.Flags.FFlagMomentsVideoPermissionContextFix)
local FFlagMomentsOptimisticProfilePending = require(MomentsCommonParent.SharedFlags).FFlagMomentsOptimisticProfilePending
local FFlagMomentsRenderAvatarPostsInFeed = require(MomentsCommonParent.SharedFlags).FFlagMomentsRenderAvatarPostsInFeed

local _createVideoNode = require(MomentsCommon.Media.Nodes.createVideoNode)
local _createScreenshotNode = require(MomentsCommon.Media.Nodes.createScreenshotNode)
local _createMusicNode = require(MomentsCommon.Media.Nodes.createMusicNode)
local _createTtsNode = require(MomentsCommon.Media.Nodes.createTtsNode)

local createSignal = Signals.createSignal
local createComputed = Signals.createComputed

local GetFFlagMomentsStickerButton = require(MomentsCommon.Flags.GetFFlagMomentsStickerButton)

local loopEpsilonSeconds = preloadConstants.loopEpsilonSeconds

local function createMomentMediaController(arg1, tbl1)
    local services = tbl1.services
    local var1 = tbl1.registry or defaultMediaNodeRegistry()
    local getHasVideoPreview = arg1.captureType == Enum.CaptureType.Video

    local edits = arg1.edits
    local ttsAudios = if edits == nil then nil else edits.ttsAudios
    local bool2 = false
    if ttsAudios ~= nil then
        for _, ttsAudio in ttsAudios do
            if ttsAudio.assetId ~= nil then
                bool2 = true
                break
            end
        end
    end

    local localTts = arg1.localTts
    if localTts ~= nil then
        bool2 = true
    end

    local var2 = mediaRoot(arg1.momentId, tbl1.parent)
    local folder = var2.folder
    local audioGraph = createAudioGraph(folder, tbl1.audioDeviceOutput, { masterVolume = tbl1.masterVolume, enableDucking = bool2 })

    local tbl2 = {}
    local tbl3 = {}

    local function addNode(arg2) -- Luacid: Inlined by compiler; 7 call sites recovered
        table.insert(tbl2, arg2)
        tbl3[arg2.id] = arg2
    end

    local var3 = nil
    local var4 = nil
    if getHasVideoPreview then
        local var5 = var1.create("video", {
            id = "video",
            kind = "video",
            content = arg1.content,
            preloadContent = if FFlagMomentsVideoPermissionContextFix then arg1.preloadContent else nil,
            region = if edits == nil then nil else edits.trim,
            parent = folder,
            zIndex = 0,
            cornerRadius = arg1.cornerRadius
        }, services)

        var3 = var5
        addNode(var5)
    else
        local var5 = var1.create("screenshot", {
            id = "screenshot",
            kind = "screenshot",
            image = if FFlagMomentsRenderAvatarPostsInFeed and arg1.isExternalBase == true then nil else arg1.content.Uri,
            imageContent = if FFlagMomentsRenderAvatarPostsInFeed and arg1.isExternalBase == true or FFlagMomentsOptimisticProfilePending then arg1.content else nil,
            poster = if arg1.posterContent == nil then nil else arg1.posterContent.Uri,
            posterContent = if FFlagMomentsOptimisticProfilePending then arg1.posterContent else nil,
            parent = folder
        }, services)

        var4 = var5
        addNode(var5)
    end

    local var5 = nil
    if edits ~= nil and edits.music ~= nil then
        local var6 = var1.create(
            "music",
            {
                id = "music",
                kind = "music",
                assetId = edits.music.assetId,
                startTime = edits.music.startTime,
                parent = folder
            },
            services
        )
        var5 = var6
        addNode(var6)
    end

    local bool3 = var5 ~= nil

    local tbl4 = {}
    if ttsAudios ~= nil then
        for k, ttsAudio in ttsAudios do
            if ttsAudio.assetId == nil then
                continue
            end

            local var6 = var1.create("tts", {
                id = `tts:{k - 1}`,
                kind = "tts",
                assetId = ttsAudio.assetId,
                assetAccessContext = ttsAudio.assetAccessContext,
                startTime = ttsAudio.startTime,
                parent = folder
            }, services)

            table.insert(tbl4, var6)
            addNode(var6)
        end
    end

    if localTts ~= nil then
        local var6 = var1.create("tts", {
            id = `tts:{#tbl4}`,
            kind = "tts",
            text = localTts.text,
            voiceId = localTts.voiceId,
            startTime = localTts.startTime,
            parent = folder
        }, services)

        table.insert(tbl4, var6)
        addNode(var6)
    end

    if edits ~= nil and edits.textOverlays ~= nil then
        for k, overlay in edits.textOverlays do
            local id = `text:{k - 1}`
            addNode((var1.create("text", { id = id, kind = "text", overlay = overlay }, services)))
        end
    end

    if GetFFlagMomentsStickerButton() and edits ~= nil and edits.stickerOverlays ~= nil then
        for k, overlay in edits.stickerOverlays do
            local id = `sticker:{k - 1}`
            addNode((var1.create("sticker", { id = id, kind = "sticker", overlay = overlay }, services)))
        end
    end

    local tbl5 = {}
    for _, value in tbl2 do
        if value.usesDecoder then
            table.insert(tbl5, value)
        end
    end

    local tbl6 = {}
    for _, value in tbl2 do
        local render = value.render
        if render == nil then
            continue
        end

        table.insert(tbl6, { id = value.id, zIndex = value.zIndex or 0, render = render })
    end

    table.sort(tbl6, function(arg2, arg3): boolean
        return arg2.zIndex < arg3.zIndex
    end)

    local getVisualLayers = createSignal(tbl6)

    local tbl7 = {}
    local function addStem(arg2) -- Luacid: Inlined by compiler; 2 call sites recovered
        local audioStem = arg2.audioStem
        local getAudioSource = arg2.getAudioSource
        if audioStem == nil or getAudioSource == nil or tbl7[audioStem.stemId] ~= nil then
            return
        end
        tbl7[audioStem.stemId] = audioGraph.addStem(audioStem.stemId, getAudioSource(), audioStem.defaultVolume, audioStem.role)
    end
    local function removeStem(arg2) -- Luacid: Inlined by compiler; 1 call site recovered
        local audioStem = arg2.audioStem
        if audioStem == nil then
            return
        end
        local var6 = tbl7[audioStem.stemId]
        if var6 ~= nil then
            var6()
            tbl7[audioStem.stemId] = nil
        end
    end

    for _, value in tbl2 do
        if value.getAudioSource ~= nil and not value.usesDecoder then
            addStem(value)
        end
    end

    local var6, var7 = createSignal(false)
    local var8, var9 = createSignal(false)
    local var10, var11 = createSignal(false)
    local var12, var13 = createSignal("Loading")
    local var14, var15 = createSignal(nil)

    local getUserToggleNonce, var17 = createSignal(0)

    local var18, var19 = createSignal(false)

    local bool4 = false

    local var20 = nil
    local getPosition = if var3 ~= nil then var3.getPosition else var4.getPosition

    local getResourceLevel = createComputed(function(arg2): string
        return if var10(arg2) then "Playing" elseif var8(arg2) then "Decoded" elseif var6(arg2) then "Downloaded" else "Idle"
    end)

    local getState = createComputed(function(arg2)
        local resolution = nil
        local failureReason, var21, duration, var22

        if var3 ~= nil then
            failureReason = var3.getFailureReason(arg2)
            var21 = if failureReason ~= nil then "Failed" elseif var3.getIsLoaded(arg2) then "Ready" elseif var8(arg2) or var6(arg2) then "Loading" else "Idle"

            resolution = var3.getResolution(arg2)
            duration = var3.getDuration(arg2)
            var22 = var3.getTimeLength(arg2)
        else
            local var23 = var4
            if FFlagMomentsRenderAvatarPostsInFeed and arg1.isExternalBase == true then
                var21 = var12(arg2)
                failureReason = var14(arg2)
            else
                failureReason = var23.getFailureReason(arg2)
                var21 = if failureReason ~= nil then "Failed" elseif var23.getIsImageLoaded(arg2) then "Ready" else "Loading"
            end

            duration = var23.getDuration()
            var22 = var23.getDuration()
        end

        return {
            readiness = var21,
            resolution = resolution,
            duration = duration,
            timeLength = var22,
            isPlaying = var10(arg2),
            isMuted = var18(arg2),
            failureReason = failureReason
        }
    end, Cryo.Dictionary.equals)

    local connection = nil
    local num1 = 0
    local function startRealignLoop() -- Luacid: Inlined by compiler; 1 call site recovered
        if connection ~= nil or var5 == nil and #tbl4 == 0 then
            return
        end
        num1 = getPosition(false)
        connection = services.runService.RenderStepped:Connect(function()
            if bool4 then
                return
            end
            local position = getPosition(false)
            if position < num1 - loopEpsilonSeconds then
                if var5 ~= nil then
                    var5.realignToRegionStart()
                end
                for _, value in tbl4 do
                    value.realignToRegionStart()
                end
            end
            for _, value in tbl4 do
                value.syncToClock(position)
            end
            num1 = position
        end)
    end
    local function stopRealignLoop() -- Luacid: Inlined by compiler; 2 call sites recovered
        if connection ~= nil then
            connection:Disconnect()
            connection = nil
        end
    end

    local function isVideoReadyForPlayback() -- Luacid: Inlined by compiler; 2 call sites recovered
        return var3 == nil or var3.isPlaybackReady()
    end

    local function play()
        if bool4 or not isVideoReadyForPlayback() then
            return
        end

        local var21 = var20
        var20 = nil

        if var5 ~= nil then
            var5.realignToRegionStart()
        end
        for _, value in tbl4 do
            value.realignToRegionStart()
        end

        if var4 ~= nil then
            var4.seek(0)
        end
        for _, value in tbl2 do
            local play2 = value.play
            if play2 ~= nil then
                play2()
            end
        end

        if var21 ~= nil and var21 > 0 then
            for _, value in tbl2 do
                local seek = value.seek
                if seek ~= nil then
                    seek(var21)
                end
            end
        end

        for _, value in tbl4 do
            value.syncToClock(getPosition(false))
        end
        var11(true)
        startRealignLoop()
    end

    local function pauseAndRemember(num2: number)
        if bool4 then
            return
        end
        if var3 ~= nil then
            var20 = math.max(0, getPosition(false) - num2)
        end
        for _, value in tbl2 do
            local pause = value.pause
            if pause ~= nil then
                pause()
            end
        end
        var11(false)
        stopRealignLoop()
    end

    local function setMasterMuted(bool5: boolean) -- Luacid: Inlined by compiler; 1 call site recovered
        if bool4 then
            return
        end
        audioGraph.setMasterMuted(bool5)
        var19(bool5)
    end

    return {
        getState = getState,
        getPosition = getPosition,
        getUserToggleNonce = getUserToggleNonce,
        getVisualLayers = getVisualLayers,
        getResourceLevel = getResourceLevel,
        audio = {
            setVolume = function(str1: string, num2: number)
                if not bool4 then
                    audioGraph.setVolume(str1, num2)
                end
            end,
            setMuted = function(str1: string, bool5: boolean)
                if not bool4 then
                    audioGraph.setMuted(str1, bool5)
                end
            end,
            setMasterMuted = setMasterMuted
        },
        download = function()
            if bool4 then
                return
            end

            for _, value in tbl2 do
                value.download()
            end

            if bool4 then
                return
            end
            var7(true)
        end,
        decode = function()
            if bool4 then
                return
            end

            for _, value in tbl5 do
                local decode2 = value.decode
                if decode2 ~= nil then
                    decode2()
                end

                addStem(value)
            end

            if bool3 and tbl7.video ~= nil then
                audioGraph.setMuted("video", true)
            end
            var9(true)
        end,
        releaseDecoder = function()
            if bool4 then
                return
            end
            for _, value in tbl5 do
                removeStem(value)
                local releaseDecoder2 = value.releaseDecoder
                if releaseDecoder2 ~= nil then
                    releaseDecoder2()
                end
            end
            var9(false)
            var11(false)
        end,
        play = play,
        pause = function(num2: number?)
            pauseAndRemember(num2 or 2)
        end,
        toggle = function()
            if bool4 or not var10(false) and not isVideoReadyForPlayback() then
                return
            end

            if var10(false) then
                pauseAndRemember(0)
            else
                play()
            end

            var17(getUserToggleNonce(false) + 1)
        end,
        seek = function(num2: number)
            if bool4 then
                return
            end
            if var10(false) then
                local duration = getState(false).duration
                num2 = if duration > 0 and duration <= num2 then 0 else num2
            end

            for _, value in tbl2 do
                local seek2 = value.seek
                if seek2 ~= nil then
                    seek2(num2)
                end
            end
        end,
        setRegion = function(arg2)
            if bool4 then
                return
            end
            if var3 ~= nil then
                var3.setRegion(arg2)
            end
        end,
        setActive = function(bool5: boolean)
            if bool5 then
                var20 = nil
            end
            setMasterMuted(not bool5)
        end,
        setExternalBaseReadiness = function(arg2, str1: string?)
            if bool4 or not FFlagMomentsRenderAvatarPostsInFeed or arg1.isExternalBase ~= true then
                return
            end
            local var21 = var15

            if arg2 ~= "Failed" then
                str1 = nil
            end

            var21(str1)
            var13(arg2)
        end,
        setSurface = function(str1: string, arg2)
            if bool4 then
                return
            end
            local var21 = tbl3[str1]
            if var21 ~= nil and var21.setSurface ~= nil then
                var21.setSurface(arg2)
            end
        end,
        getVideoPreviewSource = function(): {content: any, region: number}?
            if not getHasVideoPreview then
                return nil
            end
            return {
                content = arg1.content,
                region = if edits == nil then nil else edits.trim
            }
        end,
        getHasVideoPreview = function()
            return getHasVideoPreview
        end,
        dispose = function()
            if bool4 then
                return
            end
            bool4 = true
            stopRealignLoop()

            for _, value in tbl2 do
                value.dispose()
            end
            audioGraph.dispose()
            var2.dispose()
        end
    }
end
return createMomentMediaController
