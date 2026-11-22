-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T23:51:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function()
    local success, result = pcall(function(): RBXScriptSignal
        return game:GetService("ExperienceService").OnNewJoinAttempt
    end)
    return if success then result else nil
end
