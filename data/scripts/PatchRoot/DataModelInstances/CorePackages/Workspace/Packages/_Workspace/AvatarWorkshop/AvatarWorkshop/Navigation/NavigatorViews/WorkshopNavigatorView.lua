-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T17:50:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarWorkshop = script:FindFirstAncestor("AvatarWorkshop")
local AvatarWorkshopParent = AvatarWorkshop.Parent

local Foundation = require(AvatarWorkshopParent.Foundation)
local RoactNavigation = require(AvatarWorkshopParent.RoactNavigation)
local React = require(AvatarWorkshopParent.React)

local _NavigationTypes = require(AvatarWorkshop.Navigation.NavigationTypes)
local WorkshopWindowContext = require(AvatarWorkshop.Contexts.WorkshopWindowContext)
local HorizontalLayout = require(AvatarWorkshop.Components.HorizontalLayout)
local VerticalLayout = require(AvatarWorkshop.Components.VerticalLayout)
local TopBar = require(AvatarWorkshop.Components.TopBar)
local AvatarPreview = require(AvatarWorkshop.Components.AvatarPreview.AvatarPreview)
local ScreenTitles = require(AvatarWorkshop.Constants.ScreenTitles)
local getActiveRoute = require(AvatarWorkshop.Navigation.getActiveRoute)

local function WorkshopNavigatorView(arg1)
    local var1 = React.useContext(WorkshopWindowContext)

    local navigation = arg1.navigation
    local activeRoute = getActiveRoute(navigation)
    local routeName = activeRoute.routeName
    local routeName2 = navigation.state.routes[1].routeName

    local headerSlot = React.createElement(TopBar, {
        titleKey = ScreenTitles[routeName],
        onClose = var1.onClose,
        onBack = routeName ~= routeName2 and function()
            navigation.navigate(routeName2)
        end or nil
    })

    local content = React.createElement(RoactNavigation.RobloxSwitchView, arg1)
    local descriptor = arg1.descriptors[activeRoute.key]
    local options = if descriptor then descriptor.options else nil
    local actionBar = if options then options.actionBar else nil
    local element = if actionBar then React.createElement(actionBar) else nil

    if var1.verticalLayout then
        return React.createElement(VerticalLayout, {
            headerSlot = headerSlot,
            topItemSlot = React.createElement(AvatarPreview),
            bottomItemSlot = React.createElement(Foundation.View, { tag = "size-full-full padding-top-xlarge" }, { Content = content }),
            footerSlot = if element then React.createElement(
                Foundation.View,
                {
                    tag = "size-full-0 auto-y padding-top-medium padding-x-xlarge padding-bottom-large"
                },
                { ActionBar = element }
            ) else nil
        })
    end

    local createElement = React.createElement
    local var2 = HorizontalLayout
    local tbl1 = {
        headerSlot = headerSlot,
        leftItemSlot = React.createElement(Foundation.View, { tag = "size-full-full" }, { Content = content }),
        rightItemSlot = React.createElement(Foundation.View, { tag = "col size-full-full" }, {
            Preview = React.createElement(
                Foundation.View,
                { tag = "fill size-full-0", LayoutOrder = 1 },
                {
                    AvatarPreview = React.createElement(AvatarPreview)
                }
            ),
            ActionBar = if element then React.createElement(
                Foundation.View,
                { tag = "size-full-0 auto-y padding-medium", LayoutOrder = 2 },
                { ActionBar = element }
            ) else nil
        })
    }
    return createElement(var2, tbl1)
end

return WorkshopNavigatorView
