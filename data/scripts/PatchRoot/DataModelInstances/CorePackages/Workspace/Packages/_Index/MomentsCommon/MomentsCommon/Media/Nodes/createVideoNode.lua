-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:21:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCommon = script:FindFirstAncestor("MomentsCommon")
local MomentsCommonParent = MomentsCommon.Parent

local React = require(MomentsCommonParent.React)
local Signals = require(MomentsCommonParent.Signals)
local SignalsReact = require(MomentsCommonParent.SignalsReact)

local _MediaTypes = require(MomentsCommon.Media.MediaTypes)
local _mediaNodeRegistry = require(MomentsCommon.Media.mediaNodeRegistry)
local getFitSize = require(MomentsCommon.Utils.getFitSize)
local FFlagMomentsPreloadVideoPlayerInstance = require(MomentsCommon.Flags.FFlagMomentsPreloadVideoPlayerInstance)
local FFlagMomentsVideoPermissionContextFix = require(MomentsCommon.Flags.FFlagMomentsVideoPermissionContextFix)
local FFlagMomentsVideoLoadAsyncLoadingFix = require(MomentsCommon.Flags.FFlagMomentsVideoLoadAsyncLoadingFix)
local FFlagMomentsOptimisticProfilePending = require(MomentsCommonParent.SharedFlags).FFlagMomentsOptimisticProfilePending

local useSignalState = SignalsReact.useSignalState
local createSignal = Signals.createSignal
local createComputed = Signals.createComputed

local signal = createSignal(Enum.ScaleType.Crop)

local function VideoSurface(tbl1)
    local var1 = useSignalState(tbl1.getItemSize)

    local getResolution = tbl1.getResolution
    local var2 = React.useMemo(function()
        return createComputed(function(arg1)
            return getResolution(arg1)
        end)
    end, { getResolution })
    local var3 = useSignalState(var2)
    local var4 = useSignalState(tbl1.getScaleType or signal)

    local uDim2 = UDim2.fromScale(1, 1)
    local stretch = Enum.ScaleType.Stretch
    if var4 ~= Enum.ScaleType.Fit then
        stretch = Enum.ScaleType.Crop
    elseif var3 ~= nil and var3.X > 0 and var3.Y > 0 then
        uDim2 = getFitSize(var1, var3)
    end

    return React.createElement("VideoDisplay", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = uDim2,
        BackgroundTransparency = 1,
        ScaleType = stretch,
        ZIndex = tbl1.zIndex,
        ref = tbl1.setSurface
    }, {
        Corner = if tbl1.cornerRadius ~= nil then React.createElement("UICorner", { CornerRadius = UDim.new(0, tbl1.cornerRadius) }) elseif tbl1.surfaceCornerRadius == nil then nil else React.createElement("UICorner", { CornerRadius = tbl1.surfaceCornerRadius })
    })
end

local function defaultObserveLoaded(arg1)
    return {
        getIsLoaded = function()
            return arg1.IsLoaded
        end,
        connect = function(callback)
            local connection = arg1:GetPropertyChangedSignal("IsLoaded"):Connect(function()
                callback(arg1.IsLoaded)
            end)
            return function()
                connection:Disconnect()
            end
        end
    }
end

