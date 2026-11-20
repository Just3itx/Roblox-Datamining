-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:41:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local Analytics = require(scriptParentParent.Analytics)
local Constants = require(scriptParentParent.Constants)

local validateSingleInstance = require(scriptParentParent.validation.validateSingleInstance)
local validateAssetCreator = require(scriptParentParent.validation.validateAssetCreator)
local ParseContentIds = require(scriptParentParent.util.ParseContentIds)

local _Types = require(scriptParentParent.util.Types)

local function validatePackage(arg1)
    assert(arg1.instances ~= nil, "instances required in validationContext for validatePackage")
    local instances = arg1.instances
    local restrictedUserIds = arg1.restrictedUserIds

    local var1, var2 = validateSingleInstance(instances, arg1)
    if not var1 then
        return var1, var2
    end

    local var3 = instances[1]
    local tbl1 = {}
    local tbl2 = {}

    if not restrictedUserIds or #restrictedUserIds == 0 then
        return true
    end

    if ParseContentIds.parseWithErrorCheck(tbl1, tbl2, var3, Constants.PACKAGE_CONTENT_ID_FIELDS, nil, arg1) then
        return validateAssetCreator(tbl2, arg1)
    end

    Analytics.reportFailure(Analytics.ErrorType.validatePackage_FailedToParse, nil, arg1)
    return false, { string.format(
            "Failed to parse package data for model '%s'. Make sure the packageId is valid and try again.",
            var3:GetFullName()
        ) }
end

return validatePackage
