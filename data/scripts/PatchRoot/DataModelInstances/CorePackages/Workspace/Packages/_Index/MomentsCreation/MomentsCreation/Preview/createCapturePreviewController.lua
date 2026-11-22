-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:30:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreation = script:FindFirstAncestor("MomentsCreation")
local MomentsCreationParent = MomentsCreation.Parent

local Signals = require(MomentsCreationParent.Signals)

local _CreationFlowTypes = require(MomentsCreation.Types.CreationFlowTypes)

local createSignal = Signals.createSignal

local function createCapturePreviewController(tbl1, arg1, arg2)
    local var1, setPosition = createSignal(0)
    local var3, setDuration = createSignal(0)
    local var5, setTimeLength = createSignal(0)
    local var7, setIsPlaying = createSignal(true)
    local var9, var10 = createSignal(false)
    local var11, setReadiness = createSignal("Loading")

    local var13, setMediaController = createSignal(nil)

    local var15 = nil

    local function getRegion(arg3) -- Luacid: Inlined by compiler; 3 call sites recovered
        if arg1 ~= nil then
            return (arg1(arg3))
        end

        return nil
    end

    local function getIsMuted(arg3) -- Luacid: Inlined by compiler; 1 call site recovered
        local var16 = var13(arg3)
        if var16 ~= nil then
            return var16.getState(arg3).isMuted
        end
        return var9(arg3)
    end

    local function play()
        local var16 = var13(false)
        if var16 ~= nil then
            if not var16.getState(false).isPlaying then
                var16.play()
            end

            return
        end

        if var7(false) then
            return
        end

        setIsPlaying(true)
        if var15 ~= nil then
            var15.play()
        end
    end

    local function pause() -- Luacid: Inlined by compiler; 1 call site recovered
        local var16 = var13(false)
        if var16 ~= nil then
            var16.pause()
            return
        end

        if not var7(false) then
            return
        end

        setIsPlaying(false)
        if var15 ~= nil then
            var15.pause()
        end
    end

    local function setMuted(bool1: boolean) -- Luacid: Inlined by compiler; 1 call site recovered
        local var16 = var13(false)
        if var16 ~= nil then
            var16.audio.setMasterMuted(bool1)
            return
        end
        var10(bool1)
        if var15 ~= nil and var15.setMuted ~= nil then
            var15.setMuted(bool1)
        end
    end

    return {
        getCapture = tbl1.getSelectedCapture,
        getReadiness = function(arg3)
            local var16 = var13(arg3)
            if var16 ~= nil then
                return var16.getState(arg3).readiness
            end
            return var11(arg3)
        end,
        playback = {
            getPosition = function(arg3)
                local var16 = var13(arg3)
                if var16 ~= nil then
                    return var16.getPosition(arg3)
                end

                local var17 = getRegion(arg3)

                if var17 == nil then
                    return var1(arg3)
                end

                local num1 = math.max(0, var17.endTime - var17.startTime)
                return math.clamp(var1(arg3) - var17.startTime, 0, num1)
            end,
            getDuration = function(arg3)
                local var16 = var13(arg3)
                if var16 ~= nil then
                    return var16.getState(arg3).duration
                end

                local var17 = getRegion(arg3)

                if var17 == nil then
                    return var3(arg3)
                end

                return math.max(0, var17.endTime - var17.startTime)
            end,
            getTimeLength = function(arg3)
                local var16 = var13(arg3)
                if var16 ~= nil then
                    return var16.getState(arg3).timeLength
                end
                return var5(arg3)
            end,
            getRegion = getRegion,
            getMusic = function(arg3)
                if arg2 ~= nil then
                    return (arg2(arg3))
                end

                return nil
            end,
            getIsPlaying = function(arg3)
                local var16 = var13(arg3)
                if var16 ~= nil then
                    return var16.getState(arg3).isPlaying
                end
                return var7(arg3)
            end,
            getIsMuted = getIsMuted,
            play = play,
            pause = pause,
            toggle = function()
                local var16 = var13(false)
                if var16 ~= nil then
                    var16.toggle()
                    return
                end

                if var7(false) then
                    pause()
                else
                    play()
                end
            end,
            seek = function(num1: number)
                local var16 = var13(false)
                if var16 ~= nil then
                    var16.seek(num1)
                    return
                end

                local var17 = getRegion(false)
                local var18 = num1 + (if var17 == nil then 0 else var17.startTime)
                setPosition(var18)
                if var15 ~= nil then
                    var15.seek(var18)
                end
            end,
            setMuted = setMuted,
            toggleMute = function()
                setMuted(not getIsMuted(false))
            end
        },
        setMediaController = setMediaController,
        setRegion = function(tbl2)
            local var16 = var13(false)
            if var16 ~= nil then
                var16.setRegion(tbl2)
            end
        end,
        bindEngine = function(tbl2)
            var15 = tbl2
            if tbl2 == nil then
                return
            end

            if var7(false) then
                tbl2.play()
                return
            end
            tbl2.pause()
        end,
        setPosition = setPosition,
        setDuration = setDuration,
        setTimeLength = setTimeLength,
        setIsPlaying = setIsPlaying,
        setReadiness = setReadiness
    }
end

return createCapturePreviewController
