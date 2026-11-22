-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T17:01:26Z
-- Luau bytecode version: 14 | Luau type version: 3
local SocialCardsParent = script:FindFirstAncestor("SocialCards").Parent

local FFlagFriendsCallingClientGate_DEV = require(SocialCardsParent.SharedFlags).FFlagFriendsCallingClientGate_DEV

return game:DefineFastFlag("EnableCallCard", false) and FFlagFriendsCallingClientGate_DEV
