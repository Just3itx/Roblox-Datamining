-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:41:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local Analytics = require(scriptParentParent.Analytics)

local _Types = require(scriptParentParent.util.Types)

local function validateSingleInstance(tbl1, arg1)
    local assetTypeEnum = arg1.assetTypeEnum

    if #tbl1 == 0 then
        Analytics.reportFailure(Analytics.ErrorType.validateSingleInstance_ZeroInstances, nil, arg1)
        return false, { string.format(
                "Failed to find an instance of the asset type '%s'. Make sure one exists and try again.",
                assetTypeEnum.Name
            ) }
    end

    if not (#tbl1 > 1) then
        return true
    end

    Analytics.reportFailure(Analytics.ErrorType.validateSingleInstance_MultipleInstances, nil, arg1)
    return false, { string.format(
            "Selected more than one instance of type '%s'. Please, select a single instance of this type and try again.",
            assetTypeEnum.Name
        ) }
end

return validateSingleInstance
