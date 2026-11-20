-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:10:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCommon = script:FindFirstAncestor("MomentsCommon")
local MomentsCommonParent = MomentsCommon.Parent

local Cryo = require(MomentsCommonParent.Cryo)
local React = require(MomentsCommonParent.React)

local useCallback = React.useCallback
local useEffect = React.useEffect
local useRef = React.useRef
local useState = React.useState
local useToggleState = require(MomentsCommon.Hooks.useToggleState)

local Signal = require(MomentsCommon.Utils.Signal)

local _Types = require(MomentsCommon.Types)

local tbl1 = {
    autoplay = false,
    looping = false,
    playbackRegion = NumberRange.new(0, math.huge)
}

local function useVideoPlayback(bool1: boolean, videoContent, tbl2)
    local var1 = Cryo.Dictionary.union(tbl1, tbl2 or {})

    local ref = useRef(nil)

    local var3 = useToggleState(false)
    local var4 = useToggleState(var1.autoplay)
    local var5 = useToggleState(false)

    local timeLength, var7 = useState(0)
    local var8, var9 = useState(0)

    local duration, var11 = useState(0)
    local elapsed, var13 = useState(0)

    local onVideoDidLoopSignalRef = useRef(Signal.new())
    local onVideoLoadedSignalRef = useRef(Signal.new())

    local seek = useCallback(function(num1: number)
        local current = ref.current
        if current then
            current.TimePosition = math.clamp(num1 + var1.playbackRegion.Min, 0, timeLength)
        end
    end, { timeLength, var1.playbackRegion })

    local var17 = useCallback(function()
        local current = ref.current
        if not current then
            return
        end

        onVideoLoadedSignalRef.current:fire()
        local var17 = var1.playbackRegion.Max - var1.playbackRegion.Min
        current.Volume = if var5.enabled then 0 else 0.2
        var11(math.min(var17, current.TimeLength))
        var7(current.TimeLength)
    end, { var1.playbackRegion, var5.enabled })

    local var18 = useCallback(function()
        if not bool1 then
            return
        end

        local current = ref.current
        if current then
            var13(current.TimePosition - var1.playbackRegion.Min)
            var9(current.TimePosition)
        end
    end, { bool1, var1.playbackRegion })

    local var19 = useCallback(function()
        if not ref.current then
            return
        end

        ref.current.TimePosition = var1.playbackRegion.Min

        onVideoDidLoopSignalRef.current:fire()
    end, { var1.playbackRegion })

    useEffect(function()
        local current = ref.current
        if not current then
            return
        end

        if videoContent then
            current.VideoContent = videoContent
        end
    end, { var3.enabled, videoContent })

    useEffect(function()
        local current = ref.current
        if not current then
            return
        end

        local connection = current.Loaded:Connect(var17)
        local connection2 = game:GetService("RunService").RenderStepped:Connect(var18)
        local connection3 = current.DidLoop:Connect(var19)

        return function()
            connection:Disconnect()
            connection2:Disconnect()
            connection3:Disconnect()
        end
    end, {
        var3.enabled,
        var18,
        var17,
        var19
    })
    useEffect(function()
        local current = ref.current
        if current then
            current.Looped = var1.looping
        end
    end, { var3.enabled, var1.looping })

    useEffect(function()
        local current = ref.current
        if current then
            current.Playing = var4.enabled
        end
    end, { var3.enabled, var4.enabled })

    useEffect(function()
        local current = ref.current
        if current then
            current.Volume = if var5.enabled then 0 else 0.2
        end
    end, { var3.enabled, var5.enabled })

    useEffect(function()
        local current = ref.current
        if not current then
            return
        end

        if var8 >= var1.playbackRegion.Max + 0.001 then
            if not var4.enabled then
                var8 = var1.playbackRegion.Max
            elseif var1.looping then
                current.TimePosition = var1.playbackRegion.Min
                onVideoDidLoopSignalRef.current:fire()
            else
                var4.disable()
            end
        end

        if var8 < var1.playbackRegion.Min - 0.001 then
            current.TimePosition = var1.playbackRegion.Min
        end
    end, {
        var8,
        var1.playbackRegion,
        var1.looping,
        var4.disable
    })

    useEffect(function()
        local current = ref.current
        if current then
            local var20 = var1.playbackRegion.Max - var1.playbackRegion.Min
            var11(math.min(var20, current.TimeLength))
        end
    end, { var1.playbackRegion })

    local updateRef = useCallback(function(current)
        var3.toggle()
        ref.current = current
    end, { var3.toggle })

    return {
        timeline = {
            duration = duration,
            elapsed = elapsed,
            seek = seek,
            timeLength = timeLength,
            timePosition = var8
        },
        playback = {
            isPlaying = var4.enabled,
            pause = var4.disable,
            play = var4.enable,
            toggle = var4.toggle
        },
        volume = {
            isMuted = var5.enabled,
            mute = var5.enable,
            unmute = var5.disable,
            toggle = var5.toggle
        },
        onVideoDidLoopSignalRef = onVideoDidLoopSignalRef,
        onVideoLoadedSignalRef = onVideoLoadedSignalRef,
        ref = ref,
        updateRef = updateRef
    }
end

return useVideoPlayback
