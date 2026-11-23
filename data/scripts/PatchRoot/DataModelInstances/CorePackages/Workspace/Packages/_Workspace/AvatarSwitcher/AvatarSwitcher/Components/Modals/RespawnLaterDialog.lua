-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T17:30:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SessionService = game:GetService("SessionService")

local AvatarSwitcherParent = script:FindFirstAncestor("AvatarSwitcher").Parent

local Foundation = require(AvatarSwitcherParent.Foundation)
local Dialog = Foundation.Dialog
local ButtonVariant = Foundation.Enums.ButtonVariant
local DialogSize = Foundation.Enums.DialogSize
local EnumsOrientation = Foundation.Enums.Orientation
local React = require(AvatarSwitcherParent.React)
local useLocalization = require(AvatarSwitcherParent.Localization).Hooks.useLocalization
local AvatarExperienceAnalytics = require(AvatarSwitcherParent.AvatarExperienceAnalytics)
local addUnifiedEventLogging = AvatarExperienceAnalytics.addUnifiedEventLogging
local UnifiedEventLogEnums = AvatarExperienceAnalytics.UnifiedEventLogEnums
local UnifiedLoggingSurface = require(AvatarSwitcherParent.AvatarExperienceNavigation).Enums.UnifiedLoggingSurface

local function RespawnLaterDialog(tbl1)
    local ref = React.useRef(nil)

    local var2 = useLocalization({
        headerText = "Feature.AvatarSwitcher.Heading.RespawnToSwitch",
        contentText = "Feature.AvatarSwitcher.Message.RespawnNotAllowed",
        continueText = "Feature.AvatarSwitcher.Action.OK"
    })

    React.useEffect(function()
        addUnifiedEventLogging(ref, {
            action = UnifiedEventLogEnums.MarketplaceUnifiedAction.UI_ELEMENT_CLICK,
            surface = UnifiedLoggingSurface.IN_EXPERIENCE_AVATAR_SWITCHER,
            elementName = "DEFER_SWITCH_AVATAR_RESPAWN_DISABLED_BUTTON"
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
            DialogTitle = React.createElement(Dialog.Title, { text = var2.headerText }),
            DialogContent = React.createElement(Dialog.Content, nil, { DialogText = React.createElement(Dialog.Text, { Text = var2.contentText }) }),
            DialogActions = React.createElement(Dialog.Actions, {
                orientation = EnumsOrientation.Vertical,
                actions = {{
                    text = var2.continueText,
                    variant = ButtonVariant.Emphasis,
                    onActivated = tbl1.onDefer,
                    ref = ref
                }}
            })
        }
    )
end

return RespawnLaterDialog
