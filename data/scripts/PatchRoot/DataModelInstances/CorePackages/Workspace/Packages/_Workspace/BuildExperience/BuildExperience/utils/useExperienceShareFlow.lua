-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T21:20:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local React = require(BuildExperienceParent.React)
local Signals = require(BuildExperienceParent.Signals)
local SignalsReact = require(BuildExperienceParent.SignalsReact)

local Logger = require(BuildExperienceParent.Loggers).Logger

local UniverseConfiguration = require(BuildExperienceParent.DataHydration.UniverseConfiguration)
local GameConfigurationLabels = require(BuildExperience.utils.GameConfigurationLabels)
local useSharePublishedExperience = require(BuildExperience.utils.sharePublishedExperience).useSharePublishedExperience
local sharePrivateExperience = require(BuildExperience.utils.sharePrivateExperience)
local sendBuildExperienceEvent = require(BuildExperience.Telemetry.sendBuildExperienceEvent)
local FFlagBuildExperiencePrivateInvites = require(BuildExperience.Flags.FFlagBuildExperiencePrivateInvites)
local PrivacyType = UniverseConfiguration.PrivacyType

local signal = Signals.createSignal(nil)

local function useExperienceShareFlow(universeId: number?, num2: number?)
    local var1 = useSharePublishedExperience(universeId)
    local var2 = React.useMemo(function()
        if universeId == nil then
            return signal
        end

        return UniverseConfiguration.getUniverseConfigurationStore().getAndFetchSummary(universeId).data
    end, { universeId })
    local var3 = SignalsReact.useSignalState(var2)

    local activeDialog, var5 = React.useState("none")

    local hasShareError, var7 = React.useState(false)

    local onCancelDialog = React.useCallback(function()
        var7(false)
        var5("none")
    end, {})

    local var9 = React.useCallback(function()
        if num2 ~= nil then
            var1(num2)
        end
    end, { num2, var1 })

    local audience = React.useMemo(function()
        return GameConfigurationLabels.getAudience(var3)
    end, { var3 })

    return {
        onShare = React.useCallback(function()
            if audience ~= PrivacyType.Private then
                if audience == PrivacyType.FriendsOnly then
                    var5("friends")
                    return
                end

                if audience == PrivacyType.Public then
                    var9()
                end
            elseif FFlagBuildExperiencePrivateInvites then
                var5("playtesters")

                if universeId ~= nil then
                    sendBuildExperienceEvent("PLAYTEST_SHARE_DIALOG_IMPRESSION", { universeId = universeId })
                end
            end
        end, { audience, var9, universeId }),
        audience = audience,
        activeDialog = activeDialog,
        hasShareError = hasShareError,
        onCancelDialog = onCancelDialog,
        onConfirmFriends = React.useCallback(function()
            var5("none")
            var9()
        end, { var9 }),
        onConfirmPlaytesters = React.useCallback(function()
            if universeId == nil then
                return
            end
            sendBuildExperienceEvent("PLAYTEST_SHARE_CLICK", { universeId = universeId }, { source = "playtesters_dialog" })

            var7(false)
            sharePrivateExperience(universeId):andThen(function()
                var5("none")
            end):catch(function(arg1)
                Logger:warning("useExperienceShareFlow: private share failed for universe {}: {}", universeId, arg1)
                var7(true)
            end)
        end, { universeId })
    }
end

return useExperienceShareFlow
