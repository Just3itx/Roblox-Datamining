-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T04:10:58Z
-- Luau bytecode version: 14 | Luau type version: 3
return {
    enableManufacturerDeny = game:DefineFastFlag("LuaAppEdpVideoManufacturerDeny2", false),
    enableDeviceDeny = game:DefineFastFlag("LuaAppEdpVideoDeviceDeny", false),
    enableMaxMemoryDeny = game:DefineFastFlag("LuaAppEdpVideoMaxMemoryDeny", false),
    enableAvailableRamDeny = game:DefineFastFlag("LuaAppEdpVideoAvailableRamDeny", false),
    manufacturerDenyList = game:DefineFastString("LuaAppEdpVideoManufacturerPipeDenyList", ""),
    deviceDenyList = game:DefineFastString("LuaAppEdpVideoDevicePipeDenyList", ""),
    maxMemoryThresholdMb = game:DefineFastInt("LuaAppEdpVideoMaxMemoryThresholdMb", -1),
    availableRamThresholdMb = game:DefineFastInt("LuaAppEdpVideoAvailableRamThresholdMb", -1)
}
