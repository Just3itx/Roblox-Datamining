-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T22:30:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InGameAssetReporting = script:FindFirstAncestor("InGameAssetReporting")

local _SceneAnalysis = require(InGameAssetReporting.Analysis.SceneAnalysis)

function getPreselectedSurfaceValue(arg1)
    if arg1 == nil then
        return nil
    end

    local extractedAssets = arg1.extractedAssets

    if #arg1.extractedPlayers > 0 then
        return "avatar"
    end

    if #extractedAssets.Image > 0
        or #extractedAssets.Mesh > 0
        or #extractedAssets.Model > 0
        or #extractedAssets.Package > 0
        or #extractedAssets.Video > 0
    then
        return "item"
    end

    if #extractedAssets.Text > 0 then
        return "text"
    end

    return nil
end

return getPreselectedSurfaceValue
