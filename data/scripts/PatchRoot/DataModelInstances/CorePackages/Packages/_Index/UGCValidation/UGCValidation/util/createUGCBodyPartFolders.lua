-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:21:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local _BundlesMetadata = require(scriptParentParent.util.BundlesMetadata)
local Constants = require(scriptParentParent.Constants)

local function getUGCBodyPartsAssetTypeMap(model: Model, arg1, str1: string)
    assert(model:IsA("Model"))

    local var1 = arg1[str1]
    if var1 == nil then
        return {}
    end

    local uGcBodyPartsAssetTypeMap = ({})

    for _, value in Constants.UGC_BODY_PARTS do
        local var2 = model:FindFirstChild(value)

        if var2 == nil then
            continue
        end

        local var3 = Constants.UGC_BODY_PART_NAMES_TO_ASSET_TYPE[value]
        assert(var3 ~= nil, "Body part doesn't map to an asset type")

        if var1.allowedAssetTypeSettings[var3.Name] == nil then
            continue
        end

        if uGcBodyPartsAssetTypeMap[var3] == nil then
            uGcBodyPartsAssetTypeMap[var3] = { var2 }
        else
            table.insert(uGcBodyPartsAssetTypeMap[var3], var2)
        end
    end

    return uGcBodyPartsAssetTypeMap
end

local function createUGCBodyPartFolders(arg1, arg2, str1: string, bool1: boolean?)
    assert(arg1:IsA("Model"), "Invalid root instance, must be a model")

    local uGcBodyPartFolders = ({})

    for value, value2 in (getUGCBodyPartsAssetTypeMap(arg1, arg2, str1)) do
        if table.find(Constants.ASSET_TYPES_THAT_SKIP_FOLDER, value) ~= nil then
            uGcBodyPartFolders[value] = value2
        else
            local folder = Instance.new("Folder")
            folder.Name = Constants.FOLDER_NAMES.R15ArtistIntent

            for _, value3 in value2 do
                value3.Parent = folder
            end
            uGcBodyPartFolders[value] = { folder }

            if bool1 then
                local folder2 = folder:Clone()
                folder2.Name = Constants.FOLDER_NAMES.R15Fixed
                table.insert(uGcBodyPartFolders[value], folder2)

                local folder3 = Instance.new("Folder")
                folder3.Name = Constants.FOLDER_NAMES.R6
                table.insert(uGcBodyPartFolders[value], folder3)
            end
        end
    end
    return uGcBodyPartFolders
end

return createUGCBodyPartFolders
