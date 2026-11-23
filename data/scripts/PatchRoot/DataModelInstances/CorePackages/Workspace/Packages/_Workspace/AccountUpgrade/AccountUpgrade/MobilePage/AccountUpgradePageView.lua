-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T04:50:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AccountUpgrade = script:FindFirstAncestor("AccountUpgrade")
local AccountUpgradeParent = AccountUpgrade.Parent

local React = require(AccountUpgradeParent.React)
local ReactRoblox = require(AccountUpgradeParent.ReactRoblox)
local Foundation = require(AccountUpgradeParent.Foundation)
local FocusNavigationUtils = require(AccountUpgradeParent.FocusNavigationUtils)
local InputHandlers = require(AccountUpgradeParent.InputHandlers)
local FullscreenPageWithSafeArea = require(AccountUpgradeParent.AppBlox).FullscreenPageWithSafeArea
local LegalTextWithLinks = require(AccountUpgradeParent.AuthCommon).Components.LegalTextWithLinks

local AccountUpgradeFields = require(AccountUpgrade.Components.AccountUpgradeFields)
local AccountUpgradeFieldError = require(AccountUpgrade.Components.AccountUpgradeFieldError)
local CloseConfirmationDialog = require(AccountUpgrade.Components.CloseConfirmationDialog)
local MarketingConsentCheckbox = require(AccountUpgrade.Components.MarketingConsentCheckbox)
local AccountUpgradeField = require(AccountUpgrade.AccountUpgradeField)
local FFlagAccountUpgradeOAuthDialogFitsContent = require(AccountUpgrade.Flags.FFlagAccountUpgradeOAuthDialogFitsContent)
local FFlagAccountUpgradeOAuthTelemetry = require(AccountUpgrade.Flags.FFlagAccountUpgradeOAuthTelemetry)
local BirthdaySheet = require(script.Parent.BirthdaySheet)
local FFlagAccountUpgradeFullPageInOverlay = require(script.Parent.FFlagAccountUpgradeFullPageInOverlay)

local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum
local FocusNavigationEventNameEnum = FocusNavigationUtils.FocusNavigationEventNameEnum
local useFocusRoot = FocusNavigationUtils.useFocusRoot
local useLastInputMode = FocusNavigationUtils.useLastInputMode

local View = Foundation.View
local FoundationText = Foundation.Text
local Button = Foundation.Button
local ScrollView = Foundation.ScrollView
local HeaderBar = Foundation.HeaderBar

local ButtonVariant = Foundation.Enums.ButtonVariant
local InputSize = Foundation.Enums.InputSize
local IconName = Foundation.Enums.IconName
local ScrollBarVisibility = Foundation.Enums.ScrollBarVisibility
local StateLayerAffordance = Foundation.Enums.StateLayerAffordance

local eventMap = {
    [Enum.KeyCode.ButtonB] = FocusNavigationEventNameEnum.NavigateBack,
    [Enum.KeyCode.Escape] = FocusNavigationEventNameEnum.NavigateBack
}

local function noop() end

local function sinkPress() end

local function OverlayPageLayer(tbl2)
    return ReactRoblox.createPortal(
        React.createElement(View, {
            tag = "size-full",
            ZIndex = 100,
            testId = "AccountUpgradePageLayer"
        }, {
            Background = React.createElement(View, {
                tag = "position-center-center anchor-center-center bg-surface-0",
                Size = UDim2.fromScale(2, 2),
                ZIndex = 1,
                stateLayer = {
                    affordance = StateLayerAffordance.None
                },
                selection = { Selectable = false },
                onActivated = sinkPress,
                testId = "AccountUpgradePageBackground"
            }),
            Content = React.createElement(View, { tag = "size-full", ZIndex = 2 }, tbl2.children)
        }),
        tbl2.overlay
    )
end

