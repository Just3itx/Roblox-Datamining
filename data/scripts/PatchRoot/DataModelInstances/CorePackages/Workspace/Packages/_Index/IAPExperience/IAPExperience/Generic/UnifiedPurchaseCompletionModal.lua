-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:11:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local React = require(scriptParentParentParent.React)

local Foundation = require(scriptParentParentParent.Foundation)
local ButtonVariant = require(scriptParentParentParent.Foundation).Enums.ButtonVariant
local FillBehavior = require(scriptParentParentParent.Foundation).Enums.FillBehavior
local View = Foundation.View
local FoundationText = Foundation.Text
local Icon = Foundation.Icon
local Sheet = Foundation.Sheet
local useTokens = Foundation.Hooks.useTokens
local useScaledValue = Foundation.Hooks.useScaledValue

local LoggingProtocol = require(scriptParentParentParent.LoggingProtocol)
local UnifiedProductPurchaseCompletionModalShownCounter = require(scriptParentParent.Generic.Events.UnifiedPurchaseCompletionCounter).UnifiedProductPurchaseCompletionModalShownCounter

local useLocalization = require(scriptParentParentParent.Localization).Hooks.useLocalization
local formatTextWithParams = require(scriptParentParent.Utility.formatTextWithParams)

local useFocusNavigationRefs = require(scriptParentParent.Generic.Hooks.useFocusNavigationRefs)
local useInitialButtonDisableDelay = require(scriptParentParent.Generic.Hooks.useInitialButtonDisableDelay)

local UNIFIED_PURCHASE_COMPLETION_MODAL_MIN_HEIGHT_PIXELS = require(scriptParentParent.Generic.Constants).UNIFIED_PURCHASE_COMPLETION_MODAL_MIN_HEIGHT_PIXELS

local function UnifiedPurchaseCompletionModal(tbl1)
    local var1 = useLocalization({
        PurchaseCompleteTitle = "IAPExperience.PurchasePrompt.Title.PurchaseCompleted",
        PurchaseCompleteBody = "IAPExperience.PurchasePrompt.Body.PurchaseCompleted",
        ErrorTitle = "CoreScripts.PremiumModal.Title.Error",
        GenericErrorBody = "CoreScripts.PurchasePrompt.PurchaseFailed.UnknownFailureNoItemName",
        OkButtonText = "CoreScripts.PurchasePrompt.Button.OK",
        MultiItemPurchaseCompleteBody = "IAPExperience.PurchasePrompt.Body.PurchaseItemsSuccess"
    })

    local var2, ref = useFocusNavigationRefs(tbl1.buttons.onClose, nil)

    local isDisabled = useInitialButtonDisableDelay()

    local var5 = useTokens()
    local name, var7 = React.useState(Foundation.Enums.IconName.CircleCheck)

    React.useEffect(function()
        LoggingProtocol.default:logRobloxTelemetryCounter(UnifiedProductPurchaseCompletionModalShownCounter, 1, {})
    end, {})

    local var8 = React.useMemo(function()
        if tbl1.title then
            return tbl1.title
        end

        if tbl1.isError then
            return var1.ErrorTitle
        end

        return var1.PurchaseCompleteTitle
    end, { tbl1.title, tbl1.isError })

    local var9 = React.useMemo(function()
        if tbl1.bodyText then
            return tbl1.bodyText
        elseif tbl1.isError then
            return var1.GenericErrorBody
        elseif tbl1.isMultiItem then
            return var1.MultiItemPurchaseCompleteBody
        end
        return formatTextWithParams(var1.PurchaseCompleteBody, { ITEM_NAME = tbl1.itemName })
    end, {
        tbl1.bodyText,
        tbl1.isError,
        tbl1.isMultiItem,
        tbl1.itemName
    })

    local text = if tbl1.buttons and tbl1.buttons.text then tbl1.buttons.text else var1.OkButtonText

    React.useEffect(function()
        if tbl1.isError then
            var7(Foundation.Enums.IconName.TriangleExclamation)
            return
        end
        var7(Foundation.Enums.IconName.CircleCheck)
    end, { tbl1.isError })

    local createElement = React.createElement
    local root = Sheet.Root
    local tbl2 = {
        onClose = if tbl1.buttons.onClose then tbl1.buttons.onClose else tbl1.buttons.onActivated,
        snapPoints = { useScaledValue(UNIFIED_PURCHASE_COMPLETION_MODAL_MIN_HEIGHT_PIXELS), 0.8 },
        preferCenterSheet = true,
        ref = 0
    }
    if isDisabled then
        var2 = nil
    end

    tbl2.ref = var2
    return createElement(root, tbl2, {
        Header = React.createElement(Sheet.Header, {}, {
            Title = React.createElement(
                FoundationText,
                {
                    Text = var8,
                    tag = "auto-xy text-heading-small content-default text-align-x-left"
                }
            )
        }),
        Content = React.createElement(Sheet.Content, { LayoutOrder = 2 }, {
            Body = React.createElement(
                View,
                {
                    tag = "col gap-large auto-y size-full-0 align-x-center align-y-center padding-top-small",
                    LayoutOrder = 1
                },
                {
                    Icon = React.createElement(Icon, { name = name, size = var5.Size.Size_1200, tag = "auto-xy" }),
                    Message = React.createElement(
                        FoundationText,
                        {
                            Text = var9,
                            tag = "auto-xy text-body content-default text-align-x-left text-body-medium text-wrap"
                        }
                    )
                }
            )
        }),
        Actions = React.createElement(Sheet.Actions, { LayoutOrder = 3 }, { React.createElement(Foundation.Button, {
                text = text,
                onActivated = tbl1.buttons.onActivated,
                fillBehavior = FillBehavior.Fill,
                variant = ButtonVariant.Emphasis,
                ref = ref,
                isDisabled = isDisabled
            }) })
    })
end

return UnifiedPurchaseCompletionModal
