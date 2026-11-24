-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T07:51:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function finishDictationInput(arg1)
    if arg1 == nil then
        return false
    end

    local success, result = pcall(function(): boolean
        if not game:GetFastFlag("EnableManualVad") then
            return false
        end

        local var1 = arg1
        var1.VoiceDetectedOverride = false
        var1.DisableVoiceDetection = true
        return true
    end)
    return success and result
end

return finishDictationInput
