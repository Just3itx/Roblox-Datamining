-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T18:11:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialCarousel = script:FindFirstAncestor("SocialCarousel")
local SocialCarouselParent = SocialCarousel.Parent
local Roact = require(SocialCarouselParent.Dev.Roact)

local RoactRodux = require(SocialCarouselParent.RoactRodux)
local Rodux = require(SocialCarouselParent.Rodux)
local UIBlox = require(SocialCarouselParent.UIBlox)
local Cryo = require(SocialCarouselParent.Cryo)
local Style = require(SocialCarouselParent.Style)
local ApolloClient = require(SocialCarouselParent.ApolloClient)
local Foundation = require(SocialCarouselParent.Foundation)
local RoactNavigation = require(SocialCarouselParent.RoactNavigation)
local mockLocale = require(SocialCarouselParent.Dev.SocialTestHelpers).StoryHelpers.mockLocale
local RobloxAppUIBloxConfig = require(SocialCarouselParent.Dev.RobloxAppUIBloxConfig)
local UniversalAppPolicy = require(SocialCarouselParent.UniversalAppPolicy).UniversalAppPolicy

UIBlox.init(RobloxAppUIBloxConfig)

local FoundationProvider = Foundation.FoundationProvider
local StyleProviderWithDefaultTheme = Style.StyleProviderWithDefaultTheme
local DesignTokenProvider = require(SocialCarouselParent.Style).DesignTokenProvider
local mockApolloClient = require(SocialCarouselParent.GraphQLServer).ApolloClientTestUtils.mockApolloClient
local ColorMode = Foundation.Enums.ColorMode
local Device = Foundation.Enums.Device

Roact.setGlobalConfig({ elementTracing = true })

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
    name = "SocialCarousel",
    storyRoot = SocialCarousel,
    roact = Roact,
    roactRodux = RoactRodux,
    mapDefinition = function(arg1)
        local controls = Cryo.Dictionary.join(tbl1, arg1.controls or {})
        return Cryo.Dictionary.join(arg1, { controls = controls })
    end,
    mapStory = function(arg1)
        return function(arg2)
            local colorMode = tbl2[arg2.theme]
            local state = arg2.definition.state or {}
            return Roact.createElement(StyleProviderWithDefaultTheme, {
                withDarkTheme = true,
                withUiModeSupport = false
            }, {
                Roact.createElement(UniversalAppPolicy.Provider, {
                    policy = {
                        function()
                            return {
                                useGridPageLayout = function(): boolean
                                    return true
                                end
                            }
                        end
                    }
                }, {
                    navigationProvider = Roact.createElement(RoactNavigation.Provider, {
                        value = {
                            state = { routeName = "appPage" },
                            isFocused = function(): boolean
                                return false
                            end,
                            addListener = function()
                                return {
                                    remove = function() end
                                }
                            end,
                            getParam = function<T>(_, arg3: T): T
                                return arg3
                            end,
                            navigate = function() end
                        }
                    }, {
                        storeProvider = Roact.createElement(RoactRodux.StoreProvider, {
                            store = func1(state)
                        }, {
                            apolloClient = Roact.createElement(ApolloClient.ApolloProvider, {
                                client = mockApolloClient({})
                            }, {
                                foundationProvider = Roact.createElement(
                                    FoundationProvider,
                                    {
                                        colorMode = colorMode,
                                        device = tbl3[arg2.platform],
                                        preferences = arg2.settings
                                    },
                                    {
                                        designTokenProvider = Roact.createElement(DesignTokenProvider, { tokenMappers = {} }, { Child = mockLocale(arg1, arg2) })
                                    }
                                )
                            })
                        })
                    })
                })
            })
        end
    end
}
