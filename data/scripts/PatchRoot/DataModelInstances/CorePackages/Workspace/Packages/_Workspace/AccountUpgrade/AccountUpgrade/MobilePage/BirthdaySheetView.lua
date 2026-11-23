-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T04:50:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AccountUpgrade = script:FindFirstAncestor("AccountUpgrade")
local AccountUpgradeParent = AccountUpgrade.Parent

local React = require(AccountUpgradeParent.React)
local ReactRoblox = require(AccountUpgradeParent.ReactRoblox)
local Foundation = require(AccountUpgradeParent.Foundation)
local AuthSignup = require(AccountUpgradeParent.AuthSignup)
local FocusNavigationUtils = require(AccountUpgradeParent.FocusNavigationUtils)
local InputHandlers = require(AccountUpgradeParent.InputHandlers)

local AccountUpgradeDialogActions = require(AccountUpgrade.SuccessModal.AccountUpgradeDialogActions)

local BirthdayPicker = AuthSignup.Components.BirthdayPicker
local useFocusRoot = FocusNavigationUtils.useFocusRoot
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum
local FocusNavigationEventNameEnum = FocusNavigationUtils.FocusNavigationEventNameEnum

local View = Foundation.View
local FoundationText = Foundation.Text
local IconButton = Foundation.IconButton
local ButtonVariant = Foundation.Enums.ButtonVariant
local IconName = Foundation.Enums.IconName
local InputSize = Foundation.Enums.InputSize
local StateLayerAffordance = Foundation.Enums.StateLayerAffordance

local eventMap = {
    [Enum.KeyCode.ButtonB] = FocusNavigationEventNameEnum.NavigateBack,
    [Enum.KeyCode.Escape] = FocusNavigationEventNameEnum.NavigateBack
}

local function BirthdaySheetView(tbl2)
    local var1 = Foundation.Hooks.useTokens()
    local var2 = Foundation.Hooks.useOverlay()
    local large = var1.Radius.Large
    local backdrop = var1.Color.Common.Backdrop
    local slideProgress = tbl2.slideProgress
    local isCentered = tbl2.isCentered
    local onDismiss = tbl2.onDismiss

    local eventHandlers = React.useMemo(function()
        return {
            [FocusNavigationEventNameEnum.NavigateBack] = {
                handler = InputHandlers.onRelease(function(arg1)
                    onDismiss()
                    arg1:cancel()
                end)
            }
        }
    end, { onDismiss })

    local ref = useFocusRoot({
        surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.PopUp,
        isAutoFocusRoot = true,
        eventMap = eventMap,
        eventHandlers = eventHandlers
    })

    local createElement = React.createElement
    local var5 = View
    local tbl3 = {
        ref = ref,
        tag = "size-full",
        ZIndex = 200,
        selectionGroup = {
            SelectionBehaviorUp = Enum.SelectionBehavior.Stop,
            SelectionBehaviorDown = Enum.SelectionBehavior.Stop,
            SelectionBehaviorLeft = Enum.SelectionBehavior.Stop,
            SelectionBehaviorRight = Enum.SelectionBehavior.Stop
        },
        testId = "account-upgrade-birthday-sheet"
    }

    local tbl4 = {
        Backdrop = React.createElement(View, {
            tag = "position-center-center anchor-center-center",
            Size = UDim2.fromScale(2, 2),
            backgroundStyle = slideProgress:map(function(num1: number)
                return {
                    Color3 = backdrop.Color3,
                    Transparency = math.lerp(1, backdrop.Transparency, num1)
                }
            end),
            stateLayer = {
                affordance = StateLayerAffordance.None
            },
            onActivated = tbl2.onDismiss,
            testId = "account-upgrade-birthday-sheet--backdrop"
        }),
        Panel = 0
    }

    local createElement2 = React.createElement
    local var6 = View

    local tbl5 = {
        tag = "col gap-medium size-full-0 auto-y radius-large bg-surface-100",
        AnchorPoint = slideProgress:map(function(num1: number): Vector2
            return Vector2.new(0.5, if isCentered then 0.5 else num1)
        end),
        Position = slideProgress:map(function(num1: number): UDim2
            if isCentered then
                return UDim2.fromScale(0.5, 1.5 - num1)
            end
            return UDim2.new(0.5, 0, 1, large * num1)
        end),
        ZIndex = 2,
        padding = {
            top = UDim.new(0, var1.Padding.Large),
            left = UDim.new(0, var1.Padding.Large),
            right = UDim.new(0, var1.Padding.Large),
            bottom = UDim.new(0, if isCentered then var1.Padding.Large else large + var1.Padding.Large)
        },
        stateLayer = {
            affordance = StateLayerAffordance.None
        },
        onActivated = 0,
        testId = "account-upgrade-birthday-sheet--panel"
    }
    function tbl5.onActivated() end

    tbl4.Panel = createElement2(var6, tbl5, {
        SizeConstraint = if isCentered then React.createElement("UISizeConstraint", { MaxSize = Vector2.new(540, math.huge) }) else nil,
        Header = React.createElement(View, {
            tag = "row align-y-center gap-small size-full-0 auto-y",
            LayoutOrder = 1
        }, {
            Title = React.createElement(
                FoundationText,
                {
                    Text = tbl2.titleText,
                    tag = "fill auto-y text-heading-small text-align-x-left content-emphasis",
                    LayoutOrder = 1
                }
            ),
            Close = React.createElement(IconButton, {
                icon = IconName.X,
                size = InputSize.Medium,
                onActivated = tbl2.onDismiss,
                LayoutOrder = 2,
                testId = "account-upgrade-birthday-sheet--close"
            })
        }),
        Picker = React.createElement(View, { tag = "col size-full-0 auto-y", LayoutOrder = 2 }, {
            Wheels = React.createElement(BirthdayPicker, {
                layoutOrder = 1,
                minAgeAllowed = tbl2.minAgeAllowed,
                requireManualSelection = tbl2.requireManualSelection,
                updateBirthday = tbl2.updateBirthday,
                initialMonth = tbl2.initialMonth,
                initialDay = tbl2.initialDay,
                initialYear = tbl2.initialYear
            })
        }),
        AgeSummary = if tbl2.ageSummaryText then React.createElement(FoundationText, {
            Text = tbl2.ageSummaryText,
            tag = "size-full-0 auto-y text-label-medium text-wrap text-align-x-center content-default",
            LayoutOrder = 3,
            testId = "account-upgrade-birthday-sheet--age-summary"
        }) else nil,
        Actions = React.createElement(AccountUpgradeDialogActions, {
            LayoutOrder = 4,
            testId = "account-upgrade-birthday-sheet-actions",
            buttons = {{
                text = tbl2.confirmText,
                variant = ButtonVariant.Emphasis,
                onActivated = tbl2.onConfirmActivated,
                isDisabled = not tbl2.isConfirmEnabled
            }}
        })
    })
    local element = createElement(var5, tbl3, tbl4)

    if var2 == nil then
        return element
    end
    return ReactRoblox.createPortal(element, var2)
end

return BirthdaySheetView
