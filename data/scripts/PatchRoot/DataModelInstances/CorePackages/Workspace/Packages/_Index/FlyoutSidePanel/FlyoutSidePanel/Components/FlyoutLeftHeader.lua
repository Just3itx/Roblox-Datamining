-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T13:40:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FlyoutSidePanelParent = script:FindFirstAncestor("FlyoutSidePanel").Parent
local React = require(FlyoutSidePanelParent.React)
local Foundation = require(FlyoutSidePanelParent.Foundation)
local useTokens = Foundation.Hooks.useTokens
local AppPage = require(FlyoutSidePanelParent.RobloxAppEnums).AppPage
local NavigationRodux = require(FlyoutSidePanelParent.NavigationRodux)
local useAppPolicy = require(FlyoutSidePanelParent.UniversalAppPolicy).useAppPolicy
local AppNavBar = require(FlyoutSidePanelParent.AppNavBar)
local useNavBarPlacement = AppNavBar.useNavBarPlacement
local Placement = AppNavBar.Placement
local FlyoutHamburgerButton = require(script.Parent.FlyoutHamburgerButton)
local Constants = require(script.Parent.Parent.Constants)

local bool1 = game:DefineFastFlag("EnableHomeBetaBadge", false)
local SharedFlags = require(FlyoutSidePanelParent.SharedFlags)
local FFlagAppIaHomeSubTab = SharedFlags.FFlagAppIaHomeSubTab
local FFlagEnableCoreContentBadge = SharedFlags.FFlagEnableCoreContentBadge
local FFlagEnableHomeRobloxLogo = SharedFlags.FFlagEnableHomeRobloxLogo
local FFlagEnableConsoleRobloxLogo = SharedFlags.FFlagEnableConsoleRobloxLogo
local FFlagEnableFlyoutOnNavRail = SharedFlags.FFlagEnableFlyoutOnNavRail
local FFlagFlyoutHeaderFixPadding = SharedFlags.FFlagFlyoutHeaderFixPadding

local function FlyoutLeftHeader(tbl1)
    local var1 = useTokens()
    local size500 = var1.Size.Size_500
    local vector2 = Vector2.new(size500 * Constants.ROBLOX_LOGO_ASPECT_RATIO, size500)
    local bool2 = if FFlagEnableFlyoutOnNavRail then useNavBarPlacement() == Placement.Bottom else nil

    local var2 = if FFlagEnableCoreContentBadge then useAppPolicy(function(arg1)
        return arg1.getCoreContentBadgeText()
    end) else nil

    local var3 = if FFlagEnableCoreContentBadge then var2 and var2 ~= "" else false
    local var4 = tbl1.alwaysShowLogo
        or tbl1.routeName == AppPage.Home
        or FFlagAppIaHomeSubTab and tbl1.routeName == NavigationRodux.Constants.HomeContainerName
    local str1 = "auto-xy row align-x-left align-y-center"

    if not FFlagFlyoutHeaderFixPadding
        and (FFlagEnableHomeRobloxLogo or FFlagEnableConsoleRobloxLogo or tbl1.isAlternateEntryPointEnabled)
    then
        str1 ..= " gap-small"
    end

    local var5 = (not (FFlagEnableHomeRobloxLogo or FFlagEnableConsoleRobloxLogo) or tbl1.isFlyoutEntrypointEnabled)
        and (not FFlagEnableFlyoutOnNavRail or bool2)
    local element

    if FFlagEnableCoreContentBadge
        and (FFlagEnableHomeRobloxLogo or FFlagEnableConsoleRobloxLogo or tbl1.isRobloxLogoEnabled)
        and var4
        and var3
    then
        element = React.createElement(
            Foundation.View,
            {
                tag = "auto-xy padding-x-xsmall padding-y-xxsmall radius-small bg-system-contrast",
                LayoutOrder = 3
            },
            {
                Text = React.createElement(
                    Foundation.Text,
                    {
                        Text = var2,
                        tag = "auto-xy text-title-small",
                        textStyle = var1.Color.Surface.Surface_0
                    }
                )
            }
        )
    else
        element = nil
    end

    local element2 = if bool1 and tbl1.isRobloxLogoEnabled and var4 then React.createElement(
        Foundation.View,
        {
            LayoutOrder = 4,
            tag = "auto-xy padding-xxsmall stroke-standard stroke-emphasis radius-small"
        },
        {
            Text = React.createElement(Foundation.Text, { Text = "Beta", tag = "auto-xy text-body-small content-emphasis" })
        }
    ) else nil
    local createElement = React.createElement
    local view = Foundation.View
    local tbl2 = { tag = str1 }
    local tbl3 = {
        FlyoutHamburgerButton = if var5 then React.createElement(
            FlyoutHamburgerButton,
            {
                titleText = tbl1.titleText,
                LayoutOrder = 1,
                isAlternateEntryPointEnabled = tbl1.isAlternateEntryPointEnabled
            }
        ) else nil,
        TitleOrRobloxLogoFrame = 0,
        Badges = 0,
        CoreContentBadge = 0,
        BetaBadge = 0
    }
    local element3

    if (FFlagEnableHomeRobloxLogo or FFlagEnableConsoleRobloxLogo or tbl1.isRobloxLogoEnabled) and var4 then
        if tbl1.useHeaderLogo then
            element3 = React.createElement(require(script.Parent.HeaderLogo))
        else
            element3 = React.createElement(Foundation.Image, {
                LayoutOrder = 2,
                tag = "size-full-full",
                Image = "icons/logo/letterform",
                imageStyle = var1.Color.Content.Emphasis,
                Size = UDim2.fromOffset(vector2.X, vector2.Y)
            })
        end
    elseif tbl1.titleText then
        element3 = React.createElement(
            Foundation.Text,
            {
                tag = "auto-xy text-heading-large content-emphasis",
                LayoutOrder = 2,
                Text = tbl1.titleText
            }
        )
    else
        element3 = nil
    end

    tbl3.TitleOrRobloxLogoFrame = element3

    tbl3.Badges = if FFlagFlyoutHeaderFixPadding then React.createElement(
        Foundation.View,
        { tag = "row gap-xsmall auto-xy align-y-center padding-left-xsmall", LayoutOrder = 3 },
        { CoreContentBadge = element, BetaBadge = element2 }
    ) else nil

    if FFlagFlyoutHeaderFixPadding then
        element = nil
    end

    tbl3.CoreContentBadge = element
    if FFlagFlyoutHeaderFixPadding then
        element2 = nil
    end

    tbl3.BetaBadge = element2
    return createElement(view, tbl2, tbl3)
end

return FlyoutLeftHeader
