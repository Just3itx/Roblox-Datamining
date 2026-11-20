-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T22:11:15Z
-- Luau bytecode version: 14 | Luau type version: 3
local ApolloLocalStateParent = script:FindFirstAncestor("ApolloLocalState").Parent

local gql = require(ApolloLocalStateParent.ApolloClient).gql

local var1 = gql(require(script.Parent.schema.UserProfilesAllNamesByUserIdsNew))

local var2 = gql(require(script.Parent.schema.UserProfilesAllNamesByUserIds))

return if game:GetEngineFeature("PlatformFriendsService") and game:GetEngineFeature("PlatformFriendsProfile") then var1 else var2
