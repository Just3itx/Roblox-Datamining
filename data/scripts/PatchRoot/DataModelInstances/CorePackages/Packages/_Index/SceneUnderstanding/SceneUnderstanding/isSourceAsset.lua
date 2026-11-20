-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:31:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SceneUnderstanding = script:FindFirstAncestor("SceneUnderstanding")

local safelyAccessProperty = require(SceneUnderstanding.safelyAccessProperty)

local function isSourceAsset(arg1): boolean
    return safelyAccessProperty(arg1, "SourceAssetId", -1) > 0
end

return isSourceAsset
