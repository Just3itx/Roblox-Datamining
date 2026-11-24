-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T16:30:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericChallenges = script:FindFirstAncestor("GenericChallenges")
local GenericChallengesParent = GenericChallenges.Parent

local Players = game:GetService("Players")

local React = require(GenericChallengesParent.React)

local useDispatch = require(GenericChallengesParent.RoactUtils).Hooks.RoactRodux.useDispatch
local useSelector = require(GenericChallengesParent.RoactUtils).Hooks.RoactRodux.useSelector
local useLocalization = require(GenericChallengesParent.Localization).Hooks.useLocalization

local Foundation = require(GenericChallengesParent.Foundation)
local IconSize = Foundation.Enums.IconSize
local Loading = Foundation.Loading

local FullscreenPageWithSafeArea = require(GenericChallengesParent.AppBlox).FullscreenPageWithSafeArea

local FocusNavigationUtils = require(GenericChallengesParent.FocusNavigationUtils)
local FocusNavigableSurfaceWrapper = FocusNavigationUtils.FocusNavigableSurfaceWrapper
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum

local PersonaLivenessContainer = require(script.Parent.PersonaLivenessContainer)
local PersonaLivenessServiceWrapper = require(script.Parent.PersonaLivenessServiceWrapper)
local QRDeepLinkDialog = require(GenericChallengesParent.IdentityVerification).QRDeepLinkDialog
local BiometricTypeEnum = require(script.Parent.Parent.Common.Enums).BiometricTypeEnum
local TelemetryReasons = require(script.Parent.Parent.Common.TelemetryReasons)

local useRoactService = require(GenericChallengesParent.RobloxAppHooks).useRoactService
local AppLogging = require(GenericChallengesParent.RoactServiceTags).AppLogging
local RoactNetworking = require(GenericChallengesParent.RoactServiceTags).RoactNetworking
local BiometricChallengeEvent = require(script.Parent.Parent.Common.BiometricChallengeEvent)
local ChallengeEventConstants = require(GenericChallenges.Utils.ChallengeEventConstants)
local GetFFlagEnhancedPersonaLivenessEvents = require(GenericChallengesParent.SharedFlags).GetFFlagEnhancedPersonaLivenessEvents
local FFlagUseSignalsForUserAccess = require(GenericChallengesParent.SharedFlags).FFlagUseSignalsForUserAccess

local useSignalState = require(GenericChallengesParent.SignalsReact).useSignalState
local GetUserAccessStore = if FFlagUseSignalsForUserAccess then require(GenericChallengesParent.UserAccessStore).GetUserAccessStore else nil
local num1 = game:DefineFastInt("PersonaLivenessV2QrPollDelaySec", 6)
local num2 = game:DefineFastInt("PersonaLivenessV2QrPollMaxRetries", 60)

local function defaultGetLocalUserId(): number?
    local localPlayer = Players.LocalPlayer
    return if localPlayer then localPlayer.UserId else nil
end

local function buildDeeplink(num3: number): string -- Luacid: Inlined by compiler; 1 call site recovered
    return "https://ro.blox.com/Ebh5"
        .. "?pid=QR_code&c=liveness_onelink"
            .. "&is_retargeting=false" .. "&af_dp=" .. "roblox%3A%2F%2Fnavigation%2Faccount_unlock%3Fuser_id=" .. tostring(num3) .. "&deep_link_value=" .. "roblox%3A%2F%2Fnavigation%2Faccount_unlock%3Fuser_id=" .. tostring(num3)
end

