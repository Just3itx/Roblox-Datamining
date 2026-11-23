-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:51:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local React = require(BuildExperienceParent.React)
local Foundation = require(BuildExperienceParent.Foundation)
local Motion = require(BuildExperienceParent.Motion)
local RoactNavigation = require(BuildExperienceParent.RoactNavigation)
local LibraryBrowserContainer = require(script.Parent.LibraryBrowser.LibraryBrowserContainer)
local LibraryCategoryContainer = require(script.Parent.LibraryCategory.LibraryCategoryContainer)
local LibraryDetailContainer = require(script.Parent.LibraryDetail.LibraryDetailContainer)
local _createBuildLibraryStore = require(BuildExperience.Stores.BuildLibrary.createBuildLibraryStore)
local _LibraryCategories = require(script.Parent.LibraryCategories)
local _LibraryTypes = require(script.Parent.LibraryTypes)
local _LibraryWorldCutoutView = require(script.Parent.LibraryWorldCutout.LibraryWorldCutoutView)
local UserGameSettings = UserSettings():GetService("UserGameSettings")

local function CategoryScreen(tbl1)
    local screenProps = tbl1.screenProps
    local params = tbl1.navigation.state.params
    local var1 = React.useRef(screenProps.query)
    if screenProps.query ~= "" then
        var1.current = screenProps.query
    end
    return React.createElement(LibraryCategoryContainer, {
        itemKind = params.itemKind,
        categoryKey = params.categoryKey,
        folderId = params.folderId,
        query = if tbl1.navigation.state.routeName ~= "Search" then "" else var1.current,
        onOpenItem = screenProps.onOpenItem,
        onOpenCategory = screenProps.onOpenCategory,
        library = screenProps.library,
        isReady = screenProps.isReady
    })
end

return RoactNavigation.createAppContainer(
    RoactNavigation.createRobloxStackNavigator({
        {
            Browser = {
                screen = function(tbl1) -- name: BrowserScreen
                    local screenProps = tbl1.screenProps
                    return React.createElement(LibraryBrowserContainer, {
                        onOpenItem = screenProps.onOpenItem,
                        onOpenCategory = screenProps.onOpenCategory,
                        library = screenProps.library,
                        isReady = screenProps.isReady,
                        query = "",
                        worldCutout = screenProps.worldCutout
                    })
                end
            }
        },
        {
            Category = { screen = CategoryScreen }
        },
        {
            Search = {
                screen = function(tbl1) -- name: SearchScreen
                    local var1 = Foundation.Hooks.usePreferences().reducedMotion or UserGameSettings.ReducedMotion
                    local bool1 = tbl1.screenProps.query ~= ""
                    local var2, var3 = Motion.useMotion({ transparency = if var1 then 0 else 1 })
                    React.useEffect(function()
                        var3(
                            Motion.createState(
                                {
                                    transparency = if bool1 then 0 else 1
                                },
                                {
                                    default = Motion.transition({ duration = if var1 then 0 else 0.15 })
                                }
                            )
                        )
                    end, { bool1, var1, var3 })
                    return React.createElement(
                        Foundation.View,
                        {
                            GroupTransparency = var2.transparency,
                            tag = "size-full bg-surface-0",
                            testId = "Library.Search.Results"
                        },
                        {
                            Grid = React.createElement(CategoryScreen, tbl1)
                        }
                    )
                end,
                navigationOptions = { transparent = true }
            }
        },
        {
            Detail = {
                screen = function(tbl1) -- name: DetailScreen
                    local screenProps = tbl1.screenProps
                    local state = tbl1.navigation.state
                    local bool1 = screenProps.activeRouteKey == state.key
                    return React.createElement(LibraryDetailContainer, {
                        isActive = screenProps.isOpen and bool1,
                        itemId = state.params.itemId,
                        itemKind = state.params.itemKind,
                        library = screenProps.library,
                        isReady = screenProps.isReady,
                        onBack = function()
                            if bool1 then
                                screenProps.onBack()
                            end
                        end,
                        chatActions = screenProps.chatActions,
                        resourceActions = screenProps.resourceActions,
                        unavailableText = screenProps.unavailableText
                    })
                end
            }
        }
    }, {
        initialRouteName = "Browser",
        transitionConfig = function(tbl1, tbl2) -- name: getTransitionConfig
            local routeName = if tbl2 == nil then nil else tbl2.scene.route.routeName
            local routeName2 = tbl1.scene.route.routeName
            if routeName2 ~= "Search" and routeName ~= "Search" or routeName2 == "Detail" or routeName == "Detail" then
                return if UserGameSettings.ReducedMotion then RoactNavigation.StackViewTransitionConfigs.FadeInPlace else RoactNavigation.StackViewTransitionConfigs.SlideFromRight
            end

            local var1 = table.clone(RoactNavigation.StackViewTransitionConfigs.FadeInPlace)
            function var1.screenInterpolator(arg1)
                return {
                    initialPosition = UDim2.fromScale(0, 0),
                    forceHidden = not (arg1.scene.index == tbl1.index) and (tbl2 == nil or arg1.scene.index ~= tbl2.index)
                }
            end

            return var1
        end,
        defaultNavigationOptions = { absorbInputSelectable = false }
    })
)
