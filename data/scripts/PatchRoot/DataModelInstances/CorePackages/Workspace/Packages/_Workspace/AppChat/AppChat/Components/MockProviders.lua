-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:30:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent
local React = require(AppChatParent.React)
local ProviderContainer = require(AppChatParent.RoactUtils).Components.ProviderContainer
local Style = require(AppChatParent.Style)
local StyleProviderWithDefaultTheme = Style.StyleProviderWithDefaultTheme
local LocalizationProvider = require(AppChatParent.Localization).LocalizationProvider
local UIBlox = require(AppChatParent.UIBlox)
local FoundationProvider = require(AppChatParent.Foundation).FoundationProvider
local LayerCollectorProvider = UIBlox.Core.Layout.LayerCollector.LayerCollectorProvider
local Signal = require(AppChatParent.AppCommonLib).Signal
local Cryo = require(AppChatParent.Cryo)
local UniversalAppPolicy = require(AppChatParent.UniversalAppPolicy)
local SocialPolicies = require(AppChatParent.SocialPolicies)

local UserProfiles = require(AppChatParent.UserProfiles)
local ApolloClient = require(AppChatParent.ApolloClient)
local mockApolloClient = require(AppChatParent.GraphQLServer).ApolloClientTestUtils.mockApolloClient
local MockUserData = require(AppChat.Users.MockUserData)
local RealtimeProvider = require(AppChatParent.RealtimeDelivery).RealtimeProvider
local InteractionFeedback = require(AppChatParent.InteractionFeedback)
local HapticFeedbackConfig = require(AppChat.Utils.HapticFeedback).HapticFeedbackConfig

local Rodux = require(AppChatParent.Rodux)
local RoactRodux = require(AppChatParent.RoactRodux)

local RoactNavigation = require(AppChatParent.RoactNavigation)

local tbl1 = { withUiModeSupport = false, withLayerCollector = true, withApolloProvider = true }

local function MockProviders(tbl2)
    local var1 = Cryo.Dictionary.union(tbl1, tbl2)
    local providers = {}

    if var1.realtime then
        table.insert(providers, { class = RealtimeProvider, props = { realtime = var1.realtime } })
    end

    table.insert(providers, { class = FoundationProvider, props = { device = "Desktop", theme = var1.themeName } })

    table.insert(providers, {
        class = StyleProviderWithDefaultTheme,
        props = {
            withDarkTheme = var1.themeName ~= "Light",
            withUiModeSupport = var1.withUiModeSupport
        }
    })

    table.insert(providers, {
        class = LocalizationProvider,
        props = {
            localization = {
                Format = function(_, str1: string): string
                    return str1
                end,
                changed = Signal.new()
            }
        }
    })

    if var1.withLayerCollector then
        table.insert(providers, { class = LayerCollectorProvider, props = {} })
    end

    table.insert(providers, {
        class = RoactRodux.StoreProvider,
        props = {
            store = var1.rodux and var1.rodux.store or Rodux.Store.new(function()
                return var1.rodux and var1.rodux.state or {}
            end, var1.rodux and var1.rodux.state, { Rodux.thunkMiddleware })
        }
    })

    table.insert(providers, {
        class = UniversalAppPolicy.RoactAppPolicy.Provider,
        props = {
            policy = { UniversalAppPolicy.AppFeaturePolicies, SocialPolicies.ChatPolicies }
        }
    })

    table.insert(providers, { class = Style.DesignTokenProvider, props = { tokenMappers = {} } })

    if var1.withApolloProvider then
        local client = mockApolloClient({})

        local mockApolloProfiles = MockUserData.createMockApolloProfiles()
        UserProfiles.TestUtils.writeProfileDataToCache(client, mockApolloProfiles)

        table.insert(providers, { class = ApolloClient.ApolloProvider, props = { client = client } })
    end

    table.insert(
        providers,
        {
            class = InteractionFeedback.InteractionFeedbackContext.Provider,
            props = { value = HapticFeedbackConfig }
        }
    )
    table.insert(providers, {
        class = RoactNavigation.Provider,
        props = {
            value = {
                state = {
                    params = {},
                    routeName = "",
                    key = ""
                },
                dispatch = function() end,
                goBack = function() end,
                addListener = function()
                    return {
                        remove = function() end
                    }
                end,
                isFocused = function() end,
                setParams = function() end,
                getParam = function() end,
                replace = function() end,
                push = function() end,
                getScreenProps = function() end
            }
        }
    })

    return React.createElement(ProviderContainer, { providers = providers }, var1.children)
end

return MockProviders
