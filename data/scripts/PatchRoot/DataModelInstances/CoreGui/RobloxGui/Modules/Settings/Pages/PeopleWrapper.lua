-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:11:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")
local LocalizationService = game:GetService("LocalizationService")
local RobloxGui = CoreGui:WaitForChild("RobloxGui")
local Modules = RobloxGui.Modules

local React = require(CorePackages.Packages.React)
local ReactRoblox = require(CorePackages.Packages.ReactRoblox)

local FFlagRefactorPeoplePage = require(Modules.Settings.Flags.FFlagRefactorPeoplePage)
local FFlagRelocateMobileMenuButtons = require(Modules.Settings.Flags.FFlagRelocateMobileMenuButtons)
local FIntRelocateMobileMenuButtonsVariant = require(Modules.Settings.Flags.FIntRelocateMobileMenuButtonsVariant)

local Chrome = RobloxGui.Modules.Chrome
local chromeEnabled = require(CorePackages.Workspace.Packages.Chrome).Enabled()
local LocalStore = if chromeEnabled then require(Chrome.ChromeShared.Service.LocalStore) else nil
local Localization = require(CorePackages.Workspace.Packages.InExperienceLocales).Localization
local LocalizationProvider = require(CorePackages.Workspace.Packages.Localization).LocalizationProvider
local Signals = require(CorePackages.Packages.Signals)
local SignalsReact = require(CorePackages.Packages.SignalsReact)
local SettingsPageFactory = require(Modules.Settings.SettingsPageFactory)
local SettingsShowSignal = require(CorePackages.Workspace.Packages.CoreScriptsCommon).SettingsShowSignal
local localization = Localization.new(LocalizationService.RobloxLocaleId)
local BuilderIcons = require(CorePackages.Packages.BuilderIcons)
local BlockingModalScreen = require(Modules.Settings.Components.Blocking.BlockingModalScreen)
local uiblox = BuilderIcons.Migration.uiblox
local PeopleService = require(CorePackages.Workspace.Packages.PeopleService)
local InExperienceSideSheet = require(CorePackages.Workspace.Packages.InExperienceSideSheet)
local FFlagSideSheetOpenPeoplePage = InExperienceSideSheet.Flags.FFlagSideSheetOpenPeoplePage

local FocusNavigationUtils = require(CorePackages.Workspace.Packages.FocusNavigationUtils)
local FocusRoot = FocusNavigationUtils.FocusRoot
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum
local CoreScriptsRootProvider = require(CorePackages.Workspace.Packages.CoreScriptsRoactCommon).CoreScriptsRootProvider

local Constants = if FFlagRefactorPeoplePage() then require(CorePackages.Workspace.Packages.PeopleReactView).Constants else nil

local service = PeopleService.getService("Flags")
local GetFFlagAddPeoplePageCardLayout = service.GetFFlagAddPeoplePageCardLayout
local GetFFlagPeoplePageLazyRenderCards = service.GetFFlagPeoplePageLazyRenderCards
local FFlagEnablePeopleListLazyRender = service.FFlagEnablePeopleListLazyRender
local FFlagPeopleCardsEnableVirtualizedGrid = service.FFlagPeopleCardsEnableVirtualizedGrid

local FFlagPeoplePageDismissVolumePopoverOnScrollOutOfView = service.FFlagPeoplePageDismissVolumePopoverOnScrollOutOfView

local FFlagPeoplePageFlipVolumePopoverToFitViewport = service.FFlagPeoplePageFlipVolumePopoverToFitViewport

local FFlagPeoplePageDismissCardMenuOnScrollOutOfView = service.FFlagPeoplePageDismissCardMenuOnScrollOutOfView

local root = nil
local var2, var3 = Signals.createSignal(false)

local function PeopleFocusRoot(arg1)
    return React.createElement(
        FocusRoot,
        {
            surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.RouterView,
            isAutoFocusRoot = false
        },
        arg1.children
    )
end

