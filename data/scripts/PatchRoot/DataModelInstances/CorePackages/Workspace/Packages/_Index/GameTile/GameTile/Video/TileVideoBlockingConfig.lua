-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T22:40:32Z
-- Luau bytecode version: 14 | Luau type version: 3
local GameTileParent = script:FindFirstAncestor("GameTile").Parent
local _VideoUtils = require(GameTileParent.VideoUtils)

return {
    enableManufacturerDeny = game:DefineFastFlag("LuaAppGameTileVideoManufacturerDeny", false),
    enableDeviceDeny = game:DefineFastFlag("LuaAppGameTileVideoDeviceDeny", false),
    enableMaxMemoryDeny = game:DefineFastFlag("LuaAppGameTileVideoMaxMemoryDeny", false),
    enableAvailableRamDeny = game:DefineFastFlag("LuaAppGameTileVideoAvailableRamDeny", false),
    maxMemoryThresholdMb = game:DefineFastInt("LuaAppGameTileVideoMaxMemoryThresholdMb", -1),
    availableRamThresholdMb = game:DefineFastInt("LuaAppGameTileVideoAvailableRamThresholdMb", -1),
    manufacturerDenyList = game:DefineFastString("LuaAppGameTileVideoManufacturerPipeDenyList", ""),
    deviceDenyList = game:DefineFastString("LuaAppGameTileVideoDevicePipeDenyList", "")
}
