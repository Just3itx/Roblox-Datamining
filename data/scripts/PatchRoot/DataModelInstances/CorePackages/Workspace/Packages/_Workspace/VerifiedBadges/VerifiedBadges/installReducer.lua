-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T21:20:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VerifiedBadges = script:FindFirstAncestor("VerifiedBadges")

local Rodux = require(VerifiedBadges.Parent.Rodux)
local RoduxNetworking = require(VerifiedBadges.dependencies).RoduxNetworking

local function installReducer()
    return Rodux.combineReducers({
        VerifiedUsers = require(script.VerifiedUsers),
        VerifiedGroups = require(script.VerifiedGroups),
        NetworkStatus = RoduxNetworking.installReducer()
    })
end

return installReducer
