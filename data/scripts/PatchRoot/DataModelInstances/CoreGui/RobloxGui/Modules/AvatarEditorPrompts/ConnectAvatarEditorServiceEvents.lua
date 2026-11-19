-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:11:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarEditorService = game:GetService("AvatarEditorService")
local CorePackages = game:GetService("CorePackages")

local scriptParent = script.Parent

local OpenPrompt = require(scriptParent.Actions.OpenPrompt)
local PromptType = require(scriptParent.PromptType)

local OpenSetFavoritePrompt = require(scriptParent.Thunks.OpenSetFavoritePrompt)
local OpenSaveAvatarPrompt = require(scriptParent.Thunks.OpenSaveAvatarPrompt)
local OpenDeleteOutfitPrompt = require(scriptParent.Thunks.OpenDeleteOutfitPrompt)
local OpenRenameOutfitPrompt = require(scriptParent.Thunks.OpenRenameOutfitPrompt)
local OpenUpdateOutfitPrompt = require(scriptParent.Thunks.OpenUpdateOutfitPrompt)

local AvatarExperienceCommon = require(CorePackages.Workspace.Packages.AvatarExperienceCommon)
local showSaveAvatarTimeoutFeatureRestriction = require(scriptParent.showSaveAvatarTimeoutFeatureRestriction)

local FFlagAXUseUFRForTimeoutPromptInExperience = require(CorePackages.Workspace.Packages.AvatarExperienceFlags).FFlagAXUseUFRForTimeoutPromptInExperience

local function ConnectAvatarEditorServiceEvents(arg1)
    local result = {}

    local openPromptSaveAvatar = AvatarEditorService.OpenPromptSaveAvatar

    table.insert(result, openPromptSaveAvatar:Connect(function(humanoidDescription: HumanoidDescription, rigType: Enum.HumanoidRigType)
        AvatarExperienceCommon.Stores.getTimeoutStatusStore().fetchStatusAsync():andThen(function(arg2)
            if not arg2.isTimedOut then
                arg1:dispatch(OpenSaveAvatarPrompt(humanoidDescription, rigType))

                return
            end

            if FFlagAXUseUFRForTimeoutPromptInExperience then
                showSaveAvatarTimeoutFeatureRestriction()
                return
            end
            arg1:dispatch(OpenPrompt(PromptType.SaveAvatarTimeout, {}))
        end)
    end))

    local openAllowInventoryReadAccess = AvatarEditorService.OpenAllowInventoryReadAccess

    table.insert(result, openAllowInventoryReadAccess:Connect(function()
        arg1:dispatch(OpenPrompt(PromptType.AllowInventoryReadAccess, {}))
    end))

    local openPromptCreateOufit = AvatarEditorService.OpenPromptCreateOufit

    table.insert(result, openPromptCreateOufit:Connect(function(humanoidDescription: HumanoidDescription, rigType: Enum.HumanoidRigType)
        arg1:dispatch(OpenPrompt(PromptType.CreateOutfit, { humanoidDescription = humanoidDescription, rigType = rigType }))
    end))

    local openPromptSetFavorite = AvatarEditorService.OpenPromptSetFavorite

    table.insert(result, openPromptSetFavorite:Connect(function(itemId: number, itemType: Enum.AvatarItemType, shouldFavorite: boolean)
        arg1:dispatch(OpenSetFavoritePrompt(itemId, itemType, shouldFavorite))
    end))

    local openPromptDeleteOutfit = AvatarEditorService.OpenPromptDeleteOutfit

    table.insert(result, openPromptDeleteOutfit:Connect(function(outfitId: number)
        arg1:dispatch(OpenDeleteOutfitPrompt(outfitId))
    end))

    local openPromptRenameOutfit = AvatarEditorService.OpenPromptRenameOutfit

    table.insert(result, openPromptRenameOutfit:Connect(function(outfitId: number)
        arg1:dispatch(OpenRenameOutfitPrompt(outfitId))
    end))

    local openPromptUpdateOutfit = AvatarEditorService.OpenPromptUpdateOutfit

    table.insert(result, openPromptUpdateOutfit:Connect(function(outfitId: number, humanoidDescription: HumanoidDescription, rigType: Enum.HumanoidRigType)
        arg1:dispatch(OpenUpdateOutfitPrompt(outfitId, humanoidDescription, rigType))
    end))

    return result
end

return ConnectAvatarEditorServiceEvents
