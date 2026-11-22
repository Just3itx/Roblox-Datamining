-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T19:10:58Z
-- Luau bytecode version: 14 | Luau type version: 3
local SocialProof = script:FindFirstAncestor("SocialProof")
local SocialProofParent = SocialProof.Parent
local LuaSocialLibrariesDeps = require(SocialProofParent.LuaSocialLibrariesDeps)
local myRoduxNetworking = require(SocialProof.Networking.myRoduxNetworking)

return LuaSocialLibrariesDeps.NetworkingUsers.config({ roduxNetworking = myRoduxNetworking })
