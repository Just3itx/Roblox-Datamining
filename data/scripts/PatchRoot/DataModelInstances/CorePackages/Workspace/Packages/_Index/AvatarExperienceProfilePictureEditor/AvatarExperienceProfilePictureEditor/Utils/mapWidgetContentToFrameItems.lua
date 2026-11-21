-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:50:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceProfilePictureEditor = script:FindFirstAncestor("AvatarExperienceProfilePictureEditor")
local AvatarExperienceProfilePictureEditorParent = AvatarExperienceProfilePictureEditor.Parent

local UserLib = require(AvatarExperienceProfilePictureEditorParent.UserLib)

local _profileFramesWidgetsApi = require(AvatarExperienceProfilePictureEditor.Api.profileFramesWidgetsApi)

local getRbxthumbWithTypeSizeAndOptions = UserLib.Utils.getRbxthumbWithTypeSizeAndOptions
local Constants = UserLib.Utils.Constants

local function getProfileFramePickerImage(str1: string) -- Luacid: Inlined by compiler; 1 call site recovered
    return getRbxthumbWithTypeSizeAndOptions(str1, Constants.RbxthumbTypes.Asset, 150)
end

local function getProfileFramePreviewImage(str1: string) -- Luacid: Inlined by compiler; 1 call site recovered
    return getRbxthumbWithTypeSizeAndOptions(str1, Constants.RbxthumbTypes.Asset, 420)
end

local function buildHydratedAssetLookup(arg1)
    local hydratedAssetLookup = {}
    if arg1 == nil then
        return hydratedAssetLookup
    end

    local hydratedContent = arg1.hydratedContent
    if hydratedContent == nil then
        return hydratedAssetLookup
    end

    for _, value in hydratedContent do
        if value.type == "Asset" then
            local id = value.id
            hydratedAssetLookup[tostring(id)] = value
        end
    end

    return hydratedAssetLookup
end

return {
    FRAME_PICKER_THUMB_SIZE = 150,
    FRAME_PREVIEW_THUMB_SIZE = 420,
    getProfileFramePickerImage = getProfileFramePickerImage,
    getProfileFramePreviewImage = getProfileFramePreviewImage,
    mapWidgetContentToFrameItems = function(tbl1, arg1)
        local result = {}
        local hydratedAssetLookup = buildHydratedAssetLookup(arg1)

        for _, value in tbl1 do
            if value.type ~= "Asset" then
                continue
            end

            local id = tostring(value.id)
            local var1 = hydratedAssetLookup[id]
            table.insert(result, {
                id = id,
                label = if var1 and var1.name then var1.name else nil,
                image = getProfileFramePickerImage(id),
                previewImage = getProfileFramePreviewImage(id)
            })
        end

        return result
    end
}
