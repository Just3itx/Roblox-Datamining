-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:11:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local React = require(scriptParentParentParent.React)

local Foundation = require(scriptParentParentParent.Foundation)
local ButtonVariant = require(scriptParentParentParent.Foundation).Enums.ButtonVariant
local IconName = Foundation.Enums.IconName
local View = Foundation.View
local FoundationText = Foundation.Text
local Icon = Foundation.Icon
local Dialog = Foundation.Dialog
local DialogSize = Foundation.Enums.DialogSize
local EnumsOrientation = Foundation.Enums.Orientation
local useTokens = Foundation.Hooks.useTokens

local LoggingProtocol = require(scriptParentParentParent.LoggingProtocol)
local UnifiedProductPurchaseCompletionModalShownCounter = require(scriptParentParent.Generic.Events.UnifiedPurchaseCompletionCounter).UnifiedProductPurchaseCompletionModalShownCounter

local useLocalization = require(scriptParentParentParent.Localization).Hooks.useLocalization
local formatTextWithParams = require(scriptParentParent.Utility.formatTextWithParams)

local useFocusNavigationRefs = require(scriptParentParent.Generic.Hooks.useFocusNavigationRefs)

local FFlagEnableLaunchAfterPurchase = require(scriptParentParentParent.SharedFlags).FFlagEnableLaunchAfterPurchase
local icon = if require(scriptParentParentParent.SharedFlags).FFlagEnableLargerLaunchAfterPurchasePlayIcon then IconName.PlayXlarge else IconName.PlaySmall

local function UnifiedPurchaseCompletionModalV2(tbl1)
    local var2 = useLocalization({
        PurchaseCompleteTitle = "IAPExperience.PurchasePrompt.Title.PurchaseCompleted",
        PurchaseCompleteBody = "IAPExperience.PurchasePrompt.Body.PurchaseCompleted",
        ErrorTitle = "CoreScripts.PremiumModal.Title.Error",
        GenericErrorBody = "CoreScripts.PurchasePrompt.PurchaseFailed.UnknownFailureNoItemName",
        OkButtonText = "CoreScripts.PurchasePrompt.Button.OK",
        MultiItemPurchaseCompleteBody = "IAPExperience.PurchasePrompt.Body.PurchaseItemsSuccess"
    })

    local ref, var1 = useFocusNavigationRefs(tbl1.buttons.onClose or tbl1.buttons.onActivated, nil)
    local var5 = useTokens()
    local name, var7 = React.useState(Foundation.Enums.IconName.CircleCheck)

    local bool1 = FFlagEnableLaunchAfterPurchase

    if bool1 then
        if tbl1.enableLaunchAfterPurchase == true then
            bool1 = not tbl1.isError
        else
            bool1 = false
        end
    end

    local var8 = React.useRef(tbl1.buttons.onShown)
    var8.current = tbl1.buttons.onShown
    React.useEffect(function()
        LoggingProtocol.default:logRobloxTelemetryCounter(UnifiedProductPurchaseCompletionModalShownCounter, 1, {})
        if FFlagEnableLaunchAfterPurchase and var8.current then
            var8.current()
        end
    end, {})

    local text = React.useMemo(function()
        if tbl1.title then
            return tbl1.title
        end

        if tbl1.isError then
            return var2.ErrorTitle
        end

        return var2.PurchaseCompleteTitle
    end, { tbl1.title, tbl1.isError })

    local var10 = React.useMemo(function()
        if tbl1.bodyText then
            return tbl1.bodyText
        elseif tbl1.isError then
            return var2.GenericErrorBody
        elseif tbl1.isMultiItem then
            return var2.MultiItemPurchaseCompleteBody
        end
        return formatTextWithParams(var2.PurchaseCompleteBody, { ITEM_NAME = tbl1.itemName or "" })
    end, {
        tbl1.bodyText,
        tbl1.isError,
        tbl1.isMultiItem,
        tbl1.itemName
    })
    React.useEffect(function()
        if tbl1.isError then
            var7(Foundation.Enums.IconName.TriangleExclamation)
            return
        end
        var7(Foundation.Enums.IconName.CircleCheck)
    end, { tbl1.isError })

    local createElement = React.createElement
    local root = Dialog.Root
    local tbl2 = {
        size = DialogSize.Medium,
        closeOnClickOutside = true,
        onClose = if tbl1.buttons.onClose then tbl1.buttons.onClose else tbl1.buttons.onActivated,
        ref = ref,
        disablePortal = false
    }
    local tbl3 = {
        DialogTitle = React.createElement(Dialog.Title, { text = text }),
        DialogContent = React.createElement(Dialog.Content, nil, {
            Body = React.createElement(
                View,
                {
                    tag = "col gap-large auto-y size-full-0 align-x-center align-y-center padding-top-small"
                },
                {
                    DialogIcon = React.createElement(Icon, { name = name, size = var5.Size.Size_1200, tag = "auto-xy" }),
                    Message = React.createElement(
                        FoundationText,
                        {
                            Text = var10,
                            tag = "auto-xy text-body content-default text-align-x-left text-body-medium text-wrap"
                        }
                    )
                }
            )
        }),
        DialogActions = 0
    }

    local createElement2 = React.createElement
    local actions = Dialog.Actions
    local tbl4 = {
        orientation = EnumsOrientation.Horizontal,
        actions = 0
    }
    local tbl5

    if bool1 then
        tbl5 = {{
            icon = icon,
            variant = ButtonVariant.Emphasis,
            onActivated = tbl1.buttons.onActivated,
            ref = var1,
            isDisabled = false
        }}
    else
        tbl5 = {{
            text = if tbl1.buttons and tbl1.buttons.text then tbl1.buttons.text else var2.OkButtonText,
            variant = ButtonVariant.Emphasis,
            onActivated = tbl1.buttons.onActivated,
            ref = var1,
            isDisabled = false
        }}
    end

    tbl4.actions = tbl5
    tbl3.DialogActions = createElement2(actions, tbl4)
    return createElement(root, tbl2, tbl3)
end

return UnifiedPurchaseCompletionModalV2
