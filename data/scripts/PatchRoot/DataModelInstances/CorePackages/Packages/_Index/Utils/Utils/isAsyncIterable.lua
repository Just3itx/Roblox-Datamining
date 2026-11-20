-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:01:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local Symbol = require(scriptParentParent.LuauPolyfill).Symbol

local module = {}
function module.isAsyncIterable(arg1)
    local asyncIterator = Symbol.asyncIterator
    local bool1

    if typeof(arg1) == "table" and arg1 ~= nil then
        bool1 = asyncIterator and arg1[asyncIterator]
        bool1 = bool1 and typeof(arg1[asyncIterator]) == "function"
    else
        bool1 = false
    end

    return bool1
end

return module
