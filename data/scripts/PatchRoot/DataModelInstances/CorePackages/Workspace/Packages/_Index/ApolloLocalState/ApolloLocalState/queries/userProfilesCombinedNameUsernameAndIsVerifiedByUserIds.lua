-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T22:11:23Z
-- Luau bytecode version: 14 | Luau type version: 3
local ApolloLocalStateParent = script:FindFirstAncestor("ApolloLocalState").Parent

return (require(ApolloLocalStateParent.ApolloClient).gql(
    require(script.Parent.schema.UserProfilesCombinedNameUsernameAndIsVerifiedByUserIds)
))
