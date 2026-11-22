-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T21:01:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialTabsPage = script:FindFirstAncestor("SocialTabsPage")
local SocialTabsPageParent = SocialTabsPage.Parent

local React = require(SocialTabsPageParent.React)
local Foundation = require(SocialTabsPageParent.Foundation)
local View = Foundation.View
local useTokens = Foundation.Hooks.useTokens
local StateLayerAffordance = Foundation.Enums.StateLayerAffordance

local FullscreenPageWithSafeArea = require(SocialTabsPageParent.AppBlox).FullscreenPageWithSafeArea
local useNavigation = require(SocialTabsPageParent.Navigation).useNavigation
local Display = require(SocialTabsPageParent.Display)
local useSignalState = require(SocialTabsPageParent.SignalsReact).useSignalState
local FFlagSocialTabsPageDockedPanelSafeArea = require(SocialTabsPage.Flags.FFlagSocialTabsPageDockedPanelSafeArea)
local FFlagSocialTabsPageSplitPaneLayout = require(SocialTabsPageParent.SharedFlags).FFlagSocialTabsPageSplitPaneLayout

local SocialTabsHeader = require(SocialTabsPage.Components.SocialTabsHeader)
local SocialTabBar = require(SocialTabsPage.Components.SocialTabBar)
local SocialTabsContext = require(SocialTabsPage.Contexts.SocialTabsContext)
local useLocalizedTabs = require(SocialTabsPage.Hooks.useLocalizedTabs)

local _Types = require(SocialTabsPage.Common.Types)

local function SocialTabsPageComponent(arg1)
    local renderNavigator = arg1.renderNavigator
    local renderHeader = arg1.renderHeader
    local tabConfig = arg1.tabConfig
    local profileId = arg1.profileId
    local title = arg1.title
    local initialTabId = arg1.initialTabId
    local pageWidth = arg1.pageWidth
    local fillContainer = if FFlagSocialTabsPageSplitPaneLayout then arg1.fillContainer else nil
    local topInset = if FFlagSocialTabsPageSplitPaneLayout then arg1.topInset else nil
    local hideBackButton = if FFlagSocialTabsPageSplitPaneLayout then arg1.hideBackButton else nil

    local value = React.useMemo(function()
        return { profileId = profileId, title = title }
    end, { profileId, title })

    local tabs = useLocalizedTabs(tabConfig)
    local var3 = useTokens()
    local var4 = useNavigation()
    local var5 = if FFlagSocialTabsPageDockedPanelSafeArea then useSignalState(Display.GetDisplayStore().getDeviceSafePadding) else nil
    local var6 = React.useRef(false)

    local onActivated = React.useCallback(function()
        var4.goBack()
    end, { var4 })

    React.useEffect(function()
        if var6.current then
            return
        end

        if not initialTabId or #tabConfig == 0 then
            return
        end

        local bool1 = false
        for _, value in tabConfig do
            if value.id == initialTabId then
                bool1 = true
                break
            end
        end

        local var8 = if bool1 then initialTabId else tabConfig[1].id

        if var4.state.routes[var4.state.index].routeName ~= var8 then
            var4.navigate(var8)
        end

        var6.current = true
    end, { initialTabId, tabConfig, var4 })

    local createElement = React.createElement
    local var8 = View
    local tbl1 = {
        tag = "col size-full",
        padding = topInset and {
            top = UDim.new(0, topInset)
        } or nil
    }
    local tbl2 = {
        HeaderSection = React.createElement(View, {
            tag = "col size-full-0 auto-y bg-surface-0",
            LayoutOrder = 1
        }, {
            Header = if renderHeader then renderHeader() else React.createElement(SocialTabsHeader, { layoutOrder = 1, hideBackButton = hideBackButton }),
            TabBar = React.createElement(SocialTabBar, { layoutOrder = 2, tabs = tabs })
        }),
        TabContent = React.createElement(View, { tag = "fill size-full-0", LayoutOrder = 2 }, { Navigator = renderNavigator() })
    }
    local element = createElement(var8, tbl1, tbl2)
    local color3, surface0Transparency, tbl3

    if pageWidth ~= nil then
        local stateLayer = {
            affordance = StateLayerAffordance.None
        }
        color3 = var3.Color.Surface.Surface_0.Color3
        surface0Transparency = 1
        tbl3 = { ScrimClickHandler = 0 }
        local createElement2 = React.createElement
        local var9 = View
        local tbl5 = { tag = "size-full", stateLayer = stateLayer, onActivated = onActivated }
        local tbl6 = { Panel = 0 }
        local createElement3 = React.createElement
        local var10 = View
        local tbl7 = {
            tag = {
                ["col anchor-top-right bg-surface-0"] = true,
                ["position-top-right padding-top-xxlarge"] = not FFlagSocialTabsPageDockedPanelSafeArea
            },
            Position = if FFlagSocialTabsPageDockedPanelSafeArea then UDim2.new(1, var5.right, 0, -var5.top) else nil,
            Size = if FFlagSocialTabsPageDockedPanelSafeArea then UDim2.new(0, pageWidth, 1, var5.top + var5.bottom) else UDim2.new(0, pageWidth, 1, 0),
            padding = FFlagSocialTabsPageDockedPanelSafeArea
                and {
                    top = UDim.new(0, var5.top + var3.Padding.XXLarge),
                    right = UDim.new(0, var5.right),
                    bottom = UDim.new(0, var5.bottom)
                }
                or nil,
            stateLayer = stateLayer,
            onActivated = 0
        }

        function tbl7.onActivated() end

        tbl6.Panel = createElement3(var10, tbl7, { Content = element })
        tbl3.ScrimClickHandler = createElement2(var9, tbl5, tbl6)
    else
        color3 = var3.Color.Surface.Surface_0.Color3
        surface0Transparency = var3.Color.Surface.Surface_0.Transparency
        tbl3 = { SocialTabsPageContent = element }
    end

    return React.createElement(SocialTabsContext.Provider, { value = value }, {
        Page = React.createElement(FullscreenPageWithSafeArea, {
            includeStatusBar = true,
            useFullScalePage = fillContainer,
            BackgroundColor3 = color3,
            BackgroundTransparency = surface0Transparency
        }, tbl3)
    })
end

return SocialTabsPageComponent
