-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T08:11:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent

local bool1 = game:DefineFastFlag("DebugLuaAppEnableReactDevTools", false)

local profileOnStart = game:DefineFastFlag("DebugLuaAppsReactDevToolsProfileOnStart", false)
local host = game:DefineFastString("DebugLuaAppReactDevToolsHost", "localhost")
local port = game:DefineFastInt("DebugLuaAppReactDevToolsPort", 8097)

return {
    startup = function(bool3: boolean?)
        if not bool1 and not bool3 then
            return
        end
        _G.__PROFILE__ = true
        _G.__DEV__ = true

        require(scriptParent.Dev.ReactDevtoolsCore).backend.connectToDevtools(
            { host = host, port = port, profileOnStart = profileOnStart }
        )
    end
}
