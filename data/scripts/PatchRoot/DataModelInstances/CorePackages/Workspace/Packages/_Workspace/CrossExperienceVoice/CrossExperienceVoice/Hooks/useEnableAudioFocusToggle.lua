-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:10:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local engineFeature = game:GetEngineFeature("AudioFocusManagement")

local CrossExperienceVoice = script:FindFirstAncestor("CrossExperienceVoice")
local dependencies = require(CrossExperienceVoice.dependencies)
local SharedFlags = dependencies.SharedFlags

local fFlagEnableCrossExperienceVoiceCaptureMute = SharedFlags.GetFFlagEnableCrossExperienceVoiceCaptureMute()
local fFlagEnableVoiceChatMuteForVideoCaptures = SharedFlags.GetFFlagEnableVoiceChatMuteForVideoCaptures()
local CaptureService = if fFlagEnableVoiceChatMuteForVideoCaptures then game:GetService("CaptureService") else nil
local React = dependencies.React
local Cryo = dependencies.Cryo

local function useIsCapturingVideo()
    local var1, var2 = React.useState(CaptureService and CaptureService:IsCapturingVideo())

    React.useEffect(function()
        if not CaptureService then
            return
        end

        local connection = CaptureService.VideoCaptureInProgress:Connect(function(isInProgress: boolean)
            var2(isInProgress)
        end)

        return function()
            if CaptureService then
                connection:Disconnect()
            end
        end
    end, {})

    return var1
end

local function useEnableAudioFocusToggle()
    local var1, var2 = React.useState({})
    local var3 = if fFlagEnableCrossExperienceVoiceCaptureMute and fFlagEnableVoiceChatMuteForVideoCaptures then useIsCapturingVideo() else false

    local var4 = React.useCallback(function(arg1)
        if not var1[arg1] then
            local var4 = Cryo.Dictionary.join(var1, { [arg1] = true })

            var2(var4)
        end
    end, { var1 })

    local var5 = React.useCallback(function(arg1)
        if var1[arg1] then
            local var5 = Cryo.Dictionary.join(var1, { [arg1] = nil })

            var2(var5)
        end
    end, { var1 })

    React.useEffect(function()
        if not engineFeature then
            return
        end
        local success, result = pcall(function(): AudioFocusService
            return game:GetService("AudioFocusService")
        end)
        if not (success and result) then
            return
        end

        local tbl1 = ({})
        local registeredContexts = result:GetRegisteredContexts()
        for k, _ in pairs(registeredContexts) do
            tbl1[k] = true
        end
        var2(tbl1)

        local connection = result.OnContextRegistered:Connect(var4)
        local connection2 = result.OnContextUnregistered:Connect(var5)

        return function()
            if connection then
                connection:Disconnect()
            end
            if connection2 then
                connection2:Disconnect()
            end
        end
    end, {})

    return var1[1] and var1[2] and not var3
end

return useEnableAudioFocusToggle
