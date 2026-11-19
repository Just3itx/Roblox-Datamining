-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:50:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AbuseReportMenu = script:FindFirstAncestor("AbuseReportMenu")
local CorePackages = game:GetService("CorePackages")

local GuiService = game:GetService("GuiService")
local IXPService = game:GetService("IXPService")
local LocalizationService = game:GetService("LocalizationService")
local Players = game:GetService("Players")
local SafetyService = game:GetService("SafetyService")
local Foundation = require(CorePackages.Packages.Foundation)
local React = require(CorePackages.Packages.React)
local CoreScriptsRootProvider = require(CorePackages.Workspace.Packages.CoreScriptsRoactCommon).CoreScriptsRootProvider

local ReportTypeSelector = require(AbuseReportMenu.Components.ReportTypeSelector)
local Constants = require(AbuseReportMenu.Components.Constants)
local ReportModes = Constants.ReportModes
local ReportTypes = Constants.ReportTypes
local SelectInSceneReportMenu = require(AbuseReportMenu.Components.SelectInSceneReportMenu)
local ReportPersonMenuItemsContainer = require(AbuseReportMenu.Components.Containers.ReportPersonMenuItemsContainer)
local ReportExperienceMenuItemsContainer = require(AbuseReportMenu.Components.Containers.ReportExperienceMenuItemsContainer)
local ReportAnythingAnalytics = require(AbuseReportMenu.ReportAnything.Utility.ReportAnythingAnalytics)
local ReportAbuseAnalytics = require(AbuseReportMenu.Analytics.ReportAbuseAnalytics)
local AnnotationModal = require(AbuseReportMenu.ReportAnything.Components.AnnotationModal)
local ModalBasedSelectorDialogController = require(AbuseReportMenu.Components.ModalBasedSelectorDialogController)
local Localization = require(CorePackages.Workspace.Packages.InExperienceLocales).Localization
local setTimeout = require(CorePackages.Packages.LuauPolyfill).setTimeout

local LocalizationProvider = require(CorePackages.Workspace.Packages.Localization).LocalizationProvider
local useLocalization = require(CorePackages.Workspace.Packages.Localization).Hooks.useLocalization
local useReportAnythingWithScreenshot = require(AbuseReportMenu.Hooks.useReportAnythingWithScreenshot)
local getMenuItemSizings = require(AbuseReportMenu.Utility.getMenuItemSizings)
local analyticsReducer = require(AbuseReportMenu.Reducers.analyticsReducer)
local createCleanup = require(AbuseReportMenu.Components.createCleanup)

local useTokens = Foundation.Hooks.useTokens
local FoundationText = Foundation.Text
local View = Foundation.View

local DsaIllegalContentReporting = require(CorePackages.Workspace.Packages.DsaIllegalContentReporting)
local isShowEUDSAIllegalContentReportingLink = DsaIllegalContentReporting.isShowEUDSAIllegalContentReportingLink
local DSAReportLink = DsaIllegalContentReporting.DSAReportLink
local isShowUKOSAIllegalContentReportingLink = DsaIllegalContentReporting.isShowUKOSAIllegalContentReportingLink
local OSAReportLink = DsaIllegalContentReporting.OSAReportLink
local isShowGenericIllegalContentReportingLink = DsaIllegalContentReporting.isShowGenericIllegalContentReportingLink
local GenericReportLink = DsaIllegalContentReporting.GenericReportLink
local getTakeItDownReportLinkVisibility = DsaIllegalContentReporting.getTakeItDownReportLinkVisibility
local TakeItDownReportLink = DsaIllegalContentReporting.TakeItDownReportLink

local FocusNavigationUtils = require(CorePackages.Workspace.Packages.FocusNavigationUtils)
local FocusRoot = FocusNavigationUtils.FocusRoot
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum
local isAbuseReportMenuOpenCloseSignalEnabled = require(AbuseReportMenu.Flags.isAbuseReportMenuOpenCloseSignalEnabled)

local FIntAbuseReportTabClearCapturedScreenshotOnCloseFixDelay = require(AbuseReportMenu.Flags.FIntAbuseReportTabClearCapturedScreenshotOnCloseFixDelay)

local SharedFlags = require(CorePackages.Workspace.Packages.SharedFlags)
local FStringReportMenuIXPLayer = SharedFlags.FStringReportMenuIXPLayer
local FStringSelectInSceneIXPField = SharedFlags.FStringSelectInSceneIXPField
local FFlagHighlightModePreciseSelectionEnabled = SharedFlags.FFlagHighlightModePreciseSelectionEnabled
local FFlagHideShortcutsOnReportDropdown = require(AbuseReportMenu.Flags.FFlagHideShortcutsOnReportDropdown)

