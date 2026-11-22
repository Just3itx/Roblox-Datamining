-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T19:10:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialProof = script:FindFirstAncestor("SocialProof")
local SocialProofParent = SocialProof.Parent

local React = require(SocialProofParent.React)
local useEntityConnectionsPagination = require(SocialProof.Hooks.useEntityConnectionsPagination)
local UserListViewAdaptor = require(SocialProofParent.UserList).Components.UserListViewAdaptor
local FFlagUserListUseSheet = require(SocialProofParent.SharedFlags).FFlagUserListUseSheet
local UserListSheet = require(script.Parent.UserListSheet)
local Enums = require(SocialProof.Common.Enums)
local useLocalization = require(SocialProofParent.Localization).Hooks.useLocalization
local useNavigationProps = require(SocialProofParent.RobloxAppNavigation).useNavigationProps
local AppPage = require(SocialProofParent.RobloxAppEnums).AppPage
local NavigateDown = require(SocialProofParent.NavigationRodux).Thunks.NavigateDown
local NavigateBack = require(SocialProofParent.NavigationRodux).Thunks.NavigateBack
local FFlagSignalsNavP3Dispatch = require(SocialProofParent.SharedFlags).FFlagSignalsNavP3Dispatch
local NavigationCommands = if FFlagSignalsNavP3Dispatch then require(SocialProofParent.RobloxAppNavigation).NavigationCommands else nil
local useDispatch = require(SocialProofParent.RoactUtils).Hooks.RoactRodux.useDispatch
local Constants = require(SocialProof.Common.Constants)

local tbl1 = {
    position = UDim2.fromScale(0.6, 0),
    size = UDim2.fromScale(0.4, 1),
    anchorPoint = Vector2.new(0, 0)
}

local tbl2 = {
    position = UDim2.fromScale(0.5, 0),
    size = UDim2.new(0, 640, 1, 0),
    anchorPoint = Vector2.new(0.5, 0)
}

local function FriendsOwnedUserList(_)
    local var1 = useDispatch()
    local var2 = useNavigationProps(function(_, arg1)
        return {
            entityId = arg1.entityId,
            entityType = arg1.entityType,
            source = arg1.source
        }
    end)

    local var3 = useEntityConnectionsPagination({
        entityId = var2.entityId,
        entityType = var2.entityType,
        connectionType = Enums.ConnectionType.Friend,
        initialCursor = nil
    })

    local wideModePeekViewLayout = React.useMemo(function()
        return if var2.source == "profile" then tbl2 else tbl1
    end, { var2.source })

    local onLoadMore = React.useCallback(function()
        if var3.hasMore and not var3.isLoading then
            var3.fetchPage()
        end
    end, { var3.hasMore, var3.isLoading, var3.fetchPage })

    local onUserSelected = React.useCallback(function(detail: string)
        local tbl3 = {
            name = AppPage.ProfilePlatform,
            detail = detail,
            extraProps = {
                profileType = Constants.PROFILE_TYPE,
                source = Constants.ITEM_DETAILS_PAGE_SOURCE
            }
        }

        if FFlagUserListUseSheet then
            if FFlagSignalsNavP3Dispatch then
                NavigationCommands.back(true)
                NavigationCommands.down(NavigationCommands.fromLegacyPage(tbl3), true)
                return
            end
            var1(NavigateBack(true))
            var1(NavigateDown(tbl3, true))
        elseif FFlagSignalsNavP3Dispatch then
            NavigationCommands.down(NavigationCommands.fromLegacyPage(tbl3))
        else
            var1(NavigateDown(tbl3))
        end
    end, { var1 })

    local var7 = useLocalization({
        connectionsOwn = {
            "Feature.Friends.Label.FriendsOwn",
            numberOfConnections = var3.totalConnections
        },
        singleConnectionOwns = "Feature.Friends.Label.FriendOwns"
    })
    local title = if var3.totalConnections == 1 then var7.singleConnectionOwns else var7.connectionsOwn

    if var3.totalConnections == 0 then
        return nil
    elseif FFlagUserListUseSheet then
        return React.createElement(UserListSheet, {
            users = var3.userIds,
            title = title,
            onLoadMore = onLoadMore,
            onUserSelected = onUserSelected,
            hasMore = var3.hasMore
        })
    end

    return React.createElement(UserListViewAdaptor, {
        users = var3.userIds,
        title = title,
        totalCount = var3.totalConnections,
        onLoadMore = onLoadMore,
        onUserSelected = onUserSelected,
        hasMore = var3.hasMore,
        wideModePeekViewLayout = wideModePeekViewLayout
    })
end

return FriendsOwnedUserList