local function PersonaLivenessQRFlow(tbl1)
    local var1 = useDispatch()
    local var2 = useRoactService(AppLogging)
    local var3 = useRoactService(RoactNetworking)

    local var4 = if FFlagUseSignalsForUserAccess then useSignalState(GetUserAccessStore(false).getUserAccessRestrictionDetail) else useSelector(function(arg1)
        return arg1.UserAccess and arg1.UserAccess.restrictionDetail
    end)

    local var5 = (tbl1.getLocalUserId or defaultGetLocalUserId)()
    local deeplink = if var5 and var5 > 0 then buildDeeplink(var5) else nil
    local var6 = useLocalization({ prompt = "Feature.BiometricChallenge.Content.QRHelpPrompt" })

    local var7 = useLocalization({
        title = "Feature.BiometricChallenge.Title.QRHandoff",
        description = "Feature.BiometricChallenge.Content.ScanQR",
        footer = {
            "Feature.BiometricChallenge.Content.QRHelpFull",
            prompt = "<b>" .. var6.prompt .. "</b>"
        }
    })

    local var8 = React.useRef(false)

    local var9 = React.useCallback(function(reason)
        if var8.current then
            return
        end
        var8.current = true
        tbl1.onChallengeAbandoned("")
        if GetFFlagEnhancedPersonaLivenessEvents() then
            var2:logRobloxTelemetryEvent(BiometricChallengeEvent, {}, {
                context = ChallengeEventConstants.ChallengeLifecycleEventConstants.ChallengeAbandoned,
                challengeId = tbl1.challengeId,
                biometricType = BiometricTypeEnum.PersonaLiveness,
                reason = reason
            })
            return
        end

        var2:logRobloxTelemetryEvent(BiometricChallengeEvent, {}, {
            context = ChallengeEventConstants.ChallengeLifecycleEventConstants.ChallengeAbandoned,
            challengeId = tbl1.challengeId,
            biometricType = BiometricTypeEnum.PersonaLiveness
        })
    end, { var2, tbl1.challengeId, tbl1.onChallengeAbandoned })

    local var10 = React.useCallback(function(str1: string, reason)
        if var8.current then
            return
        end
        var8.current = true
        tbl1.onChallengeFailed(str1)
        if GetFFlagEnhancedPersonaLivenessEvents() then
            var2:logRobloxTelemetryEvent(BiometricChallengeEvent, {}, {
                context = ChallengeEventConstants.ChallengeLifecycleEventConstants.ChallengeInvalidated,
                challengeId = tbl1.challengeId,
                biometricType = BiometricTypeEnum.PersonaLiveness,
                reason = reason
            })
            return
        end

        var2:logRobloxTelemetryEvent(BiometricChallengeEvent, {}, {
            context = ChallengeEventConstants.ChallengeLifecycleEventConstants.ChallengeInvalidated,
            challengeId = tbl1.challengeId,
            biometricType = BiometricTypeEnum.PersonaLiveness
        })
    end, {})

    React.useEffect(function()
        if deeplink then
            return
        end

        if GetFFlagEnhancedPersonaLivenessEvents() then
            var10("MissingLocalUserId", TelemetryReasons.NullUserId)
            return
        end
        var10("MissingLocalUserId")
    end, { deeplink, var10 })

    React.useEffect(function()
        if not deeplink or var4 ~= nil then
            return
        end

        if not GetFFlagEnhancedPersonaLivenessEvents() then
            var9()
            return
        end

        if var8.current then
            return
        end
        var8.current = true

        var2:logRobloxTelemetryEvent(BiometricChallengeEvent, {}, {
            context = ChallengeEventConstants.ChallengeLifecycleEventConstants.ChallengeCompleted,
            challengeId = tbl1.challengeId,
            biometricType = BiometricTypeEnum.PersonaLiveness,
            reason = TelemetryReasons.QRCompleted
        })
        tbl1.onChallengeAbandoned("")
    end, {
        var4,
        deeplink,
        var9,
        var2,
        tbl1.challengeId,
        tbl1.onChallengeAbandoned
    })

    React.useEffect(function()
        if not deeplink then
            return
        end

        if GetFFlagEnhancedPersonaLivenessEvents() then
            var2:logRobloxTelemetryEvent(BiometricChallengeEvent, {}, {
                context = ChallengeEventConstants.ChallengeLifecycleEventConstants.ChallengeDisplayed,
                challengeId = tbl1.challengeId,
                biometricType = BiometricTypeEnum.PersonaLiveness,
                reason = TelemetryReasons.QRDisplayed
            })
        end

        local bool1 = false
        task.spawn(function()
            for _ = 1, num2 do
                task.wait(num1)
                if bool1 then
                    return
                end
                if tbl1.ApiFetchAccessStatus then
                    var1(tbl1.ApiFetchAccessStatus(var3))
                end
            end
            if bool1 then
                return
            end

            if GetFFlagEnhancedPersonaLivenessEvents() then
                var10("Timeout", TelemetryReasons.QRPollingTimeout)
                return
            end
            var10("Timeout")
        end)

        return function()
            bool1 = true
        end
    end, {})

    if not deeplink then
        return React.createElement(
            Loading,
            {
                size = IconSize.Medium,
                Position = UDim2.fromScale(0.5, 0.5),
                AnchorPoint = Vector2.new(0.5, 0.5)
            }
        )
    end
    return React.createElement(
        "ScreenGui",
        {
            ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
            DisplayOrder = 200,
            IgnoreGuiInset = true
        },
        {
            Overlay = React.createElement(FullscreenPageWithSafeArea, {
                includeStatusBar = false,
                useFullScalePage = true
            }, {
                FocusNavigableSurface = React.createElement(
                    FocusNavigableSurfaceWrapper,
                    {
                        surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.ModerationOverlay,
                        isIsolated = true
                    },
                    {
                        Dialog = React.createElement(QRDeepLinkDialog, {
                            deeplink = deeplink,
                            title = var7.title,
                            description = var7.description,
                            footer = var7.footer,
                            onClose = GetFFlagEnhancedPersonaLivenessEvents() and function()
                                var9(TelemetryReasons.QRUserAbandon)
                            end or var9
                        })
                    }
                )
            })
        }
    )
end

local function PersonaLivenessContainerV2(tbl1)
    if not PersonaLivenessServiceWrapper.isAvailable() then
        return React.createElement(PersonaLivenessQRFlow, tbl1)
    end

    return React.createElement(PersonaLivenessContainer, {
        challengeId = tbl1.challengeId,
        onChallengeCompleted = tbl1.onChallengeCompleted,
        onChallengeAbandoned = tbl1.onChallengeAbandoned,
        onChallengeFailed = tbl1.onChallengeFailed
    })
end
return PersonaLivenessContainerV2
