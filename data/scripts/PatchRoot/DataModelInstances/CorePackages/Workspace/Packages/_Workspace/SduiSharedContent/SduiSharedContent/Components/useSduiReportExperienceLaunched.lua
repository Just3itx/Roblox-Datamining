-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:10:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedContentParent = script:FindFirstAncestor("SduiSharedContent").Parent
local React = require(SduiSharedContentParent.React)

local _SduiCoreSystem = require(SduiSharedContentParent.SduiCoreSystem)

local sduiReportGamePlayIntent = require(script.Parent.sduiReportGamePlayIntent)
local HoverTileCoordinator = require(SduiSharedContentParent.GameTile).HoverTileCoordinator
local FFlagSduiResetHoverOnExperienceLaunch = require(SduiSharedContentParent.SharedFlags).FFlagSduiResetHoverOnExperienceLaunch
local FFlagLuaAppDemoModePlayButtonTelemetry = require(SduiSharedContentParent.SharedFlags).FFlagLuaAppDemoModePlayButtonTelemetry

local function useSduiReportExperienceLaunched(sduiContext, analyticsContext, universeId: string, placeId: string?, rootPlaceId: string?, appliedFilters, launchData: string?)
    local eventIngest = sduiContext.dependencies.eventIngest
    local sessionService = sduiContext.dependencies.sessionService

    return React.useCallback(function(actionType: string?)
        if FFlagSduiResetHoverOnExperienceLaunch then
            HoverTileCoordinator.default:reset()
        end

        local var1 = sduiReportGamePlayIntent
        local tbl1 = {
            sduiContext = sduiContext,
            analyticsContext = analyticsContext,
            universeId = universeId,
            placeId = placeId,
            rootPlaceId = rootPlaceId,
            appliedFilters = appliedFilters,
            launchData = launchData,
            actionType = 0
        }

        if not FFlagLuaAppDemoModePlayButtonTelemetry then
            actionType = nil
        end

        tbl1.actionType = actionType
        var1(tbl1)
    end, {
        eventIngest,
        analyticsContext,
        universeId,
        placeId,
        rootPlaceId,
        appliedFilters,
        launchData,
        sessionService,
        sduiContext
    })
end

return useSduiReportExperienceLaunched
