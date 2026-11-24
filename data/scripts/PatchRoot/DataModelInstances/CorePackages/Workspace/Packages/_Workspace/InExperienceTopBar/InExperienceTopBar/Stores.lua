-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T22:11:02Z
-- Luau bytecode version: 14 | Luau type version: 3
local InExperienceTopBar = script:FindFirstAncestor("InExperienceTopBar")

return {
    GetTopBarStore = if require(InExperienceTopBar.Flags).FFlagTopBarSignalizeSetCores then require(script.GetTopBarStore) else nil
}
