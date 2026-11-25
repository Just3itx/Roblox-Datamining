-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T15:31:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialContextToasts = script:FindFirstAncestor("SocialContextToasts")
local SocialContextToastsParent = SocialContextToasts.Parent
local FFlagUserProfilePlatformProfile = require(SocialContextToastsParent.SharedFlags).FFlagUserProfilePlatformProfile
local React = require(SocialContextToastsParent.React)
local Cryo = require(SocialContextToastsParent.Cryo)
local Promise = require(SocialContextToastsParent.Promise)
local UsersGetPresence = require(SocialContextToastsParent.UserLib).Requests.UsersGetPresence
local UserProfiles = require(SocialContextToastsParent.UserProfiles)
local getCombinedNameFromId = UserProfiles.Selectors.getCombinedNameFromId
local PostSendExperienceInvite = require(SocialContextToastsParent.GameInvite).PostSendExperienceInvite
local JoinExperience = require(SocialContextToastsParent.NotificationsCommon).JoinExperience
local SocialContextToastDiagKeys = require(SocialContextToasts.Enums.SocialContextToastDiagKeys)
local SetToastContent = require(SocialContextToasts.Actions.SetToastContent)
local SetConfirmationModal = require(SocialContextToasts.Actions.SetConfirmationModal)
local useDispatch = require(SocialContextToastsParent.RoactUtils).Hooks.RoactRodux.useDispatch
local ToastTypes = require(SocialContextToasts.Enums.ToastTypes)
local SocialContextToastAnalyticsActionTypes = require(SocialContextToasts.Enums.SocialContextToastAnalyticsActionTypes)
local SocialContextToastEvents = require(SocialContextToasts.SocialContextToastEvents)

local useOneToOnePartyNudgeStartPartyRejected = require(SocialContextToastsParent.SquadsCore.Hooks).useOneToOnePartyNudgeStartPartyRejected

local DEPRECATED_FriendsGetFriendStatuses = require(SocialContextToastsParent.Http).Requests.DEPRECATED_FriendsGetFriendStatuses

local GetFFlagEnableReferredPlayerJoinRemoteEvent = require(SocialContextToastsParent.SharedFlags).GetFFlagEnableReferredPlayerJoinRemoteEvent

local GetFFlagEnableReferredPlayerJoinRemoteEventForAll = require(SocialContextToastsParent.SharedFlags).GetFFlagEnableReferredPlayerJoinRemoteEventForAll
local GetFIntMaxReferredPlayerJoinToasts = require(SocialContextToastsParent.SharedFlags).GetFIntMaxReferredPlayerJoinToasts
local FFlagEnablePartyNudgeAfterJoin = require(SocialContextToastsParent.SharedFlags).FFlagEnablePartyNudgeAfterJoin

local FFlagShowFriendJoinedYouToastForNonReferredJoins = require(SocialContextToastsParent.SharedFlags).FFlagShowFriendJoinedYouToastForNonReferredJoins

local num1 = game:DefineFastInt("SocialContextToastDelay", 10)

local var1 = nil
var1 = GetFFlagEnableReferredPlayerJoinRemoteEvent() and function(): boolean
    return not not GetFFlagEnableReferredPlayerJoinRemoteEventForAll()
end or var1

local function getNames(apolloClient, arg1)
    local userIds = ({})
    for i = 1, #arg1 do
        local var2 = arg1[i]
        userIds[i] = tostring(var2)
    end
    return Promise.new(function(callback, _)
        apolloClient:query({
            query = if FFlagUserProfilePlatformProfile then UserProfiles.Queries.userProfilesBasicNamesByUserIds else UserProfiles.Queries.userProfilesAllNamesByUserIds,
            variables = { userIds = userIds }
        }):andThen(
            function(arg2)
                local tbl2 = {}
                for i = 1, #arg1 do
                    table.insert(tbl2, { userId = arg1[i], name = getCombinedNameFromId(arg2.data, arg1[i]) })
                end

                callback(tbl2)
            end
        )
    end)
end

