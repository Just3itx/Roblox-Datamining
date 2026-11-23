-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T06:11:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppBloxParent = script:FindFirstAncestor("AppBlox").Parent
local React = require(AppBloxParent.React)
local useScreenSize = require(AppBloxParent.RobloxAppHooks).useScreenSize
local useLocalization = require(AppBloxParent.Localization).Hooks.useLocalization
local UIBlox = require(AppBloxParent.UIBlox)
local InteractiveAlert = UIBlox.App.Dialog.Alert.InteractiveAlert
local ButtonType = UIBlox.App.Button.Enum.ButtonType

return function(tbl1)
    local screenSize = useScreenSize()

    local var2 = useLocalization({ closeButtonText = "Feature.ProfileBadges.action.close" })

    return React.createElement(InteractiveAlert, {
        screenSize = screenSize,
        title = tbl1.title,
        bodyText = tbl1.body,
        buttonStackInfo = {
            buttons = {{
                buttonType = ButtonType.Secondary,
                props = {
                    onActivated = tbl1.closeAlert,
                    text = tbl1.buttonText or var2.closeButtonText
                }
            }}
        },
        onCloseClicked = if tbl1.showCloseButton then tbl1.closeAlert else nil
    })
end
