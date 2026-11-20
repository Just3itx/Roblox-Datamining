-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T22:20:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ApolloLocalStateParent = script:FindFirstAncestor("ApolloLocalState").Parent
local Cryo = require(ApolloLocalStateParent.Cryo)
local FFlagUserProfilePlatformProfile = require(ApolloLocalStateParent.SharedFlags).FFlagUserProfilePlatformProfile
local FFlagUserProfileMergeCachedNames = require(ApolloLocalStateParent.SharedFlags).FFlagUserProfileMergeCachedNames
local makeDefaultReadPolicy = require(script.Parent.utils.makeDefaultReadPolicy)

local merge = FFlagUserProfileMergeCachedNames and function(_, arg1, arg2) -- name: mergeAllNames
    if arg1 and arg2 then
        return Cryo.Dictionary.join(arg1, arg2)
    end
    return arg2
end or FFlagUserProfilePlatformProfile and function(_, arg1, arg2) -- name: mergeNames
    if arg1 and arg1.platformName ~= nil and arg2 and arg2.platformName == nil then
        return Cryo.Dictionary.join(arg2, { platformName = arg1.platformName })
    end
    return arg2
end or nil

return {
    fields = {
        platformProfileId = {
            read = if FFlagUserProfilePlatformProfile then nil else makeDefaultReadPolicy("")
        },
        names = { merge = merge }
    }
}
