-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T04:50:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent
local _Types = require(ProfilePlatform.Components.CTARow.Types)
local Enums = require(ProfilePlatform.Common.Enums)
local FFlagProfileTradeItemsExposureLogging = require(ProfilePlatform.Flags.FFlagProfileTradeItemsExposureLogging)
local FFlagProfileTradeItemsImpressionLogging = require(ProfilePlatform.Flags.FFlagProfileTradeItemsImpressionLogging)
local useTradeItemsExposureLogger = require(ProfilePlatform.Hooks.useTradeItemsExposureLogger)
local useProfileAnalyticsContext = require(ProfilePlatform.Contexts.useProfileAnalyticsContext)
local EventNames = require(ProfilePlatform.Analytics.EventNames)
local contextualMenuContainsAction = require(ProfilePlatform.Utils.contextualMenuContainsAction)
local useProfileWrapperContext = require(ProfilePlatform.Contexts.useProfileWrapperContext)
local FFlagProfileGamepadPrimaryActionFocus = require(ProfilePlatform.Flags.FFlagProfileGamepadPrimaryActionFocus)

local React = require(ProfilePlatformParent.React)
local useComposedRef = require(ProfilePlatformParent.ReactUtils).useComposedRef
local _ReactFocusNavigation = require(ProfilePlatformParent.ReactFocusNavigation)
local InputHandlers = require(ProfilePlatformParent.InputHandlers)
local FocusNavigationUtils = require(ProfilePlatformParent.FocusNavigationUtils)
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum
local FocusNavigationEventNameEnum = FocusNavigationUtils.FocusNavigationEventNameEnum
local useAppFocusRoot = FocusNavigationUtils.useAppFocusRoot

local ContextualMenu = require(ProfilePlatform.Components.CTARow.ContextualMenu)

local Foundation = require(ProfilePlatformParent.Foundation)
local View = Foundation.View
local Button = Foundation.Button
local IconButton = Foundation.IconButton
local ButtonVariant = Foundation.Enums.ButtonVariant
local FillBehavior = Foundation.Enums.FillBehavior

local function CTAButton(tbl1)
    local var1, var2 = React.useState(false)
    local var3 = if FFlagProfileTradeItemsExposureLogging then useTradeItemsExposureLogger() else nil
    local var4 = if FFlagProfileTradeItemsImpressionLogging then useProfileAnalyticsContext() else nil

    local closeMenu = React.useCallback(function()
        var2(false)
    end, {})

    local var6 = React.useCallback(function()
        var2(function(arg1): boolean
            return not arg1
        end)
    end, {})

    local customEventHandlers = React.useMemo(function()
        local result = {}
        result[FocusNavigationEventNameEnum.NavigateBack] = {
            handler = InputHandlers.onRelease(closeMenu)
        }
        return result
    end, { closeMenu })

    local menuRef = useAppFocusRoot({
        surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.ContextualMenu,
        customEventHandlers = customEventHandlers,
        isAutoFocusRoot = true,
        isFocusable = var1
    })
    local anchorRef = React.useRef(nil)

    local menuItem = tbl1.buttonItem.menuItem
    local var10

    if FFlagProfileGamepadPrimaryActionFocus then
        local var11 = FocusNavigationUtils.useFocusOnMount()
        var10 = useComposedRef(anchorRef, var11)
        local var12 = useProfileWrapperContext()
        if tbl1.layoutOrder ~= 1
            or menuItem.id == Enums.ProfileActions.ContextualOverflow
            or var12.headerVariant == Enums.ProfileTabVariants.MeTab
        then
            var10 = anchorRef
        end
    else
        var10 = nil
    end

    local displayValue = menuItem.displayValue
    local icon = displayValue.icon
    local text = displayValue.text
    local contextualMenuItems = tbl1.buttonItem.contextualMenuItems
    local variant = if tbl1.buttonItem.buttonStyle then tbl1.buttonItem.buttonStyle else ButtonVariant.Standard
    local var12 = contextualMenuItems and #contextualMenuItems > 0
    local isDisabled = tbl1.buttonItem.menuItem.isDisabled

    local useCallback = React.useCallback
    local function func1()
        if FFlagProfileTradeItemsExposureLogging and menuItem.id == Enums.ProfileActions.ContextualOverflow and not var1 then
            var3()
        end

        if FFlagProfileTradeItemsImpressionLogging
            and menuItem.id == Enums.ProfileActions.ContextualOverflow
            and not var1
            and contextualMenuContainsAction(contextualMenuItems, Enums.ProfileActions.TradeItems)
        then
            var4.fireAnalyticsEvent(
                EventNames.ContextualMenuTradeItemsImpression,
                {
                    buttonSurface = Enums.ButtonSurface.ContextualMenu
                }
            )
        end

        if not var12 then
            menuItem.onActivated()

            return
        end

        if not var1 then
            menuItem.onActivated()
        end
        var6()
    end

    local id = menuItem.id
    local onActivated = menuItem.onActivated
    local var13 = if FFlagProfileTradeItemsExposureLogging then var3 else nil
    local var14 = if FFlagProfileTradeItemsImpressionLogging then var4 else nil
    local var15 = if FFlagProfileTradeItemsImpressionLogging then contextualMenuItems else nil
    local var5 = useCallback(func1, { var12, var1, id, onActivated, var6, var13, var14, var15 })
    local bool1 = not (icon == nil) and text == nil
    local var17

    if bool1 then
        local createElement = React.createElement
        local var18 = IconButton
        local tbl2 = {
            icon = icon,
            LayoutOrder = tbl1.layoutOrder,
            onActivated = var5,
            variant = ButtonVariant.Standard,
            ref = 0,
            isDisabled = 0
        }

        if not FFlagProfileGamepadPrimaryActionFocus then
            var10 = anchorRef
        end

        tbl2.ref = var10
        tbl2.isDisabled = isDisabled
        var17 = createElement(var18, tbl2)
    else
        local createElement = React.createElement
        local var18 = Button
        local tbl2 = {
            text = text,
            icon = icon,
            onActivated = var5,
            fillBehavior = FillBehavior.Fill,
            variant = variant,
            isLoading = tbl1.buttonItem.isLoading,
            LayoutOrder = tbl1.layoutOrder,
            ref = 0,
            isDisabled = 0
        }

        if not FFlagProfileGamepadPrimaryActionFocus then
            var10 = anchorRef
        end

        tbl2.ref = var10
        tbl2.isDisabled = isDisabled
        var17 = createElement(var18, tbl2)
    end

    return React.createElement(
        View,
        {
            tag = {
                ["auto-xy"] = bool1,
                ["fill auto-y"] = not bool1
            },
            LayoutOrder = tbl1.layoutOrder
        },
        {
            Button = var17,
            ContextualMenu = if var12 then React.createElement(ContextualMenu, {
                isOpen = var1,
                menuItems = contextualMenuItems,
                anchorRef = anchorRef,
                menuRef = menuRef,
                closeMenu = closeMenu,
                align = tbl1.align
            }) else nil
        }
    )
end

return CTAButton
