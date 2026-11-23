-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T17:31:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SessionService = game:GetService("SessionService")

local AvatarSwitcher = script:FindFirstAncestor("AvatarSwitcher")
local AvatarSwitcherParent = AvatarSwitcher.Parent

local Foundation = require(AvatarSwitcherParent.Foundation)
local React = require(AvatarSwitcherParent.React)
local ButtonVariant = Foundation.Enums.ButtonVariant
local FillBehavior = Foundation.Enums.FillBehavior
local ButtonSize = Foundation.Enums.ButtonSize
local useLocalization = require(AvatarSwitcherParent.Localization).Hooks.useLocalization
local SignalsReact = require(AvatarSwitcherParent.SignalsReact)
local AvatarExperienceAnalytics = require(AvatarSwitcherParent.AvatarExperienceAnalytics)
local addUnifiedEventLogging = AvatarExperienceAnalytics.addUnifiedEventLogging
local UnifiedEventLogEnums = AvatarExperienceAnalytics.UnifiedEventLogEnums
local UnifiedLoggingSurface = require(AvatarSwitcherParent.AvatarExperienceNavigation).Enums.UnifiedLoggingSurface

local getAvatarSwitcherStore = require(AvatarSwitcher.Stores.getAvatarSwitcherStore)
local getTimeoutStatusStore = require(AvatarSwitcherParent.AvatarExperienceCommon).Stores.getTimeoutStatusStore

local function SwitchAvatarButton(tbl1)
    local var1 = SignalsReact.useSignalState(getAvatarSwitcherStore)
    local var2 = SignalsReact.useSignalState(var1.getIsSwitching)
    local var3 = SignalsReact.useSignalState(var1.getSelectedOutfitId)
    local var4 = SignalsReact.useSignalState(var1.getSelectedOutfitDetails)

    local timeoutStatusStore = getTimeoutStatusStore()
    local var5 = SignalsReact.useSignalState(timeoutStatusStore.getIsTimedOut)

    local var6 = useLocalization({ buttonText = "Feature.AvatarSwitcher.Action.Continue" })

    local isLoading = var2 or not (var3 == nil) and var4 == nil
    local isDisabled = isLoading or var3 == nil or var5
    local ref = React.useRef(nil)

    React.useEffect(function()
        task.delay(0, function()
            addUnifiedEventLogging(ref, {
                action = UnifiedEventLogEnums.MarketplaceUnifiedAction.UI_ELEMENT_CLICK,
                surface = UnifiedLoggingSurface.IN_EXPERIENCE_AVATAR_SWITCHER,
                elementName = "SWITCH_AVATAR_BUTTON"
            }, {
                sessionTagName = SessionService:GetSessionTag("level2a")
            })
        end)
    end, {})

    return (React.createElement(Foundation.Button, {
        text = var6.buttonText,
        size = ButtonSize.Small,
        variant = if isDisabled then ButtonVariant.Standard else ButtonVariant.Emphasis,
        fillBehavior = FillBehavior.Fill,
        onActivated = tbl1.onActivated,
        isLoading = isLoading,
        isDisabled = isDisabled,
        ref = ref
    }))
end

return SwitchAvatarButton
