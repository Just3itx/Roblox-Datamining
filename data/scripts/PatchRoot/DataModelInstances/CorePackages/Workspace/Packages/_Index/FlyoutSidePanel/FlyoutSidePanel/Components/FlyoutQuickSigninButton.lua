-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T13:40:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FlyoutSidePanelParent = script:FindFirstAncestor("FlyoutSidePanel").Parent
local React = require(FlyoutSidePanelParent.React)
local useDispatch = require(FlyoutSidePanelParent.RoactUtils).Hooks.RoactRodux.useDispatch
local useLocalization = require(FlyoutSidePanelParent.Localization).Hooks.useLocalization
local AppPage = require(FlyoutSidePanelParent.RobloxAppEnums).AppPage
local NavigateDown = require(FlyoutSidePanelParent.NavigationRodux).Thunks.NavigateDown
local FFlagSignalsNavP3Dispatch = require(FlyoutSidePanelParent.SharedFlags).FFlagSignalsNavP3Dispatch
local NavigationCommands = if FFlagSignalsNavP3Dispatch then require(FlyoutSidePanelParent.RobloxAppNavigation).NavigationCommands else nil
local Foundation = require(FlyoutSidePanelParent.Foundation)
local Button = Foundation.Button
local ButtonVariant = Foundation.Enums.ButtonVariant
local ButtonSize = Foundation.Enums.ButtonSize
local FlyoutAnalytics = require(script.Parent.Parent.Analytics.FlyoutAnalytics)
local useRoactService = require(FlyoutSidePanelParent.RobloxAppHooks).useRoactService
local AppEventIngestService = require(FlyoutSidePanelParent.RoactServiceTags).AppEventIngestService
local FlyoutContentSettings = require(script.Parent.Parent.Config.FlyoutContentSettings)

local FFlagCTAChangeMorePageFlyoutButtonText = require(FlyoutSidePanelParent.SharedFlags).FFlagCTAChangeMorePageFlyoutButtonText

local function FlyoutQuickSigninButton(arg1)
    local var1 = useDispatch()
    local var2 = useRoactService(AppEventIngestService)

    local onActivated = React.useCallback(function()
        arg1.closeDrawer()
        local tbl1 = {
            name = AppPage.CrossDeviceLogin
        }
        if FFlagSignalsNavP3Dispatch then
            NavigationCommands.down(NavigationCommands.fromLegacyPage(tbl1))
        else
            var1(NavigateDown(tbl1))
        end
        local quickSignin = FlyoutContentSettings.ItemType.QuickSignin
        FlyoutAnalytics.sendMoreLegacyAndFlyoutItemClickEvent(var2, quickSignin)
    end, { var2, arg1.closeDrawer })

    local var4 = useLocalization({
        title = if FFlagCTAChangeMorePageFlyoutButtonText then "Authentication.Login.Action.QuickSignIn" else "Authentication.CrossDevice.Heading.QuickLogin"
    })

    return React.createElement(Button, {
        testId = "--core-ui-flyout-button-quick-signin",
        text = var4.title,
        variant = ButtonVariant.Standard,
        LayoutOrder = arg1.layoutOrder,
        onActivated = onActivated,
        isDisabled = false,
        size = ButtonSize.Large,
        width = UDim.new(1, 0)
    })
end

return FlyoutQuickSigninButton