local bool1 = game:DefineFastFlag("AbuseReportTabClearCapturedScreenshotOnCloseFix", false)

local FFlagMigrateAllOsaMessagingToCentralService = require(CorePackages.Workspace.Packages.SharedFlags).FFlagMigrateAllOsaMessagingToCentralService
local bool2 = game:DefineFastFlag("IEMReportScrollingFix", false)
local FFlagReportFocusNavIEMButtons = require(AbuseReportMenu.Flags.FFlagReportFocusNavIEMButtons)
local FFlagIEMTabFocusNav = SharedFlags.FFlagIEMTabFocusNav
local FFlagAddTakeItDownReportLinkToSurfaces = SharedFlags.FFlagAddTakeItDownReportLinkToSurfaces

local isShowSelectInSceneReportMenu = require(AbuseReportMenu.Utility.isShowSelectInSceneReportMenu)

local getHighlightModeVariant = require(CorePackages.Workspace.Packages.InGameAssetReporting).getHighlightModeVariant

local SegmentedControl = require(CorePackages.Packages.UIBlox).App.Control.SegmentedControl

local tbl1 = { ReportModes.Classic, ReportModes.SelectInScene }
local tbl2 = { ReportTypes.Person, ReportTypes.Experience }

local function isInSelectInSceneExperiment() -- Luacid: Inlined by compiler; 1 call site recovered
    local success, result = pcall(function()
        return IXPService:GetUserLayerVariables(FStringReportMenuIXPLayer)
    end)
    if not success or not result or result[FStringSelectInSceneIXPField] == nil then
        return false
    end

    IXPService:LogUserLayerExposure(FStringReportMenuIXPLayer)
    return result[FStringSelectInSceneIXPField]
end