local function sortFriendsList(tbl1, followUserId, arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    if arg1 then
        tbl1 = Cryo.List.removeValue(tbl1, followUserId)
        table.insert(tbl1, 1, followUserId)
    end

    return tbl1
end

local function showYouJoinedFriendsToast(services, arg1, followUserId, tbl1, arg2, universeId, placeId)
    if #tbl1 == 0 then
        return arg1(SetToastContent(nil))
    end

    services.analytics.Diag:reportCounter(SocialContextToastDiagKeys.YouJoinedFriends, 1)
    SocialContextToastEvents(services.eventIngest, {
        toastType = ToastTypes.YouJoinedFriends,
        friendId = table.concat(tbl1, ","),
        universeId = universeId,
        placeId = placeId,
        actionType = SocialContextToastAnalyticsActionTypes.Shown
    })

    if followUserId > 0 then
        tbl1 = sortFriendsList(tbl1, followUserId, arg2)
    end

    return getNames(services.apolloClient, tbl1):andThen(function(userList)
        arg1(SetToastContent({ toastType = ToastTypes.YouJoinedFriends, userList = userList }))
    end)
end

local function handleFollowedPlayerDisconnected(services, callback, joinerUserId: number, _, universeId, placeId)
    local analytics = services.analytics
    local networking = services.networking
    UsersGetPresence(networking, { joinerUserId }):andThen(function(arg1)
        if not arg1.responseBody or not arg1.responseBody.userPresences or #arg1.responseBody.userPresences == 0 then
            return
        end

        local var2 = arg1.responseBody.userPresences[1]
        local universeId2 = var2.universeId
        if tostring(universeId2) == tostring(universeId) then
            analytics.Diag:reportCounter(SocialContextToastDiagKeys.FollowedFriendInOtherPlace, 1)
            SocialContextToastEvents(services.eventIngest, {
                toastType = ToastTypes.FriendInNonRootPlace,
                friendId = tostring(joinerUserId),
                universeId = universeId,
                placeId = placeId,
                actionType = SocialContextToastAnalyticsActionTypes.Shown
            })

            return getNames(services.apolloClient, { joinerUserId }):andThen(function(arg2)
                if #arg2 == 0 then
                    return
                end
                callback(
                    SetToastContent({ toastType = ToastTypes.FriendInNonRootPlace, joinerUserId = joinerUserId, joinerName = arg2[1].name })
                )
            end)
        end

        if universeId2 == nil then
            analytics.Diag:reportCounter(SocialContextToastDiagKeys.FollowedFriendNotInGame, 1)
            SocialContextToastEvents(services.eventIngest, {
                toastType = ToastTypes.InviteBack,
                friendId = tostring(joinerUserId),
                universeId = universeId,
                placeId = placeId,
                actionType = SocialContextToastAnalyticsActionTypes.Shown
            })
            local function onInviteBackButtonClick()
                analytics.Diag:reportCounter(SocialContextToastDiagKeys.InviteBackButtonClicked, 1)
                SocialContextToastEvents(services.eventIngest, {
                    toastType = ToastTypes.InviteBack,
                    friendId = tostring(joinerUserId),
                    universeId = universeId,
                    placeId = placeId,
                    actionType = SocialContextToastAnalyticsActionTypes.ButtonClicked
                })
                PostSendExperienceInvite(services.networking, tostring(joinerUserId), tostring(placeId), "SocialContextToast"):andThen(
                    function(_)
                        callback(SetToastContent({ toastType = ToastTypes.InviteSuccess }))
                    end,
                    function(_)
                        callback(SetToastContent({ toastType = ToastTypes.InviteFailure }))
                    end
                )
            end

            return getNames(services.apolloClient, { joinerUserId }):andThen(function(tbl1)
                if #tbl1 == 0 then
                    return
                end
                callback(
                    SetToastContent({
                        toastType = ToastTypes.InviteBack,
                        joinerUserId = joinerUserId,
                        joinerName = tbl1[1].name,
                        onActivated = onInviteBackButtonClick
                    })
                )
            end)
        end

        analytics.Diag:reportCounter(SocialContextToastDiagKeys.FollowedFriendInOtherUniverse, 1)
        SocialContextToastEvents(services.eventIngest, {
            toastType = ToastTypes.FollowYourFriend,
            friendId = tostring(joinerUserId),
            universeId = universeId,
            placeId = placeId,
            actionType = SocialContextToastAnalyticsActionTypes.Shown
        })
        local function closeCallback(arg2)
            if not arg2 then
                callback(SetConfirmationModal(false))
                return
            end
            analytics.Diag:reportCounter(SocialContextToastDiagKeys.ConfirmLeaveGameButtonClicked, 1)
            SocialContextToastEvents(services.eventIngest, {
                toastType = "LeaveGameConfirmationModal",
                friendId = tostring(joinerUserId),
                universeId = universeId,
                placeId = placeId,
                actionType = SocialContextToastAnalyticsActionTypes.ButtonClicked
            })

            local str1 = string.format("roblox://userid=%s&placeid=%s", tostring(joinerUserId), var2.placeId)
            JoinExperience(str1, true)
        end

        local function onJoinFriendButtonClick()
            analytics.Diag:reportCounter(SocialContextToastDiagKeys.JoinFriendButtonClicked, 1)
            SocialContextToastEvents(services.eventIngest, {
                toastType = ToastTypes.FollowYourFriend,
                friendId = tostring(joinerUserId),
                universeId = universeId,
                placeId = placeId,
                actionType = SocialContextToastAnalyticsActionTypes.ButtonClicked
            })
            callback(SetConfirmationModal(true, closeCallback))
        end

        return getNames(services.apolloClient, { joinerUserId }):andThen(function(arg2)
            if #arg2 == 0 then
                return
            end
            callback(
                SetToastContent({
                    toastType = ToastTypes.FollowYourFriend,
                    joinerUserId = joinerUserId,
                    joinerName = arg2[1].name,
                    experienceName = var2.lastLocation,
                    onActivated = onJoinFriendButtonClick
                })
            )
        end)
    end, function(_)
        analytics.Diag:reportCounter(SocialContextToastDiagKeys.ErrorFetchingPresence, 1)
    end)
end

function SocialContextToastDispatcher(tbl1)
    local services = tbl1.services
    local analytics = services.analytics
    local playersService = services.playersService
    local ref = React.createRef()
    local networking = services.networking

    local var2 = React.useRef(nil)
    local var3 = React.useRef(nil)
    local var4 = if GetFFlagEnableReferredPlayerJoinRemoteEvent() then React.useRef(nil) else nil
    local var5 = if GetFFlagEnableReferredPlayerJoinRemoteEvent() then React.useRef(0) else nil
    local var6 = useDispatch()

    local function showToastOnJoin()
        local followUserId = playersService.LocalPlayer.FollowUserId
        local bool1 = false
        local tbl2 = {}

        local tbl3 = {}
        for _, player in pairs(playersService:GetPlayers()) do
            table.insert(tbl3, player.UserId)
        end

        DEPRECATED_FriendsGetFriendStatuses(networking, tbl3):andThen(function(arg1)
            if not (arg1 and arg1.responseBody and arg1.responseBody.data) then
                return
            end

            local data = arg1.responseBody.data
            for _, value in pairs(data) do
                local id = value.id
                if id == followUserId then
                    bool1 = true
                end
                if value.status == "Friends" then
                    table.insert(tbl2, id)
                end
            end

            if followUserId > 0 and not bool1 then
                return handleFollowedPlayerDisconnected(services, var6, followUserId, tbl2, tbl1.gameId, tbl1.placeId)
            end

            return showYouJoinedFriendsToast(services, var6, followUserId, tbl2, bool1, tbl1.gameId, tbl1.placeId)
        end)
    end
    local function onPlayerAdded(arg1)
        local localPlayer = playersService.LocalPlayer
        if arg1.FollowUserId ~= localPlayer.UserId then
            return
        end

        local success, result = pcall(function()
            return localPlayer:IsFriendsWithAsync(arg1.UserId)
        end)

        if not success or not result then
            return
        end

        analytics.Diag:reportCounter(SocialContextToastDiagKeys.YouWereFollowed, 1)
        SocialContextToastEvents(services.eventIngest, {
            toastType = ToastTypes.FriendJoinedYou,
            friendId = tostring(arg1.UserId),
            universeId = tbl1.gameId,
            placeId = tbl1.placeId,
            actionType = SocialContextToastAnalyticsActionTypes.Shown
        })

        local tbl2 = { arg1.UserId }
        getNames(services.apolloClient, tbl2):andThen(function(arg2)
            local name = arg2[1].name
            if name == nil then
                name = arg1.DisplayName
            end
            var6(SetToastContent({ toastType = ToastTypes.FriendJoinedYou, joinerUserId = arg1.UserId, joinerName = name }))
        end)
    end

    if FFlagEnablePartyNudgeAfterJoin then
        useOneToOnePartyNudgeStartPartyRejected(function(arg1)
            if not arg1 or not arg1.inviterId then
                return
            end

            local playerByUserId = playersService:GetPlayerByUserId(arg1.inviterId)
            if playerByUserId then
                onPlayerAdded(playerByUserId)
            end
        end)
    end

    local var7 = if GetFFlagEnableReferredPlayerJoinRemoteEvent() then React.useCallback(function(arg1)
        if var5.current >= GetFIntMaxReferredPlayerJoinToasts() then
            return
        end
        var5.current += 1

        var6(
            SetToastContent({ toastType = ToastTypes.InviteeJoinedYou, joinerUserId = arg1.UserId, joinerName = arg1.DisplayName })
        )
    end, { if FFlagShowFriendJoinedYouToastForNonReferredJoins then var6 else nil }) else nil

    local useEffect = React.useEffect

    local function func1()
        local bool1 = true
        if FFlagEnablePartyNudgeAfterJoin and services.showPlayerJoinedFriendsToastRemoteEvent then
            bool1 = false
            var3.current = services.showPlayerJoinedFriendsToastRemoteEvent.OnClientEvent:Connect(function()
                bool1 = true
            end)
        end

        task.delay(num1, function()
            if ref.current then
                return
            end

            if #playersService:GetPlayers() > 0 and bool1 then
                showToastOnJoin()
            end
            if FFlagEnablePartyNudgeAfterJoin or FFlagShowFriendJoinedYouToastForNonReferredJoins then
                if services.showFriendJoinedPlayerToastRemoteEvent then
                    var2.current = services.showFriendJoinedPlayerToastRemoteEvent.OnClientEvent:Connect(onPlayerAdded)
                end
            else
                var2.current = playersService.PlayerAdded:Connect(onPlayerAdded)
            end

            if GetFFlagEnableReferredPlayerJoinRemoteEvent() and services.referredPlayerJoinRemoteEvent and var1() then
                var4.current = services.referredPlayerJoinRemoteEvent.OnClientEvent:Connect(var7)
            end
        end)

        return function()
            ref.current = true
            if var2.current then
                var2.current:disconnect()
            end
            if FFlagEnablePartyNudgeAfterJoin and var3.current then
                var3.current:disconnect()
            end

            if GetFFlagEnableReferredPlayerJoinRemoteEvent() and var4.current then
                var4.current:disconnect()
            end
        end
    end

    local var8 = var7
    local referredPlayerJoinRemoteEvent = services.referredPlayerJoinRemoteEvent
    local showFriendJoinedPlayerToastRemoteEvent = if FFlagEnablePartyNudgeAfterJoin then services.showFriendJoinedPlayerToastRemoteEvent else nil
    local showPlayerJoinedFriendsToastRemoteEvent = if FFlagEnablePartyNudgeAfterJoin then services.showPlayerJoinedFriendsToastRemoteEvent else nil
    useEffect(func1, {
        playersService,
        var8,
        referredPlayerJoinRemoteEvent,
        showFriendJoinedPlayerToastRemoteEvent,
        showPlayerJoinedFriendsToastRemoteEvent
    })
end

return SocialContextToastDispatcher
