-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T10:20:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DiscoverabilityModal = script:FindFirstAncestor("DiscoverabilityModal")
local DiscoverabilityModalParent = DiscoverabilityModal.Parent
local React = require(DiscoverabilityModalParent.React)

local Analytics = DiscoverabilityModal.Analytics
local useAnalytics = require(Analytics.useAnalytics)
local EventNames = require(Analytics.Enums.EventNames)
local Constants = require(DiscoverabilityModal.Common.Constants)

local LegallySensitiveContent = require(DiscoverabilityModalParent.LegallySensitiveContent)
local useLegallySensitiveContentAndActions = LegallySensitiveContent.useLegallySensitiveContentAndActions
local ConsentName = LegallySensitiveContent.ConsentName

local useNavigation = require(DiscoverabilityModalParent.Navigation).useNavigation
local useDispatch = require(DiscoverabilityModalParent.RoactUtils).Hooks.RoactRodux.useDispatch
local UpdateIsDiscoverabilityUnset = require(DiscoverabilityModalParent.SocialModalsCommon).Actions.UpdateIsDiscoverabilityUnset

local Foundation = require(DiscoverabilityModalParent.Foundation)
local Dialog = Foundation.Dialog
local DialogSize = Foundation.Enums.DialogSize
local ButtonVariant = Foundation.Enums.ButtonVariant

local function DiscoverabilityWithAudit(_)
    local var1 = useNavigation()
    local var2 = useDispatch()
    local var3 = useAnalytics()

    local var4, var5 = useLegallySensitiveContentAndActions(
        ConsentName.phoneNumberDiscoverabilityUpsell,
        "generic-lua-discoverability-setting-upsell"
    )
    local wordsOfConsent = var4.wordsOfConsent
    local updateSettingWithAuditing = var5.updateSettingWithAuditing

    React.useEffect(function()
        var3.fireAnalyticsEvent(
            EventNames.DiscoverabilityModalLoad,
            {
                version = "audit_version",
                wordingVersion = Constants.WORDING_VERSION_1
            }
        )
    end, {})

    local var6 = React.useCallback(function()
        var2(UpdateIsDiscoverabilityUnset({ isDiscoverabilityUnset = false }))
    end, {})

    local param = var1.getParam(Constants.NAVIGATE_ON_ACTIVATED)

    local actions = {
        {
            text = wordsOfConsent.notNow,
            variant = ButtonVariant.Standard,
            onActivated = function()
                var3.fireAnalyticsEvent(EventNames.DiscoverabilityModalClose, { selected = Constants.UNSET })

                var6()
                var1.pop()
                param()
            end
        },
        {
            text = wordsOfConsent.turnOn,
            variant = ButtonVariant.Emphasis,
            onActivated = function()
                var3.fireAnalyticsEvent(EventNames.DiscoverabilityModalContinue, { selected = Constants.DISCOVERABLE })

                updateSettingWithAuditing("phoneNumberDiscoverability", "Discoverable")
                var6()
                var1.pop()
                param()
            end
        }
    }

    return React.createElement(Dialog.Root, {
        size = DialogSize.Medium,
        hasBackdrop = true
    }, {
        DialogTitle = React.createElement(Dialog.Title, { text = wordsOfConsent.title }),
        DialogContent = React.createElement(
            Dialog.Content,
            { LayoutOrder = 2 },
            {
                DialogView = React.createElement(Dialog.Text, { Text = wordsOfConsent.content })
            }
        ),
        DialogActions = React.createElement(Dialog.Actions, { LayoutOrder = 3, actions = actions })
    })
end

return DiscoverabilityWithAudit
