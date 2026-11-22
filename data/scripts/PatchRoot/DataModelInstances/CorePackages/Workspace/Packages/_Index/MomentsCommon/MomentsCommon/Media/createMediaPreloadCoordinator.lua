-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:21:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCommon = script:FindFirstAncestor("MomentsCommon")
local MomentsCommonParent = MomentsCommon.Parent

local Signals = require(MomentsCommonParent.Signals)
local FFlagMomentsAutoplayAmpPolicy = require(MomentsCommonParent.SharedFlags).FFlagMomentsAutoplayAmpPolicy

local _MediaTypes = require(MomentsCommon.Media.MediaTypes)
local _selectPreloadPolicy = require(MomentsCommon.Media.Preload.selectPreloadPolicy)
local _mediaTelemetry = require(MomentsCommon.Media.Telemetry.mediaTelemetry)
local createMomentMediaController = require(MomentsCommon.Media.createMomentMediaController)
local defaultMediaNodeRegistry = require(MomentsCommon.Media.defaultMediaNodeRegistry)
local _mediaNodeRegistry = require(MomentsCommon.Media.mediaNodeRegistry)
local GetFFlagMomentsRenderPostAssets = require(MomentsCommon.Flags.GetFFlagMomentsRenderPostAssets)

local createSignal = Signals.createSignal
local createEffect = Signals.createEffect

local function indexInWindow(num1: number, activeIndex: number, arg1): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return activeIndex - arg1.back <= num1 and num1 <= activeIndex + arg1.forward
end

