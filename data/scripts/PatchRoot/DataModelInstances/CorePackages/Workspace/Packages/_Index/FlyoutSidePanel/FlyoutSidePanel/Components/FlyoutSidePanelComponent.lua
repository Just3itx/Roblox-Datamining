-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T13:40:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FlyoutSidePanelParent = script:FindFirstAncestor("FlyoutSidePanel").Parent
local React = require(FlyoutSidePanelParent.React)
local AppEventIngestService = require(FlyoutSidePanelParent.RoactServiceTags).AppEventIngestService
local useSelector = require(FlyoutSidePanelParent.RoactUtils).Hooks.RoactRodux.useSelector
local useRoactService = require(FlyoutSidePanelParent.RobloxAppHooks).useRoactService
local useScreenSize = require(FlyoutSidePanelParent.RobloxAppHooks).useScreenSize
local useAppPolicy = require(FlyoutSidePanelParent.UniversalAppPolicy).useAppPolicy
local useLocalRobuxBalance = require(FlyoutSidePanelParent.RobloxAppHooks).useLocalRobuxBalance
local Foundation = require(FlyoutSidePanelParent.Foundation)
local useTokens = Foundation.Hooks.useTokens
local Divider = Foundation.Divider
local createNextOrder = require(FlyoutSidePanelParent.ReactUtils).createNextOrder
local Constants = require(script.Parent.Parent.Constants)
local useFlyoutNavigationItems = require(script.Parent.Parent.Hooks.useFlyoutNavigationItems)
local DrawerContainer = require(FlyoutSidePanelParent.Drawer).DrawerContainer
local useDeviceInsets = require(FlyoutSidePanelParent.Responsive).useDeviceInsets
local RobuxPill = require(script.Parent.RobuxPill)
local FlyoutNavigationList = require(script.Parent.FlyoutNavigationList)
local FlyoutQuickSigninButton = require(script.Parent.FlyoutQuickSigninButton)
local FlyoutReportLogs = require(script.Parent.FlyoutReportLogs)
local FlyoutSwitchAccountButton = require(script.Parent.FlyoutSwitchAccountButton)
local FlyoutProfileCard = require(script.Parent.FlyoutProfileCard)
local SwitchAccountTooltip = require(script.Parent.SwitchAccountTooltip)
local useFlyoutSwitchAccount = require(script.Parent.Parent.Hooks.useFlyoutSwitchAccount)
local useDismissFlyoutOnPartyTopBanner = require(script.Parent.Parent.Hooks.useDismissFlyoutOnPartyTopBanner)
local useSetDrawerVisible = require(FlyoutSidePanelParent.Drawer).Hooks.useSetDrawerVisible

local FFlagFlyoutSidePanelUseSharedProfileCard = require(script.Parent.Parent.Flags.FFlagFlyoutSidePanelUseSharedProfileCard)
local ProfileCard = if FFlagFlyoutSidePanelUseSharedProfileCard then require(FlyoutSidePanelParent.ProfileCard).ProfileCard else nil
local useFlyoutSidePanelLogging = require(script.Parent.Parent.Hooks.useFlyoutSidePanelLogging)
local FlyoutAccountSwitcherIXP = require(FlyoutSidePanelParent.SharedExperimentDefinition).FlyoutAccountSwitcherIXP
local FlyoutAnalytics = require(script.Parent.Parent.Analytics.FlyoutAnalytics)

local TermsPrivacyFooter = require(script.Parent.TermsPrivacyFooter)

