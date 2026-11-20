-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:41:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local Analytics = require(scriptParentParent.Analytics)
local Constants = require(scriptParentParent.Constants)

local validateMeshPartBodyPart = require(scriptParentParent.validation.validateMeshPartBodyPart)
local validateTags = require(scriptParentParent.validation.validateTags)

local FailureReasonsAccumulator = require(scriptParentParent.util.FailureReasonsAccumulator)
local createLimbsAndTorsoSchema = require(scriptParentParent.util.createLimbsAndTorsoSchema)
local _Types = require(scriptParentParent.util.Types)

local function getInstance(instances, name: string) -- Luacid: Inlined by compiler; 2 call sites recovered
    for _, value in pairs(instances) do
        if value.Name == name then
            return value
        end
    end
    return nil
end

local function areTopLevelFoldersCorrect(instances, tbl1)
    if #instances ~= #tbl1 then
        return false
    end
    for _, value in tbl1 do
        local instance = getInstance(instances, value)

        if not instance or instance.ClassName ~= "Folder" then
            return false
        end
    end
    return true
end

local function getFullNameWithoutRootFolder(arg1, str1: string): string -- Luacid: Inlined by compiler; 1 call site recovered
    local fullName = arg1:GetFullName()
    local var1, var2 = string.find(fullName, str1 .. "%.")
    assert(var1 and var2)
    return string.sub(fullName, var2 + 1, #fullName)
end

local function compareFolderInfo(arg1, arg2, arg3)
    local failureReasonsAccumulator = FailureReasonsAccumulator.new()

    for value, value2 in arg1 do
        if arg2[value] == nil or arg2[value] ~= value2 then
            Analytics.reportFailure(Analytics.ErrorType.validateLimbsAndTorso_FolderInfoMismatch, nil, arg3)

            failureReasonsAccumulator:updateReasons(false, { `Attribute {value} has different values in different children folders. You need to use the same value in all folders.` })
        end
    end

    return failureReasonsAccumulator:getFinalResults()
end

local function validateFolderAssetIdsMatch(instances, tbl1, arg1)
    if #tbl1 == 1 then
        return true
    end

    local var1 = nil
    local failureReasonsAccumulator = FailureReasonsAccumulator.new()

    for _, value in tbl1 do
        if value == Constants.FOLDER_NAMES.R6 then
            continue
        end

        local var2 = nil

        for _, value2 in pairs(instances) do
            if value2.Name == value then
                var2 = value2
                break
            end
        end

        assert(var2)

        local tbl2 = {}

        for _, descendant in var2:GetDescendants() do
            local var3 = Constants.CONTENT_ID_FIELDS[descendant.ClassName]
            if not var3 then
                continue
            end

            for _, value2 in var3 do
                tbl2[getFullNameWithoutRootFolder(descendant, value) .. "." .. value2] = descendant[value2]
            end
        end

        if not var1 then
            var1 = tbl2
        else
            failureReasonsAccumulator:updateReasons(compareFolderInfo(var1, tbl2, arg1))
            failureReasonsAccumulator:updateReasons(compareFolderInfo(tbl2, var1, arg1))
        end
    end

    return failureReasonsAccumulator:getFinalResults()
end

local function validateR6Folder(instance, assetTypeEnum, arg1)
    local failureReasonsAccumulator = FailureReasonsAccumulator.new()

    if #instance:GetChildren() > 0 then
        Analytics.reportFailure(Analytics.ErrorType.validateLimbsAndTorso_R6FolderHasChildren, nil, arg1)
        failureReasonsAccumulator:updateReasons(false, { string.format(
                "Deprecated R6 folder for '%s' should be empty. You need to clear that folder and try again.",
                assetTypeEnum.Name
            ) })
    end

    failureReasonsAccumulator:updateReasons(validateTags(instance, arg1))

    return failureReasonsAccumulator:getFinalResults()
end

local function validateLimbsAndTorso(arg1)
    assert(arg1.instances ~= nil, "instances required in validationContext for validateLimbsAndTorso")
    local instances = arg1.instances

    assert(arg1.assetTypeEnum ~= nil, "assetTypeEnum required in validationContext for validateLimbsAndTorso")

    local requireAllFolders = arg1.requireAllFolders
    local assetTypeEnum = arg1.assetTypeEnum

    local tbl1 = { Constants.FOLDER_NAMES.R15ArtistIntent }
    if requireAllFolders then
        table.insert(tbl1, Constants.FOLDER_NAMES.R15Fixed)
        table.insert(tbl1, Constants.FOLDER_NAMES.R6)
    end

    if not areTopLevelFoldersCorrect(instances, tbl1) then
        Analytics.reportFailure(Analytics.ErrorType.validateLimbsAndTorso_TopLevelFolders, nil, arg1)
        return false, { "Incorrect hierarchy for asset with the following missing folders: " .. table.concat(tbl1, ", ") }
    end

    for _, value in tbl1 do
        local instance = getInstance(instances, value)
        local var1, var2

        if value == Constants.FOLDER_NAMES.R6 then
            var1, var2 = validateR6Folder(instance, assetTypeEnum, arg1)
        else
            var1, var2 = validateMeshPartBodyPart(instance, createLimbsAndTorsoSchema(assetTypeEnum, value, arg1), arg1)
        end

        if not var1 then
            return var1, var2
        end
    end

    return validateFolderAssetIdsMatch(instances, tbl1, arg1)
end

return validateLimbsAndTorso
