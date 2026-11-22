-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T19:10:47Z
-- Luau bytecode version: 14 | Luau type version: 3
local FriendsOwnedUserList = require(script.FriendsOwnedUserList)
local SocialProofVerticalUserListSheet = require(script.SocialProofVerticalUserListSheet)
local SocialProofParent = script:FindFirstAncestor("SocialProof").Parent

local tbl1 = { FriendsOwnedUserList = FriendsOwnedUserList, SocialProofVerticalUserListSheet = 0 }

if not require(SocialProofParent.SharedFlags).FFlagEnableSocialProofVerticalUserListSheet then
    SocialProofVerticalUserListSheet = nil
end

tbl1.SocialProofVerticalUserListSheet = SocialProofVerticalUserListSheet
return tbl1
