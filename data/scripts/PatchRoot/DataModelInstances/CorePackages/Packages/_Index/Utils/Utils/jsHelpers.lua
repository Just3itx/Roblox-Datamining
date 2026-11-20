-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:01:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local LuauPolyfill = require(scriptParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Object = LuauPolyfill.Object

local module = {}

local function isSymbol(arg1): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return typeof(arg1) == "userdata" and string.sub(tostring(arg1), 1, 7) == "Symbol("
end
module.isSymbol = isSymbol

function module.getOwnPropertySymbols(tbl1)
    return Array.filter(Object.keys(tbl1), function(arg1): boolean
        return (isSymbol(arg1))
    end)
end

function module.getOwnPropertyNames(tbl1)
    Array.filter(Object.keys(tbl1), function(arg1): boolean
        return not isSymbol(arg1)
    end)
end

function module.create(tbl1)
    if not tbl1 then
        return {}
    end

    return (setmetatable({}, tbl1))
end

return module
