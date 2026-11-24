-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T22:51:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InterventionShared = script:FindFirstAncestor("InterventionShared")
local InterventionSharedParent = InterventionShared.Parent

local IXPService = game:GetService("IXPService")
local LocalizationService = game:GetService("LocalizationService")

local AppUserLayers = require(InterventionSharedParent.ExperimentLayers).AppUserLayers
local Localization = require(InterventionSharedParent.RobloxAppLocales).Localization
local Constants = require(InterventionShared.Utils.Constants)
local InterventionAnalytics = require(InterventionShared.InterventionAnalytics)
local React = require(InterventionSharedParent.React)
local Foundation = require(InterventionSharedParent.Foundation)
local IconSize = Foundation.Enums.IconSize
local useCountdownBinding = require(InterventionShared.Hooks.useCountdownBinding)
local useLocalization = require(InterventionSharedParent.Localization).Hooks.useLocalization
local useTokens = Foundation.Hooks.useTokens
local LuauPolyfill = require(InterventionSharedParent.LuauPolyfill)
local clearTimeout = LuauPolyfill.clearTimeout
local setTimeout = LuauPolyfill.setTimeout
local interventionTreatmentShownSignal = require(InterventionShared.Signals.interventionTreatmentShownSignal)

local InterventionDialog = require(InterventionShared.Components.InterventionDialog)

local FFlagUFRFriendsChatIXPExposure = require(InterventionShared.Flags.FFlagUFRFriendsChatIXPExposure)

return React.memo(function(arg1)
    local var1 = useTokens()
    local var2 = useLocalization(Constants.localizationKeys)
    local localization = Localization.new(LocalizationService.RobloxLocaleId)
    React.useEffect(function()
        if FFlagUFRFriendsChatIXPExposure and game:GetEngineFeature("EnableLogFlagLinkedUserLayerExposure") then
            IXPService:LogFlagLinkedUserLayerExposure(AppUserLayers.FriendsChatRestrictionUserIDLayer)
        end

        interventionTreatmentShownSignal:fire(Constants.TreatmentType.PartyChatTimeoutDialog)
    end, {})

    local var3 = useCountdownBinding(arg1.endTimestamp, "0:00")
    React.useEffect(function()
        local var4 = if arg1.endTimestamp ~= nil then setTimeout(function()
            arg1.onDismiss()
        end, math.max(arg1.endTimestamp - DateTime.now().UnixTimestamp + 1, 1) * 1000) else nil

        return function()
            if var4 then
                clearTimeout(var4)
            end
        end
    end, { arg1.endTimestamp, arg1.onDismiss })

    return React.createElement(InterventionDialog, {
        titleText = var3:map(function(remainingTime)
            return localization:Format(Constants.localizationKeys.PartyChatSuspendedText, { remainingTime = remainingTime })
        end),
        bodyText = var2.CantUsePartyChatText,
        onDismiss = arg1.onDismiss,
        iconName = "icons/status/error_large",
        iconSize = IconSize.Large,
        iconStyle = var1.Color.System.Alert,
        eventId = arg1.eventId,
        namespaceForAnalytics = InterventionAnalytics.Constants.CounterNamespaceTypes.PartyChat,
        interventionTypeForAnalytics = InterventionAnalytics.Constants.InterventionTypes.PartyChatTimeout,
        durationForAnalytics = arg1.durationForAnalytics
    })
end)
