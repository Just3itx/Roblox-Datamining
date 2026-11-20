-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:11:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local validateAccurateBoundingBoxRasterMethod = require(scriptParentParent.validation.validateAccurateBoundingBoxRasterMethod)

local module = {}

function module.getBoundsViewsForAssetType(arg1)
    return validateAccurateBoundingBoxRasterMethod.getBoundsViewsForAssetType(arg1)
end

function module.validate(arg1, arg2, arg3)
    return validateAccurateBoundingBoxRasterMethod.validate(arg1, arg2, arg3)
end

return module
