-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:01:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUiParent = script:FindFirstAncestor("ServerDrivenUi").Parent

local Cryo = require(ServerDrivenUiParent.Cryo)
local LaunchGame = require(ServerDrivenUiParent.GameLaunch).LaunchGame
local FFlagDeferInExperienceRbxmDownload = require(ServerDrivenUiParent.SharedFlags).FFlagDeferInExperienceRbxmDownload
local SduiSharedContent = require(ServerDrivenUiParent.SduiSharedContent)
local FFlagLuaAppFixLaunchGameSourceParam = require(ServerDrivenUiParent.SharedFlags).FFlagLuaAppFixLaunchGameSourceParam

local FFlagSduiLaunchExperienceCheckPlayabilityBeforeLaunch = require(ServerDrivenUiParent.SharedFlags).FFlagSduiLaunchExperienceCheckPlayabilityBeforeLaunch
local sduiReportGamePlayIntent = SduiSharedContent.sduiReportGamePlayIntent
local LaunchUnlessNotPlayable = require(ServerDrivenUiParent.GamePlayButton).LaunchUnlessNotPlayable

local SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)
local SduiActionType = SduiCoreSystem.SduiActionType
local SduiErrorType = SduiCoreSystem.SduiErrors.SduiErrorType
local executeAction = SduiCoreSystem.executeAction

local LaunchExperience = SduiActionType.LaunchExperience

local function launchExperience(placeId: string, universeId: string?, launchSource: string?, tbl1, analyticsContext, sduiContext)
    sduiReportGamePlayIntent({
        sduiContext = sduiContext,
        analyticsContext = analyticsContext,
        universeId = tostring(universeId or ""),
        placeId = placeId
    })

    if FFlagLuaAppFixLaunchGameSourceParam then
        LaunchGame(placeId, nil, tbl1, nil, launchSource)
        return
    end
    LaunchGame(placeId, launchSource, tbl1, nil)
end

return function(arg1, analyticsContext, sduiContext, _)
    local actionParams = if arg1 then arg1.actionParams or nil else nil

    if actionParams == nil then
        sduiContext.dependencies.logger.reportError(
            SduiErrorType.InvalidActionParams,
            { name = LaunchExperience, message = "Missing actionParams" },
            sduiContext.appPage
        )
        return
    end

    assert(actionParams, "actionParams must exist")

    local placeId = actionParams.placeId
    if placeId == nil then
        sduiContext.dependencies.logger.reportError(
            SduiErrorType.InvalidActionParams,
            { name = LaunchExperience, message = "Missing placeId", propName = "placeId" },
            sduiContext.appPage
        )
        return
    end

    local universeId = actionParams.universeId
    local launchSource = actionParams.launchSource
    local experienceJoinData = actionParams.experienceJoinData

    if FFlagDeferInExperienceRbxmDownload then
        experienceJoinData = Cryo.Dictionary.join(experienceJoinData or {}, { universeId = universeId })
    end

    if not FFlagSduiLaunchExperienceCheckPlayabilityBeforeLaunch then
        sduiReportGamePlayIntent({
            sduiContext = sduiContext,
            analyticsContext = analyticsContext,
            universeId = tostring(universeId or ""),
            placeId = placeId
        })

        if FFlagLuaAppFixLaunchGameSourceParam then
            LaunchGame(placeId, nil, experienceJoinData, nil, launchSource)
        else
            LaunchGame(placeId, launchSource, experienceJoinData, nil)
        end

        return
    end

    if actionParams.checkPlayabilityBeforeLaunch ~= true then
        launchExperience(placeId, universeId, launchSource, experienceJoinData, analyticsContext, sduiContext)
        return
    end

    local function launch() -- Luacid: Inlined by compiler; 2 call sites recovered
        launchExperience(placeId, universeId, launchSource, experienceJoinData, analyticsContext, sduiContext)
    end

    if universeId == nil then
        sduiContext.dependencies.logger.reportError(
            SduiErrorType.InvalidActionParams,
            {
                name = LaunchExperience,
                message = "Missing universeId for checkPlayabilityBeforeLaunch",
                propName = "universeId"
            },
            sduiContext.appPage
        )
        launch()
        return
    end

    local dependencies = sduiContext.dependencies
    if dependencies.networking == nil then
        dependencies.logger.reportError(
            SduiErrorType.GetNilDependencies,
            {
                name = LaunchExperience,
                message = "checkPlayabilityBeforeLaunch requires networking dependency"
            },
            sduiContext.appPage
        )
        launch()
        return
    end

    local function openGameDetails()
        local tbl1 = {
            actionType = SduiActionType.OpenGameDetails,
            actionParams = actionParams
        }
        executeAction(tbl1, analyticsContext, sduiContext)
    end

    dependencies.dispatch(LaunchUnlessNotPlayable(dependencies.networking, tostring(universeId), launch, openGameDetails))
end
