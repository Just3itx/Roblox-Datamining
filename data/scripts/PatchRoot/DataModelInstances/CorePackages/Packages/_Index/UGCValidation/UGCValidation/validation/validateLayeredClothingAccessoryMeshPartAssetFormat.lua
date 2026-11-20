-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:41:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local _Types = require(scriptParentParent.util.Types)

local validateLayeredClothingAccessory = require(scriptParentParent.validation.validateLayeredClothingAccessory)

local validateLayeredClothingAccessoryMeshPartAssetFormatMatch = require(scriptParentParent.validation.validateLayeredClothingAccessoryMeshPartAssetFormatMatch)

local function validateLayeredClothingAccessoryMeshPartAssetFormat(arg1, arg2)
    assert(
        arg2.instances ~= nil,
        "instances required in validationContext for validateLayeredClothingAccessoryMeshPartAssetFormat"
    )

    local instances = arg2.instances

    local var1, var2 = validateLayeredClothingAccessory(arg2)
    if not var1 then
        return false, var2
    end

    local var3 = instances[1]

    local var4, var5 = validateLayeredClothingAccessoryMeshPartAssetFormatMatch(var3, arg1, arg2)

    if not var4 then
        return false, var5
    end

    return true
end

return validateLayeredClothingAccessoryMeshPartAssetFormat
