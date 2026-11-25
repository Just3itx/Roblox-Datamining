-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:51:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedUtilitiesParent = script:FindFirstAncestor("SduiSharedUtilities").Parent
local React = require(SduiSharedUtilitiesParent.React)

local Foundation = require(SduiSharedUtilitiesParent.Foundation)
local SystemBanner = Foundation.SystemBanner
local AlertSeverity = Foundation.Enums.AlertSeverity
local ButtonVariant = Foundation.Enums.ButtonVariant
local useLocalization = require(SduiSharedUtilitiesParent.Localization).Hooks.useLocalization

return React.memo(function(tbl1) -- name: SduiPageErrorState
    local var1 = useLocalization({
        title = "CommonUI.Messages.Response.PageError",
        description = "Feature.Toast.NetworkingError.SomethingIsWrong",
        retry = "InGame.CommonUI.Button.Retry"
    })

    return React.createElement(SystemBanner, {
        severity = AlertSeverity.Error,
        title = var1.title,
        description = var1.description,
        actions = {{
            text = var1.retry,
            variant = ButtonVariant.Standard,
            onActivated = tbl1.refresh
        }}
    })
end)
