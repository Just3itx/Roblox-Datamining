-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T02:11:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalog = script:FindFirstAncestor("AvatarExperienceCatalog")

local createMakeupLook = require(AvatarExperienceCatalog.Api.CreateMakeupLook.createMakeupLook)
local AvatarExperienceCatalogParent = AvatarExperienceCatalog.Parent
local AvatarExperienceCommon = require(AvatarExperienceCatalogParent.AvatarExperienceCommon)
local AvatarExperienceFlags = require(AvatarExperienceCatalogParent.AvatarExperienceFlags)
local AvatarExperienceAnalytics = require(AvatarExperienceCatalogParent.AvatarExperienceAnalytics)
local PerformFetch = require(AvatarExperienceCatalogParent.Http).PerformFetch
local Promise = require(AvatarExperienceCatalogParent.Promise)
local ToastRodux = require(AvatarExperienceCatalogParent.ToastRodux)
local mutedError = require(AvatarExperienceCatalogParent.Loggers).mutedError
local Constants = AvatarExperienceCommon.Constants

local AVATAR_EDITOR_CONSTANTS = AvatarExperienceCommon.Constants.AVATAR_EDITOR_CONSTANTS
local ToastType = ToastRodux.Enums.ToastType
local SetCurrentToastMessage = ToastRodux.Actions.SetCurrentToastMessage
local isMakeupOrEyebrowEyelashAssetType = AvatarExperienceCommon.Utils.isMakeupOrEyebrowEyelashAssetType

local Constants2 = AvatarExperienceAnalytics.Constants
local AVATAR_EDITOR_SERVICE_COUNTER_STATUS = Constants2.AVATAR_EDITOR_SERVICE_COUNTER_STATUS

local reportAvatarEventCounterNoAnalyticsArgument = AvatarExperienceAnalytics.reportAvatarEventCounterNoAnalyticsArgument
local reportAvatarEditorServiceCounter = AvatarExperienceAnalytics.reportAvatarEditorServiceCounter
local reportAvatarEventCounterV1 = AvatarExperienceAnalytics.reportAvatarEventCounterV1

local FIntAXLookOutfitCreationDelayMs = AvatarExperienceFlags.FIntAXLookOutfitCreationDelayMs
local FFlagAXMISSaveWearFix = AvatarExperienceFlags.FFlagAXMISSaveWearFix
local FFlagAXAvatarEditorServiceTelemetryV2 = AvatarExperienceFlags.FFlagAXAvatarEditorServiceTelemetryV2

local FFlagAXDeprecateAvatarEditorServiceTelemetryV1 = AvatarExperienceFlags.FFlagAXDeprecateAvatarEditorServiceTelemetryV1

local tbl1 = {
    toastMessage = "Feature.Avatar.Message.UnknownErrorCreatingMakeupLook",
    isLocalized = false,
    toastType = ToastType.InformationMessage
}

return function(arg1, name, arg3, callback: ((...any) -> (...any))?, func1: ((...any) -> (...any))?)
    return PerformFetch.Single(AVATAR_EDITOR_CONSTANTS.CreateMakeupLookKey, function(arg4)
        local state = arg4:getState()
        local bodyColor3s = state.AvatarExperience.AvatarEditor.Character.BodyColor3s
        local avatarScales = state.AvatarExperience.AvatarEditor.Character.AvatarScales
        local avatarType = state.AvatarExperience.AvatarEditor.Character.AvatarType
        local equippedAssets = if FFlagAXMISSaveWearFix then state.AvatarExperience.AvatarEditor.Character.EquippedAssets else nil
        local tbl2 = ({})
        for k, bodyColor3 in bodyColor3s do
            tbl2[k] = bodyColor3:ToHex()
        end

        local assets = {}
        for _, value in arg3 do
            if not (value.itemSubType and isMakeupOrEyebrowEyelashAssetType(value.itemSubType) and value.selectedInTryOnManager) then
                continue
            end
            table.insert(assets, { id = tonumber(value.itemId), meta = { order = value.order, version = tonumber(value.version) } })
        end

        if #assets == 0 then
            mutedError("SaveAsMakeupLookThunk: No valid makeup assets to save")
            return Promise.resolve()
        end

        if FFlagAXMISSaveWearFix and func1 then
            local var1 = func1(state, arg3)

            local tbl4 = {}
            if var1 then
                for _, child in var1:GetChildren() do
                    if child:IsA("MakeupDescription") then
                        local assetId = child.assetId
                        tbl4[tostring(assetId)] = child.order
                    end
                end
            end

            for value, _ in Constants.ASSET_TYPE_ID_STRING_TO_MAKEUP_TYPE do
                if not (equippedAssets and equippedAssets[value]) then
                    continue
                end

                for id, value3 in equippedAssets[value] do
                    if tbl4[id] == nil then
                        continue
                    end

                    table.insert(assets, { id = id, meta = { order = tbl4[id], version = tonumber(value3.version) } })
                end
            end
        end

        local tbl4 = {
            name = name,
            bodyColor3s = tbl2,
            assets = assets,
            scale = avatarScales,
            playerAvatarType = avatarType,
            outfitType = "Makeup"
        }

        task.spawn(function()
            task.wait(FIntAXLookOutfitCreationDelayMs / 1000)

            if FFlagAXAvatarEditorServiceTelemetryV2 then
                reportAvatarEditorServiceCounter(
                    Constants2.AVATAR_EDITOR_SERVICE_EVENTS.CreateMakeupLook,
                    AVATAR_EDITOR_SERVICE_COUNTER_STATUS.Request
                )
            end

            local var1, _ = createMakeupLook(arg1, tbl4)

            return var1:andThen(function(_)
                if FFlagAXAvatarEditorServiceTelemetryV2 then
                    reportAvatarEditorServiceCounter(
                        Constants2.AVATAR_EDITOR_SERVICE_EVENTS.CreateMakeupLook,
                        AVATAR_EDITOR_SERVICE_COUNTER_STATUS.Success
                    )
                end
                if callback then
                    callback()
                end

                reportAvatarEventCounterV1(Constants2.AVATAR_EVENT_COUNTER_NAME.AXCreateMakeupLook)
            end):catch(function(arg5)
                warn("Failed to create makeup look", arg5)
                arg4:dispatch(SetCurrentToastMessage(tbl1))

                if not FFlagAXDeprecateAvatarEditorServiceTelemetryV1 then
                    reportAvatarEventCounterNoAnalyticsArgument(Constants2.AVATAR_EDITOR_SERVICE_ERRORS.CreateOutfit)
                end

                if FFlagAXAvatarEditorServiceTelemetryV2 then
                    local httpError = if typeof(arg5) == "table" and typeof(arg5.HttpError) == "EnumItem" then arg5.HttpError else nil
                    reportAvatarEditorServiceCounter(
                        Constants2.AVATAR_EDITOR_SERVICE_EVENTS.CreateMakeupLook,
                        AVATAR_EDITOR_SERVICE_COUNTER_STATUS.Error,
                        httpError
                    )
                end
            end)
        end)

        return Promise.resolve()
    end)
end