return {
    kind = "video",
    create = function(arg1, arg2) -- name: createVideoNode
        local id = arg1.id
        local content = arg1.content
        local var1 = content
        if FFlagMomentsVideoPermissionContextFix then
            var1 = arg1.preloadContent or content
        end

        local var2, var3 = createSignal(arg1.region)
        local parent = arg1.parent
        local zIndex = arg1.zIndex or 0
        local cornerRadius = arg1.cornerRadius

        local runService = arg2.runService
        local contentProvider = arg2.contentProvider

        local var4 = arg2.observeLoaded or defaultObserveLoaded

        local var5 = arg2.loadVideo or function(arg3)
            return arg3:LoadAsync()
        end

        local function getRegionStart() -- Luacid: Inlined by compiler; 7 call sites recovered
            local var6 = var2(false)
            return if var6 == nil then 0 else var6.startTime
        end

        local var6, var7 = createSignal(false)
        local var8, var9 = createSignal(false)
        local var10, var11 = createSignal(false)

        local getIsLoaded, var13 = createSignal(false)

        local getFailureReason, var15 = createSignal(nil)
        local getResolution, var17 = createSignal(nil)
        local getTimeLength, var19 = createSignal(0)
        local getPosition, var21 = createSignal(0)

        local getResourceLevel = createComputed(function(arg3): string
            return if var10(arg3) then "Playing" elseif var8(arg3) then "Decoded" elseif var6(arg3) then "Downloaded" else "Idle"
        end)

        local getDuration = createComputed(function(arg3)
            local var22 = var2(arg3)
            if var22 ~= nil then
                return var22.endTime - var22.startTime
            end
            return getTimeLength(arg3)
        end)

        local var22 = nil
        local var23 = nil
        local var24 = nil
        local tbl1 = {}
        local var25 = nil
        local var26 = nil
        local connection = nil
        local bool1 = false
        local bool2 = false
        local bool3 = false
        local bool4 = false
        local bool5 = false
        local bool6 = false
        local bool7 = false
        local var27 = nil
        local bool8 = false
        local bool9 = false

        local num1 = 0
        local bool10 = false

        local function regionEnd() -- Luacid: Inlined by compiler; 3 call sites recovered
            local var28 = var2(false)
            if var28 ~= nil then
                return var28.endTime
            end

            return (getTimeLength(false))
        end

        local function applyLoopingMode() -- Luacid: Inlined by compiler; 3 call sites recovered
            local var28 = var22
            if not var28 then
                return
            end
            local var29 = var2(false)
            local var30 = getTimeLength(false)
            local looping = var29 == nil or var30 > 0 and var29.startTime <= 0.05 and var29.endTime >= var30 - 0.05
            bool1 = looping
            var28.Looping = looping
        end

        local function ensureWire() -- Luacid: Inlined by compiler; 2 call sites recovered
            local sourceInstance = var22
            local targetInstance = var24
            if not bool2 or not sourceInstance or not targetInstance or var23 then
                return
            end

            local wire = Instance.new("Wire")
            wire.SourceInstance = sourceInstance
            wire.TargetInstance = targetInstance
            wire.Parent = sourceInstance
            var23 = wire
        end

        local function tearWire() -- Luacid: Inlined by compiler; 3 call sites recovered
            if var23 then
                var23:Destroy()
                var23 = nil
            end
        end

        local function onStep()
            local var28 = var22
            if not var28 then
                return
            end

            local regionStart = getRegionStart()
            local timePosition = var28.TimePosition

            if not bool1 and regionEnd() - 0.05 <= timePosition then
                var28.TimePosition = regionStart
                timePosition = regionStart
            end
            var21(timePosition - regionStart)
        end

        local function startPlaybackLoop() -- Luacid: Inlined by compiler; 2 call sites recovered
            if connection then
                return
            end
            connection = runService.RenderStepped:Connect(onStep)
        end

        local function stopPlaybackLoop() -- Luacid: Inlined by compiler; 3 call sites recovered
            if connection then
                connection:Disconnect()
                connection = nil
            end
        end

        local function startPlayerPlaybackIfReady()
            local var28 = var22

            if not bool7
                or var10(false)
                or not bool2
                or var28 == nil
                or FFlagMomentsPreloadVideoPlayerInstance and not (bool6 or getIsLoaded(false))
            then
                return
            end
            var28:Play()
            var11(true)
            startPlaybackLoop()
        end

        local function createPlayer(): VideoPlayer -- Luacid: Inlined by compiler; 2 call sites recovered
            local videoPlayer = Instance.new("VideoPlayer")
            videoPlayer.Name = "VideoPlayer"
            videoPlayer.Looping = false
            videoPlayer.InternalVideoUsage = Enum.InternalVideoUsage.WatchPage
            videoPlayer.VideoContent = content
            if FFlagMomentsPreloadVideoPlayerInstance then
                videoPlayer.TimePosition = getRegionStart()
            end
            videoPlayer.Parent = parent
            var22 = videoPlayer
            return videoPlayer
        end

        local function runLoad(arg3, arg4, bool11: boolean)
            if bool10 or var22 ~= arg3 or not bool2 then
                return
            end
            local success, result = pcall(var5, arg3)
            if bool10 or var22 ~= arg3 or not bool2 then
                return
            end

            if not success then
                var15(`video load errored: {tostring(result)}`)
                return
            end

            if result == Enum.AssetFetchStatus.Success then
                bool6 = true
                var13(arg4.getIsLoaded())
                var15(nil)
                startPlayerPlaybackIfReady()
                return
            end

            if not FFlagMomentsVideoLoadAsyncLoadingFix or result ~= Enum.AssetFetchStatus.Loading or bool11 then
                var15(`video load failed: {result.Name}`)
                return
            end

            var13(arg4.getIsLoaded())
            if bool3 and not bool4 then
                bool9 = true
                return
            end
            runLoad(arg3, arg4, true)
        end

        local function startLoadIfReady()
            local var28 = var22
            local var29 = var25
            if bool10 or not bool2 or bool5 or var28 == nil or var29 == nil then
                return
            end

            if not FFlagMomentsPreloadVideoPlayerInstance or not bool3 or bool4 or bool8 then
                var27 = nil
                bool5 = true
                bool6 = false

                task.spawn(runLoad, var28, var29, false)
                return
            end

            if var27 ~= nil then
                return
            end

            var27 = var29

            task.delay(2, function()
                if var27 ~= var29 then
                    return
                end
                var27 = nil
                if bool10 or not bool2 or var22 ~= var28 or var25 ~= var29 then
                    return
                end
                bool8 = true
                startLoadIfReady()
            end)
        end

        return {
            id = id,
            kind = "video",
            usesDecoder = true,
            zIndex = zIndex,
            audioStem = { stemId = id, defaultVolume = 1 },
            assets = function()
                return { var1 }
            end,
            download = function()
                local num2 = num1
                if FFlagMomentsPreloadVideoPlayerInstance then
                    local var28 = var22 or createPlayer()
                    bool3 = true

                    pcall(function()
                        contentProvider:PreloadAsync({ var28 })
                    end)
                    if bool10 or num2 ~= num1 or var22 ~= var28 then
                        return
                    end
                    bool4 = true
                    if FFlagMomentsVideoLoadAsyncLoadingFix and bool9 then
                        bool9 = false
                        local var29 = var25
                        if bool2 and var29 ~= nil and not var29.getIsLoaded() then
                            task.spawn(runLoad, var28, var29, true)
                        end
                    end
                elseif not FFlagMomentsOptimisticProfilePending or var1.Uri ~= nil then
                    contentProvider:PreloadAsync({ var1.Uri })
                end
                if bool10 or num2 ~= num1 then
                    return
                end
                var7(true)
                startLoadIfReady()
            end,
            decode = function()
                if bool10 or bool2 then
                    return
                end
                var15(nil)

                local var28 = var22 or createPlayer()

                local var29 = var4(var28)
                var25 = var29
                var13(var29.getIsLoaded())
                var26 = var29.connect(function(arg3)
                    var13(arg3)
                    if arg3 then
                        startPlayerPlaybackIfReady()
                    end
                end)

                local function readResolution() -- Luacid: Inlined by compiler; 1 call site recovered
                    local resolution = var28.Resolution
                    local var30 = var17

                    if not (resolution.X > 0 and resolution.Y > 0) then
                        resolution = nil
                    end

                    var30(resolution)
                end

                readResolution()
                table.insert(tbl1, var28:GetPropertyChangedSignal("Resolution"):Connect(readResolution))

                var19(var28.TimeLength)

                local tbl2 = tbl1
                local timeLengthChanged = var28:GetPropertyChangedSignal("TimeLength")

                table.insert(tbl2, timeLengthChanged:Connect(function()
                    var19(var28.TimeLength)
                    applyLoopingMode()
                end))

                bool2 = true
                applyLoopingMode()
                ensureWire()
                startLoadIfReady()
                var9(true)
            end,
            releaseDecoder = function()
                local var28 = var22
                if not (var28 and bool2) then
                    return
                end

                bool2 = false
                var27 = nil
                bool9 = false
                bool7 = false
                stopPlaybackLoop()
                var11(false)
                tearWire()

                if var26 then
                    var26()
                    var26 = nil
                end
                var25 = nil
                for _, value in tbl1 do
                    value:Disconnect()
                end
                table.clear(tbl1)

                if not (FFlagMomentsPreloadVideoPlayerInstance and bool3) or bool4 or bool5 then
                    var22 = nil
                    var28:Destroy()
                end
                bool5 = false
                bool6 = false

                var9(false)
                var13(false)
                var15(nil)
                var21(0)
            end,
            getResourceLevel = getResourceLevel,
            getAudioSource = function()
                local var28 = var22
                assert(var28 and bool2, "createVideoNode: getAudioSource() requires decode() first")
                return var28
            end,
            render = function(arg3)
                return React.createElement(VideoSurface, {
                    getItemSize = arg3.getItemSize,
                    getResolution = arg3.getResolution,
                    getScaleType = arg3.getScaleType,
                    setSurface = arg3.setSurface,
                    zIndex = zIndex,
                    cornerRadius = cornerRadius,
                    surfaceCornerRadius = arg3.cornerRadius
                })
            end,
            play = function()
                local var28 = var22
                if not (var28 and bool2) then
                    return
                end

                var28.TimePosition = getRegionStart()
                var21(0)
                if FFlagMomentsPreloadVideoPlayerInstance then
                    bool7 = true
                    startPlayerPlaybackIfReady()
                    return
                end
                var28:Play()
                var11(true)
                startPlaybackLoop()
            end,
            pause = function()
                local var28 = var22
                if FFlagMomentsPreloadVideoPlayerInstance then
                    bool7 = false
                end
                if not (var28 and bool2) then
                    return
                end
                if not FFlagMomentsPreloadVideoPlayerInstance or var10(false) then
                    var28:Pause()
                end
                var11(false)
                stopPlaybackLoop()
            end,
            seek = function(num2: number)
                local var28 = var22
                if not var28 then
                    return
                end

                local regionStart = getRegionStart()
                local timePosition = math.clamp(regionStart + num2, regionStart, (regionEnd()))
                var28.TimePosition = timePosition
                var21(timePosition - regionStart)
            end,
            setRegion = function(tbl2)
                var3(tbl2)
                applyLoopingMode()
                local var28 = var22
                if var28 ~= nil then
                    local regionStart = getRegionStart()
                    local timePosition = math.clamp(var28.TimePosition, regionStart, (regionEnd()))
                    var28.TimePosition = timePosition
                    var21(timePosition - regionStart)
                end
            end,
            dispose = function()
                if bool10 then
                    return
                end
                bool10 = true
                num1 += 1
                bool2 = false
                var27 = nil
                bool9 = false
                bool5 = false
                bool6 = false
                bool7 = false
                stopPlaybackLoop()
                tearWire()

                if var26 then
                    var26()
                    var26 = nil
                end
                var25 = nil
                for _, value in tbl1 do
                    value:Disconnect()
                end
                table.clear(tbl1)
                if var22 then
                    var22:Destroy()
                    var22 = nil
                end

                var24 = nil
            end,
            getIsLoaded = getIsLoaded,
            getFailureReason = getFailureReason,
            getResolution = getResolution,
            getTimeLength = getTimeLength,
            getDuration = getDuration,
            getPosition = getPosition,
            isPlaybackReady = function()
                return not FFlagMomentsPreloadVideoPlayerInstance or getIsLoaded(false)
            end,
            setSurface = function(arg3)
                if arg3 == var24 then
                    return
                end

                tearWire()
                var24 = arg3
                ensureWire()
            end
        }
    end
}
