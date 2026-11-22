-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T12:40:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TiltLoadingScreen = script:FindFirstAncestor("TiltLoadingScreen")
local TiltLoadingScreenParent = TiltLoadingScreen.Parent
local TiltLoadingScreenParentParent = TiltLoadingScreenParent.Parent

local React = require(TiltLoadingScreenParentParent.React)
local SignalsReact = require(TiltLoadingScreenParentParent.SignalsReact)

local Constants = require(TiltLoadingScreen.Constants)
local createTiltLoadingScreenModel = require(TiltLoadingScreen.Models.createTiltLoadingScreenModel)
local LoadingScreenTelemetry = require(TiltLoadingScreenParent.LoadingScreenTelemetry)

local _Types = require(TiltLoadingScreen.Types)

local function useTiltLoadingScreenViewModel(num1: number, vector2: Vector2, num2: number?)
    local var1 = React.useMemo(function()
        return createTiltLoadingScreenModel(num1, nil, num2)
    end, { num1, num2 })
    local var2 = SignalsReact.useSignalState(var1.getAssetInfo)
    local var3 = SignalsReact.useSignalState(var1.getUniverseId)
    local followUserId = SignalsReact.useSignalState(var1.getFollowUserId)
    local var5 = SignalsReact.useSignalState(var1.getIsAutoTranslated)
    local isSubjectToChinaPolicies = SignalsReact.useSignalState(var1.getIsSubjectToChinaPolicies)
    local status = SignalsReact.useSignalState(var1.getJoinState)
    local queuePosition = SignalsReact.useSignalState(var1.getQueuePosition)
    local queueTreatment = SignalsReact.useSignalState(var1.getQueueTreatment)
    local statusText = SignalsReact.useSignalState(var1.getServerStatusText)
    local var11 = React.useRef(var5)
    local var12 = React.useRef(false)

    React.useEffect(function()
        var1.start()
        return var1.destroy
    end, { var1 })
    var11.current = var5
    var12.current = not (var3 <= 0)
    React.useEffect(function()
        return function()
            if var12.current and var11.current == nil then
                LoadingScreenTelemetry.countPlayerLocalizationChoiceNotReady()
            end
        end
    end, {})

    local onJoinNewServer = React.useCallback(function(num3: number?)
        var1.logQueuedStateButtonClick("JoinNewServer", num3)
        var1.launchExperience()
    end, { var1 })
    local onAutoJoinNewServer = React.useCallback(function()
        var1.launchExperience()
    end, { var1 })
    local onJoinTheLine = React.useCallback(function(num3: number?)
        var1.logQueuedStateButtonClick("JoinTheLine", num3)
    end, { var1 })
    local onShowConnectionHealth = React.useCallback(function()
        var1.showConnectionHealth()
    end, { var1 })
    local gameData = React.useMemo(function()
        if not var2 then
            return nil
        end

        return {
            name = var2.name or "",
            creator = var2.creatorName or "",
            verified = var2.creatorHasVerifiedBadge == true
        }
    end, { var2 })

    return {
        isMobile = math.min(vector2.X, vector2.Y) <= Constants.MOBILE_BREAKPOINT,
        gameData = gameData,
        thumbnailUrl = if var3 > 0 then string.format("rbxthumb://type=GameIcon&id=%d&w=256&h=256", var3) else "",
        isAutoTranslated = var5,
        statusPanel = {
            status = status,
            statusText = statusText,
            queuePosition = queuePosition,
            queueTreatment = queueTreatment,
            followUserId = followUserId,
            isSubjectToChinaPolicies = isSubjectToChinaPolicies,
            onAutoJoinNewServer = onAutoJoinNewServer,
            onJoinNewServer = onJoinNewServer,
            onJoinTheLine = onJoinTheLine,
            onShowConnectionHealth = onShowConnectionHealth
        }
    }
end

return useTiltLoadingScreenViewModel
