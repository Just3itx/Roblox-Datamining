-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T16:21:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericChallenges = script:FindFirstAncestor("GenericChallenges")
local GenericChallengesParent = GenericChallenges.Parent

local HttpService = game:GetService("HttpService")

local React = require(GenericChallengesParent.React)
local Promise = require(GenericChallengesParent.Promise)

local AppPage = require(GenericChallengesParent.RobloxAppEnums).AppPage
local useDispatch = require(GenericChallengesParent.RoactUtils).Hooks.RoactRodux.useDispatch
local useAppPolicy = require(GenericChallengesParent.UniversalAppPolicy).useAppPolicy
local NavigateDown = require(GenericChallengesParent.NavigationRodux).Thunks.NavigateDown
local FFlagSignalsNavP3Dispatch = require(GenericChallengesParent.SharedFlags).FFlagSignalsNavP3Dispatch
local NavigationCommands = if FFlagSignalsNavP3Dispatch then require(GenericChallengesParent.RobloxAppNavigation).NavigationCommands else nil
local IdentityVerification = require(GenericChallengesParent.IdentityVerification)
local IDVApiProvider = IdentityVerification.IDVApiProvider
local usePollIDVStatus = IdentityVerification.usePollIDVStatus

local Foundation = require(GenericChallengesParent.Foundation)
local IconSize = Foundation.Enums.IconSize
local Loading = Foundation.Loading

local PersonaLivenessServiceWrapper = require(script.Parent.PersonaLivenessServiceWrapper)
local PersonaLivenessHosted = require(script.Parent.PersonaLivenessHosted)
local BiometricTypeEnum = require(script.Parent.Parent.Common.Enums).BiometricTypeEnum
local TelemetryReasons = require(script.Parent.Parent.Common.TelemetryReasons)

local useRoactService = require(GenericChallengesParent.RobloxAppHooks).useRoactService
local AppLogging = require(GenericChallengesParent.RoactServiceTags).AppLogging
local BiometricChallengeEvent = require(script.Parent.Parent.Common.BiometricChallengeEvent)
local ChallengeEventConstants = require(GenericChallenges.Utils.ChallengeEventConstants)
local GetFFlagEnhancedPersonaLivenessEvents = require(GenericChallengesParent.SharedFlags).GetFFlagEnhancedPersonaLivenessEvents

local delay = game:DefineFastInt("LivenessWithCallbackPollDelay", 2)
local retries = game:DefineFastInt("LivenessWithCallbackPollMaxRetries", 5)

local num1 = game:DefineFastInt("LivenessBackgroundOnlyPollDelay", 6)
local num2 = game:DefineFastInt("LivenessBackgroundOnlyPollMaxRetries", 30)

