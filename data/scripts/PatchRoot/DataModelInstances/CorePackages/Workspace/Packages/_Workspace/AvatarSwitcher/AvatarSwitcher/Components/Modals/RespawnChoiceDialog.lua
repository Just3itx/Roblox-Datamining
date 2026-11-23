-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T17:30:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SessionService = game:GetService("SessionService")

local AvatarSwitcherParent = script:FindFirstAncestor("AvatarSwitcher").Parent

local Foundation = require(AvatarSwitcherParent.Foundation)
local EnumsOrientation = Foundation.Enums.Orientation
local Dialog = Foundation.Dialog
local ButtonVariant = Foundation.Enums.ButtonVariant
local DialogSize = Foundation.Enums.DialogSize
local React = require(AvatarSwitcherParent.React)
local useLocalization = require(AvatarSwitcherParent.Localization).Hooks.useLocalization
local AvatarExperienceAnalytics = require(AvatarSwitcherParent.AvatarExperienceAnalytics)
local addUnifiedEventLogging = AvatarExperienceAnalytics.addUnifiedEventLogging
local UnifiedEventLogEnums = AvatarExperienceAnalytics.UnifiedEventLogEnums
local UnifiedLoggingSurface = require(AvatarSwitcherParent.AvatarExperienceNavigation).Enums.UnifiedLoggingSurface

local function RespawnChoiceDialog(tbl1)
    local ref = React.useRef(nil)
    local var1 = React.useRef(nil)

    local var3 = useLocalization({
        headerText = "Feature.AvatarSwitcher.Heading.RespawnToSwitch",
        contentText = "Feature.AvatarSwitcher.Label.RespawnLater",
        respawnText = "Feature.AvatarSwitcher.Action.Respawn",
        respawnLaterText = "Feature.AvatarSwitcher.Action.RespawnLater"
    })

    React.useEffect(function()
        addUnifiedEventLogging(ref, {
            action = UnifiedEventLogEnums.MarketplaceUnifiedAction.UI_ELEMENT_CLICK,
            surface = UnifiedLoggingSurface.IN_EXPERIENCE_AVATAR_SWITCHER,
            elementName = "CONFIRM_SWITCH_AVATAR_BUTTON"
        }, {
            sessionTagName = SessionService:GetSessionTag("level2a")
        })
        addUnifiedEventLogging(var1, {
            action = UnifiedEventLogEnums.MarketplaceUnifiedAction.UI_ELEMENT_CLICK,
            surface = UnifiedLoggingSurface.IN_EXPERIENCE_AVATAR_SWITCHER,
            elementName = "DEFER_SWITCH_AVATAR_BUTTON"
        }, {
            sessionTagName = SessionService:GetSessionTag("level2a")
        })
    end, {})

    return React.createElement(
        Dialog.Root,
        {
            disablePortal = false,
            size = DialogSize.Small,
            hasBackdrop = true,
            onClose = tbl1.onClose
        },
        {
            DialogTitle = React.createElement(Dialog.Title, { text = var3.headerText }),
            DialogContent = React.createElement(Dialog.Content, nil, { DialogText = React.createElement(Dialog.Text, { Text = var3.contentText }) }),
            DialogActions = React.createElement(Dialog.Actions, {
                orientation = EnumsOrientation.Vertical,
                actions = {
                    {
                        text = var3.respawnText,
                        variant = ButtonVariant.Emphasis,
                        onActivated = tbl1.onConfirm,
                        ref = ref
                    },
                    {
                        text = var3.respawnLaterText,
                        variant = ButtonVariant.Standard,
                        onActivated = tbl1.onDefer,
                        ref = var1
                    }
                }
            })
        }
    )
end

return RespawnChoiceDialog
