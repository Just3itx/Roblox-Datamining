-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T22:30:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameTileParent = script:FindFirstAncestor("GameTile").Parent
local ExperimentCacheManager = require(GameTileParent.ExperimentCacheManager).ExperimentCacheManager

local str1 = game:DefineFastString("LuaAppGameTileMigrationExpLayer", "PlayerApp.HomePage.UX.TileLayer")
local FFlagLuaAppUnifyPlayButtonTileIxp = require(GameTileParent.SharedFlags).FFlagLuaAppUnifyPlayButtonTileIxp

local function getIsUserInTreatmentAndSendExposureLog(str2: string) -- Luacid: Inlined by compiler; 2 call sites recovered
    local str3 = str1
    local layerVariables = ExperimentCacheManager.default:getLayerVariables(str3, true)

    if not layerVariables or layerVariables[str2] == nil then
        return false
    end

    ExperimentCacheManager.default:sendCustomExposureLog(str3)
    return layerVariables[str2]
end

return {
    getIsTileMigrationEnabled = function()
        return getIsUserInTreatmentAndSendExposureLog("IsTileMigrationEnabled")
    end,
    getIsPlayButtonMigrationEnabled = if FFlagLuaAppUnifyPlayButtonTileIxp then FFlagLuaAppUnifyPlayButtonTileIxp and function()
        return getIsUserInTreatmentAndSendExposureLog("IsPlayButtonMigrationEnabled")
    end or nil else nil
}
