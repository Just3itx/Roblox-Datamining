-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T23:10:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CancelSubscriptionApp = script:FindFirstAncestor("CancelSubscriptionApp")
local CancelSubscriptionAppParent = CancelSubscriptionApp.Parent
local React = require(CancelSubscriptionAppParent.React)
local UIBlox = require(CancelSubscriptionAppParent.UIBlox)
local InteractiveAlert = UIBlox.App.Dialog.Alert.InteractiveAlert
local ButtonType = UIBlox.App.Button.Enum.ButtonType
local useLocalization = require(CancelSubscriptionAppParent.Localization).Hooks.useLocalization
local iconsStatusError_large = UIBlox.App.ImageSet.Images["icons/status/error_large"]
local useScreenSize = require(CancelSubscriptionAppParent.EconomyCommonCoreScriptHooks).useScreenSize

local ErrorStateEnum = require(CancelSubscriptionApp.Enums.ErrorStateEnum)

local tbl1 = {
    [ErrorStateEnum.Expiring] = "CoreScripts.CancelUserSubscriptionPrompt.ExpiringPrompt.Heading",
    [ErrorStateEnum.Unsubscribed] = "CoreScripts.CancelUserSubscriptionPrompt.UnsubscribedPrompt.Heading",
    [ErrorStateEnum.ErrorCancelling] = "CoreScripts.CancelUserSubscriptionPrompt.ErrorCancellingPrompt.Heading"
}

local tbl2 = {
    [ErrorStateEnum.Expiring] = "CoreScripts.CancelUserSubscriptionPrompt.ExpiringPrompt.Body",
    [ErrorStateEnum.Unsubscribed] = "CoreScripts.CancelUserSubscriptionPrompt.UnsubscribedPrompt.Body",
    [ErrorStateEnum.ErrorCancelling] = "CoreScripts.CancelUserSubscriptionPrompt.ErrorCancellingPrompt.Body"
}

local function CancelUserSubscriptionErrorPrompt(tbl3)
    local var1 = useLocalization({
        heading = tbl1[tbl3.errorState],
        bodyText = tbl2[tbl3.errorState],
        buttonText = "CoreScripts.CancelUserSubscriptionPrompt.Error.ButtonText"
    })

    local createElement = React.createElement
    local var2 = InteractiveAlert
    local tbl4 = {
        title = var1.heading,
        titleIcon = iconsStatusError_large,
        bodyText = var1.bodyText,
        buttonStackInfo = 0,
        position = 0,
        screenSize = 0
    }
    local buttonStackInfo = { buttons = 0 }

    local tbl6 = {
        buttonType = ButtonType.PrimarySystem,
        props = {
            onActivated = tbl3.onDismiss or function() end,
            text = var1.buttonText,
            delayInputSeconds = 0.75,
            [React.Tag] = "data-testid=CancelSubscriptionApp_OkButton"
        },
        isDefaultChild = true
    }
    buttonStackInfo.buttons = { tbl6 }
    tbl4.buttonStackInfo = buttonStackInfo

    tbl4.position = UDim2.fromScale(0.5, 0.5)
    tbl4.screenSize = useScreenSize()
    return createElement(var2, tbl4)
end

return CancelUserSubscriptionErrorPrompt
