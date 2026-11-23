-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T03:51:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VerifiedParentalConsentDialogParent = script:FindFirstAncestor("VerifiedParentalConsentDialog").Parent
local React = require(VerifiedParentalConsentDialogParent.React)
local UIBlox = require(VerifiedParentalConsentDialogParent.UIBlox)
local InteractiveAlert = UIBlox.App.Dialog.Alert.InteractiveAlert
local useLocalization = require(VerifiedParentalConsentDialogParent.Localization).Hooks.useLocalization

local ButtonType = UIBlox.App.Button.Enum.ButtonType

local function AlertPrompt(tbl1)
    local var1 = useLocalization({
        GoToSettings = "Common.VerifiedParentalConsent.Action.GoToSettings",
        Cancel = "Common.VerifiedParentalConsent.Action.Cancel",
        Close = "Common.VerifiedParentalConsent.Action.Close"
    })

    local createElement = React.createElement
    local var2 = InteractiveAlert
    local tbl2 = {
        title = tbl1.title,
        titleIcon = tbl1.titleIcon,
        bodyText = tbl1.bodyText,
        buttonStackInfo = 0,
        position = 0,
        screenSize = 0,
        middleContent = 0
    }
    local buttonStackInfo = { buttons = 0 }
    local tbl4

    if tbl1.isActionable then
        tbl4 = {
            {
                buttonType = ButtonType.PrimarySystem,
                props = {
                    onActivated = if tbl1.onAction then tbl1.onAction else tbl1.onDismiss,
                    text = var1.GoToSettings
                }
            },
            {
                props = {
                    onActivated = tbl1.onDismiss,
                    text = var1.Cancel
                }
            }
        }
    else
        tbl4 = {{
            props = {
                onActivated = tbl1.onDismiss,
                text = var1.Close
            }
        }}
    end

    buttonStackInfo.buttons = tbl4
    tbl2.buttonStackInfo = buttonStackInfo

    tbl2.position = UDim2.fromScale(0.5, 0.5)
    tbl2.screenSize = tbl1.screenSize
    tbl2.middleContent = tbl1.middleContent
    return createElement(var2, tbl2)
end

return AlertPrompt
