-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:30:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommon = script:FindFirstAncestor("AuthCommon")
local AuthCommonParent = AuthCommon.Parent

local UserInputService = game:GetService("UserInputService")

local React = require(AuthCommonParent.React)
local useBrowserTrackerExperiment = require(AuthCommonParent.RoactAppExperiment).useBrowserTrackerExperiment
local useIXPService = require(AuthCommonParent.RoactAppExperiment).useIXPService
local useAppPolicy = require(AuthCommonParent.UniversalAppPolicy).useAppPolicy
local useUiModeInfo = require(AuthCommonParent.RobloxAppHooks).useUiModeInfo
local UiMode = require(AuthCommonParent.RobloxAppEnums).UiMode
local isPioneerLaunch = require(AuthCommonParent.PioneerUtils).isPioneerLaunch
local AppBtidLayers = require(AuthCommonParent.ExperimentLayers).AppBtidLayers
local FFlagGoogleAppleSsoDesktop = require(AuthCommon.Flags.FFlagGoogleAppleSsoDesktop)
local FFlagEnableAccountSwitchSsoLogin = require(AuthCommonParent.SharedFlags).FFlagEnableAccountSwitchSsoLogin

local num1 = game:DefineFastInt("DebugAuthEntryVariantOverride", -1)

local UniversalAppAuthEntryLayer = AppBtidLayers.UniversalAppAuthEntryLayer

local AuthEntryVariant = { Control = 0, Foundation = 1, FoundationSso = 2 }

local function resolveAuthEntryVariant(arg1, bool1: boolean, num2: number?) -- Luacid: Inlined by compiler; 1 call site recovered
    if num2 ~= nil and num2 >= 0 then
        arg1 = num2
    end

    return if bool1 and (arg1 == AuthEntryVariant.Foundation or arg1 == AuthEntryVariant.FoundationSso) then arg1 else AuthEntryVariant.Control
end

local function isPlatformInPopulation(platform) -- Luacid: Inlined by compiler; 1 call site recovered
    if platform == Enum.Platform.Windows or platform == Enum.Platform.OSX then
        return FFlagGoogleAppleSsoDesktop
    end

    return platform == Enum.Platform.IOS or platform == Enum.Platform.Android
end

return {
    AuthEntryVariant = AuthEntryVariant,
    resolveAuthEntryVariant = resolveAuthEntryVariant,
    useAuthEntryVariant = function(arg1, bool1: boolean?)
        local var1 = useIXPService()
        local var2 = useBrowserTrackerExperiment({ UniversalAppAuthEntryLayer }, function(arg2)
            return (arg2[UniversalAppAuthEntryLayer] or {}).authEntryVariant
        end, false)

        local bool2 = var1:GetBrowserTrackerStatusForLayer(UniversalAppAuthEntryLayer) == Enum.IXPLoadingStatus.Initialized
        local var3 = useAppPolicy(function(arg2)
            return arg2.getExcludeExternalIdentityLogin() or arg2.getUseVNGUserAgreementPopup()
        end)
        local uiMode = useUiModeInfo().uiMode
        local var4 = React.useRef(false)
        local bool3 = not FFlagEnableAccountSwitchSsoLogin or bool1 ~= false
        local bool4 = isPlatformInPopulation(arg1 or UserInputService:GetPlatform())

        if bool4 then
            if uiMode == UiMode.TenFoot or uiMode == UiMode.VR then
                bool4 = false
            else
                bool4 = not (var3 or isPioneerLaunch())
            end
        end

        React.useEffect(function()
            if bool3 and bool4 and bool2 and not var4.current then
                var4.current = true
                var1:LogBrowserTrackerLayerExposure(UniversalAppAuthEntryLayer)
            end
        end, {
            var1,
            bool4,
            bool2,
            bool3
        })
        return resolveAuthEntryVariant(var2, bool4, num1)
    end
}