local function createPeoplePage()
    local peopleReactView = require(CorePackages.Workspace.Packages.PeopleReactView)
    local peopleReactView2 = peopleReactView.PeopleReactView
    local sideSheetFocusContext = peopleReactView.SideSheetFocusContext
    local peopleService = require(CorePackages.Workspace.Packages.PeopleService)
    local var4 = SettingsPageFactory:CreateNewPage()

    var4.TabHeader.Name = Constants.PEOPLEPAGE.TAB_HEADER.NAME
    var4.Page.Name = Constants.PEOPLEPAGE.PAGE_ID
    local var5 = uiblox[Constants.PEOPLEPAGE.TAB_HEADER.ICON]
    var4.TabHeader.TabLabel.Icon.Text = var5.name
    var4.TabHeader.TabLabel.Icon.FontFace = BuilderIcons.Font[var5.variant]
    var4.TabHeader.TabLabel.Title.Text = localization:Format(Constants.PEOPLEPAGE.TAB_HEADER.TEXT)

    local service2 = peopleService.getService("SettingsHubService")
    service2.register(var4)

    function var4.CreateMenuButtonsContainer(_)
        service2.setShowMenuButtonsContainer(true)
    end

    if FFlagRelocateMobileMenuButtons and FIntRelocateMobileMenuButtonsVariant == 2 then
        function var4.UnmountMenuButtonsContainer(_)
            service2.setShowMenuButtonsContainer(false)
        end
    end

    local function createReactTree()
        if root then
            return
        end

        local var6 = if GetFFlagPeoplePageLazyRenderCards()
            or FFlagEnablePeopleListLazyRender
            or FFlagPeopleCardsEnableVirtualizedGrid
            or FFlagPeoplePageDismissVolumePopoverOnScrollOutOfView
            or FFlagPeoplePageFlipVolumePopoverToFitViewport
            or FFlagPeoplePageDismissCardMenuOnScrollOutOfView then var4.Page:FindFirstAncestorWhichIsA("ScrollingFrame") else nil

        local function PeopleConditionalView()
            local var7 = SignalsReact.useSignalState(var2)
            local var8 = if FFlagSideSheetOpenPeoplePage then SignalsReact.useSignalState(InExperienceSideSheet.getSideSheetVisibility) else false
            local var9 = if FFlagSideSheetOpenPeoplePage then SignalsReact.useSignalState(InExperienceSideSheet.getDidSideSheetOpenWithPeoplePage) else false
            local element

            if var7 then
                local createElement = React.createElement
                local var10 = CoreScriptsRootProvider
                local tbl1 = {}
                local tbl2 = { LocalizationProvider = 0 }
                local createElement2 = React.createElement
                local var11 = LocalizationProvider
                local tbl3 = { localization = localization }
                local tbl4 = { FocusRoot = 0 }
                local createElement3 = React.createElement
                local func1 = PeopleFocusRoot
                local tbl5 = {}
                local tbl6 = {
                    PeopleReactView = React.createElement(peopleReactView2, {
                        blockingModalScreen = BlockingModalScreen,
                        blockingFlags = {},
                        scrollingFrame = if GetFFlagPeoplePageLazyRenderCards()
                            or FFlagEnablePeopleListLazyRender
                            or FFlagPeopleCardsEnableVirtualizedGrid
                            or FFlagPeoplePageDismissVolumePopoverOnScrollOutOfView
                            or FFlagPeoplePageFlipVolumePopoverToFitViewport
                            or FFlagPeoplePageDismissCardMenuOnScrollOutOfView then var6 else nil,
                        chromeEnabled = chromeEnabled,
                        getUniversesExposedTo = if GetFFlagAddPeoplePageCardLayout() and LocalStore then LocalStore.getUniversesExposedTo else nil,
                        addUniverseToExposureList = if GetFFlagAddPeoplePageCardLayout() and LocalStore then LocalStore.addUniverseToExposureList else nil,
                        minimumCardWidth = if FFlagSideSheetOpenPeoplePage and var8 and var9 then Constants.PEOPLEPAGE.PEOPLE_CARDS.SIDE_SHEET_MINIMUM_CARD_WIDTH else nil
                    })
                }
                tbl4.FocusRoot = createElement3(func1, tbl5, tbl6)
                tbl2.LocalizationProvider = createElement2(var11, tbl3, tbl4)
                element = createElement(var10, tbl1, tbl2)
            else
                element = nil
            end

            if FFlagSideSheetOpenPeoplePage then
                element = element and React.createElement(sideSheetFocusContext.Provider, { value = var8 and var9 }, { People = element })
            end

            return element
        end

        root = ReactRoblox.createRoot(var4.Page)
        if root then
            root:render(React.createElement(PeopleConditionalView))
        end
    end

    var4.Displayed.Event:Connect(function()
        if not var2(false) then
            createReactTree()
            var3(true)
        end
        local menuContainer = var4.Page:FindFirstAncestor("MenuContainer")
        if not menuContainer then
            return
        end

        local bottomButtonFrame = menuContainer:FindFirstChild("BottomButtonFrame", true)
        if bottomButtonFrame then
            bottomButtonFrame.SelectionBehaviorUp = Enum.SelectionBehavior.Escape
        end
    end)

    SettingsShowSignal:connect(function(arg1)
        if not arg1 then
            var3(false)
        end
    end)

    var4.Page.Size = UDim2.new(1, 0, 0, 0)
    var4.Page.AutomaticSize = Enum.AutomaticSize.Y

    return var4
end

if FFlagRefactorPeoplePage() then
    return (createPeoplePage())
end
return require(Modules.Settings.Pages.Players)
