-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:11:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VirtualEvents = script:FindFirstAncestor("VirtualEvents")

local ApolloClient = require(VirtualEvents.Parent.ApolloClient)
local GraphQLServer = require(VirtualEvents.Parent.GraphQLServer)
local React = require(VirtualEvents.Parent.React)
local Rodux = require(VirtualEvents.Parent.Rodux)
local RoactNavigation = require(VirtualEvents.Parent.RoactNavigation)
local RoactRodux = require(VirtualEvents.Parent.RoactRodux)
local RobloxAppLocales = require(VirtualEvents.Parent.RobloxAppLocales)
local Localization = require(VirtualEvents.Parent.Localization)
local UIBlox = require(VirtualEvents.Parent.UIBlox)
local DesignTokenProvider = require(VirtualEvents.Parent.Style).DesignTokenProvider
local VirtualEventsState = require(VirtualEvents.Parent.VirtualEventsState)
local MockContentProvider = UIBlox.UnitTestHelpers.MockContentProvider
local Foundation = require(VirtualEvents.Parent.Foundation)
local FoundationProvider = Foundation.FoundationProvider
local ColorMode = Foundation.Enums.ColorMode

local AppStyleProvider = UIBlox.App.Style.AppStyleProvider
local Constants = UIBlox.App.Style.Constants
local ContentProvider = UIBlox.App.Context.ContentProvider

local var1 = Rodux.combineReducers({ VirtualEvents = VirtualEventsState.installReducer() })

local function withMockProviders(tbl1, tbl2)
    local store = (if tbl2 then tbl2.store else nil)
        or Rodux.Store.new(var1, if tbl2 then tbl2.initialStoreState else nil, { Rodux.thunkMiddleware })

    local tbl3 = {
        StoreProvider = React.createElement(RoactRodux.StoreProvider, { store = store }, {
            ContentProvider = React.createElement(ContentProvider.Provider, {
                value = MockContentProvider.new()
            }, {
                LocalizationProvider = React.createElement(
                    Localization.LocalizationProvider,
                    {
                        localization = RobloxAppLocales.Localization.new("en-us")
                    },
                    {
                        FoundationProvider = React.createElement(FoundationProvider, {
                            colorMode = ColorMode.Dark
                        }, {
                            StyleProvider = React.createElement(
                                AppStyleProvider,
                                {
                                    style = {
                                        themeName = ColorMode.Dark,
                                        fontName = Constants.FontName.Gotham
                                    }
                                },
                                {
                                    NavigationProvider = React.createElement(RoactNavigation.Provider, {
                                        value = {
                                            isFocused = function(): boolean
                                                return true
                                            end,
                                            goBack = function() end,
                                            addListener = function()
                                                return {
                                                    remove = function() end
                                                }
                                            end
                                        }
                                    }, {
                                        DesignTokenProvider = React.createElement(
                                            DesignTokenProvider,
                                            {
                                                tokenMappers = {}
                                            },
                                            {
                                                Children = React.createElement(React.Fragment, nil, tbl1)
                                            }
                                        )
                                    })
                                }
                            )
                        })
                    }
                )
            })
        })
    }

    if tbl2 then
        if tbl2.mockResolvers then
            local graphQlServer = GraphQLServer.GraphQLServer.new({ mockResolvers = tbl2.mockResolvers })

            local apolloClient = ApolloClient.ApolloClient.new({
                cache = ApolloClient.InMemoryCache.new({}),
                link = ApolloClient.HttpLink.new({
                    uri = "/api",
                    fetch = function(_, arg1)
                        return graphQlServer:fetchLocal(arg1)
                    end
                })
            })

            tbl3 = {
                ApolloProvider = React.createElement(ApolloClient.ApolloProvider, { client = apolloClient }, tbl3)
            }
        end

        tbl3 = tbl2.mockNavigation
            and {
                NavigationProvider = React.createElement(RoactNavigation.Provider, { value = tbl2.mockNavigation }, tbl3)
            }
            or tbl3
    end

    return React.createElement(React.Fragment, nil, tbl3)
end

return withMockProviders
