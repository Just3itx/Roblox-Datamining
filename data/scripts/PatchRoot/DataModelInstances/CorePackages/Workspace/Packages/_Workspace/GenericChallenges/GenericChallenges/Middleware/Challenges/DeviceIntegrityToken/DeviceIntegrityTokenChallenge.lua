-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T16:31:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local GenericChallenges = script:FindFirstAncestor("GenericChallenges")
local GenericChallengesParent = GenericChallenges.Parent
local React = require(GenericChallengesParent.React)
local useRoactService = require(GenericChallengesParent.RobloxAppHooks).useRoactService
local AppLogging = require(GenericChallengesParent.RoactServiceTags).AppLogging
local Foundation = require(GenericChallengesParent.Foundation)
local IconSize = Foundation.Enums.IconSize
local Loading = Foundation.Loading

local DeviceIntegrityChallengeEvent = require(script.Parent.DeviceIntegrityChallengeEvent)

local GetFFlagEnableTransparentDeviceIntegrityChallengeSpinner = require(GenericChallenges.Middleware.Flags.GetFFlagEnableTransparentDeviceIntegrityChallengeSpinner)

local GetFFlagEnableNewDeviceIntegrityFailureHandling = require(GenericChallenges.Middleware.Flags.GetFFlagEnableNewDeviceIntegrityFailureHandling)
local useEffect = React.useEffect
local ChallengeEventConstants = require(GenericChallenges.Utils.ChallengeEventConstants)
local useSelector = require(GenericChallengesParent.RoactUtils).Hooks.RoactRodux.useSelector
game:DefineFastInt("DeviceIntegrityNativeTimeoutMilliseconds", 450)

function constructAccountServiceParams(requestHash: string): string
    return HttpService:JSONEncode({ requestHash = requestHash })
end

local function DeviceIntegrityTokenChallenge(tbl1)
    local var1 = useRoactService(AppLogging)

    useEffect(function()
        local var2 = HttpService:JSONDecode(tbl1.challengeMetadata)
        var1:logRobloxTelemetryEvent(DeviceIntegrityChallengeEvent, {}, {
            context = ChallengeEventConstants.ChallengeLifecycleEventConstants.ChallengeInitialized,
            challengeId = tbl1.challengeId,
            integrityType = var2.integrityType
        })

        local accountService = tbl1.accountService
        if not accountService or not accountService:DeviceIntegrityAvailable() then
            if GetFFlagEnableNewDeviceIntegrityFailureHandling() then
                var1:logRobloxTelemetryEvent(DeviceIntegrityChallengeEvent, {}, {
                    context = ChallengeEventConstants.ChallengeLifecycleEventConstants.ChallengeInvalidated,
                    challengeId = tbl1.challengeId,
                    integrityType = var2.integrityType
                })

                tbl1.onChallengeCompleted(HttpService:JSONEncode({ redemptionToken = "", integrityType = var2.integrityType }))
            else
                tbl1.onChallengeFailed()
                var1:logRobloxTelemetryEvent(DeviceIntegrityChallengeEvent, {}, {
                    context = ChallengeEventConstants.ChallengeLifecycleEventConstants.ChallengeInvalidated,
                    challengeId = tbl1.challengeId,
                    integrityType = var2.integrityType
                })
            end

            return
        end

        local var3

        if GetFFlagEnableNewDeviceIntegrityFailureHandling() then
            local deviceIntegrityTokenYield = accountService:GetDeviceIntegrityTokenYield(
                (HttpService:JSONEncode(
                    {
                        requestHash = var2.requestHash,
                        timeoutMillis = game:GetFastInt("DeviceIntegrityNativeTimeoutMilliseconds")
                    }
                ))
            )

            if deviceIntegrityTokenYield == nil or deviceIntegrityTokenYield == "" then
                var1:logRobloxTelemetryEvent(DeviceIntegrityChallengeEvent, {}, {
                    context = ChallengeEventConstants.ChallengeLifecycleEventConstants.ChallengeInvalidated,
                    challengeId = tbl1.challengeId,
                    integrityType = var2.integrityType
                })

                tbl1.onChallengeCompleted(HttpService:JSONEncode({ redemptionToken = "", integrityType = var2.integrityType }))

                return
            end

            var3 = HttpService:JSONDecode(deviceIntegrityTokenYield)
        else
            var3 = HttpService:JSONDecode(accountService:GetDeviceIntegrityTokenYield(constructAccountServiceParams(var2.requestHash)))
        end

        tbl1.onChallengeCompleted(HttpService:JSONEncode({ redemptionToken = var3.token, integrityType = var2.integrityType }))

        var1:logRobloxTelemetryEvent(DeviceIntegrityChallengeEvent, {}, {
            context = ChallengeEventConstants.ChallengeLifecycleEventConstants.ChallengeCompleted,
            challengeId = tbl1.challengeId,
            integrityType = var2.integrityType,
            result = var3.result
        })
    end, {})
    local var2 = useSelector(function(arg1)
        return {
            screenSize = arg1.ScreenSize
        }
    end)
    local uDim2 = UDim2.fromOffset(var2.screenSize.X, var2.screenSize.Y)
    if GetFFlagEnableTransparentDeviceIntegrityChallengeSpinner() then
        return React.createElement("Frame", {
            Size = uDim2,
            BackgroundTransparency = 1,
            Active = true
        }, {
            Spinner = React.createElement(
                Loading,
                {
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Position = UDim2.fromScale(0.5, 0.5),
                    size = IconSize.Large
                }
            )
        })
    end

    return React.createElement("Frame", {
        Size = uDim2,
        BackgroundTransparency = 0.2,
        Active = true
    }, {
        Spinner = React.createElement(
            Loading,
            {
                AnchorPoint = Vector2.new(0.5, 0.5),
                Position = UDim2.fromScale(0.5, 0.5),
                size = IconSize.Large
            }
        )
    })
end
return DeviceIntegrityTokenChallenge
