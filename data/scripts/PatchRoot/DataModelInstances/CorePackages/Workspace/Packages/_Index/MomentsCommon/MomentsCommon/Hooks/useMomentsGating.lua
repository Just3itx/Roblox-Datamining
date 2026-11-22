-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:20:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCommon = script:FindFirstAncestor("MomentsCommon")
local MomentsCommonParent = MomentsCommon.Parent

local React = require(MomentsCommonParent.React)
local useSignalState = require(MomentsCommonParent.SignalsReact).useSignalState
local SharedFlags = require(MomentsCommonParent.SharedFlags)
local var1 = require(MomentsCommonParent.Loggers).Logger:new("Moments.Gating")

local FFlagEnableArgus = SharedFlags.FFlagEnableArgus
local FFlagArgoEnableMoments = SharedFlags.FFlagArgoEnableMoments
local FFlagMomentsCreationFeatureGate = SharedFlags.FFlagMomentsCreationFeatureGate
local bool1 = game:DefineFastFlag("DebugMomentsGating", false)
local FFlagFlyoutRemoveMomentsForArgoEnabled = SharedFlags.FFlagFlyoutRemoveMomentsForArgoEnabled

local GetMomentsCapabilities = require(MomentsCommon.Stores.GetMomentsCapabilities)
local getIsSupportedOnPlatform = if FFlagFlyoutRemoveMomentsForArgoEnabled then require(MomentsCommon.Utils.getIsSupportedOnPlatform) else nil

local function useMomentsGating()
    local isMasterEnabled = FFlagEnableArgus

    local momentsCapabilities = GetMomentsCapabilities(false)
    local isAmpPolicyEnabled = useSignalState(momentsCapabilities.getHasMomentsAccess)
    local var4 = useSignalState(momentsCapabilities.getIsInfluencerContentEnabled)
    local var5 = if FFlagMomentsCreationFeatureGate then useSignalState(momentsCapabilities.getCanCreateMoments) else nil
    local isSupportedOnPlatform = if FFlagFlyoutRemoveMomentsForArgoEnabled then getIsSupportedOnPlatform() else false
    local var6 = isMasterEnabled and isAmpPolicyEnabled

    local useMemo = React.useMemo
    local function func1()
        return {
            isMasterEnabled = isMasterEnabled,
            isAmpPolicyEnabled = isAmpPolicyEnabled,
            isMomentsEnabled = var6,
            isSupportedOnPlatform = isSupportedOnPlatform,
            isFlyoutEntryEnabled = var6,
            isTabEnabled = FFlagArgoEnableMoments and var6,
            isCreationEnabled = var6 and (not FFlagMomentsCreationFeatureGate or var5),
            platformIntegrationEnabled = var6,
            influencerUploadsEnabled = var6 and var4
        }
    end

    local var7 = if FFlagMomentsCreationFeatureGate then var5 else false
    local var8 = useMemo(func1, { isMasterEnabled, isAmpPolicyEnabled, var6, isSupportedOnPlatform, isAmpPolicyEnabled, var4, var7 })

    React.useEffect(function()
        if not bool1 then
            return
        end

        var1:debug(
            "Moments.Gating master={} ampPolicy={} moments={} supportedOnPlatform={} platformIntegration={} influencerUploads={} creation={} flyout={} tab={} forceAll={}",
            tostring(var8.isMasterEnabled),
            tostring(var8.isAmpPolicyEnabled),
            tostring(var8.isMomentsEnabled),
            tostring(var8.isSupportedOnPlatform),
            tostring(var8.platformIntegrationEnabled),
            tostring(var8.influencerUploadsEnabled),
            tostring(var8.isCreationEnabled),
            tostring(var8.isFlyoutEntryEnabled),
            tostring(var8.isTabEnabled),
            tostring(FFlagArgoEnableMoments)
        )
    end, { bool1, var8 })

    return var8
end

return useMomentsGating
