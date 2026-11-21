-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T02:11:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalogParent = script:FindFirstAncestor("AvatarExperienceCatalog").Parent
local AvatarExperienceCommon = require(AvatarExperienceCatalogParent.AvatarExperienceCommon)
local AvatarExperienceAnalytics = require(AvatarExperienceCatalogParent.AvatarExperienceAnalytics)
local AvatarExperienceFlags = require(AvatarExperienceCatalogParent.AvatarExperienceFlags)
local PerformFetch = require(AvatarExperienceCatalogParent.Http).PerformFetch
local Promise = require(AvatarExperienceCatalogParent.Promise)
local ToastRodux = require(AvatarExperienceCatalogParent.ToastRodux)

local AVATAR_EDITOR_CONSTANTS = AvatarExperienceCommon.Constants.AVATAR_EDITOR_CONSTANTS
local ToastType = ToastRodux.Enums.ToastType
local SetCurrentToastMessage = ToastRodux.Actions.SetCurrentToastMessage

local Constants = AvatarExperienceAnalytics.Constants
local AVATAR_EDITOR_SERVICE_COUNTER_STATUS = Constants.AVATAR_EDITOR_SERVICE_COUNTER_STATUS
local getGearAssetIdFromState = AvatarExperienceCommon.Utils.getGearAssetIdFromState

local reportAvatarEventCounterNoAnalyticsArgument = AvatarExperienceAnalytics.reportAvatarEventCounterNoAnalyticsArgument
local reportAvatarEditorServiceCounter = AvatarExperienceAnalytics.reportAvatarEditorServiceCounter
local reportAvatarEventCounterV1 = AvatarExperienceAnalytics.reportAvatarEventCounterV1

local FIntAXLookOutfitCreationDelayMs = AvatarExperienceFlags.FIntAXLookOutfitCreationDelayMs
local FFlagAXAvatarEditorServiceTelemetryV2 = AvatarExperienceFlags.FFlagAXAvatarEditorServiceTelemetryV2

local FFlagAXDeprecateAvatarEditorServiceTelemetryV1 = AvatarExperienceFlags.FFlagAXDeprecateAvatarEditorServiceTelemetryV1

local tbl1 = {
    toastMessage = "Feature.Avatar.Message.InvalidName",
    isLocalized = false,
    toastType = ToastType.InformationMessage
}

local tbl2 = {
    toastMessage = "Feature.Avatar.Message.ReachedMaxOutfits",
    isLocalized = false,
    toastType = ToastType.InformationMessage
}

local tbl3 = {
    toastMessage = "Feature.Avatar.Message.UnknownErrorCreatingOutfit",
    isLocalized = false,
    toastType = ToastType.InformationMessage
}

return function(str1: string, func1: (...any) -> (...any), tbl4, callback: (...any) -> (...any))
    return function(arg1, arg2)
        local avatarEditorService = arg2.avatarEditorService
        return PerformFetch.Single(AVATAR_EDITOR_CONSTANTS.CreateOutfitKey, function(arg3)
            local state = arg3:getState()
            local avatarType = state.AvatarExperience.AvatarEditor.Character.AvatarType
            local var1 = Enum.HumanoidRigType[avatarType]

            local gearAssetIdFromState = getGearAssetIdFromState(state.AvatarExperience)

            local var2 = func1(state, tbl4)

            task.spawn(function()
                task.wait(FIntAXLookOutfitCreationDelayMs / 1000)

                Promise.new(function(callback2, callback3)
                    if FFlagAXAvatarEditorServiceTelemetryV2 then
                        reportAvatarEditorServiceCounter(
                            Constants.AVATAR_EDITOR_SERVICE_EVENTS.NoPromptCreateOutfit,
                            AVATAR_EDITOR_SERVICE_COUNTER_STATUS.Request
                        )
                    end
                    local var3 = avatarEditorService:NoPromptCreateOutfit(var2, var1, str1, gearAssetIdFromState)

                    while not var3 do
                        if FFlagAXAvatarEditorServiceTelemetryV2 then
                            reportAvatarEditorServiceCounter(
                                Constants.AVATAR_EDITOR_SERVICE_EVENTS.NoPromptCreateOutfit,
                                AVATAR_EDITOR_SERVICE_COUNTER_STATUS.Error
                            )
                        end
                        avatarEditorService.PromptCreateOutfitCompleted:Wait()
                        if FFlagAXAvatarEditorServiceTelemetryV2 then
                            reportAvatarEditorServiceCounter(
                                Constants.AVATAR_EDITOR_SERVICE_EVENTS.NoPromptCreateOutfit,
                                AVATAR_EDITOR_SERVICE_COUNTER_STATUS.Request
                            )
                        end

                        var3 = avatarEditorService:NoPromptCreateOutfit(var2, var1, str1, 0)

                        if not FFlagAXDeprecateAvatarEditorServiceTelemetryV1 then
                            reportAvatarEventCounterNoAnalyticsArgument(Constants.AVATAR_EDITOR_SERVICE_ERRORS.NoPromptCreateOutfit)
                        end
                    end

                    local result, var4 = avatarEditorService.PromptCreateOutfitCompleted:Wait()
                    if result == Enum.AvatarPromptResult.Success then
                        if FFlagAXAvatarEditorServiceTelemetryV2 then
                            reportAvatarEditorServiceCounter(
                                Constants.AVATAR_EDITOR_SERVICE_EVENTS.NoPromptCreateOutfit,
                                AVATAR_EDITOR_SERVICE_COUNTER_STATUS.Success
                            )
                        end
                        reportAvatarEventCounterV1(Constants.AVATAR_EVENT_COUNTER_NAME.AXCreateCostume)

                        callback()

                        callback2()
                        return
                    end
                    if var4 == Enum.CreateOutfitFailure.InvalidName then
                        arg3:dispatch(SetCurrentToastMessage(tbl1))
                    elseif var4 == Enum.CreateOutfitFailure.OutfitLimitReached then
                        arg3:dispatch(SetCurrentToastMessage(tbl2))
                    elseif var4 == Enum.CreateOutfitFailure.Other then
                        arg3:dispatch(SetCurrentToastMessage(tbl3))
                    end

                    if not FFlagAXDeprecateAvatarEditorServiceTelemetryV1 then
                        reportAvatarEventCounterNoAnalyticsArgument(Constants.AVATAR_EDITOR_SERVICE_ERRORS.CreateOutfit)
                    end

                    if FFlagAXAvatarEditorServiceTelemetryV2 then
                        reportAvatarEditorServiceCounter(
                            Constants.AVATAR_EDITOR_SERVICE_EVENTS.NoPromptCreateOutfit,
                            AVATAR_EDITOR_SERVICE_COUNTER_STATUS.Error,
                            var4 or result
                        )
                    end
                    callback3()
                end)
            end)

            return Promise.resolve()
        end)(arg1):catch(function(_) end)
    end
end
