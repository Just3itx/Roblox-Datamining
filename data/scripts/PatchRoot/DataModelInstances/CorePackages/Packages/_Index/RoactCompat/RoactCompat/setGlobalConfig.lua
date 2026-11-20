-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:01:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local ReactGlobals = require(scriptParentParent.ReactGlobals)
local warnOnce = require(script.Parent.warnOnce)

return function(_)
    if ReactGlobals.__DEV__ and ReactGlobals.__COMPAT_WARNINGS__ then
        warnOnce(
            "setGlobalConfig",
            "Roact 17 uses a `ReactGlobals.__DEV__` flag to enable development behavior. If you're seeing this warning, you already have it enabled. Please remove any redundant uses of `setGlobalConfig`."
        )
    end
end
