-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:51:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local HttpService = game:GetService("HttpService")

local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)
local APIUtil = require(scriptParentParentParent.util.APIUtil)

local module = {
    categories = { ValidationEnums.UploadCategory.EMOTE_ANIMATION, ValidationEnums.UploadCategory.ANIMATION },
    requiredData = { ValidationEnums.SharedDataMember.consumerConfig },
    conditionalData = { ValidationEnums.SharedDataMember.curveAnimBoneData },
    expectedFailures = {},
    prereqTests = { ValidationEnums.ValidationModule.CurveAnimDataAvailable }
}
local function checkTrustedCreatorPermission()
    local str1 = string.format(
        "https://itemconfiguration.%s/v1/permissions/action-allowed-for-item-type?trustedCreatorCheck=true&action=1&assetType=61",
        APIUtil.getBaseDomain()
    )

    local var1, input = APIUtil.requestAndRetryGet(str1)
    if not var1 then
        return false, "Failed to check trusted creator permission: " .. tostring(input)
    end

    local success, result = pcall(function()
        return HttpService:JSONDecode(input)
    end)
    if not success then
        return false, "Failed to decode permission response"
    end

    return result.isActionAllowed == true, nil
end

function module.run(arg1, arg2)
    local validationEnv = arg2.consumerConfig.validationEnv

    if validationEnv == ValidationEnums.ValidationEnv.IEC then
        arg1:fail(ErrorSourceStrings.Keys.CurveAnim_BonesNotAllowed)
        return
    end

    if validationEnv == ValidationEnums.ValidationEnv.Backend then
        if not arg2.consumerConfig.backendConfigs.isUserInTrustedCreatorProgram then
            arg1:fail(ErrorSourceStrings.Keys.CurveAnim_BonesNotAllowed)
        end

        return
    end

    local bool1, var1 = checkTrustedCreatorPermission()
    if var1 then
        arg1:forceError(var1)
    end
    if not bool1 then
        arg1:fail(ErrorSourceStrings.Keys.CurveAnim_BonesNotAllowed)
    end
end

return module
