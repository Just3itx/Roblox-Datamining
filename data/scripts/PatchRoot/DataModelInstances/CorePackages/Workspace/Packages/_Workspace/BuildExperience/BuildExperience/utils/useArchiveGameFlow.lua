-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T21:20:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local React = require(BuildExperienceParent.React)

local GameConfigurationActions = require(BuildExperience.utils.GameConfigurationActions)
local ConfigurationActionTelemetry = require(BuildExperience.Telemetry.ConfigurationActionTelemetry)
local FFlagBuildExperienceActionOutcomeTelemetry = require(BuildExperience.Flags.FFlagBuildExperienceActionOutcomeTelemetry)

local Action = ConfigurationActionTelemetry.Action
local FailureReason = ConfigurationActionTelemetry.FailureReason

local function useArchiveGameFlow(tbl1)
    local universeId, var2 = React.useState(nil)
    local context = if FFlagBuildExperienceActionOutcomeTelemetry then tbl1.context else nil

    local requestArchive = React.useCallback(function(num1: number)
        var2(num1)
    end, {})

    local cancel = React.useCallback(function()
        var2(nil)
    end, {})

    return {
        isOpen = universeId ~= nil,
        requestArchive = requestArchive,
        confirm = React.useCallback(function()
            if universeId ~= nil then
                local var5 = FFlagBuildExperienceActionOutcomeTelemetry and {
                    universeId = universeId
                } or nil

                if FFlagBuildExperienceActionOutcomeTelemetry then
                    ConfigurationActionTelemetry.sendClick(Action.ArchiveGame, var5, context)
                end
                local var6 = GameConfigurationActions.archiveGame(universeId)
                if FFlagBuildExperienceActionOutcomeTelemetry then
                    var6:andThen(function()
                        ConfigurationActionTelemetry.sendSuccess(Action.ArchiveGame, var5, context)
                    end):catch(function(error)
                        ConfigurationActionTelemetry.sendFailure(
                            Action.ArchiveGame,
                            var5,
                            {
                                reason = FailureReason.RequestFailed,
                                error = error
                            },
                            context
                        )
                    end)
                end
            end
            var2(nil)
        end, { universeId, context }),
        cancel = cancel
    }
end

return useArchiveGameFlow
