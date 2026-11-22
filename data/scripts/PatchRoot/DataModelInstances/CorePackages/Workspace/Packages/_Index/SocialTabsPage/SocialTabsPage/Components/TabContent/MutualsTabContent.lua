-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T21:01:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialTabsPage = script:FindFirstAncestor("SocialTabsPage")
local SocialTabsPageParent = SocialTabsPage.Parent

local React = require(SocialTabsPageParent.React)
local Dash = require(SocialTabsPageParent.Dash)
local Foundation = require(SocialTabsPageParent.Foundation)
local View = Foundation.View
local Loading = Foundation.Loading

local UserList = require(SocialTabsPageParent.UserList)
local UserListLayoutAdaptor = UserList.UserListLayoutAdaptor
local LayoutMode = UserList.Enums.LayoutMode
local EntityType = UserList.Enums.EntityType

local RowDataProvider = require(SocialTabsPage.Components.RowDataProvider)
local useSocialTabsContext = require(SocialTabsPage.Contexts.useSocialTabsContext)
local useMutualsList = require(SocialTabsPage.Hooks.useMutualsList)
local useSortedEntitiesByPresence = require(SocialTabsPage.Hooks.useSortedEntitiesByPresence)
local useUserListCTAs = require(SocialTabsPage.Hooks.useUserListCTAs)
local useCTAActionHandlers = require(SocialTabsPage.Hooks.useCTAActionHandlers)
local SocialTabsCtaConfig = require(SocialTabsPage.Common.SocialTabsCtaConfig)
local FFlagUserListCtaIntegrationEnabled = require(SocialTabsPageParent.SharedFlags).FFlagUserListCtaIntegrationEnabled

local function MutualsTabContent()
    local profileId = useSocialTabsContext().profileId

    local var1 = useMutualsList(profileId)

    local var2 = React.useMemo(function()
        return Dash.map(var1.mutualFriends, function(arg1)
            return {
                id = arg1.id,
                type = EntityType.User
            }
        end)
    end, { var1.mutualFriends })

    local var3 = React.useMemo(function()
        return Dash.map(var2, function(arg1)
            return arg1.id
        end)
    end, { var2 })

    local entities = useSortedEntitiesByPresence(var2)
    local var5

    if FFlagUserListCtaIntegrationEnabled then
        var5 = nil
    else
        local var6 = useUserListCTAs(var3)
        local actionHandlers = useCTAActionHandlers()

        var5 = React.useCallback(function(createRow, entity, _: number)
            return React.createElement(
                RowDataProvider,
                {
                    createRow = createRow,
                    entity = entity,
                    ctaResult = var6[entity.id],
                    actionHandlers = actionHandlers
                }
            )
        end, { var6, actionHandlers })
    end

    if var1.isLoading and #var2 == 0 then
        return React.createElement(
            View,
            { tag = "col align-x-center align-y-center size-full" },
            {
                LoadingIndicator = React.createElement(Loading)
            }
        )
    end
    local createElement = React.createElement
    local var6 = View
    local tbl1 = { tag = "col size-full padding-x-xlarge" }

    local tbl2 = {
        MutualsList = React.createElement(UserListLayoutAdaptor, {
            entities = entities,
            layoutMode = LayoutMode.Vertical,
            isScrollEnabled = true,
            hasMore = var1.hasMore,
            onLoadMore = if var1.hasMore then var1.loadMore else nil,
            renderRow = var5,
            ctaConfig = if FFlagUserListCtaIntegrationEnabled then SocialTabsCtaConfig.Mutuals else nil,
            rowSelectionConfig = SocialTabsCtaConfig.RowSelection
        })
    }
    return createElement(var6, tbl1, tbl2)
end

return MutualsTabContent
