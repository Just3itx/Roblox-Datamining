-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T16:01:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsLanding = script:FindFirstAncestor("FriendsLanding")
local dependencies = require(FriendsLanding.dependencies)

local Roact = dependencies.Roact
local withStyle = dependencies.UIBlox.Style.withStyle

local FriendsLandingContext = require(FriendsLanding.FriendsLandingContext)

local var1 = Roact.PureComponent:extend("PlayerSearchWrapper")

var1.defaultProps = { layoutOrder = 1, onActivated = nil, searchText = "" }

function var1.render(arg1)
    return FriendsLandingContext.with(function(arg2)
        return withStyle(function(arg3)
            local searchKeyword = arg1.props.navigation.getParam("searchText", nil) or ""

            local shouldShowUserSearchLandingPage = arg1.props.navigation.getParam("shouldShowUserSearchLandingPage", nil)

            return Roact.createElement("Frame", {
                Size = UDim2.fromScale(1, 1),
                BackgroundColor3 = arg3.Theme.BackgroundDefault.Color,
                BackgroundTransparency = 0,
                BorderSizePixel = 0
            }, { Roact.createElement(arg2.playerSearchPage, {
                    searchParameters = {
                        searchKeyword = searchKeyword,
                        isKeywordSuggestionEnabled = true
                    },
                    shouldShowUserSearchLandingPage = shouldShowUserSearchLandingPage
                }) })
        end)
    end)
end

return var1