local function func1(tbl3)
    local isReportTabVisible, var2 = React.useState(false)
    local selectedTabIndex, var4 = React.useState(1)
    local var5, var6 = React.useState(1)
    local preselectedPlayer, setPreselectedPlayer = React.useState(nil)
    local menuWidth, var9 = React.useState(0)
    local isSelectionDisabled, var11 = React.useState(false)
    local var12, var13 = React.useState(false)
    local var14, var15 = React.useState(true)
    local var16 = React.useRef(nil)
    local ref = React.useRef(nil)

    local viewportDimension, var19 = React.useState({ width = 0, height = 0 })
    local isSmallPortraitViewport = viewportDimension.width < viewportDimension.height and viewportDimension.width < 700
    local analyticsState, analyticsDispatch = React.useReducer(analyticsReducer, Constants.AnalyticsInitialState)
    local var22 = tbl1[selectedTabIndex]
    local var23 = tbl2[var5]
    local var24 = React.useCallback(
        createCleanup(analyticsState, analyticsDispatch, setPreselectedPlayer, var23),
        { analyticsState, var5 }
    )

    local reportAnythingState, reportAnythingDispatch = useReportAnythingWithScreenshot(isReportTabVisible, tbl3.hideReportTab, tbl3.showReportTab, var24)

    local menuItemSizings = getMenuItemSizings()
    local var27 = useTokens()

    local var28 = useLocalization(Constants.localizationKeys)

    React.useEffect(function()
        tbl3.registerOnReportTabDisplayed(function()
            var2(true)

            if isAbuseReportMenuOpenCloseSignalEnabled() and reportAnythingState.screenshotContentId ~= "" then
                SafetyService:ReportMenuTabOpen()
            end
        end)

        tbl3.registerOnReportTabHidden(function()
            var2(false)
            AnnotationModal.unmountAnnotationPage()

            ModalBasedSelectorDialogController.unmountModalSelector()
            if isAbuseReportMenuOpenCloseSignalEnabled() then
                SafetyService:ReportMenuTabClose()
            end
        end)
        tbl3.registerSetNextPlayerToReport(function(arg1)
            setPreselectedPlayer(arg1)
        end)
        tbl3.registerOnMenuWidthChange(function(arg1)
            var9(arg1)
        end)
        tbl3.registerOnSettingsHidden(function()
            if not bool1 then
                if ReportAbuseAnalytics:getAbuseReportSessionEntryPoint() == "" then
                    reportAnythingDispatch({ type = Constants.ReportAnythingActions.ClearAll })
                end

                return
            end

            setTimeout(function()
                if ReportAbuseAnalytics:getAbuseReportSessionEntryPoint() == "" then
                    reportAnythingDispatch({ type = Constants.ReportAnythingActions.ClearAll })
                end
            end, FIntAbuseReportTabClearCapturedScreenshotOnCloseFixDelay)
        end)
    end, { reportAnythingState })

    React.useEffect(function()
        if not isReportTabVisible then
            var6(0)

            var4(1)

            var13(false)
        elseif #Players:GetPlayers() <= 1 then
            var11(true)
            var6(2)
        else
            var6(1)
            var11(false)
        end
    end, { isReportTabVisible })

    React.useEffect(function()
        if isReportTabVisible then
            analyticsDispatch({
                type = Constants.AnalyticsActions.SetMenuOpenedTimestamp,
                timestamp = math.floor(workspace:GetServerTimeNow() * 1000)
            })

            ReportAbuseAnalytics:startAbuseReportSession("ReportPage")

            if isShowSelectInSceneReportMenu(analyticsDispatch) and isInSelectInSceneExperiment() then
                var13(true)
            end
        end

        local currentCamera = game.Workspace.CurrentCamera
        if currentCamera == nil then
            return
        end

        local viewportSize = currentCamera.ViewportSize
        var19({ width = viewportSize.X, height = viewportSize.Y })
        analyticsDispatch({
            type = Constants.AnalyticsActions.SetViewportInformation,
            viewportSizeX = viewportSize.X,
            viewportSizeY = viewportSize.Y
        })
    end, { isReportTabVisible, menuWidth })

    if FFlagReportFocusNavIEMButtons then
        React.useEffect(function()
            if not isReportTabVisible then
                return
            end

            local function isMenuSelected() -- Luacid: Inlined by compiler; 2 call sites recovered
                local getSettingsHubRef = tbl3.getSettingsHubRef
                local settingsHubRef = getSettingsHubRef and getSettingsHubRef()
                local menuContainer = settingsHubRef and settingsHubRef.MenuContainer

                return not (GuiService.SelectedCoreObject == nil or menuContainer == nil)
                    and GuiService.SelectedCoreObject:IsDescendantOf(menuContainer)
            end

            var15(not isMenuSelected())

            local connection = GuiService:GetPropertyChangedSignal("SelectedCoreObject"):Connect(function()
                var15(not isMenuSelected())
            end)

            return function()
                connection:Disconnect()
            end
        end, { isReportTabVisible, tbl3.getSettingsHubRef })
    end

    if FFlagIEMTabFocusNav then
        React.useEffect(function()
            if not isReportTabVisible then
                return
            end

            local var29 = nil
            if var16.current then
                var29 = var16.current.tabRefs
                    and { var16.current.tabRefs[1].current:FindFirstChild("Tab"), var16.current.tabRefs[2].current:FindFirstChild("Tab") }
                    or var29
            end

            if tbl3.setFirstSelectableObjects and var29 then
                tbl3.setFirstSelectableObjects(var29)
            end
        end, {
            isReportTabVisible,
            var16,
            tbl3.setFirstSelectableObjects,
            var12
        })
    end

    if not isReportTabVisible then
        return nil
    end

    local element = nil

    local utilityProps = {
        onReportComplete = tbl3.onReportComplete,
        onDropdownMenuOpenChange = if FFlagHideShortcutsOnReportDropdown then tbl3.onDropdownMenuOpenChange else nil,
        reportAnythingAnalytics = ReportAnythingAnalytics,
        reportAnythingState = reportAnythingState,
        reportAnythingDispatch = reportAnythingDispatch,
        hideReportTab = tbl3.hideReportTab,
        isReportTabVisible = isReportTabVisible,
        showReportSentPage = tbl3.showReportSentPage,
        analyticsState = analyticsState,
        analyticsDispatch = analyticsDispatch,
        preselectedPlayer = preselectedPlayer,
        setPreselectedPlayer = setPreselectedPlayer,
        menuWidth = menuWidth,
        viewportDimension = viewportDimension,
        setLastSelectableObjects = if FFlagReportFocusNavIEMButtons then tbl3.setLastSelectableObjects else nil
    }

    if var23 == ReportTypes.Person then
        element = React.createElement(
            ReportPersonMenuItemsContainer,
            { utilityProps = utilityProps, isSmallPortraitViewport = isSmallPortraitViewport }
        )
    elseif var23 == ReportTypes.Experience then
        element = React.createElement(
            ReportExperienceMenuItemsContainer,
            { utilityProps = utilityProps, isSmallPortraitViewport = isSmallPortraitViewport }
        )
    end

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl5 = {
        ref = ref,
        BackgroundTransparency = 1,
        AutomaticSize = Enum.AutomaticSize.Y,
        Size = UDim2.new(1, 0, 0, 0),
        Position = UDim2.new(0, 0, 0, menuItemSizings.TopPadding)
    }
    local tbl6 = { FocusNavigationCoreScriptsWrapper = 0 }
    local createElement2 = React.createElement
    local var29 = FocusRoot
    local tbl7 = {
        surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.RouterView,
        frameProps = {
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y
        },
        isIsolated = not bool2 or nil,
        isAutoFocusRoot = not FFlagReportFocusNavIEMButtons or var14,
        shouldRestoreFocus = not FFlagReportFocusNavIEMButtons
    }
    local tbl8 = {}

    local abuseReportMenuPlaceholderFrame = Constants.AbuseReportMenuPlaceholderFrame
    local createElement3 = React.createElement
    local str2 = "Frame"
    local tbl9 = {
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
        BorderSizePixel = 0
    }

    local tbl10 = { MenuLayoutFrame = 0 }
    local createElement4 = React.createElement
    local str3 = "Frame"
    local tbl11 = {
        BackgroundTransparency = 1,
        AutomaticSize = Enum.AutomaticSize.Y,
        Size = UDim2.new(1, 0, 0, 0)
    }
    local tbl12 = {
        Layout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            SortOrder = Enum.SortOrder.LayoutOrder,
            HorizontalAlignment = 0,
            Padding = UDim.new(0, 12)
        }),
        Padding = React.createElement(
            "UIPadding",
            {
                PaddingTop = UDim.new(0, menuItemSizings.ItemPadding),
                PaddingBottom = UDim.new(0, menuItemSizings.ItemPadding)
            }
        ),
        SelectInSceneToggleFrame = 0,
        Menu = 0
    }
    local var30

    if var12 then
        local createElement5 = React.createElement
        local str4 = "Frame"
        local tbl13 = {
            BackgroundTransparency = 1,
            AutomaticSize = Enum.AutomaticSize.XY,
            Position = UDim2.new(0.5, 0, 0, 0),
            AnchorPoint = Vector2.new(0.5, 0),
            LayoutOrder = 0
        }
        local tbl14 = {
            SelectInSceneToggle = React.createElement(SegmentedControl, {
                onTabActivated = function(arg1)
                    var4(arg1)
                end,
                selectedTabIndex = selectedTabIndex,
                tabs = {
                    {
                        tabName = var28.BuildAReport
                    },
                    {
                        tabName = var28.SelectInScene
                    }
                },
                width = UDim.new(0, menuWidth),
                ref = if FFlagIEMTabFocusNav then var16 else nil
            })
        }

        var30 = createElement5(str4, tbl13, tbl14)
    else
        var30 = nil
    end

    tbl12.SelectInSceneToggleFrame = var30
    local element2

    if var22 == ReportModes.SelectInScene then
        element2 = React.createElement(SelectInSceneReportMenu, {
            hideReportTab = tbl3.hideReportTab,
            variant = if FFlagHighlightModePreciseSelectionEnabled then getHighlightModeVariant() else nil
        })
    elseif var22 == ReportModes.Classic then
        local createElement5 = React.createElement
        local str4 = "Frame"
        local tbl13 = {
            BackgroundTransparency = 1,
            AutomaticSize = Enum.AutomaticSize.Y,
            Size = UDim2.new(1, 0, 0, 0),
            LayoutOrder = 1
        }
        local tbl14 = {
            Layout = React.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Vertical,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, menuItemSizings.ItemPadding)
            }),
            ReportTypeSelector = React.createElement(ReportTypeSelector, {
                label = var28.ReportType,
                abuseType = var28[tbl2[var5]],
                layoutOrder = 0,
                utilityProps = utilityProps,
                isSelectionDisabled = isSelectionDisabled,
                menuWidth = menuWidth,
                isSmallPortraitViewport = isSmallPortraitViewport,
                onClickLeft = function()
                    reportAnythingDispatch({ type = Constants.ReportAnythingActions.ClearAnnotationFlowProperties })

                    analyticsDispatch({ type = Constants.AnalyticsActions.IncrementExperiencePersonChanged })

                    var6((var5 - 1 - 1) % #tbl2 + 1)
                end,
                onClickRight = function()
                    reportAnythingDispatch({ type = Constants.ReportAnythingActions.ClearAnnotationFlowProperties })

                    analyticsDispatch({ type = Constants.AnalyticsActions.IncrementExperiencePersonChanged })

                    var6((var5 - 1 + 1) % #tbl2 + 1)
                end
            }),
            MenuItemsContainer = React.createElement(
                "Frame",
                {
                    BackgroundTransparency = 1,
                    LayoutOrder = 1,
                    AutomaticSize = Enum.AutomaticSize.Y,
                    Size = UDim2.new(1, 0, 0, 0)
                },
                { MenuItems = element }
            ),
            FooterFrame = 0,
            DSALinkFrame = 0,
            OSALinkFrame = 0,
            GenericIllegalContentReportLink = 0,
            TakeItDownReportLink = 0
        }
        local createElement6 = React.createElement
        local var31 = View
        local tbl15 = { tag = "size-full-0 auto-y", LayoutOrder = 2 }

        local tbl16 = { TextFrame = 0 }
        local createElement7 = React.createElement
        local var32 = View
        local tbl17 = { tag = "size-full col align-x-left gap-small padding-top-medium" }

        local tbl18 = {
            Divider = React.createElement(View, { tag = "size-full-0 stroke-muted padding-top-medium", LayoutOrder = 1 }),
            InfoText = React.createElement(FoundationText, {
                Text = if isShowUKOSAIllegalContentReportingLink() then var28.FooterInformation2 else var28.FooterInformation1,
                fontStyle = var27.Typography.BodySmall,
                textStyle = var27.Color.Content.Muted,
                TextWrapped = true,
                TextXAlignment = Enum.TextXAlignment.Left,
                tag = "auto-xy",
                LayoutOrder = 2
            })
        }
        tbl16.TextFrame = createElement7(var32, tbl17, tbl18)
        tbl14.FooterFrame = createElement6(var31, tbl15, tbl16)

        tbl14.DSALinkFrame = if FFlagMigrateAllOsaMessagingToCentralService or not isShowEUDSAIllegalContentReportingLink() then nil else React.createElement(
            "Frame",
            {
                BackgroundTransparency = 1,
                LayoutOrder = 3,
                AutomaticSize = Enum.AutomaticSize.Y,
                Size = UDim2.new(1, 0, 0, 0)
            },
            {
                DSALink = React.createElement(DSAReportLink)
            }
        )

        tbl14.OSALinkFrame = if FFlagMigrateAllOsaMessagingToCentralService or not isShowUKOSAIllegalContentReportingLink() then nil else React.createElement(
            View,
            { tag = "size-full-0 auto-y", LayoutOrder = 3 },
            {
                OSALink = React.createElement(OSAReportLink)
            }
        )

        tbl14.GenericIllegalContentReportLink = if FFlagMigrateAllOsaMessagingToCentralService and isShowGenericIllegalContentReportingLink() then React.createElement(View, { tag = "size-full-0 auto-y", LayoutOrder = 3 }, React.createElement(GenericReportLink)) else nil

        tbl14.TakeItDownReportLink = if FFlagAddTakeItDownReportLinkToSurfaces and getTakeItDownReportLinkVisibility() then React.createElement(TakeItDownReportLink, { layoutOrder = 4 }) else nil
        element2 = createElement5(str4, tbl13, tbl14)
    else
        element2 = nil
    end

    tbl12.Menu = element2
    tbl10.MenuLayoutFrame = createElement4(str3, tbl11, tbl12)
    tbl8[abuseReportMenuPlaceholderFrame] = createElement3(str2, tbl9, tbl10)
    tbl6.FocusNavigationCoreScriptsWrapper = createElement2(var29, tbl7, tbl8)
    return createElement(str1, tbl5, tbl6)
end

return function(tbl3)
    local localization = Localization.new(LocalizationService.RobloxLocaleId)
    local createElement = React.createElement
    local var1 = CoreScriptsRootProvider
    local tbl4 = {
        LocalizationProvider = React.createElement(
            LocalizationProvider,
            { localization = localization },
            {
                [Constants.LegacyAbuseReportMenuRootName] = React.createElement(func1, tbl3)
            }
        )
    }
    return createElement(var1, {}, tbl4)
end