local function createMediaPreloadCoordinator(arg1, arg2, arg3, audioDeviceOutput, services, tbl1)
    local tbl2 = tbl1 or {}
    local fFlagMomentsRenderPostAssets = GetFFlagMomentsRenderPostAssets()
    local var1 = services.now or os.clock

    local registry = tbl2.registry or defaultMediaNodeRegistry()

    local var3 = tbl2.createController or function(arg4)
        return createMomentMediaController(arg4, {
            services = services,
            audioDeviceOutput = audioDeviceOutput,
            registry = registry,
            parent = tbl2.parent,
            masterVolume = tbl2.masterVolume
        })
    end

    local tbl3 = ({})

    local var4 = nil

    local var5 = nil
    local bool1 = false

    local getControllerMap, var7 = createSignal({})

    local function publishControllerMap() -- Luacid: Inlined by compiler; 1 call site recovered
        local tbl4 = ({})
        for value, value2 in tbl3 do
            tbl4[value] = value2.controller
        end
        var7(tbl4)
    end

    local function scheduleDecodeRetry(str1: string, tbl4) -- Luacid: Inlined by compiler; 1 call site recovered
        if tbl4.retryScheduled or tbl4.decodeRetries >= arg2.maxDecodeRetries then
            return
        end
        tbl4.retryScheduled = true
        task.delay(arg2.decodeRetryDelayMs / 1000, function()
            tbl4.retryScheduled = false
            if bool1 or tbl3[str1] ~= tbl4 or var5 ~= str1 or not tbl4.decoded or not arg1.getPlaybackActive(false) then
                return
            end

            local readiness = tbl4.controller.getState(false).readiness

            if readiness == "Ready" or readiness == "Failed" then
                return
            end
            local tbl5 = tbl4
            tbl5.decodeRetries += 1

            tbl4.controller.releaseDecoder()
            tbl4.controller.decode()
            scheduleDecodeRetry(str1, tbl4)
        end)
    end

    local function reconcile(arg4)
        local items = arg1.getItems(arg4)
        local activeIndex = arg1.getActiveIndex(arg4)
        local playbackActive = arg1.getPlaybackActive(arg4)
        local canAutoPlay = if FFlagMomentsAutoplayAmpPolicy then arg1.getCanAutoPlay(arg4) else nil
        local item = items[activeIndex]
        local momentId = if item == nil then nil else item.momentId
        var5 = momentId

        local tbl4 = {}
        local tbl5 = {}
        local tbl6 = {}
        for k, item2 in items do
            if not indexInWindow(k, activeIndex, arg2.downloadWindow) then
                continue
            end

            if fFlagMomentsRenderPostAssets and item2.resolve ~= nil then
                item2 = item2.resolve(arg4) or item2
            end
            tbl4[item2.momentId] = true
            tbl6[item2.momentId] = item2

            if indexInWindow(k, activeIndex, arg2.decodeWindow) then
                tbl5[item2.momentId] = true
            end
        end

        local bool2 = false

        for value, value2 in tbl3 do
            local var8 = tbl6[value]

            if tbl4[value] and (not fFlagMomentsRenderPostAssets or var8 == nil or value2.sourceKey == var8.sourceKey) then
                continue
            end
            if var4 == value then
                var4 = nil
            end
            value2.controller.dispose()
            tbl3[value] = nil
            bool2 = true
        end

        for value in tbl4 do
            if tbl3[value] ~= nil then
                continue
            end

            local controller = var3(tbl6[value])
            local tbl7 = {
                controller = controller,
                sourceKey = if fFlagMomentsRenderPostAssets then tbl6[value].sourceKey else nil,
                active = nil,
                decoded = false,
                recordedTtff = false,
                decodeStartedAt = nil,
                decodeRetries = 0,
                retryScheduled = false
            }

            tbl3[value] = tbl7

            task.spawn(function()
                if bool1 or tbl3[value] ~= tbl7 then
                    return
                end
                controller.download()

                if not bool1 and tbl3[value] == tbl7 then
                    scheduleDecodeRetry(value, tbl7)
                end
            end)

            bool2 = true
        end

        if bool2 then
            publishControllerMap()
        end

        for value, value2 in tbl3 do
            local bool3 = tbl5[value] == true
            if bool3 and not value2.decoded then
                value2.decodeStartedAt = var1()
                value2.controller.decode()
                value2.decoded = true
            elseif not bool3 and value2.decoded then
                value2.controller.releaseDecoder()
                value2.decoded = false
            end
        end

        for value, value2 in tbl3 do
            local active = value == momentId
            if value2.active ~= active then
                value2.controller.setActive(active)
                value2.active = active
            end
        end

        local var8 = if momentId == nil then nil else tbl3[momentId]
        local bool3 = not (var8 == nil) and var8.controller.getState(arg4).readiness == "Ready"

        if FFlagMomentsAutoplayAmpPolicy then
            if var4 ~= nil and var4 ~= momentId then
                if tbl3[var4] ~= nil then
                    tbl3[var4].controller.pause()
                end
                var4 = nil
            end

            if var8 ~= nil and var8.controller.getState(arg4).isPlaying then
                var4 = momentId
            end
        end

        if not playbackActive or var8 == nil or not bool3 then
            if var4 ~= nil then
                if tbl3[var4] ~= nil then
                    tbl3[var4].controller.pause()
                end
                var4 = nil
            end

            return
        end

        if FFlagMomentsAutoplayAmpPolicy and not canAutoPlay or var4 == momentId then
            return
        end

        if var4 ~= nil and tbl3[var4] ~= nil then
            tbl3[var4].controller.pause()
        end

        var4 = momentId
        var8.controller.play()

        if var8.recordedTtff then
            return
        end

        var8.recordedTtff = true
        local decodeStartedAt = var8.decodeStartedAt
        if decodeStartedAt ~= nil and momentId ~= nil then
            arg3.recordTimeToFirstFrame({ momentId = momentId, durationSeconds = var1() - decodeStartedAt })
        end
    end

    local effect = createEffect(function(arg4)
        if bool1 then
            return
        end
        reconcile(arg4)
    end)

    return {
        getControllerFor = function(str1: string)
            local var8 = tbl3[str1]
            return if var8 == nil then nil else var8.controller
        end,
        getControllerMap = getControllerMap,
        dispose = function()
            if bool1 then
                return
            end
            bool1 = true
            effect()
            for _, value in tbl3 do
                value.controller.dispose()
            end
            table.clear(tbl3)
            var4 = nil
            var7({})
        end
    }
end
return createMediaPreloadCoordinator
