-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T04:30:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarEditorService = game:GetService("AvatarEditorService")
local AvatarExperienceSaveParent = script:FindFirstAncestor("AvatarExperienceSave").Parent

local Promise = require(AvatarExperienceSaveParent.Promise)
local _LuauPolyfill = require(AvatarExperienceSaveParent.LuauPolyfill)
local AvatarExperienceAnalytics = require(AvatarExperienceSaveParent.AvatarExperienceAnalytics)
local AvatarExperienceFlags = require(AvatarExperienceSaveParent.AvatarExperienceFlags)
local buildProfileConfigurationApplyConfig = require(script.Parent.buildProfileConfigurationApplyConfig)

local reportAvatarEventCounterNoAnalyticsArgument = AvatarExperienceAnalytics.reportAvatarEventCounterNoAnalyticsArgument
local reportAvatarEditorServiceCounter = AvatarExperienceAnalytics.reportAvatarEditorServiceCounter
local AVATAR_EDITOR_SERVICE_ERRORS = AvatarExperienceAnalytics.Constants.AVATAR_EDITOR_SERVICE_ERRORS
local AVATAR_EDITOR_SERVICE_EVENTS = AvatarExperienceAnalytics.Constants.AVATAR_EDITOR_SERVICE_EVENTS
local AVATAR_EDITOR_SERVICE_COUNTER_STATUS = AvatarExperienceAnalytics.Constants.AVATAR_EDITOR_SERVICE_COUNTER_STATUS
local FFlagAXAvatarEditorServiceTelemetryV2 = AvatarExperienceFlags.FFlagAXAvatarEditorServiceTelemetryV2

local FFlagAXDeprecateAvatarEditorServiceTelemetryV1 = AvatarExperienceFlags.FFlagAXDeprecateAvatarEditorServiceTelemetryV1

local function saveProfileConfiguration(backgroundAssetId)
    return Promise.new(function(callback, callback2)
        local profileConfiguration = not AvatarExperienceFlags.FFlagAXProfileConfigurationMultiFieldApply and {
            BackgroundAssetId = backgroundAssetId
        }
            or buildProfileConfigurationApplyConfig(backgroundAssetId)

        if FFlagAXAvatarEditorServiceTelemetryV2 then
            reportAvatarEditorServiceCounter(
                AVATAR_EDITOR_SERVICE_EVENTS.NoPromptApplyProfileConfiguration,
                AVATAR_EDITOR_SERVICE_COUNTER_STATUS.Request
            )
        end
        local bool1 = AvatarEditorService:NoPromptApplyProfileConfiguration(profileConfiguration)

        while not bool1 do
            if FFlagAXAvatarEditorServiceTelemetryV2 then
                reportAvatarEditorServiceCounter(
                    AVATAR_EDITOR_SERVICE_EVENTS.NoPromptApplyProfileConfiguration,
                    AVATAR_EDITOR_SERVICE_COUNTER_STATUS.Error
                )
            end
            AvatarEditorService.PromptApplyProfileConfigurationCompleted:Wait()
            if not FFlagAXDeprecateAvatarEditorServiceTelemetryV1 then
                reportAvatarEventCounterNoAnalyticsArgument(AVATAR_EDITOR_SERVICE_ERRORS.NoPromptApplyProfileConfiguration)
            end

            if FFlagAXAvatarEditorServiceTelemetryV2 then
                reportAvatarEditorServiceCounter(
                    AVATAR_EDITOR_SERVICE_EVENTS.NoPromptApplyProfileConfiguration,
                    AVATAR_EDITOR_SERVICE_COUNTER_STATUS.Request
                )
            end
            bool1 = AvatarEditorService:NoPromptApplyProfileConfiguration(profileConfiguration)
        end

        local result = AvatarEditorService.PromptApplyProfileConfigurationCompleted:Wait()
        if result == Enum.AvatarPromptResult.Success then
            if FFlagAXAvatarEditorServiceTelemetryV2 then
                reportAvatarEditorServiceCounter(
                    AVATAR_EDITOR_SERVICE_EVENTS.NoPromptApplyProfileConfiguration,
                    AVATAR_EDITOR_SERVICE_COUNTER_STATUS.Success
                )
            end
            callback({ avatarPromptResult = result })
            return
        end

        if not FFlagAXDeprecateAvatarEditorServiceTelemetryV1 then
            reportAvatarEventCounterNoAnalyticsArgument(AVATAR_EDITOR_SERVICE_ERRORS.PromptApplyProfileConfigurationCompleted)
        end

        if FFlagAXAvatarEditorServiceTelemetryV2 then
            reportAvatarEditorServiceCounter(
                AVATAR_EDITOR_SERVICE_EVENTS.NoPromptApplyProfileConfiguration,
                AVATAR_EDITOR_SERVICE_COUNTER_STATUS.Error,
                result
            )
        end

        callback2({ avatarPromptResult = result })
    end)
end

return saveProfileConfiguration
