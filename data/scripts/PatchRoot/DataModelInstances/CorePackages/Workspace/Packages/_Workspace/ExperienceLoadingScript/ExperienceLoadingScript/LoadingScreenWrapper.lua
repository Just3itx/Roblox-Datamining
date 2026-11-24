-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T11:01:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExperienceLoadingScript = script:FindFirstAncestor("ExperienceLoadingScript")
local ExperienceLoadingScriptParent = ExperienceLoadingScript.Parent

local ExperienceService = game:GetService("ExperienceService")

local React = require(ExperienceLoadingScriptParent.React)
local RoactUtils = require(ExperienceLoadingScriptParent.RoactUtils)
local useSelector = RoactUtils.Hooks.RoactRodux.useSelector
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local Responsive = require(ExperienceLoadingScriptParent.Responsive)
local LoggingProtocol = require(ExperienceLoadingScriptParent.LoggingProtocol)
local game2 = require(ExperienceLoadingScriptParent.MockableProxyServices).game

local GetGameProductInfo = require(ExperienceLoadingScript.Thunks.GetGameProductInfo)
local GetIsSubjectToChinaPolicies = require(ExperienceLoadingScript.Thunks.GetIsSubjectToChinaPolicies)
local GetUniverseId = require(ExperienceLoadingScript.Thunks.GetUniverseId)

local GetFFlagReportFirstExperienceCancelled = require(ExperienceLoadingScript.Flags.GetFFlagReportFirstExperienceCancelled)
local FFlagLoadingScreenControlMilestones = require(ExperienceLoadingScriptParent.SharedFlags).FFlagLoadingScreenControlMilestones
local LoadingScreenMilestones = require(ExperienceLoadingScriptParent.ProgressLoading.LoadingScreenMilestones)

local QueueExperimentation = require(ExperienceLoadingScriptParent.SocialExperiments).QueueExperimentation

local ProgressLoading = require(ExperienceLoadingScriptParent.ProgressLoading)
local LoadingScreenView = ProgressLoading.LoadingScreenView
local PlaceLauncherState = ProgressLoading.PlaceLauncherState

local createNetworking = ProgressLoading.createNetworking

local function LoadingScreenWrapper(arg1)
    local placeId = useSelector(function(arg2)
        return arg2.gameIds and arg2.gameIds.placeId or arg1.placeId
    end)
    local universeId = useSelector(function(arg2)
        return arg2.gameIds and arg2.gameIds.universeId or 0
    end)
    local productInfo = useSelector(function(arg2)
        return arg2.productInfo
    end)
    local isSubjectToChinaPolicies = useSelector(function(arg2)
        return arg2.isSubjectToChinaPolicies
    end)
    local var5 = useDispatch()

    local shouldStartFadeOut, var7 = React.useState(false)

    local preferredInputRef = React.useRef(nil)
    preferredInputRef.current = Responsive.usePreferredInput()

    React.useEffect(function()
        var5(GetUniverseId(createNetworking, placeId))
        var5(GetGameProductInfo(placeId))
        var5(GetIsSubjectToChinaPolicies())
    end, { placeId, var5 })

    React.useEffect(function()
        local connection = game.Loaded:Connect(function()
            var7(true)
        end)
        return function()
            connection:Disconnect()
        end
    end, {})

    React.useEffect(function()
        if not (QueueExperimentation.isInExperiment() and ExperienceService:GetFollowUserId() > 0 and placeId > 0) then
            return
        end
        if ExperienceService:GetPlaceJoinState() == PlaceLauncherState.Queued then
            QueueExperimentation.logExposure()
            return
        end
        local connection = ExperienceService.PlaceJoinStateChanged:Connect(function(state: string)
            if state == PlaceLauncherState.Queued then
                QueueExperimentation.logExposure()
            end
        end)
        return function()
            connection:Disconnect()
        end
    end, { placeId })

    local createElement = React.createElement
    local var9 = LoadingScreenView
    local tbl1 = {
        placeId = placeId,
        universeId = universeId,
        productInfo = productInfo,
        isSubjectToChinaPolicies = isSubjectToChinaPolicies,
        preferredInputRef = preferredInputRef,
        shouldStartFadeOut = shouldStartFadeOut,
        manageRobloxGuiFocus = true,
        milestones = if FFlagLoadingScreenControlMilestones then arg1.milestones else nil,
        onCloseButtonActivated = 0,
        onGamepadCancel = 0
    }

    function tbl1.onCloseButtonActivated()
        if FFlagLoadingScreenControlMilestones and arg1.milestones then
            arg1.milestones.abort(LoadingScreenMilestones.AbortReason.Cancelled)
        end
        if GetFFlagReportFirstExperienceCancelled then
            LoggingProtocol.default:logEventOnce("first_experience_cancelled")
        end
        game2:Shutdown()
    end
    function tbl1.onGamepadCancel()
        if game2:IsLoaded() then
            return
        end

        if FFlagLoadingScreenControlMilestones and arg1.milestones then
            arg1.milestones.abort(LoadingScreenMilestones.AbortReason.Cancelled)
        end
        game2:Shutdown()
    end

    return createElement(var9, tbl1)
end

return LoadingScreenWrapper
