-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:10:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCommon = script:FindFirstAncestor("MomentsCommon")
local MomentsCommonParent = MomentsCommon.Parent

local Players = game:GetService("Players")

local Cryo = require(MomentsCommonParent.Cryo)
local React = require(MomentsCommonParent.React)

local useCallback = React.useCallback
local useEffect = React.useEffect
local useMemo = React.useMemo
local useRef = React.useRef
local useState = React.useState
local useToggleState = require(MomentsCommon.Hooks.useToggleState)

local _Types = require(MomentsCommon.Types)

local LocalPlayer = Players.LocalPlayer

local function assetIdAsContent(num1: number?) -- Luacid: Inlined by compiler; 1 call site recovered
    if not num1 then
        return nil
    end

    return `rbxassetid://{num1}`
end

local tbl1 = {
    autoplay = false,
    looping = false,
    playbackRegion = NumberRange.new(0, math.huge)
}

local function useAudioPlayback(bool1: boolean, asset: number?, tbl2)
    local var1 = Cryo.Dictionary.union(tbl1, tbl2 or {})

    local ref = useRef(nil)

    local var3 = useToggleState(var1.autoplay)
    local var4 = useToggleState(false)

    local timeLength, var6 = useState(0)
    local timePosition, var8 = useState(0)

    local duration, var10 = useState(0)
    local elapsed, var12 = useState(0)

    local seek = useCallback(function(num2: number)
        local current = ref.current
        if current then
            current.TimePosition = math.clamp(num2 + var1.playbackRegion.Min, 0, timeLength)
        end
    end, { timeLength, var1.playbackRegion })

    local var14 = useCallback(function()
        if not bool1 then
            return
        end

        local current = ref.current
        if current then
            var12(current.TimePosition - var1.playbackRegion.Min)
            var8(current.TimePosition)
        end
    end, { bool1, asset, var1.playbackRegion })

    asset = useMemo(function()
        return assetIdAsContent(asset)
    end, { asset })

    useEffect(function()
        if not asset then
            return
        end

        local folder = Instance.new("Folder")
        folder.Name = `AudioPlayback_{asset}`

        local audioPlayer = Instance.new("AudioPlayer")
        audioPlayer.Asset = asset
        audioPlayer.PlaybackRegion = var1.playbackRegion
        audioPlayer.Looping = var1.looping or false
        audioPlayer.Parent = folder
        audioPlayer.Volume = 0.2

        local function updateTimeLength() -- Luacid: Inlined by compiler; 1 call site recovered
            var6(audioPlayer.TimeLength)
        end

        audioPlayer:GetPropertyChangedSignal("TimeLength"):Connect(updateTimeLength)
        updateTimeLength()
        local audioDeviceOutput = Instance.new("AudioDeviceOutput")
        audioDeviceOutput.Parent = folder

        local wire = Instance.new("Wire")
        wire.SourceInstance = audioPlayer
        wire.TargetInstance = audioDeviceOutput
        wire.Parent = folder

        ref.current = audioPlayer
        task.spawn(function()
            folder.Parent = LocalPlayer:WaitForChild("PlayerGui")
        end)

        return function()
            folder:Destroy()
        end
    end, { asset })

    useEffect(function()
        local current = ref.current
        if current then
            current.PlaybackRegion = var1.playbackRegion
            current.TimePosition = 0
        end
    end, { var1.playbackRegion })

    useEffect(function()
        local var15 = var1.playbackRegion.Max - var1.playbackRegion.Min
        var10(math.min(var15, timeLength))
    end, { timeLength, var1.playbackRegion })

    useEffect(function()
        local current = ref.current

        if not current then
            return
        end

        if var3.enabled then
            current.PlaybackSpeed = 1
            if not current.IsPlaying then
                current:Play()
            end
        else
            current.PlaybackSpeed = 0
            if current.IsPlaying then
                current:Stop()
            end
        end
    end, { asset, var3.enabled })

    useEffect(function()
        local current = ref.current

        if not current then
            return
        end

        if var4.enabled or not var3.enabled then
            current.Volume = 0
            return
        end
        current.Volume = 0.2
    end, { var4.enabled, var3.enabled })

    local var15 = useCallback(function()
        var3.disable()
    end, {})

    useEffect(function()
        local tbl3 = {}

        if ref.current then
            local renderStepped = game:GetService("RunService").RenderStepped
            table.insert(tbl3, renderStepped:Connect(var14))
            local ended = ref.current.Ended
            table.insert(tbl3, ended:Connect(var15))
        end

        return function()
            for _, value in tbl3 do
                value:Disconnect()
            end
        end
    end, { var14, var15 })

    return {
        timeline = {
            duration = duration,
            elapsed = elapsed,
            seek = seek,
            timeLength = timeLength,
            timePosition = timePosition
        },
        playback = {
            isPlaying = var3.enabled,
            pause = var3.disable,
            play = var3.enable,
            toggle = var3.toggle
        },
        volume = {
            isMuted = var4.enabled,
            mute = var4.enable,
            unmute = var4.disable,
            toggle = var4.toggle
        },
        ref = ref
    }
end

return useAudioPlayback
