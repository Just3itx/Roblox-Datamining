-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:01:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreation = script:FindFirstAncestor("MomentsCreation")
local MomentsCreationParent = MomentsCreation.Parent

local React = require(MomentsCreationParent.React)
local Signals = require(MomentsCreationParent.Signals)

local _CreationFlowTypes = require(MomentsCreation.Types.CreationFlowTypes)

local GetFFlagMomentsTTSStartTimePositioning = require(MomentsCreation.Flags.GetFFlagMomentsTTSStartTimePositioning)

local useEffect = React.useEffect
local useRef = React.useRef
local useState = React.useState

local function VoicePreviewLayer(tbl1)
    local controller = tbl1.controller

    local ttsAudio = controller.ttsAudio
    assert(ttsAudio ~= nil, "VoicePreviewLayer requires controller.ttsAudio")

    local var1, var2 = useState(controller.getActiveTool(false))
    local var3, var4 = useState(controller.getEffectiveTTS(false))

    local var5, var6 = useState(ttsAudio.getIsLoaded(false))
    useEffect(function()
        return Signals.createEffect(function(arg1)
            var2(controller.getActiveTool(arg1))
            var4(controller.getEffectiveTTS(arg1))
            var6(ttsAudio.getIsLoaded(arg1))
        end)
    end, { controller, ttsAudio })

    local var7 = useRef(false)
    local var8 = useRef(0)
    local bool1 = not (var1 == nil) and var1.kind == "voice"
    local bool2 = not bool1 and var3 ~= nil

    local str1 = if var3 == nil then "" else `{var3.text}:{var3.voiceId}`

    local var9 = if var3 == nil then 0 else var3.startTime or 0

    useEffect(function()
        if not bool2 or var3 == nil then
            return
        end
        ttsAudio.generate(var3.text, var3.voiceId)
    end, { bool2, str1 })

    useEffect(function()
        if bool1 and var7.current then
            ttsAudio.pause()
            var7.current = false
        end
    end, { bool1 })

    local var10, var11 = useState(controller.preview.playback.getIsPlaying(false))
    useEffect(function()
        return Signals.createEffect(function(arg1)
            var11(controller.preview.playback.getIsPlaying(arg1))
        end)
    end, { controller })

    useEffect(function()
        if not bool2 or var3 == nil or not ttsAudio.getIsLoaded(false) then
            return
        end

        local timeLength = ttsAudio.getTimeLength(false)
        if timeLength <= 0 then
            return
        end

        local startTime = var3.startTime or 0
        local var12 = startTime + timeLength

        local position = controller.preview.playback.getPosition(false)
        if var10 and startTime <= position and position < var12 then
            local var13 = position - startTime
            if math.abs(ttsAudio.getTimePosition(false) - var13) > 0.1 then
                ttsAudio.seek(var13)
            end
            ttsAudio.play()
            var7.current = true
        elseif (not var10 or GetFFlagMomentsTTSStartTimePositioning) and var7.current then
            ttsAudio.pause()
            var7.current = false
        end

        return function()
            if var7.current then
                ttsAudio.pause()
                var7.current = false
            end
        end
    end, {
        bool2,
        str1,
        var9,
        var10,
        var5
    })

    useEffect(function()
        if not bool2 or var3 == nil then
            return
        end

        local startTime = var3.startTime or 0

        return Signals.createEffect(function(arg1)
            local position = controller.preview.playback.getPosition(arg1)
            local current = var8.current
            var8.current = position

            if not (ttsAudio.getIsLoaded(false) and controller.preview.playback.getIsPlaying(false)) then
                return
            end

            local timeLength = ttsAudio.getTimeLength(false)
            if timeLength <= 0 then
                return
            end
            local var12 = startTime + timeLength
            local bool3 = startTime <= position and position < var12

            if not (current - position > 0.5) then
                if GetFFlagMomentsTTSStartTimePositioning and current < startTime and bool3 then
                    ttsAudio.seek(position - startTime)
                    ttsAudio.play()
                    var7.current = true
                end

                return
            end

            if bool3 then
                ttsAudio.seek(position - startTime)
                ttsAudio.play()
                var7.current = true
                return
            end

            if GetFFlagMomentsTTSStartTimePositioning then
                ttsAudio.pause()
                var7.current = false
            end
        end)
    end, { bool2, str1, var9 })

    return nil
end

return VoicePreviewLayer
