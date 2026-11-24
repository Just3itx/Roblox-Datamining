-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T14:40:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameInvite = script:FindFirstAncestor("GameInvite")
local GameInviteParent = GameInvite.Parent
local React = require(GameInviteParent.React)
local FriendsMenu = require(GameInviteParent.FriendsMenu)
local UserList = require(GameInviteParent.UserList)
local DataHydration = require(GameInviteParent.DataHydration)
local useAppPolicy = require(GameInviteParent.UniversalAppPolicy).useAppPolicy

local GameInviteConstants = require(GameInvite.GameInviteConstants)
local _gameInviteModalType = require(GameInvite.gameInviteModalType)
local GameDetailsContext = require(GameInvite.Context.GameDetailsContext)
local GameInviteFriendRow = require(script.Parent.GameInviteFriendRow)
local _GameInviteFriendsListView = require(script.Parent.GameInviteFriendsListView)
local canShareGameInviteLink = require(script.Parent.canShareGameInviteLink)
local useGameInviteJoinCard = require(script.Parent.useGameInviteJoinCard)
local isInThisServer = require(GameInvite.utils.isInThisServer)
local isJoinExpected = require(GameInvite.utils.isJoinExpected)
local shouldShowJoinCta = require(GameInvite.utils.shouldShowJoinCta)
local FFlagGameInviteInExpJoinCta = require(GameInvite.Flags.FFlagGameInviteInExpJoinCta)
local FFlagGameInviteInExpLivePresence = require(GameInvite.Flags.FFlagGameInviteInExpLivePresence)
local FFlagGameInviteInExpRefetchOnPresenceEvent = require(GameInvite.Flags.FFlagGameInviteInExpRefetchOnPresenceEvent)
local useRefetchOnlineFriendsOnPresenceEvent = if FFlagGameInviteInExpRefetchOnPresenceEvent then require(script.Parent.useRefetchOnlineFriendsOnPresenceEvent) else nil
local FFlagUserListHideNotJoinableJoin = require(GameInviteParent.SharedFlags).FFlagUserListHideNotJoinableJoin
local isPioneerLaunch = if FFlagUserListHideNotJoinableJoin then require(GameInviteParent.PioneerUtils).isPioneerLaunch else nil
local User = UserList.Enums.EntityType.User

local function ignoreRowSelection() end

local function isJoinVisible(arg1): boolean
    return not isInThisServer(arg1, game.JobId)
end

local function createJoinCtaConfig(friendsById, onActivated: (...any) -> (...any))
    return {
        supportedActions = { "JoinExperience" },
        primaryCtaMinWidth = GameInviteConstants.Layout.JoinCtaMinWidth,
        primaryCtaMaxWidth = GameInviteConstants.Layout.JoinCtaMaxWidth,
        enableJoinabilityCheck = if FFlagUserListHideNotJoinableJoin and isPioneerLaunch() then true else nil,
        join = {
            onActivated = onActivated,
            isVisible = isJoinVisible,
            isJoinExpected = function(str1: string, arg1)
                return isJoinExpected(arg1, friendsById[str1], game.JobId)
            end
        }
    }
end

local function useJoinCtaConfig<T>(friendsById, arg1, open: (...any) -> (...any))
    local var1 = shouldShowJoinCta(arg1)
    return React.useMemo(function()
        if var1 then
            return (createJoinCtaConfig(friendsById, open))
        end

        return nil
    end, { var1, friendsById, open })
end

local function useGameInviteFriendsListViewModel(tbl1)
    local var1 = React.useContext(FriendsMenu.FriendsListContext)
    local friends = var1.friends
    local var2 = React.useContext(GameDetailsContext)
    local var3 = useAppPolicy(function(arg1)
        return arg1.getExperienceInviteShareLinkEnabled()
    end)
    if FFlagGameInviteInExpLivePresence then
        React.useEffect(function()
            DataHydration.Friends.FriendsStore.get().RefetchOnlineFriends()
        end, {})
    end

    local var4 = React.useMemo(function()
        local entities = {}
        local friendsById = {}
        for _, friend in friends do
            if friend.isLoadingPlaceholder or friendsById[friend.id] ~= nil then
                continue
            end

            table.insert(entities, { id = friend.id, type = User })
            friendsById[friend.id] = friend
        end
        return { entities = entities, friendsById = friendsById }
    end, { friends })

    local friendsById = var4.friendsById
    if FFlagGameInviteInExpRefetchOnPresenceEvent then
        useRefetchOnlineFriendsOnPresenceEvent(friendsById)
    end

    local var5 = if FFlagGameInviteInExpJoinCta then useGameInviteJoinCard(tostring(game.GameId), game.JobId) else nil
    local var6 = if FFlagGameInviteInExpJoinCta then useJoinCtaConfig(friendsById, var2, var5.open) else nil

    local renderRow = React.useCallback(function(createRow, arg1, rowNumber: number)
        local friend = friendsById[arg1.id]
        if friend == nil then
            return nil
        end
        return React.createElement(GameInviteFriendRow, { createRow = createRow, friend = friend, rowNumber = rowNumber })
    end, { friendsById })

    local fetchMoreFriends = var1.fetchMoreFriends
    local var8 = React.useCallback(function()
        fetchMoreFriends()
    end, { fetchMoreFriends })

    local tbl2 = {
        layoutOrder = tbl1.layoutOrder,
        size = tbl1.size,
        entities = var4.entities,
        renderRow = renderRow,
        onRowSelected = ignoreRowSelection,
        onEndReached = 0,
        showShareGameInviteLink = 0,
        ctaConfig = 0,
        joinCard = 0
    }
    if not fetchMoreFriends or var1.searchFriendsString ~= "" then
        var8 = nil
    end

    tbl2.onEndReached = var8
    tbl2.showShareGameInviteLink = canShareGameInviteLink(game.GameId, var2, var3)
    tbl2.ctaConfig = if FFlagGameInviteInExpJoinCta then var6 else nil
    if not FFlagGameInviteInExpJoinCta or var6 == nil then
        var5 = nil
    end

    tbl2.joinCard = var5
    return tbl2
end

return useGameInviteFriendsListViewModel