local function AccountUpgradePageView(form)
    local var1 = Foundation.Hooks.useTokens()

    local isDisabled = not (form.isSaveEnabled or form.isSubmitting)
    local onClose = form.onClose
    local onSignOut = form.onSignOut
    local bool2 = useLastInputMode() == "Focus"
    local eventHandlers = React.useMemo(function()
        return {
            [FocusNavigationEventNameEnum.NavigateBack] = {
                handler = InputHandlers.onRelease(function(arg1)
                    if onClose then
                        onClose()
                    end
                    arg1:cancel()
                end)
            }
        }
    end, { onClose })

    local ref = useFocusRoot({
        surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.PopUp,
        isFocusable = not (form.isBirthdayPickerOpen or form.isCloseConfirmationOpen),
        isAutoFocusRoot = true,
        eventMap = eventMap,
        eventHandlers = eventHandlers
    })
    local overlay = if FFlagAccountUpgradeFullPageInOverlay then Foundation.Hooks.useOverlay() else nil
    local var5 = FullscreenPageWithSafeArea

    local tbl2 = {
        includeStatusBar = true,
        BackgroundTransparency = 0,
        BackgroundColor3 = var1.Color.Surface.Surface_0.Color3
    }
    if overlay ~= nil then
        var5 = OverlayPageLayer
        tbl2 = { overlay = overlay }
    end

    local createElement = React.createElement
    local tbl3 = { Page = 0 }
    local createElement2 = React.createElement
    local var6 = View
    local tbl4 = {
        ref = ref,
        tag = "col size-full bg-surface-0",
        selectionGroup = {
            SelectionBehaviorUp = Enum.SelectionBehavior.Stop,
            SelectionBehaviorDown = Enum.SelectionBehavior.Stop,
            SelectionBehaviorLeft = Enum.SelectionBehavior.Stop,
            SelectionBehaviorRight = Enum.SelectionBehavior.Stop
        },
        testId = "AccountUpgradePage"
    }

    local tbl5 = { Header = 0, Scroll = 0, BirthdayPicker = 0, CloseConfirmation = 0 }

    local createElement3 = React.createElement
    local root = HeaderBar.Root
    local tbl6 = { LayoutOrder = 1, testId = "AccountUpgradePageHeader" }
    local tbl7 = {
        Leading = React.createElement(HeaderBar.Leading),
        Content = React.createElement(HeaderBar.Content, nil, {
            Title = React.createElement(
                FoundationText,
                {
                    Text = form.titleText,
                    tag = "auto-xy text-heading-medium content-emphasis",
                    testId = "AccountUpgradePageTitle"
                }
            )
        }),
        Trailing = React.createElement(HeaderBar.Trailing, nil, {
            Actions = if onClose and not bool2 then React.createElement(HeaderBar.Actions, { actions = {{ id = "close", icon = IconName.X, onActivated = onClose }} }) else nil
        })
    }
    tbl5.Header = createElement3(root, tbl6, tbl7)

    local createElement4 = React.createElement
    local var7 = ScrollView
    local tbl8 = {
        tag = "fill size-full-0",
        LayoutOrder = 2,
        scroll = {
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
            CanvasSize = UDim2.fromScale(1, 0),
            ScrollingDirection = Enum.ScrollingDirection.Y,
            scrollBarVisibility = ScrollBarVisibility.Auto
        },
        testId = "AccountUpgradePageScroll"
    }

    local tbl9 = { Content = 0 }
    local createElement5 = React.createElement
    local var8 = View
    local tbl10 = { tag = "col gap-xxlarge size-full-0 auto-y padding-x-large padding-y-medium" }

    local tbl11 = {
        Subtitle = React.createElement(FoundationText, {
            Text = form.subtitleText,
            tag = "size-full-0 auto-y text-body-medium text-wrap text-align-x-left content-default",
            LayoutOrder = 1,
            testId = "AccountUpgradeSubtitle"
        }),
        Fields = React.createElement(AccountUpgradeFields, { form = form, size = InputSize.Large, boldLabels = true, LayoutOrder = 2 }),
        MarketingConsent = 0,
        Actions = 0
    }
    local element

    if form.marketingConsentText == nil then
        element = nil
    else
        element = React.createElement(MarketingConsentCheckbox, {
            text = form.marketingConsentText,
            isChecked = form.isMarketingConsentChecked == true,
            isDisabled = form.isSubmitting or form.isMarketingConsentDisabled == true,
            onToggled = form.onMarketingConsentToggled or noop,
            size = InputSize.Small,
            smallGap = true,
            LayoutOrder = 3
        })
    end

    tbl11.MarketingConsent = element

    local createElement6 = React.createElement
    local var9 = View
    local tbl12 = {
        tag = "col gap-small size-full-0 auto-y",
        LayoutOrder = 4,
        testId = "AccountUpgradePageActions"
    }

    local tbl13 = {
        Save = React.createElement(Button, {
            text = form.saveText,
            variant = if isDisabled then ButtonVariant.Standard else ButtonVariant.Emphasis,
            size = InputSize.Large,
            width = UDim.new(1, 0),
            onActivated = form.onSaveActivated,
            isDisabled = isDisabled,
            isLoading = form.isSubmitting,
            LayoutOrder = 1,
            testId = "AccountUpgradePageSaveButton"
        }),
        Error = React.createElement(
            AccountUpgradeFieldError,
            {
                text = form.submitError,
                LayoutOrder = 2,
                testId = "AccountUpgradeSubmitError"
            }
        ),
        LegalText = if FFlagAccountUpgradeOAuthDialogFitsContent and form.legalText then React.createElement(
            LegalTextWithLinks,
            {
                text = form.legalText,
                onLinkActivated = form.onLegalLinkActivated,
                LayoutOrder = 3,
                testId = "AccountUpgradeLegalText"
            }
        ) else nil
    }
    tbl11.Actions = createElement6(var9, tbl12, tbl13)
    tbl9.Content = createElement5(var8, tbl10, tbl11)
    tbl5.Scroll = createElement4(var7, tbl8, tbl9)
    local element2 = if form.fieldStates[AccountUpgradeField.Birthday] == nil then nil else React.createElement(
        BirthdaySheet,
        {
            isOpen = form.isBirthdayPickerOpen,
            birthday = form.birthday,
            onClose = form.onBirthdayPickerClosed,
            onConfirm = form.onBirthdayConfirmed,
            onAllPicked = if FFlagAccountUpgradeOAuthTelemetry then form.onBirthdayPickerAllPicked else nil
        }
    )
    tbl5.BirthdayPicker = element2

    tbl5.CloseConfirmation = if form.isCloseConfirmationOpen and onSignOut then React.createElement(CloseConfirmationDialog, { onBack = form.onCloseConfirmationBack, onSignOut = onSignOut }) else nil
    tbl3.Page = createElement2(var6, tbl4, tbl5)
    return createElement(var5, tbl2, tbl3)
end

return AccountUpgradePageView