local function PersonaLivenessContainer(tbl1)
    local var1 = useDispatch()

    local var2 = useAppPolicy(function(arg1)
        return arg1.getHasWebViewSupportForFAE()
    end)

    local var3 = useRoactService(AppLogging)
    local webLink, var5 = React.useState(nil)

    local var6 = React.useRef("Persona")
    local var7 = React.useRef(nil)

    local var8 = React.useCallback(function(str1: string, reason)
        tbl1.onChallengeFailed(str1)
        if GetFFlagEnhancedPersonaLivenessEvents() then
            var3:logRobloxTelemetryEvent(BiometricChallengeEvent, {}, {
                context = ChallengeEventConstants.ChallengeLifecycleEventConstants.ChallengeInvalidated,
                challengeId = tbl1.challengeId,
                biometricType = BiometricTypeEnum.PersonaLiveness,
                reason = reason,
                inquiryId = var7.current
            })
            return
        end

        var3:logRobloxTelemetryEvent(BiometricChallengeEvent, {}, {
            context = ChallengeEventConstants.ChallengeLifecycleEventConstants.ChallengeInvalidated,
            challengeId = tbl1.challengeId,
            biometricType = BiometricTypeEnum.PersonaLiveness
        })
    end, { var3, tbl1.challengeId, tbl1.onChallengeFailed })

    local var9 = React.useCallback(function()
        tbl1.onChallengeAbandoned("")
        if not GetFFlagEnhancedPersonaLivenessEvents() then
            var3:logRobloxTelemetryEvent(BiometricChallengeEvent, {}, {
                context = ChallengeEventConstants.ChallengeLifecycleEventConstants.ChallengeAbandoned,
                challengeId = tbl1.challengeId,
                biometricType = BiometricTypeEnum.PersonaLiveness
            })

            return
        end

        local reason = if var6.current == "Hosted" then TelemetryReasons.HostedUserAbandon else TelemetryReasons.PersonaUserAbandon
        var3:logRobloxTelemetryEvent(BiometricChallengeEvent, {}, {
            context = ChallengeEventConstants.ChallengeLifecycleEventConstants.ChallengeAbandoned,
            challengeId = tbl1.challengeId,
            biometricType = BiometricTypeEnum.PersonaLiveness,
            reason = reason,
            inquiryId = var7.current
        })
    end, { var3, tbl1.challengeId, tbl1.onChallengeAbandoned })

    local var10 = React.useCallback(function()
        tbl1.onChallengeCompleted(HttpService:JSONEncode({ biometricType = BiometricTypeEnum.PersonaLiveness }))

        if not GetFFlagEnhancedPersonaLivenessEvents() then
            var3:logRobloxTelemetryEvent(BiometricChallengeEvent, {}, {
                context = ChallengeEventConstants.ChallengeLifecycleEventConstants.ChallengeCompleted,
                challengeId = tbl1.challengeId,
                biometricType = BiometricTypeEnum.PersonaLiveness
            })

            return
        end

        local reason = if var6.current == "Hosted" then TelemetryReasons.HostedCompleted else TelemetryReasons.PersonaCompleted
        var3:logRobloxTelemetryEvent(BiometricChallengeEvent, {}, {
            context = ChallengeEventConstants.ChallengeLifecycleEventConstants.ChallengeCompleted,
            challengeId = tbl1.challengeId,
            biometricType = BiometricTypeEnum.PersonaLiveness,
            reason = reason,
            inquiryId = var7.current
        })
    end, { var3, tbl1.challengeId, tbl1.onChallengeCompleted })

    local var11 = React.useCallback(function(detail, callback)
        local tbl2 = {
            name = AppPage.GenericWebPage,
            detail = detail,
            extraProps = {
                title = "",
                onClose = function()
                    callback()
                end
            }
        }
        if FFlagSignalsNavP3Dispatch then
            NavigationCommands.down(NavigationCommands.fromLegacyPage(tbl2))
            return
        end
        var1(NavigateDown(tbl2))
    end, { var1 })

    local var12 = React.useMemo(function()
        return if PersonaLivenessServiceWrapper.isAvailable() or var2 then {
            delay = delay,
            retries = retries
        } else { delay = num1, retries = num2 }
    end)

    local var13, var14 = usePollIDVStatus({ delay = var12.delay, retries = var12.retries })

    local var15 = React.useCallback(function(arg1)
        local sessionIdentifier = arg1.sessionIdentifier
        local sessionToken = arg1.sessionToken

        var7.current = sessionIdentifier

        if PersonaLivenessServiceWrapper.isAvailable() then
            var6.current = "Persona"
            if GetFFlagEnhancedPersonaLivenessEvents() then
                var3:logRobloxTelemetryEvent(BiometricChallengeEvent, {}, {
                    context = ChallengeEventConstants.ChallengeLifecycleEventConstants.ChallengeDisplayed,
                    challengeId = tbl1.challengeId,
                    biometricType = BiometricTypeEnum.PersonaLiveness,
                    reason = TelemetryReasons.PersonaDisplayed,
                    inquiryId = sessionIdentifier
                })
            end
            return PersonaLivenessServiceWrapper.startFlow(sessionIdentifier, sessionToken)
        end

        if not var2 then
            var6.current = "Hosted"
            if GetFFlagEnhancedPersonaLivenessEvents() then
                var3:logRobloxTelemetryEvent(BiometricChallengeEvent, {}, {
                    context = ChallengeEventConstants.ChallengeLifecycleEventConstants.ChallengeDisplayed,
                    challengeId = tbl1.challengeId,
                    biometricType = BiometricTypeEnum.PersonaLiveness,
                    reason = TelemetryReasons.HostedDisplayed,
                    inquiryId = sessionIdentifier
                })
            end
            var5(arg1.verificationLink)
            return Promise.resolve(sessionIdentifier)
        end

        var6.current = "Hosted"
        if GetFFlagEnhancedPersonaLivenessEvents() then
            var3:logRobloxTelemetryEvent(BiometricChallengeEvent, {}, {
                context = ChallengeEventConstants.ChallengeLifecycleEventConstants.ChallengeDisplayed,
                challengeId = tbl1.challengeId,
                biometricType = BiometricTypeEnum.PersonaLiveness,
                reason = TelemetryReasons.HostedDisplayed,
                inquiryId = sessionIdentifier
            })
        end
        return Promise.new(function(callback)
            var11(arg1.verificationLink, function()
                callback(sessionIdentifier)
            end)
        end)
    end, {
        var2,
        var11,
        var3,
        tbl1.challengeId
    })

    React.useEffect(function()
        IDVApiProvider.startLivenessVerification():andThen(function<T>(arg1: T): T
            return arg1
        end):andThen(function(arg1)
            return var15(arg1)
        end):andThen(function(arg1)
            return var13(arg1)
        end):andThen(function()
            return var10()
        end):catch(function(arg1)
            if arg1 and arg1.resultType == Enum.FacialAgeEstimationResultType.Cancel then
                var9()
            elseif GetFFlagEnhancedPersonaLivenessEvents() then
                local var16 = if arg1 and arg1.sessionStatus ~= nil then if var6.current == "Hosted" then TelemetryReasons.HostedPollingTimeout else TelemetryReasons.PersonaPollingTimeout else TelemetryReasons.StartLivenessFailed
                var8("Persona error", var16)
            else
                var8("Persona error")
            end
        end)

        return function()
            var14()
        end
    end, {})

    if webLink then
        return React.createElement(PersonaLivenessHosted, {
            sessionId = "",
            webLink = webLink,
            onCancel = function()
                var9()
            end
        })
    end

    return React.createElement(
        Loading,
        {
            size = IconSize.Medium,
            Position = UDim2.fromScale(0.5, 0.5),
            AnchorPoint = Vector2.new(0.5, 0.5)
        }
    )
end
return PersonaLivenessContainer
