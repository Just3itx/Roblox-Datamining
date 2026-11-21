-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T13:41:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FlyoutSidePanel = script:FindFirstAncestor("FlyoutSidePanel")
local FlyoutSidePanelParent = FlyoutSidePanel.Parent
local React = require(FlyoutSidePanelParent.React)
local useAppPolicy = require(FlyoutSidePanelParent.UniversalAppPolicy).useAppPolicy
local RoactUtils = require(FlyoutSidePanelParent.RoactUtils)
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local useSelector = RoactUtils.Hooks.RoactRodux.useSelector
local useNavigation = require(FlyoutSidePanelParent.Navigation).useNavigation
local AppPage = require(FlyoutSidePanelParent.RobloxAppEnums).AppPage
local NavigateDown = require(FlyoutSidePanelParent.NavigationRodux).Thunks.NavigateDown
local SharedFlags = require(FlyoutSidePanelParent.SharedFlags)
local FFlagSignalsNavP3Dispatch = SharedFlags.FFlagSignalsNavP3Dispatch
local FFlagEnableArgus = SharedFlags.FFlagEnableArgus
local FFlagEnableArgusImmersiveNav = SharedFlags.FFlagEnableArgusImmersiveNav
local FFlagFlyoutFilterWebViewsAndBrowserLinks = SharedFlags.FFlagFlyoutFilterWebViewsAndBrowserLinks
local FFlagFlyoutResolveItemContextOnActivation = require(FlyoutSidePanel.Flags.FFlagFlyoutResolveItemContextOnActivation)
local NavigationCommands = if FFlagSignalsNavP3Dispatch then require(FlyoutSidePanelParent.RobloxAppNavigation).NavigationCommands else nil
local LinkingProtocol = require(FlyoutSidePanelParent.LinkingProtocol)
local DeepLinkSource = LinkingProtocol.Enums.DeepLinkSource
local default = LinkingProtocol.LinkingProtocol.default
local useRoactService = require(FlyoutSidePanelParent.RobloxAppHooks).useRoactService
local AppEventIngestService = require(FlyoutSidePanelParent.RoactServiceTags).AppEventIngestService
local FFlagCreateConnectionsHub = require(FlyoutSidePanelParent.SharedFlags).FFlagCreateConnectionsHub

local FlyoutContentSettings = require(script.Parent.Parent.Config.FlyoutContentSettings)
local FlyoutAnalytics = require(script.Parent.Parent.Analytics.FlyoutAnalytics)

local str1 = game:DefineFastString("FlyoutGiftCardSourceParam", "flyout-side-panel")

local function useFlyoutItemNavigation(arg1, callback: (...any) -> (...any), func1: ((...any) -> (...any))?)
    local var1 = useDispatch()
    local var2 = if FFlagCreateConnectionsHub or FFlagEnableArgus then useNavigation() else nil

    local var3 = useSelector(function(arg2)
        return arg2.LocalUserId
    end)
    local var4 = useAppPolicy(function(arg2)
        return arg2.getGiftCardSourceRefOverride()
    end)
    local var5 = useAppPolicy(function<T>(arg2: T): T
        return arg2
    end)

    local var6 = useRoactService(AppEventIngestService)
    local useCallback = React.useCallback
    local function func2()
        callback()
        local url = nil
        local context = if FFlagFlyoutResolveItemContextOnActivation and arg1.getContext then arg1.getContext() else arg1.context

        if context then
            if context.url then
                url = context.url
            elseif context.appPage then
                local appPage = context.appPage
                if FFlagCreateConnectionsHub and appPage == AppPage.CoHubMyConnections then
                    var2.navigate(appPage)
                elseif FFlagEnableArgus and FFlagEnableArgusImmersiveNav and appPage == AppPage.Moments then
                    local tbl1 = {
                        name = AppPage.MomentsImmersive,
                        source = "flyout_menu"
                    }

                    if FFlagSignalsNavP3Dispatch then
                        NavigationCommands.down(NavigationCommands.fromLegacyPage(tbl1))
                    else
                        var1(NavigateDown(tbl1))
                    end
                elseif appPage == AppPage.Moments then
                    var2.navigate(appPage, { source = "flyout_menu" })
                else
                    local tbl1 = { name = appPage }

                    if FFlagSignalsNavP3Dispatch then
                        NavigationCommands.down(NavigationCommands.fromLegacyPage(tbl1))
                    else
                        var1(NavigateDown(tbl1))
                    end
                end
            elseif context.appUri then
                local appUri = context.appUri
                default:isURLRegistered(appUri):andThen(function(arg2)
                    if not arg2 then
                        return
                    end

                    if default:isInternalDlicEnabled() then
                        local var7 = default:createInternalDlic(appUri, DeepLinkSource.LuaInternal)
                        default:detectDeeplinkIntent(var7)
                        return
                    end
                    default:detectURL(appUri)
                end)
            elseif context.urlGenerator then
                local urlGenerator = context.urlGenerator
                if arg1.itemType == FlyoutContentSettings.ItemType.Inventory then
                    url = urlGenerator(var3)
                elseif arg1.itemType == FlyoutContentSettings.ItemType.GiftCards then
                    if var4 and var4 ~= "" then
                        url = urlGenerator(var4 .. "-" .. str1)
                    end
                elseif arg1.itemType == FlyoutContentSettings.ItemType.CreateGames then
                    url = urlGenerator(func1)
                elseif arg1.itemType == FlyoutContentSettings.ItemType.Terms or arg1.itemType == FlyoutContentSettings.ItemType.Privacy then
                    url = urlGenerator(var3, var5)
                end
            end
        end
        if url then
            local var7 = FFlagFlyoutFilterWebViewsAndBrowserLinks

            if var7 then
                if context == nil or context.destinationType ~= FlyoutContentSettings.DestinationType.WebLink then
                    var7 = false
                else
                    var7 = var5.shouldUseExternalBrowserForMorePageItem()
                end
            end

            if var7 then
                default:openURL(url)
            else
                local tbl1 = {
                    name = AppPage.GenericWebPage,
                    detail = url,
                    extraProps = {
                        titleKey = arg1.textKey
                    }
                }
                if FFlagSignalsNavP3Dispatch then
                    NavigationCommands.down(NavigationCommands.fromLegacyPage(tbl1))
                else
                    var1(NavigateDown(tbl1))
                end
            end
        end
        FlyoutAnalytics.sendMoreLegacyAndFlyoutItemClickEvent(var6, arg1.itemType, var3, url)
    end

    local navigate = if FFlagCreateConnectionsHub then var2.navigate else nil
    return useCallback(func2, { arg1, callback, var3, var4, var6, func1, var1, var5, navigate })
end

return useFlyoutItemNavigation
