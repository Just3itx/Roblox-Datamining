-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T23:10:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CancelSubscriptionAppParent = script:FindFirstAncestor("CancelSubscriptionApp").Parent
local React = require(CancelSubscriptionAppParent.React)
local UIBlox = require(CancelSubscriptionAppParent.UIBlox)
local InteractiveAlert = UIBlox.App.Dialog.Alert.InteractiveAlert
local ButtonType = UIBlox.App.Button.Enum.ButtonType
local useLocalization = require(CancelSubscriptionAppParent.Localization).Hooks.useLocalization
local useScreenSize = require(CancelSubscriptionAppParent.EconomyCommonCoreScriptHooks).useScreenSize

local tbl1 = {
    heading = "CoreScripts.CancelUserSubscriptionPrompt.RequestPrompt.Heading",
    bodyText = "CoreScripts.CancelUserSubscriptionPrompt.RequestPrompt.Body",
    noButtonText = "CoreScripts.CancelUserSubscriptionPrompt.RequestPrompt.DontCancelButton",
    yesButtonText = "CoreScripts.CancelUserSubscriptionPrompt.RequestPrompt.YesCancelButton"
}

local function CancelUserSubscriptionRequestPrompt(tbl2)
    local var1 = useLocalization(tbl1)
    local bodyText = var1.bodyText:gsub("{date}", tbl2.expirationDate)
    local createElement = React.createElement
    local var3 = InteractiveAlert
    local tbl3 = {
        title = var1.heading,
        bodyText = bodyText,
        buttonStackInfo = 0,
        position = 0,
        screenSize = 0
    }
    local buttonStackInfo = {
        forcedFillDirection = Enum.FillDirection.Horizontal,
        buttons = 0
    }
    local tbl5 = {
        props = {
            onActivated = tbl2.onCancel or function() end,
            text = var1.noButtonText,
            delayInputSeconds = 0.75,
            [React.Tag] = "data-testid=CancelSubscriptionApp_DontCancelButton"
        },
        isDefaultChild = true
    }

    local tbl6 = {
        buttonType = ButtonType.PrimarySystem,
        props = {
            onActivated = tbl2.onConfirm or function() end,
            text = var1.yesButtonText,
            delayInputSeconds = 0.75,
            [React.Tag] = "data-testid=CancelSubscriptionApp_YesCancelButton"
        },
        isDefaultChild = false
    }
    buttonStackInfo.buttons = { tbl5, tbl6 }
    tbl3.buttonStackInfo = buttonStackInfo

    tbl3.position = UDim2.fromScale(0.5, 0.5)
    tbl3.screenSize = useScreenSize()
    return createElement(var3, tbl3)
end

return CancelUserSubscriptionRequestPrompt
