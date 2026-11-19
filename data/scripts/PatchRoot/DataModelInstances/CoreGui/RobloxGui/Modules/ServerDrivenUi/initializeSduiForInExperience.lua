-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:41:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function initializeSduiForInExperience()
    require(script.Parent.registerInExperienceComponents)()
    require(script.Parent.registerInExperienceActions)()
    require(script.Parent.registerInExperienceTelemetryHandlers)()
end

return initializeSduiForInExperience
