-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T20:40:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserProfiles = script:FindFirstAncestor("UserProfiles")
local UserProfilesParent = UserProfiles.Parent
local SignalsReact = require(UserProfilesParent.SignalsReact)
local var1 = require(UserProfiles.Stores.VerifiedBadgeDisplayStore).get()

local function useVerifiedBadge(arg1)
    local badgeVisibilitySignal = var1.getBadgeVisibilitySignal(arg1.UserId)
    return (SignalsReact.useSignalState(badgeVisibilitySignal))
end

return useVerifiedBadge
