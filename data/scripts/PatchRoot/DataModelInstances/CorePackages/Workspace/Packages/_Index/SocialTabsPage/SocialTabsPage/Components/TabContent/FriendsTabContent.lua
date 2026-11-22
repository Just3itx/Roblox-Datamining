-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T21:01:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialTabsPage = script:FindFirstAncestor("SocialTabsPage")
local SocialTabsPageParent = SocialTabsPage.Parent

local React = require(SocialTabsPageParent.React)
local Dash = require(SocialTabsPageParent.Dash)
local Foundation = require(SocialTabsPageParent.Foundation)
local View = Foundation.View
local Loading = Foundation.Loading
local useLocalization = require(SocialTabsPageParent.Localization).Hooks.useLocalization

local UserList = require(SocialTabsPageParent.UserList)
local UserListLayoutAdaptor = UserList.UserListLayoutAdaptor
local LayoutMode = UserList.Enums.LayoutMode
local EntityType = UserList.Enums.EntityType

local SocialTabsEmptyState = require(SocialTabsPage.Components.SocialTabsEmptyState)
local RowDataProvider = require(SocialTabsPage.Components.RowDataProvider)
local useSocialTabsContext = require(SocialTabsPage.Contexts.useSocialTabsContext)
local useFriendsList = require(SocialTabsPage.Hooks.useFriendsList)
local useUserListCTAs = require(SocialTabsPage.Hooks.useUserListCTAs)
local useCTAActionHandlers = require(SocialTabsPage.Hooks.useCTAActionHandlers)
local SocialTabsCtaConfig = require(SocialTabsPage.Common.SocialTabsCtaConfig)
local TextKeys = require(SocialTabsPage.Common.TextKeys)
local FFlagUserListCtaIntegrationEnabled = require(SocialTabsPageParent.SharedFlags).FFlagUserListCtaIntegrationEnabled

local function FriendsTabContent()
    local var1 = useSocialTabsContext()
    local profileId = var1.profileId
    local title = var1.title

    local var2 = useFriendsList({ targetUserId = profileId })

    local friends = var2.friends
    local loading = var2.loading
    local hasMore = var2.hasMore
    local fetchMore = var2.fetchMore

    local var3 = useLocalization({ emptyText = { TextKeys.NoFriendsYet, name = title or "" } })

    local entities = React.useMemo(function()
        return Dash.map(friends, function(arg1)
            return {
                id = tostring(arg1.id),
                type = EntityType.User
            }
        end)
    end, { friends })

    local var5 = React.useMemo(function()
        return Dash.map(entities, function(arg1)
            return arg1.id
        end)
    end, { entities })

    local var6

    if FFlagUserListCtaIntegrationEnabled then
        var6 = nil
    else
        local var7 = useUserListCTAs(var5)
        local actionHandlers = useCTAActionHandlers()

        var6 = React.useCallback(function(createRow, entity, _: number)
            return React.createElement(
                RowDataProvider,
                {
                    createRow = createRow,
                    entity = entity,
                    ctaResult = var7[entity.id],
                    actionHandlers = actionHandlers
                }
            )
        end, { var7, actionHandlers })
    end

    if loading and #entities == 0 then
        return React.createElement(
            View,
            { tag = "col align-x-center align-y-center size-full" },
            {
                LoadingIndicator = React.createElement(Loading)
            }
        )
    end
    if not loading and #entities == 0 then
        return (React.createElement(SocialTabsEmptyState, { text = var3.emptyText }))
    end

    local createElement = React.createElement
    local var7 = View
    local tbl1 = { tag = "col size-full padding-x-xlarge" }

    local tbl2 = { FriendsList = 0 }
    local createElement2 = React.createElement
    local var8 = UserListLayoutAdaptor
    local tbl3 = {
        entities = entities,
        layoutMode = LayoutMode.Vertical,
        isScrollEnabled = true,
        hasMore = hasMore,
        onLoadMore = 0,
        renderRow = 0,
        ctaConfig = 0,
        rowSelectionConfig = 0
    }

    if not hasMore then
        fetchMore = nil
    end

    tbl3.onLoadMore = fetchMore
    tbl3.renderRow = var6
    tbl3.ctaConfig = if FFlagUserListCtaIntegrationEnabled then SocialTabsCtaConfig.Friends else nil
    tbl3.rowSelectionConfig = SocialTabsCtaConfig.RowSelection
    tbl2.FriendsList = createElement2(var8, tbl3)
    return createElement(var7, tbl1, tbl2)
end

return FriendsTabContent
