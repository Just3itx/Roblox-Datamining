-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:51:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceAnalytics = script:FindFirstAncestor("AvatarExperienceAnalytics")
local AvatarExperienceAnalyticsParent = AvatarExperienceAnalytics.Parent
local AnalyticsService = require(AvatarExperienceAnalytics.AnalyticsService)
local ImpressionEnums = require(AvatarExperienceAnalytics.Enums.ImpressionEnums)

local AvatarExperienceFlags = require(AvatarExperienceAnalyticsParent.AvatarExperienceFlags)
local FFlagAXExtendUndoRedoTracking = AvatarExperienceFlags.FFlagAXExtendUndoRedoTracking
local FFlagAXResetAvatarButton = AvatarExperienceFlags.FFlagAXResetAvatarButton
local AvatarScreen = require(AvatarExperienceAnalyticsParent.AvatarExperienceNavigation).Enums.AvatarScreen

function mapAvatarScreenToSurface(str1: string)
    local homepage = ImpressionEnums.MarketplaceSurfaceType.HOMEPAGE
    if str1 == AvatarScreen.Catalog then
        return ImpressionEnums.MarketplaceSurfaceType.HOMEPAGE
    end

    if str1 == AvatarScreen.CatalogSearch then
        return ImpressionEnums.MarketplaceSurfaceType.SEARCH
    end

    if str1 == AvatarScreen.AvatarEditor then
        homepage = ImpressionEnums.MarketplaceSurfaceType.MARKETPLACE_USER_INVENTORY
    end
    return homepage
end

