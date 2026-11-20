-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T16:21:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)

local module = {
    categories = {
        ValidationEnums.UploadCategory.FULL_BODY,
        ValidationEnums.UploadCategory.LAYERED_CLOTHING,
        ValidationEnums.UploadCategory.EYEBROW_EYELASH,
        ValidationEnums.UploadCategory.RIGID_ACCESSORY,
        ValidationEnums.UploadCategory.DYNAMIC_HEAD
    },
    fflag = require(scriptParentParentParent.flags.getFFlagUGCValidateAQTextureQuality)
}
function module.run(arg1, arg2)
    local measureTextureComplexity = arg2.aqsSummaryData.Measure_Texture_Complexity
    if measureTextureComplexity == nil then
        arg1:warn(ErrorSourceStrings.Keys.AQSWarn_MissingData, { measureName = "Measure_Texture_Complexity" })

        return
    end
    for textureName, value2 in measureTextureComplexity do
        if textureName == "measurement_score" then
            continue
        end

        if value2 == nil or value2.score == nil then
            arg1:warn(ErrorSourceStrings.Keys.AQSWarn_MissingData, { measureName = "Measure_Texture_Complexity" })

            return
        end
        if tonumber(value2.score) ~= 100 then
            arg1:warn(ErrorSourceStrings.Keys.AQSWarn_TextureComplexity, { textureName = textureName })
        end
    end
end

return module
