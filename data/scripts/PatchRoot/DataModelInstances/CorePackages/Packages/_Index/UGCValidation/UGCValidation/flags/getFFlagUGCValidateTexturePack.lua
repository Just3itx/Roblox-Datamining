-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T16:50:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local getEngineUGCValidateTexturePackCPlusPlus = require(scriptParentParent.flags.getEngineUGCValidateTexturePackCPlusPlus)

game:DefineFastFlag("UGCValidateTexturePack", false)

return function()
    return game:GetFastFlag("UGCValidateTexturePack") and getEngineUGCValidateTexturePackCPlusPlus()
end
