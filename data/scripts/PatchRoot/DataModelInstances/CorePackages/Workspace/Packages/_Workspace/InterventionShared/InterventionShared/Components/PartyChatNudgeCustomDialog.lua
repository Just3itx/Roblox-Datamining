-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T22:51:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InterventionShared = script:FindFirstAncestor("InterventionShared")
local InterventionSharedParent = InterventionShared.Parent

local IXPService = game:GetService("IXPService")

local AppUserLayers = require(InterventionSharedParent.ExperimentLayers).AppUserLayers
local Constants = require(InterventionShared.Utils.Constants)
local InterventionAnalytics = require(InterventionShared.InterventionAnalytics)
local React = require(InterventionSharedParent.React)
local Foundation = require(InterventionSharedParent.Foundation)
local IconSize = Foundation.Enums.IconSize
local useLocalization = require(InterventionSharedParent.Localization).Hooks.useLocalization
local useTokens = Foundation.Hooks.useTokens
local interventionTreatmentShownSignal = require(InterventionShared.Signals.interventionTreatmentShownSignal)

local InterventionDialog = require(InterventionShared.Components.InterventionDialog)

local FFlagUFRFriendsChatIXPExposure = require(InterventionShared.Flags.FFlagUFRFriendsChatIXPExposure)

return React.memo(function(arg1)
    local var1 = useTokens()
    local var2 = useLocalization(Constants.localizationKeys)
    React.useEffect(function()
        if FFlagUFRFriendsChatIXPExposure and game:GetEngineFeature("EnableLogFlagLinkedUserLayerExposure") then
            IXPService:LogFlagLinkedUserLayerExposure(AppUserLayers.FriendsChatRestrictionUserIDLayer)
        end

        interventionTreatmentShownSignal:fire(Constants.TreatmentType.PartyChatNudgeDialog)
    end, {})

    return React.createElement(InterventionDialog, {
        titleText = var2.DontSharePersonalInformationText,
        bodyText = var2.PartyChatMayBeSuspendedText,
        onDismiss = arg1.onDismiss,
        iconName = "icons/status/error_large",
        iconSize = IconSize.Large,
        iconStyle = var1.Color.System.Warning,
        eventId = arg1.eventId,
        namespaceForAnalytics = InterventionAnalytics.Constants.CounterNamespaceTypes.PartyChat,
        interventionTypeForAnalytics = InterventionAnalytics.Constants.InterventionTypes.PartyChatNudge
    })
end)
