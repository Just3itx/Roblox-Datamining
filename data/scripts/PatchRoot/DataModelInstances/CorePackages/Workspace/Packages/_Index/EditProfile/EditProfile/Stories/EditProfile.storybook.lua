-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T12:10:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local EditProfile = script:FindFirstAncestor("EditProfile")
local EditProfileParent = EditProfile.Parent

local UIBlox = require(EditProfileParent.UIBlox)
local RobloxAppUIBloxConfig = require(EditProfileParent.Dev.RobloxAppUIBloxConfig)

UIBlox.init(RobloxAppUIBloxConfig)

local React = require(EditProfileParent.React)
local ReactRoblox = require(EditProfileParent.ReactRoblox)

local RoactRodux = require(EditProfileParent.RoactRodux)
local Rodux = require(EditProfileParent.Rodux)
local Cryo = require(EditProfileParent.Cryo)
local Style = require(EditProfileParent.Style)
local ApolloClient = require(EditProfileParent.ApolloClient)
local Foundation = require(EditProfileParent.Foundation)
local mockLocale = require(EditProfileParent.Dev.SocialTestHelpers).StoryHelpers.mockLocale

local FoundationProvider = Foundation.FoundationProvider
local StyleProviderWithDefaultTheme = Style.StyleProviderWithDefaultTheme
local DesignTokenProvider = require(EditProfileParent.Style).DesignTokenProvider
local mockApolloClient = require(EditProfileParent.GraphQLServer).ApolloClientTestUtils.mockApolloClient
local ColorMode = Foundation.Enums.ColorMode
local Device = Foundation.Enums.Device
local UniversalAppPolicy = require(EditProfileParent.UniversalAppPolicy)

local tbl1 = { language = "en-us" }

local tbl2 = {
    Light = ColorMode.Light,
    Dark = ColorMode.Dark
}

local tbl3 = {
    Console = Device.Console,
    Desktop = Device.Desktop
}

local function func1(arg1)
    return Rodux.Store.new(function()
        return Cryo.Dictionary.join(arg1, {
            ScreenSize = Vector2.new(600, 600),
            TopBar = { topBarHeight = 0 },
            GlobalGuiInset = { left = 0, top = 0, right = 0, bottom = 0 }
        })
    end, {}, { Rodux.thunkMiddleware })
end

return {
    name = "EditProfile",
    storyRoot = EditProfile,
    roact = React,
    reactRoblox = ReactRoblox,
    roactRodux = RoactRodux,
    mapDefinition = function(arg1)
        local controls = Cryo.Dictionary.join(tbl1, arg1.controls or {})
        return Cryo.Dictionary.join(arg1, { controls = controls })
    end,
    mapStory = function(arg1)
        return function(arg2)
            local colorMode = tbl2[arg2.theme]
            local state = arg2.definition.state or {}
            return React.createElement(StyleProviderWithDefaultTheme, {
                withDarkTheme = true,
                withUiModeSupport = false
            }, {
                storeProvider = React.createElement(RoactRodux.StoreProvider, {
                    store = func1(state)
                }, {
                    policyProvider = React.createElement(
                        UniversalAppPolicy.RoactAppPolicy.Provider,
                        {
                            policy = { UniversalAppPolicy.AppFeaturePolicies }
                        },
                        {
                            apolloClient = React.createElement(ApolloClient.ApolloProvider, {
                                client = mockApolloClient({})
                            }, {
                                foundationProvider = React.createElement(
                                    FoundationProvider,
                                    {
                                        colorMode = colorMode,
                                        device = tbl3[arg2.platform],
                                        preferences = arg2.settings
                                    },
                                    {
                                        designTokenProvider = React.createElement(DesignTokenProvider, { tokenMappers = {} }, { Child = mockLocale(arg1, arg2) })
                                    }
                                )
                            })
                        }
                    )
                })
            })
        end
    end
}
