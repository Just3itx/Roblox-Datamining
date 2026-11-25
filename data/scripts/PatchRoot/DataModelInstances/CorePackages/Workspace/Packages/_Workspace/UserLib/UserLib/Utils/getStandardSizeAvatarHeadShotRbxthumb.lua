-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T20:21:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local getRbxthumbWithTypeSizeAndOptions = require(script.Parent.getRbxthumbWithTypeSizeAndOptions)
local Constants = require(script.Parent.Constants)

return function(str1: string, bool1: boolean?)
    return getRbxthumbWithTypeSizeAndOptions(str1, Constants.RbxthumbTypes.AvatarHeadShot, 150, nil, nil, bool1)
end
