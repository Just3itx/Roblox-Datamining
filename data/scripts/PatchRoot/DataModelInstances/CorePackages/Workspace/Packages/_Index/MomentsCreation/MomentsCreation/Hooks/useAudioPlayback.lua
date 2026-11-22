-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:21:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreation = script:FindFirstAncestor("MomentsCreation")
local MomentsCreationParent = MomentsCreation.Parent

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local MomentsCommon = require(MomentsCreationParent.MomentsCommon)
local React = require(MomentsCreationParent.React)
local fadeVolume = require(MomentsCreation.Audio.fadeVolume)
local startAudioOnLoad = require(MomentsCreation.Audio.startAudioOnLoad)
local FFlagMomentsCreationStartAudioOnLoad = require(MomentsCreation.Flags.FFlagMomentsCreationStartAudioOnLoad)
local GetFFlagMomentsTTSAudioOverlay = require(MomentsCreation.Flags.GetFFlagMomentsTTSAudioOverlay)

local useCallback = React.useCallback
local useEffect = React.useEffect
local useMemo = React.useMemo
local useRef = React.useRef
local useState = React.useState
local useToggleState = MomentsCommon.Hooks.useToggleState

local LocalPlayer = Players.LocalPlayer

local function assetIdAsContent(num1: number?) -- Luacid: Inlined by compiler; 1 call site recovered
    if num1 == nil then
        return nil
    end
    return `rbxassetid://{num1}`
end

local function useAudioPlayback(bool1: boolean, num1: number?, tbl1)
    local tbl2 = tbl1 or {}
    local autoplay = not (tbl2.autoplay == nil) and tbl2.autoplay
    local looping = not (tbl2.looping == nil) and tbl2.looping
    local playbackRegion = tbl2.playbackRegion or NumberRange.new(0, math.huge)
    local var2 = if tbl2.duckScalar == nil then 1 else tbl2.duckScalar

    local ref = useRef(nil)

    local var4 = useToggleState(autoplay)
    local var5 = useToggleState(false)
    local var6 = useRef(var4.enabled)
    if FFlagMomentsCreationStartAudioOnLoad then
        var6.current = var4.enabled
    end

    local timeLength, var8 = useState(0)
    local timePosition, var10 = useState(0)
    local duration, var12 = useState(0)
    local elapsed, var14 = useState(0)

    local asset = useMemo(function()
        return assetIdAsContent(num1)
    end, { num1 })

    local seek = useCallback(function(num2: number)
        local current = ref.current
        if current then
            current.TimePosition = math.clamp(num2 + playbackRegion.Min, 0, timeLength)
        end
    end, { timeLength, playbackRegion })

    local var17 = useCallback(function()
        if not bool1 then
            return
        end
        local current = ref.current
        if current then
            var14(current.TimePosition - playbackRegion.Min)
            var10(current.TimePosition)
        end
    end, { bool1, playbackRegion })

    useEffect(function()
        if asset == nil then
            return
        end

        local folder = Instance.new("Folder")
        folder.Name = `AudioPlayback_{asset}`

        local audioPlayer = Instance.new("AudioPlayer")
        audioPlayer.Asset = asset
        audioPlayer.PlaybackRegion = playbackRegion
        audioPlayer.Looping = looping
        audioPlayer.Parent = folder
        audioPlayer.Volume = 0.2

        local function updateTimeLength() -- Luacid: Inlined by compiler; 1 call site recovered
            var8(audioPlayer.TimeLength)
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
        local var18 = if FFlagMomentsCreationStartAudioOnLoad then startAudioOnLoad(audioPlayer, function()
            return var6.current
        end) else nil

        local bool2 = false
        task.spawn(function()
            local playerGui = LocalPlayer:WaitForChild("PlayerGui")
            if bool2 then
                return
            end
            folder.Parent = playerGui
        end)

        return function()
            bool2 = true
            if var18 ~= nil then
                var18:Disconnect()
            end
            folder:Destroy()
        end
    end, { asset })

    useEffect(function()
        local current = ref.current
        if not current then
            return
        end

        current.PlaybackRegion = playbackRegion
        if FFlagMomentsCreationStartAudioOnLoad then
            if current.IsReady then
                current.TimePosition = playbackRegion.Min
            end
        else
            current.TimePosition = 0
        end
    end, { playbackRegion })

    useEffect(function()
        var12(math.min(playbackRegion.Max - playbackRegion.Min, timeLength))
    end, { timeLength, playbackRegion })

    useEffect(function()
        local current = ref.current
        if not current then
            return
        end

        if FFlagMomentsCreationStartAudioOnLoad and not current.IsReady then
            current.PlaybackSpeed = 0
            return
        end
        if var4.enabled then
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
    end, { var4.enabled, asset })

    useEffect(function()
        if GetFFlagMomentsTTSAudioOverlay then
            return
        end
        local current = ref.current
        if current ~= nil then
            current.Volume = if var5.enabled or not var4.enabled then 0 else 0.2
        end
    end, { var5.enabled, var4.enabled })

    useEffect(function()
        if not GetFFlagMomentsTTSAudioOverlay then
            return
        end
        local current = ref.current
        if current == nil then
            return
        end

        if var5.enabled or not var4.enabled then
            fadeVolume(current, 0, true)
            return
        end
        fadeVolume(current, 0.2 * var2)
    end, {
        var5.enabled,
        var4.enabled,
        var2,
        asset
    })

    local var18 = useCallback(function()
        var4.disable()
    end, {})

    useEffect(function()
        local tbl3 = {}
        local current = ref.current
        if current then
            local renderStepped = RunService.RenderStepped
            table.insert(tbl3, renderStepped:Connect(var17))
            local ended = current.Ended
            table.insert(tbl3, ended:Connect(var18))
        end

        return function()
            for _, value in tbl3 do
                value:Disconnect()
            end
        end
    end, { var17, var18, asset })

    return {
        timeline = {
            duration = duration,
            elapsed = elapsed,
            seek = seek,
            timeLength = timeLength,
            timePosition = timePosition
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
        ref = ref
    }
end

return useAudioPlayback
