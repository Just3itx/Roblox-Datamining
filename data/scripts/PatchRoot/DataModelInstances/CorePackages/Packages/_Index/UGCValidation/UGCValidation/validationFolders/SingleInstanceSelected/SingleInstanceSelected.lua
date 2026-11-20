-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:10:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local Constants = require(scriptParentParentParent.Constants)
local _Types = require(scriptParentParentParent.util.Types)
local module = {}

local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)

local getEngineFeatureEngineUGCValidateInstanceTreesEquivalent = require(scriptParentParentParent.flags.getEngineFeatureEngineUGCValidateInstanceTreesEquivalent)

local UGCValidationService = game:GetService("UGCValidationService")

module.categories = Constants.AllAssetUploadCategories
module.requiredData = { ValidationEnums.SharedDataMember.entrypointInput, ValidationEnums.SharedDataMember.consumerConfig, ValidationEnums.SharedDataMember.uploadEnum }

local function deepEquals(expectedTree: Instance, candidateTree: Instance, backend) -- Luacid: Inlined by compiler; 1 call site recovered
    if getEngineFeatureEngineUGCValidateInstanceTreesEquivalent() and backend == ValidationEnums.ConsumerEnv.Backend then
        return UGCValidationService:AreInstanceTreesEquivalent(expectedTree, candidateTree)
    end
    return true
end

local function getFoldersMapping(entrypointInput)
    local tbl1 = { R15ArtistIntent = true, R15Fixed = true, R6 = true }

    local foldersMapping = {}

    for _, value in entrypointInput do
        if value:IsA("Folder") and tbl1[value.Name] then
            foldersMapping[value.Name] = value
        end
    end

    return foldersMapping
end

function module.run(arg1, arg2)
    local entrypointInput = arg2.entrypointInput
    local consumerConfig = arg2.consumerConfig
    local assetType = arg2.uploadEnum.assetType

    if not Constants.AssetUploadsWithFolderStructure[assetType] or not consumerConfig.enforceR15FolderStructure then
        if #entrypointInput ~= 1 then
            arg1:fail(ErrorSourceStrings.Keys.SelectionCountNotOne)
        end

        return
    end

    if #entrypointInput ~= 3 then
        arg1:fail(ErrorSourceStrings.Keys.FolderStructureMismatch)
        return
    end

    local foldersMapping = getFoldersMapping(entrypointInput)

    if not foldersMapping.R15ArtistIntent
        or not foldersMapping.R15Fixed
        or not foldersMapping.R6
        or #foldersMapping.R6:GetChildren() ~= 0
        or not deepEquals(foldersMapping.R15ArtistIntent, foldersMapping.R15Fixed, consumerConfig.consumerEnv)
    then
        arg1:fail(ErrorSourceStrings.Keys.FolderStructureMismatch)
    end
end

return module
