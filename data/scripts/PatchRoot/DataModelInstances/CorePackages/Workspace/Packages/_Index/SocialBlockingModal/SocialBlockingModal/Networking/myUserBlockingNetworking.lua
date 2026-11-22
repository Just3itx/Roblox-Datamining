-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T16:50:39Z
-- Luau bytecode version: 14 | Luau type version: 3
local SocialBlockingModalParent = script:FindFirstAncestor("SocialBlockingModal").Parent

local UserBlockingNetworking = require(SocialBlockingModalParent.UserBlockingNetworking)
local myRoduxNetworking = require(script.Parent.myRoduxNetworking)

return (UserBlockingNetworking.config({ roduxNetworking = myRoduxNetworking }))