local SharedFlags = require(FlyoutSidePanelParent.SharedFlags)
local FFlagEnableBlackbird = SharedFlags.FFlagEnableBlackbird
local FFlagEnableBlackbirdOnFlyoutMenu = SharedFlags.FFlagEnableBlackbirdOnFlyoutMenu
local bool1 = game:DefineFastFlag("EnableBlackbirdUpsellOnFlyoutMenu", false)
local FFlagEnableFlyoutMenuRobuxCardRefactor = SharedFlags.FFlagEnableFlyoutMenuRobuxCardRefactor
local FFlagEnableBlackbirdCheck = SharedFlags.FFlagEnableBlackbirdCheck
local FFlagEnablePlusReferralFlyoutEntry = SharedFlags.FFlagEnablePlusReferralFlyoutEntry
local FFlagEnablePlusReferralRecipientFlyoutEntry = SharedFlags.FFlagEnablePlusReferralRecipientFlyoutEntry
local FFlagEnableFlyoutOnNavRail = SharedFlags.FFlagEnableFlyoutOnNavRail
local FFlagFixOverlayTopInsetForDeviceSafeInsets = SharedFlags.FFlagFixOverlayTopInsetForDeviceSafeInsets
local shouldUseDeviceSafeInsets = require(FlyoutSidePanelParent.Display).shouldUseDeviceSafeInsets
local FFlagFlyoutSidePanelUseProfileFrameThumbnail = SharedFlags.FFlagFlyoutSidePanelUseProfileFrameThumbnail
local bool2 = game:DefineFastFlag("FlyoutScaleMenuWidth", false)
local useHasRobloxSubscription = if FFlagEnableBlackbirdCheck then require(script.Parent.Parent.Hooks.useHasRobloxSubscription) else nil
local usePlusReferralFlyoutBannerBlindness = if FFlagEnablePlusReferralFlyoutEntry or FFlagEnablePlusReferralRecipientFlyoutEntry then require(script.Parent.Parent.Hooks.usePlusReferralFlyoutBannerBlindness) else nil
local num1 = game:DefineFastInt("PlusReferralRecipientFlyoutBannerMaxImpressions", 10)
local PlusReferralBanner = if FFlagEnablePlusReferralFlyoutEntry then require(script.Parent.PlusReferralBanner) else nil
local PlusReferralRecipientBanner = if FFlagEnablePlusReferralRecipientFlyoutEntry then require(script.Parent.PlusReferralRecipientBanner) else nil
local BlackbirdUpsellBanner = if FFlagEnableBlackbird and FFlagEnableBlackbirdOnFlyoutMenu and bool1 then require(script.Parent.BlackbirdUpsellBanner) else nil

local function selectStatusBarHeight(arg1)
    return arg1.TopBar.statusBarHeight or 0
end

local function selectGlobalGuiInset(arg1)
    return arg1.GlobalGuiInset or { left = 0, top = 0, right = 0, bottom = 0 }
end

local function getFlyoutMenuWidth(num2: number, scale: number): number -- Luacid: Inlined by compiler; 1 call site recovered
    return math.min(Constants.FLYOUT_SIDE_PANEL_WIDTH * scale, num2 - Constants.FLYOUT_SIDE_PADDING * scale)
end

