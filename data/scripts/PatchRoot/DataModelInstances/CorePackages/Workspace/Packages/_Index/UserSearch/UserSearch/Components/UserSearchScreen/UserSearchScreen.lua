-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T03:01:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local UserSearch = script:FindFirstAncestor("UserSearch")
local UserSearchParent = UserSearch.Parent

local React = require(UserSearchParent.React)

local AppPage = require(UserSearchParent.RobloxAppEnums).AppPage

local useStyle = require(UserSearchParent.UIBlox).Core.Style.useStyle
local FullscreenPageWithSafeArea = require(UserSearchParent.AppBlox).FullscreenPageWithSafeArea

local useNavigation = require(UserSearchParent.Navigation).useNavigation

local UserSearchHeaderBar = require(UserSearch.Components.UserSearchHeaderBar)

local Analytics = require(UserSearch.Analytics)
local EventNames = Analytics.EventNames
local useUserSearchAnalytics = Analytics.useUserSearchAnalytics

local function UserSearchScreen(tbl1)
    local renderUserSearchResults = tbl1.renderUserSearchResults

    local var1 = useNavigation()

    local var2 = useStyle()
    local tokens = var2.Tokens

    local searchKeyword = var1.getParam("searchKeyword")
    local param2 = var1.getParam("shouldShowUserSearchLandingPage")
    local param3 = var1.getParam("entryPoint")

    local var3 = React.useRef(HttpService:GenerateGUID(false))
    local var4 = useUserSearchAnalytics({ currentPage = param3, userSearchSessionId = var3.current })

    React.useEffect(function()
        if param2 then
            var4.fireAnalyticsEvent(EventNames.UserSearchBarOpen)
        end
    end, {})

    local onSubmitSearch = React.useCallback(function(arg1)
        var1.replace(AppPage.UserSearch, { searchKeyword = arg1, entryPoint = param3 })

        var4.fireAnalyticsEvent(EventNames.UserSearchBarSubmit, { kwd = arg1 })
    end, { param3 })

    local onBackClick = React.useCallback(function()
        var1.pop()

        var4.fireAnalyticsEvent(EventNames.UserSearchBarCancel)
    end, {})

    local userSearchPage = React.useMemo(function()
        return renderUserSearchResults(
            {
                searchKeyword = searchKeyword,
                shouldShowUserSearchLandingPage = param2,
                searchUuid = var3.current
            }
        )
    end, { searchKeyword, param2, var3 })

    return React.createElement(FullscreenPageWithSafeArea, {
        includeStatusBar = true,
        BackgroundColor3 = var2.Theme.BackgroundDefault.Color,
        BackgroundTransparency = var2.Theme.BackgroundDefault.Transparency,
        buttonRef = tbl1.containerRef
    }, {
        UserSearchHeaderBar = React.createElement(UserSearchHeaderBar, {
            searchKeyword = searchKeyword,
            focusOnSearchInput = param2,
            onSubmitSearch = onSubmitSearch,
            onBackClick = onBackClick,
            headerHeight = tokens.Size.Size_1200
        }),
        PageContent = React.createElement("Frame", {
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 0, 0, tokens.Size.Size_1200),
            Size = UDim2.new(1, 0, 1, -tokens.Size.Size_1200)
        }, { UserSearchPage = userSearchPage })
    })
end

return UserSearchScreen
