-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T16:30:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")

local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent
local utils = scriptParentParent.utils
local scriptParentParentParent = scriptParentParent.Parent

local FriendsMenuDependencies = require(scriptParentParent.FriendsMenuDependencies)
local Constants = require(scriptParentParent.Constants)
local _friendsMenuModalType = require(scriptParentParent.friendsMenuModalType)

local React = require(scriptParentParentParent.React)
local Requests = require(scriptParentParentParent.Http).Requests
local UserLib = require(scriptParentParentParent.UserLib)
local RoactUtils = require(scriptParentParentParent.RoactUtils)
local UserProfiles = require(scriptParentParentParent.UserProfiles)
local GetFFlagEnableFriendsListSearchNormalizationErrorFix = require(scriptParentParentParent.SharedFlags).GetFFlagEnableFriendsListSearchNormalizationErrorFix

local UserModel = UserLib.Models.UserModel
local Constants2 = UserLib.Utils.Constants
local ApiFetchUsersPresences = UserLib.Thunks.ApiFetchUsersPresences
local UpdateUsers = UserLib.Thunks.UpdateUsers
local ThumbnailRequest = UserLib.Utils.ThumbnailRequest
local PreloadUsersThumbnail = UserLib.Thunks.PreloadUsersThumbnail
local networkImpl = FriendsMenuDependencies.networkImpl
local sortFriendsByCorrectedPresenceAndRank = FriendsMenuDependencies.sortFriendsByCorrectedPresenceAndRank

local useSelector = RoactUtils.Hooks.RoactRodux.useSelector
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch

local FriendsListContext = require(scriptParent.FriendsListContext)
local generateDummyFriends = require(utils.generateDummyFriends)
local DEPRECATED_UsersGetFriends = Requests.DEPRECATED_UsersGetFriends

local UserSorts = Constants.UserSorts
local tbl1 = {
    InviteAvatarThumbnailType = Constants2.RbxAvatarThumbnailTypesFromEnum.HeadShot,
    InviteAvatarThumbnailSize = Constants2.RbxThumbnailSizes.Size150x150,
    InviteAvatarRbxthumbType = Constants2.RbxthumbTypes.AvatarHeadShot
}
tbl1.ThumbnailRequest = {
    InviteToGame = { ThumbnailRequest.fromData(tbl1.InviteAvatarThumbnailType, tbl1.InviteAvatarThumbnailSize) }
}

