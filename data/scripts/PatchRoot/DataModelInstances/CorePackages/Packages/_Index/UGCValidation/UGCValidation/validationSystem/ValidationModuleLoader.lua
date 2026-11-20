-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:20:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local _Types = require(scriptParentParent.util.Types)
local ValidationEnums = require(scriptParentParent.validationSystem.ValidationEnums)
local getFFlagUGCValidateAQSRequiresOnlySummary = require(scriptParentParent.flags.getFFlagUGCValidateAQSRequiresOnlySummary)

local validationFolders = scriptParentParent.validationFolders
local assetQualityFolders = scriptParentParent.assetQualityFolders

local module = {}
local tbl1 = {
    ValidationEnums.SharedDataMember.aqsSummaryData,
    ValidationEnums.SharedDataMember.renderMeshesData,
    ValidationEnums.SharedDataMember.innerCagesData,
    ValidationEnums.SharedDataMember.outerCagesData,
    ValidationEnums.SharedDataMember.meshTextures
}

local tbl2 = ({})
for _, value in ValidationEnums.ValidationModule do
    tbl2[value] = validationFolders
end
for _, value in ValidationEnums.AssetQualityCheck do
    tbl2[value] = assetQualityFolders
end

local tbl3 = ({})
for k, ValidationEnum in ValidationEnums do
    tbl3[k] = {}
    if typeof(ValidationEnum) ~= "table" then
        continue
    end

    for value, _ in ValidationEnum do
        tbl3[k][value] = true
    end
end

local function tableOnlyHasExistingEnums(str1: string, tbl4, str2: string)
    if typeof(tbl4) ~= "table" then
        error(`Invalid config option {str2} inside of {str1} - expected to be table`)
    end

    for _, value in tbl4 do
        if not tbl3[str2][value] then
            error(`Invalid config option {value} in {str2} inside of {str1}`)
        end
    end
end

local function defaultFlagCheck(): boolean
    return true
end

local function defaultShadowCheck(): boolean
    return false
end

local allModules = ({})
for value, value2 in tbl2 do
    local var1 = value2:FindFirstChild(value)
    if var1 == nil then
        error(`{value} validation folder is missing from {value2.Name}`)
    end

    local var2 = var1:FindFirstChild(value)
    if var2 == nil or not var2:IsA("ModuleScript") then
        error(`{value}.lua validation file is missing from {value2.Name}/{value}`)
    end

    local var3 = require(var2)

    for value3, _ in var3 do
        if typeof(value3) ~= "string" then
            error(`{value}.lua contains non-string key {tostring(value3)}`)
        elseif not tbl3.ValidationConfig[value3] then
            error(
                `{value}.lua contains unexpected member {value3}. Check for typos or add an extra ValidationEnums.ValidationConfig`
            )
        end
    end

    var3.fflag = var3.fflag or defaultFlagCheck
    var3.shadowFlag = var3.shadowFlag or defaultShadowCheck
    var3.categories = var3.categories or {}
    var3.requiredData = var3.requiredData or {}
    var3.conditionalData = var3.conditionalData or {}
    var3.prereqTests = var3.prereqTests or {}
    var3.expectedFailures = var3.expectedFailures or {}
    var3.knownAqsUserErrors = var3.knownAqsUserErrors or {}

    var3.isAssetQualityModule = value2 == assetQualityFolders

    if var3.isAssetQualityModule then
        for _, value3 in getFFlagUGCValidateAQSRequiresOnlySummary() and { ValidationEnums.SharedDataMember.aqsSummaryData } or tbl1 do
            if not table.find(var3.requiredData, value3) then
                table.insert(var3.requiredData, value3)
            end
        end
    end

    if var3.run == nil or typeof(var3.run) ~= "function" then
        error(`Missing module run function in {value}`)
    end

    setmetatable(var3, {
        __index = function(_, arg1)
            error(`Invalid ValidationConfig {arg1} used on the module {value}`)
        end
    })

    local fflag = var3.fflag

    if typeof(fflag) ~= "function" or typeof(var3.fflag()) ~= "boolean" then
        error(`Invalid FFlag config in {value}`)
    end
    local shadowFlag = var3.shadowFlag

    if typeof(shadowFlag) ~= "function" or typeof(var3.shadowFlag()) ~= "boolean" then
        error(`Invalid shadowFlag config in {value}`)
    end

    tableOnlyHasExistingEnums(value, var3.categories, "UploadCategory")
    tableOnlyHasExistingEnums(value, var3.requiredData, "SharedDataMember")
    tableOnlyHasExistingEnums(value, var3.conditionalData, "SharedDataMember")
    tableOnlyHasExistingEnums(value, var3.prereqTests, "ValidationModule")

    allModules[value] = var3
end

module.allModules = allModules

function module.getValidationModule(str1: string)
    if allModules[str1] == nil then
        error(`{str1} does not exist in the preload table.`)
    end

    return allModules[str1]
end

return module
