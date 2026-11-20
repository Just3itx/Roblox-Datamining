-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:01:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)
local UGCValidationService = game:GetService("UGCValidationService")
local num1 = game:DefineFastInt("UGCValidationMinimumHeadSizePercentAcrossFacs", 95)
local num2 = game:DefineFastInt("UGCValidationMaximumHeadSizePercentAcrossFacs", 120)

local module = {
    fflag = require(scriptParentParentParent.flags.getEngineFeatureEngineUGCValidateMinMaxMeshSizeAcrossAllFacs),
    categories = { ValidationEnums.UploadCategory.DYNAMIC_HEAD },
    requiredData = { ValidationEnums.SharedDataMember.renderMeshesData },
    expectedFailures = { "Asset_EF_HeadWithExpandingFacs", "Asset_EF_HeadWithShrinkingFacs" }
}
function module.run(arg1, arg2)
    local head = arg2.renderMeshesData.Head

    local var1, var2 = unpack(UGCValidationService:GetMinAndMaxMeshSizeAcrossAllFacs(head.editable))

    local var3 = 100 * var1 / head.originalSize
    local modPercent = math.floor(math.min(var3.X, var3.Y, var3.Z))
    if modPercent < num1 then
        arg1:fail(ErrorSourceStrings.Keys.FacsShrinksHead, { modPercent = modPercent })
    end

    local var4 = 100 * var2 / head.originalSize
    local num3 = math.ceil(math.max(var4.X, var4.Y, var4.Z))
    if num2 < num3 then
        arg1:fail(ErrorSourceStrings.Keys.FacsExpandsHead, { modPercent = num3 })
    end
end

return module
