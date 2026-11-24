-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T05:50:57Z
-- Luau bytecode version: 14 | Luau type version: 3
local scriptParentParent = script.Parent.Parent
return {
    ExperienceUnavailable = "ExperienceUnavailable",
    NetworkError = if require(scriptParentParent.SharedFlags).FFlagLuaAppInExperienceDetailsPrompt then "NetworkError" else nil
}
