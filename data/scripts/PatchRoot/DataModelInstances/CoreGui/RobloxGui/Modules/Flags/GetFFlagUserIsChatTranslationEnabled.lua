-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:50:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local success, result = pcall(function()
    return UserSettings():IsUserFeatureEnabled("UserIsChatTranslationEnabled2")
end)

return function()
    return success and result
end
