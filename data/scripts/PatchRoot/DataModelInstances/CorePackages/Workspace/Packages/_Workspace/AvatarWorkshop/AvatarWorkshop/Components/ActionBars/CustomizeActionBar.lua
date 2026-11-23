-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T17:40:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarWorkshopParent = script:FindFirstAncestor("AvatarWorkshop").Parent

local React = require(AvatarWorkshopParent.React)
local Foundation = require(AvatarWorkshopParent.Foundation)
local useLocalization = require(AvatarWorkshopParent.Localization).Hooks.useLocalization

local ActionBar = require(script.Parent.ActionBar)

local function CustomizeActionBar()
    local var1 = useLocalization({ continue = "Feature.AvatarSwitcher.Action.Continue" })

    return React.createElement(ActionBar, {
        actions = {{
            key = "ContinueButton",
            text = var1.continue,
            onActivated = function() end,
            variant = Foundation.Enums.ButtonVariant.Emphasis,
            testId = "avatar-workshop-continue-button"
        }}
    })
end

return CustomizeActionBar