return {
    trackSlotClick = function(tbl1)
        local tbl2 = {
            actionType = ImpressionEnums.ActionType.UI_BUTTON_CLICK,
            subcategory = tbl1.editorSubcategory,
            surface = ImpressionEnums.MarketplaceSurfaceType.MARKETPLACE_USER_INVENTORY
        }
        AnalyticsService.EventStream:sendTelemetryEvent("SlotBasedEditor", "marketplaceOrganicFELog", tbl2)
    end,
    trackSaveClick = function()
        local tbl1 = {
            actionType = ImpressionEnums.ActionType.UI_BUTTON_CLICK,
            group = "SaveAvatarButton",
            surface = ImpressionEnums.MarketplaceSurfaceType.MARKETPLACE_USER_INVENTORY
        }
        AnalyticsService.EventStream:sendTelemetryEvent("SlotBasedEditor", "marketplaceOrganicFELog", tbl1)
    end,
    trackControlBarClick = function(str1: string)
        local tbl1 = {
            actionType = ImpressionEnums.ActionType.UI_BUTTON_CLICK,
            group = `ControlBar_{str1}`,
            surface = ImpressionEnums.MarketplaceSurfaceType.MARKETPLACE_USER_INVENTORY
        }
        AnalyticsService.EventStream:sendTelemetryEvent("SlotBasedEditor", "marketplaceOrganicFELog", tbl1)
    end,
    trackAdvancedCustomizationControlBarClick = function(str1: string)
        local tbl1 = {
            actionType = ImpressionEnums.ActionType.UI_BUTTON_CLICK,
            group = `ControlBar_AdvancedCustomization_{str1}`,
            surface = ImpressionEnums.MarketplaceSurfaceType.MARKETPLACE_USER_INVENTORY
        }
        AnalyticsService.EventStream:sendTelemetryEvent("SlotBasedEditor", "marketplaceOrganicFELog", tbl1)
    end,
    trackAdvancedCustomizationControlBarClickFromSurface = function(str1: string, str2: string)
        local surface = mapAvatarScreenToSurface(str2)

        local tbl1 = {
            actionType = ImpressionEnums.ActionType.UI_BUTTON_CLICK,
            group = `ControlBar_AdvancedCustomization_{str1}`,
            surface = surface
        }
        AnalyticsService.EventStream:sendTelemetryEvent("SlotBasedEditor", "marketplaceOrganicFELog", tbl1)
    end,
    trackSaveBlockPromptLeaveClick = function()
        local tbl1 = {
            actionType = ImpressionEnums.ActionType.UI_BUTTON_CLICK,
            group = "SaveAvatarBlockPrompt_Leave",
            surface = ImpressionEnums.MarketplaceSurfaceType.MARKETPLACE_USER_INVENTORY
        }
        AnalyticsService.EventStream:sendTelemetryEvent("SlotBasedEditor", "marketplaceOrganicFELog", tbl1)
    end,
    trackSaveBlockPromptSaveClick = function()
        local tbl1 = {
            actionType = ImpressionEnums.ActionType.UI_BUTTON_CLICK,
            group = "SaveAvatarBlockPrompt_Save",
            surface = ImpressionEnums.MarketplaceSurfaceType.MARKETPLACE_USER_INVENTORY
        }
        AnalyticsService.EventStream:sendTelemetryEvent("SlotBasedEditor", "marketplaceOrganicFELog", tbl1)
    end,
    trackUndoRedoClick = function(bool1: boolean, str1: string?)
        local str2 = if bool1 then "Undo" else "Redo"
        local var1 = if FFlagAXExtendUndoRedoTracking and str1 then mapAvatarScreenToSurface(str1) else ImpressionEnums.MarketplaceSurfaceType.MARKETPLACE_USER_INVENTORY
        local tbl1 = {
            actionType = ImpressionEnums.ActionType.UI_BUTTON_CLICK,
            group = `UndoRedo_{str2}`,
            surface = 0
        }

        if not FFlagAXExtendUndoRedoTracking then
            var1 = ImpressionEnums.MarketplaceSurfaceType.MARKETPLACE_USER_INVENTORY
        end

        tbl1.surface = var1

        AnalyticsService.EventStream:sendTelemetryEvent("SlotBasedEditor", "marketplaceOrganicFELog", tbl1)
    end,
    trackSlotsCustomizeFtuxPrompt = function()
        local tbl1 = {
            actionType = ImpressionEnums.ActionType.UI_BUTTON_CLICK,
            group = "SlotsCustomizeFtuxPrompt",
            surface = ImpressionEnums.MarketplaceSurfaceType.MARKETPLACE_USER_INVENTORY
        }
        AnalyticsService.EventStream:sendTelemetryEvent("SlotBasedEditor", "marketplaceOrganicFELog", tbl1)
    end,
    trackSlotsAvatarSwitcherFtuxPrompt = function()
        local tbl1 = {
            actionType = ImpressionEnums.ActionType.UI_BUTTON_CLICK,
            group = "SlotsAvatarSwitcherFtuxPrompt",
            surface = ImpressionEnums.MarketplaceSurfaceType.MARKETPLACE_USER_INVENTORY
        }
        AnalyticsService.EventStream:sendTelemetryEvent("SlotBasedEditor", "marketplaceOrganicFELog", tbl1)
    end,
    trackAddNewAvatarClick = function()
        local tbl1 = {
            actionType = ImpressionEnums.ActionType.UI_BUTTON_CLICK,
            group = "AvatarSwitcher_AddNewAvatar",
            surface = ImpressionEnums.MarketplaceSurfaceType.MARKETPLACE_USER_INVENTORY
        }
        AnalyticsService.EventStream:sendTelemetryEvent("SlotBasedEditor", "marketplaceOrganicFELog", tbl1)
    end,
    trackUpdateAvatarClick = function()
        local tbl1 = {
            actionType = ImpressionEnums.ActionType.UI_BUTTON_CLICK,
            group = "AvatarSwitcher_UpdateAvatar",
            surface = ImpressionEnums.MarketplaceSurfaceType.MARKETPLACE_USER_INVENTORY
        }
        AnalyticsService.EventStream:sendTelemetryEvent("SlotBasedEditor", "marketplaceOrganicFELog", tbl1)
    end,
    trackManageAvatarsClick = function()
        local tbl1 = {
            actionType = ImpressionEnums.ActionType.UI_BUTTON_CLICK,
            group = "AvatarSwitcher_ManageAvatars",
            surface = ImpressionEnums.MarketplaceSurfaceType.MARKETPLACE_USER_INVENTORY
        }
        AnalyticsService.EventStream:sendTelemetryEvent("SlotBasedEditor", "marketplaceOrganicFELog", tbl1)
    end,
    trackDeleteAvatarAttemptClick = function(bool1: boolean)
        local tbl1 = {
            actionType = ImpressionEnums.ActionType.UI_BUTTON_CLICK,
            group = if bool1 then "AvatarSwitcher_DeleteAvatar_Attempt_Mass" else "AvatarSwitcher_DeleteAvatar_Attempt_Single",
            surface = ImpressionEnums.MarketplaceSurfaceType.MARKETPLACE_USER_INVENTORY
        }
        AnalyticsService.EventStream:sendTelemetryEvent("SlotBasedEditor", "marketplaceOrganicFELog", tbl1)
    end,
    trackDeleteAvatarConfirm = function()
        local tbl1 = {
            actionType = ImpressionEnums.ActionType.UI_BUTTON_CLICK,
            group = "AvatarSwitcher_DeleteAvatar_Confirm",
            surface = ImpressionEnums.MarketplaceSurfaceType.MARKETPLACE_USER_INVENTORY
        }
        AnalyticsService.EventStream:sendTelemetryEvent("SlotBasedEditor", "marketplaceOrganicFELog", tbl1)
    end,
    trackSettingsTileClick = function()
        local tbl1 = {
            actionType = ImpressionEnums.ActionType.UI_BUTTON_CLICK,
            group = "AvatarSwitcher_SettingsTile",
            surface = ImpressionEnums.MarketplaceSurfaceType.MARKETPLACE_USER_INVENTORY
        }
        AnalyticsService.EventStream:sendTelemetryEvent("SlotBasedEditor", "marketplaceOrganicFELog", tbl1)
    end,
    trackUndoHistoryCount = FFlagAXExtendUndoRedoTracking and function(str1: string, num1: number) -- name: trackUndoHistoryCount
        local surface = mapAvatarScreenToSurface(str1)

        local tbl1 = {
            actionType = ImpressionEnums.ActionType.UI_BUTTON_CLICK,
            group = `UndoRedo_history_count_{num1}`,
            surface = surface
        }
        AnalyticsService.EventStream:sendTelemetryEvent("SlotBasedEditor", "marketplaceOrganicFELog", tbl1)
    end or nil,
    trackAvatarRemoveAllClick = FFlagAXResetAvatarButton and function(str1: string) -- name: trackAvatarRemoveAllClick
        local surface = mapAvatarScreenToSurface(str1)

        local tbl1 = {
            actionType = ImpressionEnums.ActionType.UI_BUTTON_CLICK,
            group = "AvatarRemoveAll",
            surface = surface
        }
        AnalyticsService.EventStream:sendTelemetryEvent("SlotBasedEditor", "marketplaceOrganicFELog", tbl1)
    end or nil,
    trackAvatarRestoreClick = FFlagAXResetAvatarButton and function(str1: string) -- name: trackAvatarRestoreClick
        local surface = mapAvatarScreenToSurface(str1)

        local tbl1 = {
            actionType = ImpressionEnums.ActionType.UI_BUTTON_CLICK,
            group = "AvatarRestoreSaved",
            surface = surface
        }
        AnalyticsService.EventStream:sendTelemetryEvent("SlotBasedEditor", "marketplaceOrganicFELog", tbl1)
    end or nil
}
