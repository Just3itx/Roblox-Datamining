-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T21:21:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VerifiedBadges = script:FindFirstAncestor("VerifiedBadges")

local Rodux = require(VerifiedBadges.Parent.Rodux)
local Cryo = require(VerifiedBadges.Parent.Cryo)
local dependencies = require(VerifiedBadges.dependencies)

local UsersNetworking = dependencies.UsersNetworking
local FriendsNetworking = dependencies.FriendsNetworking

local function func1(tbl1, tbl2)
    local tbl3 = {}

    for _, value in ipairs(tbl2) do
        local id = value.id
        tbl3[tostring(id)] = if value.hasVerifiedBadge then true else Cryo.None
    end

    return Cryo.Dictionary.join(tbl1, tbl3)
end

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[UsersNetworking.GetUserV2FromUserId.Succeeded.name] = function(tbl2, arg1)
    return func1(tbl2, { arg1.responseBody })
end

tbl1[FriendsNetworking.GetFriendsFromUserId.Succeeded.name] = function(tbl2, arg1)
    return func1(tbl2, arg1.responseBody.data)
end

function tbl1.AddGameDetails(tbl2, arg1)
    local tbl3 = ({})

    for _, gameDetail in pairs(arg1.gameDetails) do
        local str1 = tostring(gameDetail.creator.id)
        local type = gameDetail.creator.type
        local hasVerifiedBadge = gameDetail.creator.hasVerifiedBadge

        if type == Enum.CreatorType.User.Name then
            tbl3[str1] = if hasVerifiedBadge then true else Cryo.None
        end
    end

    return Cryo.Dictionary.join(tbl2, tbl3)
end

function tbl1.AddGameDetailsV2(tbl2, arg1)
    local tbl3 = ({})

    for _, gameDetail in pairs(arg1.gameDetails) do
        local str1 = tostring(gameDetail.creator.id)
        local type = gameDetail.creator.type
        local hasVerifiedBadge = gameDetail.creator.hasVerifiedBadge

        if type == Enum.CreatorType.User.Name then
            tbl3[str1] = if hasVerifiedBadge then true else Cryo.None
        end
    end

    return Cryo.Dictionary.join(tbl2, tbl3)
end

function tbl1.SetAssetInfoFromCatalogItemAction(tbl2, arg1)
    if arg1.assetData.creatorType ~= Enum.CreatorType.User.Name then
        return tbl2
    end

    local str1 = tostring(arg1.assetData.creatorTargetId)
    local creatorHasVerifiedBadge = arg1.assetData.creatorHasVerifiedBadge
    return Cryo.Dictionary.join(tbl2, { [str1] = if creatorHasVerifiedBadge then true else Cryo.None })
end

return createReducer({}, tbl1)
