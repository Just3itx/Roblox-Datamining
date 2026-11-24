-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T16:31:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local GenericChallenges = script:FindFirstAncestor("GenericChallenges")
local GenericChallengesParent = GenericChallenges.Parent
local useRoactService = require(GenericChallengesParent.RobloxAppHooks).useRoactService
local useSelector = require(GenericChallengesParent.RoactUtils).Hooks.RoactRodux.useSelector
local React = require(GenericChallengesParent.React)
local useState = React.useState
local useEffect = React.useEffect
local Roact = require(GenericChallengesParent.Roact)
local RoactNavigation = require(GenericChallengesParent.RoactNavigation)
local AppLogging = require(GenericChallengesParent.RoactServiceTags).AppLogging
local Foundation = require(GenericChallengesParent.Foundation)
local IconSize = Foundation.Enums.IconSize
local Loading = Foundation.Loading

local DeviceAccessChallengeEvent = require(script.Parent.DeviceAccessChallengeEvent)
local ChallengeEventConstants = require(GenericChallenges.Utils.ChallengeEventConstants)

local GetFFlagLuaAppChallengeMoreTelemetryEnabled = require(GenericChallenges.Middleware.Flags.GetFFlagLuaAppChallengeMoreTelemetryEnabled)

local function DeviceAccessTokenChallenge(tbl1)
    local var1 = useRoactService(AppLogging)

    local var2 = nil
    local var3 = nil
    local var4 = nil
    local var5 = nil
    local var6 = HttpService:JSONDecode(tbl1.challengeMetadata)

    if GetFFlagLuaAppChallengeMoreTelemetryEnabled() then
        var2, var3 = useState(false)
        var4, var5 = useState(false)
    end

    useEffect(function()
        var1:logRobloxTelemetryEvent(DeviceAccessChallengeEvent, {}, {
            context = ChallengeEventConstants.ChallengeLifecycleEventConstants.ChallengeInitialized,
            challengeId = tbl1.challengeId,
            tokenType = var6.tokenType
        })

        local accountService = tbl1.accountService
        local errorCode

        if accountService and accountService:DeviceAccessTokenAvailable() then
            local var7 = HttpService:JSONDecode(accountService:GetDeviceAccessToken())
            errorCode = var7.errorCode
            if errorCode == nil or errorCode == "" then
                var7.accessToken.tokenType = var6.tokenType
                if GetFFlagLuaAppChallengeMoreTelemetryEnabled() then
                    var3(true)
                end
                tbl1.onChallengeCompleted(HttpService:JSONEncode(var7.accessToken))
                var1:logRobloxTelemetryEvent(DeviceAccessChallengeEvent, {}, {
                    context = ChallengeEventConstants.ChallengeLifecycleEventConstants.ChallengeCompleted,
                    challengeId = tbl1.challengeId,
                    tokenType = var6.tokenType
                })
                return
            end
        else
            errorCode = nil
        end

        if GetFFlagLuaAppChallengeMoreTelemetryEnabled() then
            var5(true)
        end
        tbl1.onChallengeFailed(errorCode)
        var1:logRobloxTelemetryEvent(DeviceAccessChallengeEvent, {}, {
            context = ChallengeEventConstants.ChallengeLifecycleEventConstants.ChallengeInvalidated,
            challengeId = tbl1.challengeId,
            tokenType = var6.tokenType,
            errorCode = errorCode
        })
    end, {})

    local var7 = useSelector(function(arg1)
        return {
            screenSize = arg1.ScreenSize
        }
    end)

    local uDim2 = UDim2.fromOffset(var7.screenSize.X, var7.screenSize.Y)

    return Roact.createElement("Frame", {
        Size = uDim2,
        BackgroundTransparency = 0.2,
        Active = true
    }, {
        Spinner = Roact.createElement(
            Loading,
            {
                AnchorPoint = Vector2.new(0.5, 0.5),
                Position = UDim2.fromScale(0.5, 0.5),
                size = IconSize.Large
            }
        ),
        NavigationEvents = if GetFFlagLuaAppChallengeMoreTelemetryEnabled() then Roact.createElement(RoactNavigation.NavigationEvents, {
            onWillBlur = function()
                if var2 or var4 then
                    return
                end

                var1:logRobloxTelemetryEvent(DeviceAccessChallengeEvent, {}, {
                    context = ChallengeEventConstants.ChallengeLifecycleEventConstants.ChallengeAbandoned,
                    challengeId = tbl1.challengeId,
                    tokenType = var6.tokenType
                })
            end
        }) else nil
    })
end

return DeviceAccessTokenChallenge
