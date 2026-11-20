-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:21:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local _Signals = require(scriptParentParent.Signals)

local function onDisposed(callback, callback2)
    callback(function(_, bool1: boolean?): number -- name: source
        if bool1 then
            callback2()
        end
        return 0
    end)
end
return onDisposed
