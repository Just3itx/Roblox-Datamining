-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:11:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceShop = script:FindFirstAncestor("InExperienceShop")
local InExperienceShopParent = InExperienceShop.Parent

local React = require(InExperienceShopParent.React)
local FocusNavigationUtils = require(InExperienceShopParent.FocusNavigationUtils)
local ReactFocusNavigation = require(InExperienceShopParent.ReactFocusNavigation)

local ShopErrorDialog = require(InExperienceShop.Components.ShopErrorDialog)
local useTrialRedemptionErrorDialogViewModel = require(script.Parent.useTrialRedemptionErrorDialogViewModel)

local Provider = FocusNavigationUtils.FocusNavigableSurfaceRegistry.Provider

local function FocusNavigableShopErrorDialog(arg1)
    local value = React.useMemo(function()
        return ReactFocusNavigation.FocusNavigationService.new(ReactFocusNavigation.EngineInterface.CoreGui)
    end, {})

    React.useEffect(function()
        return function()
            value:teardown()
        end
    end, { value })

    return React.createElement(
        ReactFocusNavigation.FocusNavigationContext.Provider,
        { value = value },
        {
            Registry = React.createElement(Provider, nil, { Dialog = React.createElement(ShopErrorDialog, arg1) })
        }
    )
end

local function TrialRedemptionErrorDialogContainer()
    local var1 = useTrialRedemptionErrorDialogViewModel()
    if var1 == nil then
        return nil
    end

    return React.createElement(FocusNavigableShopErrorDialog, var1)
end

return TrialRedemptionErrorDialogContainer
