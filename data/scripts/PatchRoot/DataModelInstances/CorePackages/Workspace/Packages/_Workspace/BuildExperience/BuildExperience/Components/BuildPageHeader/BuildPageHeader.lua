-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:21:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local Display = require(BuildExperienceParent.Display)
local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)
local SharedFlags = require(BuildExperienceParent.SharedFlags)
local SignalsReact = require(BuildExperienceParent.SignalsReact)
local UIBlox = require(BuildExperienceParent.UIBlox)
local useLocalization = require(BuildExperienceParent.Localization).Hooks.useLocalization
local LocalizationStrings = require(BuildExperience.LocalizationStrings)
local FFlagEnableHomeRobloxLogo = SharedFlags.FFlagEnableHomeRobloxLogo
local FFlagAppThemeHalloween2026BuildBackground = require(BuildExperience.Flags.FFlagAppThemeHalloween2026BuildBackground)
local useThemeBackground = require(BuildExperienceParent.ThemeBackground).useThemeBackground

local HeaderBar = UIBlox.App.Bar.HeaderBar
local Button = Foundation.Button
local IconButton = Foundation.IconButton
local View = Foundation.View

local ButtonVariant = Foundation.Enums.ButtonVariant
local IconName = Foundation.Enums.IconName
local InputSize = Foundation.Enums.InputSize
local useScaledValue = Foundation.Hooks.useScaledValue
local useTokens = Foundation.Hooks.useTokens

local FlyoutSidePanelIXP = require(BuildExperienceParent.SharedExperimentDefinition).FlyoutSidePanelIXP
local FlyoutLeftHeader = require(BuildExperienceParent.FlyoutSidePanel).Components.FlyoutLeftHeader
local SearchBarContainer = require(BuildExperience.Components.SearchBar.SearchBarContainer)
local GetSearchQueryStore = require(BuildExperience.Stores.GetSearchQueryStore)
local _createSearchQueryStore = require(BuildExperience.Stores.GetSearchQueryStore.createSearchQueryStore)

local num1 = game:DefineFastInt("BuildSearchBarWidth", 400)

local function renderFlyoutLeftHeader(titleText: string?)
    return React.createElement(FlyoutLeftHeader, {
        titleText = titleText,
        isRobloxLogoEnabled = false,
        isFlyoutEntrypointEnabled = if FFlagEnableHomeRobloxLogo then FlyoutSidePanelIXP.isFlyoutSidePanelEnabled() else nil,
        isAlternateEntryPointEnabled = FlyoutSidePanelIXP.isAlternateEntryPointEnabled()
    })
end

local function renderEmptyRight()
    return nil
end

local function HeaderSearch(tbl1)
    local xOffset = useScaledValue(num1)
    local size2200 = useTokens().Size.Size_2200
    local searchQueryStore = tbl1.searchQueryStore
    local var1 = searchQueryStore.useIsSearchActive()
    local query = SignalsReact.useSignalBinding(searchQueryStore.getDraftQuery)
    local var3 = useLocalization(
        {
            searchbarPlaceholder = "Feature.Build.Label.SearchGames",
            cancelText = "Feature.Build.Action.Cancel"
        }
    )

    React.useEffect(function()
        return function()
            searchQueryStore.setIsSearchActive(false)
        end
    end, { searchQueryStore })

    local createElement = React.createElement
    local var4 = View
    local tbl2 = {
        tag = "row align-y-center gap-small size-full",
        testId = "BuildPageHeader.CenterSearchContainer"
    }

    local tbl3 = {
        LeftSpacer = React.createElement(View, { LayoutOrder = 1, tag = "fill size-0-full" }),
        SearchBarContainer = React.createElement(
            View,
            {
                LayoutOrder = 2,
                Size = UDim2.new(0, xOffset, 1, 0),
                tag = "row align-y-center shrink"
            },
            {
                SearchBar = React.createElement(SearchBarContainer, {
                    clear = searchQueryStore.clear,
                    onDismiss = searchQueryStore.endSearch,
                    onFocusGained = searchQueryStore.beginSearch,
                    onFocusLost = searchQueryStore.endSearchIfEmpty,
                    placeholder = var3.searchbarPlaceholder,
                    query = query,
                    setQuery = searchQueryStore.setQuery
                })
            }
        ),
        RightContainer = React.createElement(View, {
            LayoutOrder = 3,
            tag = "row align-y-center fill size-0-full"
        }, {
            Cancel = if var1 then React.createElement(Button, {
                width = UDim.new(0, size2200),
                text = var3.cancelText,
                variant = ButtonVariant.Utility,
                size = InputSize.Medium,
                onActivated = searchQueryStore.endSearch,
                testId = "BuildPageHeader.SearchCancelButton"
            }) else nil
        })
    }
    return createElement(var4, tbl2, tbl3)
end

local function HeaderCenter(tbl1)
    local displayStore = Display.GetDisplayStore(false)
    if SignalsReact.useSignalState(displayStore.getDisplaySize) == Enum.DisplaySize.Small then
        return nil
    end

    return React.createElement(HeaderSearch, { searchQueryStore = tbl1.searchQueryStore or GetSearchQueryStore() })
end

local function BuildPageHeader(tbl1)
    local title = useLocalization({ title = LocalizationStrings.BUILD_HEADER_TITLE }).title
    local bool1 = if FFlagAppThemeHalloween2026BuildBackground then useThemeBackground() ~= nil else false
    local var1 = FlyoutSidePanelIXP.isFlyoutSidePanelEnabled()

    local displayStore = Display.GetDisplayStore(false)
    local var2 = SignalsReact.useSignalState(displayStore.getDisplaySize)
    local searchQueryStore = tbl1.searchQueryStore or GetSearchQueryStore()
    local bool2 = var2 ~= Enum.DisplaySize.Small
    local bool3 = var2 == Enum.DisplaySize.Small and tbl1.onOpenSearch ~= nil
    local renderCenter = bool2 and function()
        return React.createElement(HeaderCenter, { searchQueryStore = searchQueryStore })
    end or nil

    local renderRight = bool3 and function()
        return React.createElement(
            View,
            {
                tag = "row align-y-center gap-medium auto-xy",
                testId = "BuildPageHeader.RightActions"
            },
            {
                Search = if bool3 then React.createElement(IconButton, {
                    LayoutOrder = 1,
                    icon = IconName.MagnifyingGlass,
                    isCircular = true,
                    onActivated = tbl1.onOpenSearch,
                    size = InputSize.Medium,
                    testId = "BuildPageHeader.SearchButton",
                    variant = ButtonVariant.Utility
                }) else nil
            }
        )
    end or renderEmptyRight

    local createElement = React.createElement
    local var5 = View
    local tbl2 = {
        LayoutOrder = tbl1.LayoutOrder,
        ZIndex = 3,
        tag = "composition-content-header size-full-0 auto-y",
        Size = UDim2.new(1, 0, 0, tbl1.height),
        testId = "BuildPageHeader"
    }
    local tbl3 = {
        HeaderBar = React.createElement(HeaderBar, {
            barHeight = tbl1.height,
            isTitleCentered = false,
            paddingLeft = UDim.new(0, 0),
            paddingRight = UDim.new(0, 0),
            renderLeft = var1 and function()
                return renderFlyoutLeftHeader(title)
            end or nil,
            title = if var1 then nil else title,
            renderCenter = renderCenter,
            renderRight = renderRight,
            backgroundTransparency = if bool1 then 1 else nil
        })
    }

    return createElement(var5, tbl2, tbl3)
end

return BuildPageHeader
