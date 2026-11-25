-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T18:00:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SquadsCore = script:FindFirstAncestor("SquadsCore")
local SquadsCoreParent = SquadsCore.Parent

local useSignalState = require(SquadsCoreParent.SignalsReact).useSignalState

local GetExperienceInviteRetryAfterStore = require(SquadsCore.Stores.GetExperienceInviteRetryAfterStore)

local function useIsExperienceInviteRetryBlocked(str1: string?): boolean
    local experienceInviteRetryAfterStore = GetExperienceInviteRetryAfterStore(false)
    local var1 = useSignalState(experienceInviteRetryAfterStore.getBlockedSquadId)
    return not (str1 == nil) and var1 == str1
end

return useIsExperienceInviteRetryBlocked
