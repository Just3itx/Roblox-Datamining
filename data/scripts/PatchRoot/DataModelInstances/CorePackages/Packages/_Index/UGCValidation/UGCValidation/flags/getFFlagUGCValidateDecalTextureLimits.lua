-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T16:41:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local getEngineUGCValidateAssetTextureLimits = require(scriptParentParent.flags.getEngineUGCValidateAssetTextureLimits)

game:DefineFastFlag("UGCValidateDecalTextureLimits", false)

return function()
    return getEngineUGCValidateAssetTextureLimits() and game:GetFastFlag("UGCValidateDecalTextureLimits")
end
