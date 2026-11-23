-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T17:41:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarWorkshop = script:FindFirstAncestor("AvatarWorkshop")
local AvatarWorkshopParent = AvatarWorkshop.Parent

local React = require(AvatarWorkshopParent.React)
local Foundation = require(AvatarWorkshopParent.Foundation)
local useLocalization = require(AvatarWorkshopParent.Localization).Hooks.useLocalization

local Screens = require(AvatarWorkshop.Navigation.Screens)
local useNavigation = require(AvatarWorkshop.Hooks.useNavigation)
local ActionBar = require(script.Parent.ActionBar)

local function YourAvatarsActionBar()
    local var1 = useNavigation()
    local var2 = useLocalization(
        {
            continue = "Feature.AvatarSwitcher.Action.Continue",
            editAvatar = "Feature.AvatarWorkshop.Action.EditAvatar"
        }
    )

    local onActivated = React.useCallback(function()
        var1.navigate(Screens.Workshop.Customize)
    end, { var1 })

    return React.createElement(ActionBar, {
        actions = {
            {
                key = "ContinueButton",
                text = var2.continue,
                onActivated = function() end,
                variant = Foundation.Enums.ButtonVariant.Emphasis,
                testId = "avatar-workshop-continue-button"
            },
            {
                key = "EditAvatarButton",
                text = var2.editAvatar,
                onActivated = onActivated,
                variant = Foundation.Enums.ButtonVariant.Standard,
                testId = "avatar-workshop-edit-avatar-button"
            }
        }
    })
end

return YourAvatarsActionBar
