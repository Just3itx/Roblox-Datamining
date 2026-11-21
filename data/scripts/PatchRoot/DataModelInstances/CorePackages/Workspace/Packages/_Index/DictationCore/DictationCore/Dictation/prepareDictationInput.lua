-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T10:00:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function prepareDictationInput(arg1)
    local success, result = pcall(function(): boolean
        if not game:GetFastFlag("EnableManualVad") then
            return false
        end

        arg1.VoiceDetectedOverride = true
        return true
    end)
    return success and result
end

return prepareDictationInput
