-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:01:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Roact = require(CorePackages.Packages.Roact)
local Rodux = require(CorePackages.Packages.Rodux)
local RoactRodux = require(CorePackages.Packages.RoactRodux)
local UIBlox = require(CorePackages.Packages.UIBlox)
local Foundation = require(CorePackages.Packages.Foundation)

local scriptParent = script.Parent
local Reducers = scriptParent.Reducers
local Reducer = require(Reducers.Reducer)

local Connection = script.Parent.Components.Connection
local Provider = require(Connection.LayoutValues).Provider

local PlayerList = require(CorePackages.Workspace.Packages.PlayerList)
local LayoutValuesContext = PlayerList.Common.LayoutValuesContext
local LeaderboardStoreContext = PlayerList.LeaderboardStoreContext

local var1 = require(CorePackages.Workspace.Packages.LeaderboardStore).dev.createMockLeaderboardStore()()

local ApolloProvider = require(CorePackages.Packages.ApolloClient).ApolloProvider

local mockApolloClient = require(CorePackages.Workspace.Packages.GraphQLServer).ApolloClientTestUtils.mockApolloClient

local Array = require(CorePackages.Packages.LuauPolyfill).Array

local CreateLayoutValues = require(scriptParent.CreateLayoutValues)

local function TestProviders(arg1)
    local store = Rodux.Store.new(Reducer)
    local var2 = mockApolloClient({
        mockResolvers = {
            Query = {
                userProfiles = function(_, arg2, _, _)
                    return (Array.map(arg2.userIds, function(userId)
                        return {
                            userId = userId,
                            names = {
                                alias = `alias{userId}`,
                                combinedName = `combinedName{userId}`,
                                contactName = `contactName{userId}`,
                                displayName = `displayName{userId}`,
                                username = `username{userId}`,
                                platformName = `platformName{userId}`,
                                inExperienceCombinedName = `inExperienceCombinedName{userId}`
                            }
                        }
                    end))
                end
            },
            UserProfile = {
                id = function(arg2): string
                    return tostring(arg2.userId)
                end,
                names = function(arg2)
                    return arg2.names
                end
            }
        }
    })

    return Roact.createElement(RoactRodux.StoreProvider, {
        store = arg1.store or store
    }, {
        ApolloProvider = Roact.createElement(ApolloProvider, {
            client = arg1.client or var2
        }, {
            LayoutValuesProvider_DEPRECATED = Roact.createElement(
                Provider,
                {
                    layoutValues = arg1.layoutValues or CreateLayoutValues(false)
                },
                {
                    ThemeProvider = Roact.createElement(UIBlox.App.Style.AppStyleProvider, {
                        style = arg1.style
                    }, {
                        FoundationProvider = Roact.createElement(
                            Foundation.FoundationProvider,
                            {
                                colorMode = Foundation.Enums.ColorMode.Dark
                            },
                            {
                                LayoutValuesProvider = Roact.createElement(
                                    LayoutValuesContext.Provider,
                                    {
                                        value = arg1.layoutValues or CreateLayoutValues(false)
                                    },
                                    {
                                        LeaderboardStoreProvider = Roact.createElement(LeaderboardStoreContext.Provider, { value = arg1.leaderboardStore or var1 }, arg1.children)
                                    }
                                )
                            }
                        )
                    })
                }
            )
        })
    })
end

return TestProviders
