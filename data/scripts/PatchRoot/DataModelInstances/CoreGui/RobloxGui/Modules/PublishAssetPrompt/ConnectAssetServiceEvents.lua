-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:11:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AssetService = game:GetService("AssetService")
local AvatarCreationService = game:GetService("AvatarCreationService")
local ExperienceAuthService = game:GetService("ExperienceAuthService")
local RobloxReplicatedStorage = game:GetService("RobloxReplicatedStorage")
local CorePackages = game:GetService("CorePackages")

local scriptParent = script.Parent
local OpenPublishAssetPrompt = require(scriptParent.Thunks.OpenPublishAssetPrompt)
local OpenPublishAvatarPrompt = require(scriptParent.Thunks.OpenPublishAvatarPrompt)
local OpenPublishAvatarAssetPrompt = require(scriptParent.Thunks.OpenPublishAvatarAssetPrompt)
local OpenPublishMakeupLookPrompt = require(scriptParent.Thunks.OpenPublishMakeupLookPrompt)
local OpenResultModal = require(scriptParent.Thunks.OpenResultModal)
local SetHumanoidModel = require(scriptParent.Actions.SetHumanoidModel)
local SetAccessoryInstance = require(scriptParent.Actions.SetAccessoryInstance)
local SetPriceInRobux = require(scriptParent.Actions.SetPriceInRobux)
local OpenValidationErrorModal = require(scriptParent.Actions.OpenValidationErrorModal)
local PublishAssetAnalytics = require(CorePackages.Workspace.Packages.PurchasePrompt).PublishAssetAnalytics

local GetFFlagUploadMakeupSupport = require(scriptParent.Flags.GetFFlagUploadMakeupSupport)

local FFlagPublishAssetPromptItemDetailsTelemetry = require(scriptParent.Flags.FFlagPublishAssetPromptItemDetailsTelemetry)

local engineFeature = game:GetEngineFeature("PromptImportAnimationClipFromVideoAsyncEnabled")

local function updateModelAttachmentsWithWrapDeformers(arg1: Instance)
    arg1.Parent = RobloxReplicatedStorage

    for _, child in arg1:GetChildren() do
        if not child:IsA("MeshPart") then
            continue
        end

        local wrapDeformer = child:FindFirstChildWhichIsA("WrapDeformer")
        if not wrapDeformer then
            continue
        end

        for _, child2 in child:GetChildren() do
            if child2:IsA("Attachment") then
                child2.CFrame = wrapDeformer:GetDeformedCFrameAsync(child2.CFrame)
            end
        end
    end
end

local function setAnalyticsItemDetails(metadata)
    if metadata.instanceToPublish or metadata.serializedInstance then
        PublishAssetAnalytics.setItemDetails(PublishAssetAnalytics.ItemType.Asset, metadata.assetType.Name)
    elseif metadata.outfitToPublish then
        PublishAssetAnalytics.setItemDetails(PublishAssetAnalytics.ItemType.Outfit, Enum.OutfitType.Avatar.Name)
    elseif metadata.makeupLookToPublish then
        PublishAssetAnalytics.setItemDetails(PublishAssetAnalytics.ItemType.Outfit, Enum.OutfitType.Makeup.Name)
    elseif metadata.accessoryToPublish then
        PublishAssetAnalytics.setItemDetails(PublishAssetAnalytics.ItemType.Asset, metadata.accessoryType.Name)
    end
end

local function ConnectAssetServiceEvents(arg1)
    local result = {}

    local openAuthPrompt = ExperienceAuthService.OpenAuthPrompt

    table.insert(result, openAuthPrompt:Connect(function(guid: string, scopes, metadata)
        local isVideoToAnimationFlow = engineFeature and metadata.isVideoToAnimationFlow

        if #scopes ~= 1 or scopes[1] ~= Enum.ExperienceAuthScope.CreatorAssetsCreate or isVideoToAnimationFlow then
            return
        end

        if FFlagPublishAssetPromptItemDetailsTelemetry then
            setAnalyticsItemDetails(metadata)
        end

        if metadata.instanceToPublish then
            arg1:dispatch(OpenPublishAssetPrompt(metadata.instanceToPublish, metadata.assetType, guid, scopes))
        elseif metadata.serializedInstance then
            local var1 = AssetService:DeserializeInstance(metadata.serializedInstance)
            arg1:dispatch(OpenPublishAssetPrompt(var1, metadata.assetType, guid, scopes))
        elseif metadata.outfitToPublish then
            arg1:dispatch(OpenPublishAvatarPrompt(guid, scopes))
        elseif GetFFlagUploadMakeupSupport() and metadata.makeupLookToPublish then
            local makeupEntries = metadata.makeupEntries
            arg1:dispatch(OpenPublishMakeupLookPrompt(guid, scopes, makeupEntries))
        elseif metadata.accessoryToPublish then
            local accessoryType = metadata.accessoryType
            arg1:dispatch(OpenPublishAvatarAssetPrompt(accessoryType, guid, scopes))
        end
    end))

    local openPublishResultModal = AssetService.OpenPublishResultModal

    table.insert(result, openPublishResultModal:Connect(function(resultType: Enum.PromptCreatePlatformContentResult)
        arg1:dispatch(OpenResultModal(resultType))
    end))

    local function checkNewEventsExist(): RBXScriptSignal
        return AvatarCreationService.UgcValidationSuccess and AvatarCreationService.UgcValidationFailure
    end

    if pcall(checkNewEventsExist) then
        local ugcValidationSuccess = AvatarCreationService.UgcValidationSuccess

        table.insert(result, ugcValidationSuccess:Connect(function(guid: string, serializedModel: string, price: number)
            local state = arg1:getState()
            if state
                and (state.promptRequest.promptInfo.promptType == "PublishAvatarAsset"
                    or GetFFlagUploadMakeupSupport() and state.promptRequest.promptInfo.promptType == "PublishMakeupLook")
            then
                local var1 = AvatarCreationService:DeserializeAvatarModel(serializedModel)
                arg1:dispatch(SetAccessoryInstance(var1))

                if price then
                    arg1:dispatch(SetPriceInRobux(price))
                end

                return
            end

            if state and state.promptRequest.promptInfo.guid == guid then
                local var1 = AvatarCreationService:DeserializeAvatarModel(serializedModel)

                updateModelAttachmentsWithWrapDeformers(var1)

                arg1:dispatch(SetHumanoidModel(var1))
                arg1:dispatch(SetPriceInRobux(price))
            end
        end))
    end

    if pcall(checkNewEventsExist) then
        local ugcValidationFailure = AvatarCreationService.UgcValidationFailure

        table.insert(result, ugcValidationFailure:Connect(function(guid: string, errorMessage: string)
            local state = arg1:getState()

            if state and state.promptRequest.promptInfo.guid == guid then
                arg1:dispatch(OpenValidationErrorModal(errorMessage))
            end
        end))
    end

    return result
end

return ConnectAssetServiceEvents
