-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T19:51:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialServerDrivenUiParent = script:FindFirstAncestor("SocialServerDrivenUi").Parent

local React = require(SocialServerDrivenUiParent.React)
local RoactUtils = require(SocialServerDrivenUiParent.RoactUtils)
local SduiCoreSystem = require(SocialServerDrivenUiParent.SduiCoreSystem)
local UserSearch = require(SocialServerDrivenUiParent.UserSearch)
local UserSearchTile = UserSearch.UserSearchTile
local Analytics = UserSearch.Analytics.Analytics
local NavigateDown = require(SocialServerDrivenUiParent.NavigationRodux).Thunks.NavigateDown
local SharedFlags = require(SocialServerDrivenUiParent.SharedFlags)
local AppPage = require(SocialServerDrivenUiParent.RobloxAppEnums).AppPage
local UnifiedLogging = require(SocialServerDrivenUiParent.UnifiedLogging)

local findAnalyticsFieldInAncestors = SduiCoreSystem.findAnalyticsFieldInAncestors
local calculateRowPositionFields = UnifiedLogging.calculateRowPositionFields

local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local FFlagSignalsNavP3Dispatch = SharedFlags.FFlagSignalsNavP3Dispatch
local FFlagLuaAppSearchPeopleUnifiedSchemaFields = SharedFlags.FFlagLuaAppSearchPeopleUnifiedSchemaFields
local NavigationCommands = if FFlagSignalsNavP3Dispatch then require(SocialServerDrivenUiParent.RobloxAppNavigation).NavigationCommands else nil

return React.memo(function(tbl1) -- name: SduiUserSearchTile
    local var1 = useDispatch()
    local userId = tbl1.userId

    local searchKeyword = findAnalyticsFieldInAncestors("searchQuery", tbl1.analyticsContext) or ""
    local userSearchSessionId = findAnalyticsFieldInAncestors("userSearchSessionId", tbl1.analyticsContext)
    local sortId = findAnalyticsFieldInAncestors("collectionId", tbl1.analyticsContext)
    local sortPosition = findAnalyticsFieldInAncestors("collectionPosition", tbl1.analyticsContext)
    local appPage = if tbl1.sduiContext then tbl1.sduiContext.appPage else nil

    local fireAnalyticsEvent = React.useMemo(function()
        return Analytics({
            infoForAllEvents = {
                userSearchSessionId = userSearchSessionId,
                sortPosition = sortPosition,
                sortId = sortId,
                pageContext = appPage
            }
        }).fireAnalyticsEvent
    end, {
        userSearchSessionId,
        sortPosition,
        sortId,
        appPage
    })

    local collectionData = if tbl1.analyticsContext and tbl1.analyticsContext.getCollectionData then tbl1.analyticsContext.getCollectionData() else nil
    local rowPositionFields = calculateRowPositionFields(
        tbl1.index,
        if collectionData then collectionData.itemsPerRow else nil,
        if collectionData then collectionData.startRowNumber else nil
    )

    local navigateToUserInfo = React.useCallback(function(arg1)
        local tbl2 = {
            name = AppPage.ProfilePlatform,
            detail = arg1.userId,
            extraProps = {
                profileType = "User",
                profilePeekViewProps = {
                    resetPeekView = false,
                    source = "PlayerSearch",
                    contextualInfoType = arg1.contextualInfoType,
                    contextualInfoDisplay = arg1.contextualInfoDisplay,
                    analyticsProps = userSearchSessionId and {
                        userSearchSessionId = userSearchSessionId
                    } or nil
                }
            }
        }
        if FFlagSignalsNavP3Dispatch then
            NavigationCommands.down(NavigationCommands.fromLegacyPage(tbl2))
            return
        end
        var1(NavigateDown(tbl2))
    end, { var1, userSearchSessionId })

    if userId == nil or userId == "" then
        return nil
    end

    return React.createElement(UserSearchTile, {
        user = {
            id = userId,
            name = tbl1.name or "",
            displayName = tbl1.displayName or "",
            previousUsernames = if SharedFlags.FFlagUserSearchUsePreviousUsernameMatch then nil else tbl1.previousUsernames or {},
            isPreviousUsernameMatch = if SharedFlags.FFlagUserSearchUsePreviousUsernameMatch then tbl1.isPreviousUsernameMatch else nil
        },
        index = tbl1.index or 0,
        size = UDim2.fromScale(1, 1),
        searchParameters = { searchKeyword = searchKeyword },
        luaAppNavigation = { navigateToUserInfo = navigateToUserInfo },
        fireAnalyticsEvent = fireAnalyticsEvent,
        subpage = "UserSearchFeedItem",
        shouldUseCompactTiles = true,
        rowInSort = rowPositionFields.rowInSort,
        positionInRow = if FFlagLuaAppSearchPeopleUnifiedSchemaFields then rowPositionFields.positionInRow else nil,
        feedRowNumber = if FFlagLuaAppSearchPeopleUnifiedSchemaFields then rowPositionFields.rowOnPage else nil
    })
end)