return React.memo(function(tbl1, _)
    local var1 = useTokens()
    local robuxBalance = useLocalRobuxBalance()
    local var3 = useSelector(selectStatusBarHeight)
    local var4 = useSelector(selectGlobalGuiInset)
    local var5

    if FFlagFixOverlayTopInsetForDeviceSafeInsets then
        var5 = useDeviceInsets()
        if not shouldUseDeviceSafeInsets then
            var5 = nil
        end
    else
        var5 = nil
    end
    local topOffset = var4.top + var3
    local bottomOffset = if var5 then 0 else var4.bottom
    local left = if FFlagEnableFlyoutOnNavRail then nil else var4.left
    local var8 = useScreenSize()
    local menuWidth = if bool2 then getFlyoutMenuWidth(var8.X, var1.Config.UI.Scale) elseif var8.X - Constants.FLYOUT_SIDE_PADDING < Constants.FLYOUT_SIDE_PANEL_WIDTH then var8.X - Constants.FLYOUT_SIDE_PADDING else Constants.FLYOUT_SIDE_PANEL_WIDTH

    local var10 = useAppPolicy(function(arg1)
        return arg1.getDisableBlackbirdEntrypoints() or false
    end)

    local var11 = if FFlagEnableBlackbirdCheck then useHasRobloxSubscription() else false
    local referrerId, var12, var13

    if FFlagEnablePlusReferralRecipientFlyoutEntry then
        local pendingReferral = tbl1.pendingReferral
        local recipientEligibility = tbl1.recipientEligibility
        local hasPending = if pendingReferral then pendingReferral.hasPending else false

        if pendingReferral then
            referrerId = pendingReferral.referrerId
        else
            referrerId = nil
        end

        local eligible = if recipientEligibility then recipientEligibility.eligible else false
        local var14 = usePlusReferralFlyoutBannerBlindness(not var11 and hasPending and eligible, "RobloxPlusUpsellImpressionCount4", num1)

        var12 = not var10 and FFlagEnableBlackbird and not var11 and hasPending and eligible and var14
        local isLoading = if recipientEligibility then recipientEligibility.isLoading else false

        if pendingReferral then
            var13 = pendingReferral.isLoading or hasPending and isLoading
        else
            var13 = false
        end
    else
        var12 = false
        referrerId = nil
        var13 = false
    end

    local bool3 = not var10

    if bool3 then
        if BlackbirdUpsellBanner == nil then
            bool3 = false
        else
            bool3 = not (var11 or var12 or var13)
        end
    end

    local var14

    if FFlagEnablePlusReferralFlyoutEntry then
        local senderEligibility = tbl1.senderEligibility
        local eligible = if senderEligibility then senderEligibility.eligible else false
        local var15 = usePlusReferralFlyoutBannerBlindness(var11 and eligible, "RobloxPlusUpsellImpressionCount2")
        var14 = var11 and eligible and var15
    else
        var14 = false
    end

    local var15 = robuxBalance and robuxBalance >= 0
    local var16 = var15 or bool3 or var14 or var12

    local var17 = useFlyoutNavigationItems()
    local nextOrder = createNextOrder()
    local var18 = useSetDrawerVisible()

    local var19 = if FFlagFlyoutSidePanelUseSharedProfileCard then useRoactService(AppEventIngestService) else nil

    useFlyoutSidePanelLogging(var17.myLibraryItems)

    local closeDrawer = React.useCallback(function()
        var18(false)
    end, { var18 })

    local var21 = if FlyoutAccountSwitcherIXP.isUsernameAccountSwitcherEnabled() then useFlyoutSwitchAccount(tbl1.onSwitchAccountActivated, closeDrawer) else nil

    local onDrawerClosedAnalytics = React.useCallback(function(arg1)
        FlyoutAnalytics.onFlyoutSidePanelClosed(arg1)
    end, {})

    local onProfileActivated = if FFlagFlyoutSidePanelUseSharedProfileCard then React.useCallback(function()
        closeDrawer()
        if tbl1.onProfileActivated then
            tbl1.onProfileActivated()
            local id = tbl1.localUserModel and tbl1.localUserModel.id or ""
            FlyoutAnalytics.sendMoreLegacyAndFlyoutItemClickEvent(var19, "Profile", id)
        end
    end, {
        closeDrawer,
        var19,
        tbl1.localUserModel,
        tbl1.onProfileActivated
    }) else nil

    local createElement = React.createElement
    local fragment = React.Fragment
    local var24 = nil
    local tbl2 = {
        UIPadding = React.createElement("UIPadding", {
            PaddingTop = UDim.new(0, var1.Padding.XLarge),
            PaddingBottom = UDim.new(0, var1.Padding.XLarge),
            PaddingLeft = UDim.new(0, var1.Padding.XLarge),
            PaddingRight = UDim.new(0, var1.Padding.XLarge)
        }),
        UIListLayout = React.createElement("UIListLayout", {
            Padding = UDim.new(0, var1.Gap.Large),
            SortOrder = Enum.SortOrder.LayoutOrder,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            VerticalAlignment = Enum.VerticalAlignment.Top
        }),
        ProfileCard = 0,
        SwitchAccountTooltip = 0,
        RobuxPill = 0,
        RobuxCard = 0,
        MyLibrary = 0,
        Divider = 0,
        AdditionalNavigation = 0,
        SwitchAccountButton = 0,
        QuickSigninButton = 0,
        LogOut = 0,
        ReportLogs = 0,
        TermsPrivacyFooter = 0
    }
    local var25

    if FFlagFlyoutSidePanelUseSharedProfileCard then
        local createElement2 = React.createElement
        local var26 = ProfileCard
        local tbl3 = {
            layoutOrder = nextOrder(),
            localUserModel = tbl1.localUserModel,
            isRobloxSubscriber = 0,
            onProfileActivated = 0,
            onSwitchAccountActivated = 0,
            switchAccountAnchorRef = 0,
            useProfileFrameThumbnail = 0
        }

        if not FFlagEnableBlackbirdCheck then
            var11 = nil
        end

        tbl3.isRobloxSubscriber = var11
        tbl3.onProfileActivated = onProfileActivated
        tbl3.onSwitchAccountActivated = if FlyoutAccountSwitcherIXP.isUsernameAccountSwitcherEnabled() then var21.onActivated else nil

        tbl3.switchAccountAnchorRef = if FlyoutAccountSwitcherIXP.isUsernameAccountSwitcherEnabled() then var21.anchorRef else nil

        tbl3.useProfileFrameThumbnail = FFlagFlyoutSidePanelUseProfileFrameThumbnail
        var25 = createElement2(var26, tbl3)
    else
        local createElement2 = React.createElement
        local var26 = FlyoutProfileCard
        local tbl3 = {
            layoutOrder = nextOrder(),
            localUserModel = tbl1.localUserModel,
            isRobloxSubscriber = 0,
            onProfileActivated = 0,
            closeDrawer = 0
        }

        if not FFlagEnableBlackbirdCheck then
            var11 = nil
        end

        tbl3.isRobloxSubscriber = var11
        tbl3.onProfileActivated = tbl1.onProfileActivated
        tbl3.closeDrawer = closeDrawer
        var25 = createElement2(var26, tbl3)
    end

    tbl2.ProfileCard = var25

    tbl2.SwitchAccountTooltip = if FlyoutAccountSwitcherIXP.isSwitchAccountTooltipEnabled() then React.createElement(
        SwitchAccountTooltip,
        {
            anchorRef = var21.anchorRef,
            isEligible = tbl1.onSwitchAccountActivated ~= nil,
            dismissRef = var21.dismissRef
        }
    ) else nil

    tbl2.RobuxPill = if FFlagEnableFlyoutMenuRobuxCardRefactor or not var15 then nil else React.createElement(RobuxPill, {
        layoutOrder = nextOrder(),
        openPurchaseRobuxPage = tbl1.openPurchaseRobuxPage,
        robuxBalance = robuxBalance,
        closeDrawer = closeDrawer
    })
    local element

    if FFlagEnableFlyoutMenuRobuxCardRefactor and var16 then
        element = React.createElement(Foundation.View, {
            tag = "col size-full-0 auto-y",
            LayoutOrder = nextOrder(),
            stroke = {
                Color = var1.Color.Stroke.Default.Color3,
                Transparency = var1.Color.Stroke.Default.Transparency,
                Thickness = var1.Stroke.Standard
            },
            cornerRadius = UDim.new(0, var1.Radius.Medium)
        }, {
            RobuxPill = if var15 then React.createElement(RobuxPill, {
                layoutOrder = 1,
                openPurchaseRobuxPage = tbl1.openPurchaseRobuxPage,
                robuxBalance = robuxBalance,
                closeDrawer = closeDrawer
            }) else nil,
            UpsellDivider = if var15 and bool3 then React.createElement(Divider, { LayoutOrder = 2 }) else nil,
            BlackbirdUpsellBanner = if bool3 then React.createElement(BlackbirdUpsellBanner, { layoutOrder = 3, closeDrawer = closeDrawer }) else nil,
            PlusReferralDivider = if var14 and (var15 or bool3) then React.createElement(Divider, { LayoutOrder = 4 }) else nil,
            PlusReferralBanner = if var14 then React.createElement(PlusReferralBanner, { layoutOrder = 5, closeDrawer = closeDrawer }) else nil,
            PlusReferralRecipientDivider = if var12 and (var15 or bool3 or var14) then React.createElement(Divider, { LayoutOrder = 6 }) else nil,
            PlusReferralRecipientBanner = if var12 then React.createElement(
                PlusReferralRecipientBanner,
                {
                    layoutOrder = 7,
                    closeDrawer = closeDrawer,
                    referrerId = referrerId,
                    onOpenReferralSheet = tbl1.onOpenReferralSheet
                }
            ) else nil
        })
    else
        element = nil
    end

    tbl2.RobuxCard = element

    tbl2.MyLibrary = React.createElement(FlyoutNavigationList, {
        layoutOrder = nextOrder(),
        navigationItems = var17.myLibraryItems,
        closeDrawer = closeDrawer,
        buildCreatorWebNavUrl = tbl1.buildCreatorWebNavUrl
    })
    tbl2.Divider = React.createElement(Divider, { LayoutOrder = nextOrder() })

    tbl2.AdditionalNavigation = React.createElement(FlyoutNavigationList, {
        layoutOrder = nextOrder(),
        navigationItems = var17.additionalNavigationItems,
        closeDrawer = closeDrawer,
        buildCreatorWebNavUrl = tbl1.buildCreatorWebNavUrl
    })
    local element2 = if tbl1.onSwitchAccountActivated and FlyoutAccountSwitcherIXP.isBottomButtonEnabled() then React.createElement(
        FlyoutSwitchAccountButton,
        {
            layoutOrder = nextOrder(),
            onSwitchAccountActivated = if FlyoutAccountSwitcherIXP.isUsernameAccountSwitcherEnabled() then var21.onActivated else tbl1.onSwitchAccountActivated,
            closeDrawer = if FlyoutAccountSwitcherIXP.isUsernameAccountSwitcherEnabled() then nil else closeDrawer
        }
    ) else nil
    tbl2.SwitchAccountButton = element2

    tbl2.QuickSigninButton = React.createElement(FlyoutQuickSigninButton, { layoutOrder = nextOrder(), closeDrawer = closeDrawer })

    tbl2.LogOut = tbl1.renderLogOut(nextOrder())
    tbl2.ReportLogs = if tbl1.openReportLogConfirmation then React.createElement(
        FlyoutReportLogs,
        {
            layoutOrder = nextOrder(),
            openReportLogConfirmation = tbl1.openReportLogConfirmation,
            closeDrawer = closeDrawer
        }
    ) else nil

    tbl2.TermsPrivacyFooter = React.createElement(TermsPrivacyFooter, { layoutOrder = nextOrder(), closeDrawer = closeDrawer })
    local children = createElement(fragment, var24, tbl2)

    useDismissFlyoutOnPartyTopBanner()
    return React.createElement(DrawerContainer, {
        displayOrder = tbl1.displayOrder,
        menuWidth = menuWidth,
        children = children,
        leftOffset = left,
        topOffset = topOffset,
        bottomOffset = bottomOffset,
        deviceSafeInsets = var5,
        backgroundStyle = var1.Color.Surface.Surface_0,
        onDrawerClosedAnalytics = onDrawerClosedAnalytics
    })
end)