return function(tbl2)
    local var1 = if tbl2.networkImplOverride then tbl2.networkImplOverride else networkImpl
    local isFetchingFriends, var3 = React.useState(false)
    local isFriendsListFetchFailed, var5 = React.useState(false)
    local userIds, var7 = React.useState({})
    local searchFriendsString, searchFriends = React.useState("")

    local friends, var11 = React.useState((generateDummyFriends(7)))
    local var12 = useDispatch()

    local var13 = UserProfiles.Hooks.useUserProfilesFetch(
        {
            userIds = userIds,
            query = UserProfiles.Queries.userProfilesAllNamesByUserIds
        }
    )
    local function func1(arg1): boolean
        if not (arg1 and arg1.isFriend) then
            return false
        end

        if tbl2.excludedFriendsSet and tbl2.excludedFriendsSet[arg1.id] then
            return false
        end

        if searchFriendsString == nil or searchFriendsString == "" then
            return true
        end
        local displayName = arg1.displayName or ""
        local name = arg1.name or ""
        local str1 = ""
        local str2 = ""
        local str3 = ""

        if var13 and var13.data then
            local names = UserProfiles.Selectors.getUserProfileFromId(var13.data, arg1.id).names
            if names then
                str1 = names.alias or ""
                displayName = names.displayName or ""
                name = names.username or ""
                str2 = names.contactName or ""
                str3 = names.platformName or ""
            end
        end

        local var14 = utf8.nfdnormalize(displayName)
        local var15 = utf8.nfdnormalize(str1)
        local var16 = utf8.nfdnormalize(str2)
        local var17 = utf8.nfdnormalize(str3)
        local var18 = nil
        if GetFFlagEnableFriendsListSearchNormalizationErrorFix() then
            pcall(function()
                var18 = utf8.nfdnormalize(searchFriendsString)
            end)
        else
            var18 = utf8.nfdnormalize(searchFriendsString)
        end

        if GetFFlagEnableFriendsListSearchNormalizationErrorFix() then
            return var18
                and (string.find(var15:lower(), var18:lower(), 1, true) ~= nil
                    or string.find(var16:lower(), var18:lower(), 1, true) ~= nil
                    or string.find(var17:lower(), var18:lower(), 1, true) ~= nil
                    or string.find(var14:lower(), var18:lower(), 1, true) ~= nil)
                and true
                or string.find(name:lower(), searchFriendsString:lower(), 1, true) ~= nil
        end

        return string.find(var15:lower(), var18:lower(), 1, true) ~= nil
            or string.find(var16:lower(), var18:lower(), 1, true) ~= nil
            or string.find(var17:lower(), var18:lower(), 1, true) ~= nil
            or string.find(var14:lower(), var18:lower(), 1, true) ~= nil
            or string.find(name:lower(), searchFriendsString:lower(), 1, true) ~= nil
    end

    local function func2(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
        local combinedNameFromId = if var13 and var13.data then UserProfiles.Selectors.getCombinedNameFromId(var13.data, arg1.id) else nil
        return if combinedNameFromId == nil then arg1.displayName else combinedNameFromId
    end

    local function func3(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
        local usernameFromId = if var13 and var13.data then UserProfiles.Selectors.getUsernameFromId(var13.data, arg1.id) else nil
        return if usernameFromId == nil then arg1.name else usernameFromId
    end

    React.useEffect(function()
        local var14 = if Players and Players.LocalPlayer then tostring(Players.LocalPlayer.UserId) else nil

        if isFetchingFriends or not var14 then
            return
        end

        var3(true)
        var5(false)
        DEPRECATED_UsersGetFriends(var1, var14, UserSorts.StatusFrequents):andThen(function(arg1): {string}
            local responseBody = arg1.responseBody
            local result = {}
            local tbl3 = {}
            for friendRank, value in pairs(responseBody.data) do
                local str1 = tostring(value.id)
                value.isFriend = true
                value.friendRank = friendRank
                value.name = ""
                value.displayName = ""

                local dataTable = UserModel.fromDataTable(value)

                table.insert(result, str1)
                tbl3[dataTable.id] = dataTable
            end
            var12(UpdateUsers(tbl3))
            var7(result)
            return result
        end, function(_)
            var3(false)
            var5(true)

            return {}
        end):andThen(function(arg1)
            var12(PreloadUsersThumbnail(arg1, tbl1.ThumbnailRequest.InviteToGame, nil))

            return var12(ApiFetchUsersPresences(var1, arg1))
        end):andThen(function(_)
            var3(false)
        end, function(_)
            var3(false)
            var5(true)
        end)
    end, {})

    local var14 = useSelector(function(arg1)
        return arg1.Users
    end)

    local useEffect = React.useEffect

    local function func4()
        if isFetchingFriends then
            var11(generateDummyFriends(7))
            return
        end
        local tbl3 = {}
        for _, value in pairs(var14) do
            if func1(value) then
                tbl3[#tbl3 + 1] = value
                value.displayName = func2(value)
                value.name = func3(value)
            end
        end
        table.sort(tbl3, sortFriendsByCorrectedPresenceAndRank)
        var11(tbl3)
    end

    local str1 = tostring(isFetchingFriends)
    local loading = var13 and var13.loading
    useEffect(func4, { var14, searchFriendsString, str1, tostring(loading) })

    return React.createElement(FriendsListContext.Provider, {
        value = {
            friends = friends,
            hasFriends = #userIds > 0,
            isFetchingFriends = isFetchingFriends or tbl2.isLoadingCustomParams,
            isFriendsListFetchFailed = isFriendsListFetchFailed,
            friendsNames = {
                loading = var13 and var13.loading
            },
            searchFriends = searchFriends,
            searchFriendsString = searchFriendsString
        }
    }, tbl2.children)
end
