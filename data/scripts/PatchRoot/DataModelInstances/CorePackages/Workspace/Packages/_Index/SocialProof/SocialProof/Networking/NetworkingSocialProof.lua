-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T19:10:56Z
-- Luau bytecode version: 14 | Luau type version: 3
local SocialProof = script:FindFirstAncestor("SocialProof")
local SocialProofParent = SocialProof.Parent
local SocialProofNetworking = require(SocialProofParent.SocialProofNetworking)
local myRoduxNetworking = require(SocialProof.Networking.myRoduxNetworking)

return (SocialProofNetworking.config({ roduxNetworking = myRoduxNetworking }))
