-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T18:10:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SquadsCoreParent = script:FindFirstAncestor("SquadsCore").Parent
local Signals = require(SquadsCoreParent.Signals)

local createExperienceInviteRetryAfterStore = require(script.createExperienceInviteRetryAfterStore)

return Signals.createComputed(function()
    return createExperienceInviteRetryAfterStore()
end)
