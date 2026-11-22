-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T19:11:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialProof = script:FindFirstAncestor("SocialProof")
local SocialProofParent = SocialProof.Parent

local Rodux = require(SocialProofParent.Rodux)
local myRoduxNetworking = require(SocialProof.Networking.myRoduxNetworking)
local ConnectionsByEntityId = require(SocialProof.Rodux.ConnectionsByEntityId)

return function()
    return Rodux.combineReducers(
        {
            NetworkStatus = myRoduxNetworking.installReducer(),
            ConnectionsByEntityId = ConnectionsByEntityId
        }
    )
end
