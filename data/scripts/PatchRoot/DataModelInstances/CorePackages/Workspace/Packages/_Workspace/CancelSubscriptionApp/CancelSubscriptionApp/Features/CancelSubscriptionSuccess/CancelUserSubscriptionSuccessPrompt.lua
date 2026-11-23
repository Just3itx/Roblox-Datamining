-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T23:10:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CancelSubscriptionAppParent = script:FindFirstAncestor("CancelSubscriptionApp").Parent
local React = require(CancelSubscriptionAppParent.React)
local UIBlox = require(CancelSubscriptionAppParent.UIBlox)
local Toast = UIBlox.App.Dialog.Toast
local useLocalization = require(CancelSubscriptionAppParent.Localization).Hooks.useLocalization
local iconsLogoBlock = UIBlox.App.ImageSet.Images["icons/logo/block"]

local tbl1 = { heading = "CoreScripts.CancelUserSubscriptionPrompt.SuccessPrompt.Heading" }

local function CancelUserSubscriptionSuccessPrompt(tbl2)
    local var1 = useLocalization(tbl1)
    return React.createElement(Toast, {
        toastContent = {
            toastTitle = var1.heading,
            iconImage = iconsLogoBlock,
            onAppeared = function() end,
            onDismissed = tbl2.onDismissed or function() end,
            swipeUpDismiss = true
        },
        anchorPoint = Vector2.new(0.5, 0),
        duration = 3,
        layoutOrder = 1,
        position = UDim2.new(0.5, 0, 0, 20),
        size = UDim2.new(0.5, -24, 0, 0),
        show = true
    })
end

return CancelUserSubscriptionSuccessPrompt
