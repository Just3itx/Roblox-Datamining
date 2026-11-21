-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T14:11:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local isSubjectTo10ftPolicies = require(scriptParentParent.dependencies).isSubjectTo10ftPolicies
local getFIntShowFriendRecommendationsLimit = require(scriptParentParent.Flags.getFIntShowFriendRecommendationsLimit)

return function(num1: number): boolean
    return if isSubjectTo10ftPolicies() then true else num1 <= getFIntShowFriendRecommendationsLimit()
end
