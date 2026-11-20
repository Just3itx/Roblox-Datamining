-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T22:20:46Z
-- Luau bytecode version: 14 | Luau type version: 3
local ApolloLocalStateParent = script:FindFirstAncestor("ApolloLocalState").Parent
local FFlagUserProfilePlatformProfile = require(ApolloLocalStateParent.SharedFlags).FFlagUserProfilePlatformProfile
local makeDefaultReadPolicy = require(script.Parent.utils.makeDefaultReadPolicy)

return {
    fields = {
        alias = {
            read = makeDefaultReadPolicy("")
        },
        contactName = {
            read = makeDefaultReadPolicy("")
        },
        platformName = {
            read = if FFlagUserProfilePlatformProfile then nil else makeDefaultReadPolicy("")
        }
    }
}
