-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:51:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RoduxFriends = script:FindFirstAncestor("RoduxFriends")
local RoduxFriendsParent = RoduxFriends.Parent
local mockId = require(script.Parent.mockId)
local _roduxFriendsTypes = require(script.Parent.Parent.roduxFriendsTypes)
local llama = require(RoduxFriendsParent.llama)
local RecommendationContextType = require(RoduxFriends.Enums.RecommendationContextType)

local module = {}

function module.new(arg1)
    assert(module.isValid(arg1))

    module.__index = module

    local tbl1 = {
        id = arg1.id,
        entityId = arg1.entityId,
        rank = arg1.rank,
        contextType = arg1.contextType,
        mutualFriendsList = arg1.mutualFriendsList,
        mutualFriendsCount = arg1.mutualFriendsCount,
        thumbnailEntities = arg1.thumbnailEntities,
        entityDisplayName = arg1.entityDisplayName
    }

    setmetatable(tbl1, module)

    return tbl1
end

function module.mock(tbl1)
    local tbl2 = {
        id = mockId(),
        contextType = RecommendationContextType.MutualFriends
    }
    local var1 = llama.Dictionary.join(tbl2, tbl1)

    local new = module.new
    local tbl3 = {
        id = var1.id,
        mutualFriendsList = var1.mutualFriendsList,
        rank = var1.rank or tonumber(var1.id),
        contextType = var1.contextType,
        mutualFriendsCount = if var1.mutualFriendsCount then var1.mutualFriendsCount else var1.mutualFriendsList and #var1.mutualFriendsList or 0
    }
    return (new(tbl3))
end

function module.isValid(arg1): (boolean, string)
    if not arg1 then
        return false, "Expected recommendation information to be given"
    elseif not arg1.id then
        return false, "Expected user's id to be given"
    elseif not arg1.rank then
        return false, "Expected user's rank to be given"
    elseif not (arg1.contextType and RecommendationContextType.isEnumValue(arg1.contextType)) then
        return false, "Expected contextType to be given"
    elseif arg1.mutualFriendsList and type(arg1.mutualFriendsList) ~= "table" then
        return false, "mutualFriendList must be a table of strings"
    elseif arg1.mutualFriendsCount and type(arg1.mutualFriendsCount) ~= "number" then
        return false, "mutualFriendsCount must be a number"
    elseif arg1.contextType == RecommendationContextType.Contacts and not arg1.entityId then
        return false, "entity Id must be given for Contacts recommendation type"
    end

    return true, "Valid Recommendation"
end

function module:isEqual(arg1)
    local bool1

    if self.id == arg1.id then
        bool1 = llama.List.equals(self.mutualFriendsList, arg1.mutualFriendsList)

        if bool1 then
            if self.rank == arg1.rank and self.contextType == arg1.contextType then
                bool1 = self.mutualFriendsCount == arg1.mutualFriendsCount
            else
                bool1 = false
            end
        end
    else
        bool1 = false
    end

    return bool1
end

function module:format()
    local contextType = if self.contextType then RecommendationContextType.fromRawValue(self.contextType) or RecommendationContextType.None else RecommendationContextType.None
    local mutualFriendsCount = if self.mutualFriendsCount then self.mutualFriendsCount else self.mutualFriendsList and #self.mutualFriendsList or 0
    local contactId2 = if self.contactId == "" then nil else self.contactId
    local displayName = if contextType == RecommendationContextType.Contacts then self.displayName else nil
    return module.new(
        llama.Dictionary.join(self, {
            id = self.id,
            entityId = contactId2,
            contextType = contextType,
            mutualFriendsCount = mutualFriendsCount,
            contactId = contactId,
            thumbnailEntities = self.thumbnailEntities,
            entityDisplayName = displayName
        })
    )
end
return module
