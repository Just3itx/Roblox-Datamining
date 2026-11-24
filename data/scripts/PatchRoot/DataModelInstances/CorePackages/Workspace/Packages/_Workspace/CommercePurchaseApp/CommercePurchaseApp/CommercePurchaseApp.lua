-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:41:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GuiService = game:GetService("GuiService")

local CommercePurchaseApp = script:FindFirstAncestor("CommercePurchaseApp")
local CommercePurchaseAppParent = CommercePurchaseApp.Parent
local React = require(CommercePurchaseAppParent.React)
local useSelector = require(CommercePurchaseAppParent.RoactUtils).Hooks.RoactRodux.useSelector
local Toast = require(CommercePurchaseAppParent.ToastLite).Components.Toast

local CommercePurchasePromptStateEnum = require(CommercePurchaseApp.Enums.CommercePurchasePromptStateEnum)
local CommercePurchaseErrorContainer = require(CommercePurchaseApp.Features.CommercePurchaseError.CommercePurchaseErrorContainer)
local ScreenSizeContext = require(CommercePurchaseAppParent.EconomyCommonCoreScriptHooks).ScreenSizeContext
local useBenefitStatusReceivedListenerEffect = require(CommercePurchaseApp.Hooks.useBenefitStatusReceivedListenerEffect)

local useCommerceProductPurchaseRequestListenerEffect = require(CommercePurchaseApp.Hooks.useCommerceProductPurchaseRequestListenerEffect)
local FocusNavigationModalSurface = require(CommercePurchaseAppParent.EconomyCommonCoreScriptHooks).FocusNavigationModalSurface
local usePurchaseBrowserClosedListenerEffect = require(CommercePurchaseApp.Hooks.usePurchaseBrowserClosedListenerEffect)
local selectPromptState = require(CommercePurchaseApp.Store.Selectors.selectPromptState)

local function CommercePurchaseApp2()
    local value, var2 = React.useState(Vector2.new(0, 0))
    local var3 = useSelector(selectPromptState)

    useBenefitStatusReceivedListenerEffect()
    usePurchaseBrowserClosedListenerEffect()
    useCommerceProductPurchaseRequestListenerEffect()

    React.useEffect(function()
        if var3 == CommercePurchasePromptStateEnum.None then
            GuiService.SelectedCoreObject = nil
        end
    end, { var3 })
    if var3 == CommercePurchasePromptStateEnum.None then
        return nil
    end

    local createElement = React.createElement
    local provider = ScreenSizeContext.Provider
    local tbl1 = { value = value }
    local createElement2 = React.createElement
    local str1 = "ScreenGui"
    local tbl2 = {}
    tbl2[React.Change.AbsoluteSize] = function(arg1)
        var2(arg1.AbsoluteSize)
    end
    tbl2.ScreenInsets = Enum.ScreenInsets.None
    local tbl3 = {
        FocusNavigationEffects = React.createElement(
            FocusNavigationModalSurface,
            { selectionGroupName = "CommercePurchaseApp" },
            {
                Error = if var3 == CommercePurchasePromptStateEnum.Error then React.createElement(CommercePurchaseErrorContainer) else nil,
                Toast = React.createElement(Toast)
            }
        )
    }
    return (createElement(provider, tbl1, createElement2(str1, tbl2, tbl3)))
end

return CommercePurchaseApp2
