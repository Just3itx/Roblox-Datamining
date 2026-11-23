-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T03:11:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserSearch = script:FindFirstAncestor("UserSearch")
local UserSearchParent = UserSearch.Parent

local Roact = require(UserSearchParent.Roact)
local Dash = require(UserSearchParent.Dash)
local UIBlox = require(UserSearchParent.UIBlox)
local RoactRodux = require(UserSearchParent.RoactRodux)
local Rodux = require(UserSearchParent.Rodux)

local mockLocale = require(UserSearchParent.Dev.SocialTestHelpers).StoryHelpers.mockLocale
local ApolloClient = require(UserSearchParent.ApolloClient)
local mockApolloClient = require(UserSearchParent.GraphQLServer).ApolloClientTestUtils.mockApolloClient

local RobloxAppUIBloxConfig = require(UserSearchParent.Dev.RobloxAppUIBloxConfig)

UIBlox.init(RobloxAppUIBloxConfig)

local AppStyleProvider = UIBlox.App.Style.AppStyleProvider

Roact.setGlobalConfig({ elementTracing = true })

local tbl1 = {
    Default = { themeName = "Light", fontName = "Gotham" },
    Light = { themeName = "Light", fontName = "Gotham" },
    Dark = { themeName = "Dark", fontName = "Gotham" }
}

local tbl2 = { language = "en-us" }

local function func1(arg1)
    return Rodux.Store.new(function()
        return arg1
    end, {}, { Rodux.thunkMiddleware })
end

return {
    name = "UserSearch",
    storyRoot = UserSearch,
    roact = Roact,
    mapDefinition = function(tbl3)
        local controls = Dash.join(tbl2, tbl3.controls or {})
        return Dash.join(tbl3, { controls = controls, state = tbl3.state or {} })
    end,
    mapStory = function(arg1)
        return function(arg2)
            local state = arg2.definition.state or {}
            return Roact.createElement(AppStyleProvider, {
                style = arg2 and tbl1[arg2.theme] or tbl1.Default
            }, {
                storeProvider = Roact.createElement(RoactRodux.StoreProvider, {
                    store = func1(state)
                }, {
                    apolloClient = Roact.createElement(ApolloClient.ApolloProvider, { client = mockApolloClient({}) }, { Child = mockLocale(arg1, arg2) })
                })
            })
        end
    end
}
