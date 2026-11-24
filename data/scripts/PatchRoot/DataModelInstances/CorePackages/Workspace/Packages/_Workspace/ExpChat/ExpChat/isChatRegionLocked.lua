-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:01:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local ExpChatParent = script:FindFirstAncestor("ExpChat").Parent

local GetFFlagExpChatGuacChatDisabledReason = require(ExpChatParent.SharedFlags).GetFFlagExpChatGuacChatDisabledReason

local UniversalAppPolicy = if GetFFlagExpChatGuacChatDisabledReason() then require(ExpChatParent.UniversalAppPolicy) else nil

return function(): boolean
    return if GetFFlagExpChatGuacChatDisabledReason() then UniversalAppPolicy.getAppFeaturePolicies().getExperienceChatAvailability() == "regionLocked" else false
end
