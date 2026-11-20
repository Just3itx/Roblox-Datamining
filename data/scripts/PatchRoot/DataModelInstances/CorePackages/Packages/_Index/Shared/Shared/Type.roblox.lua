-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:21:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SymbolRoblox = require(script.Parent["Symbol.roblox"])

local var1 = newproxy(true)

local tbl1 = {}

local function addType(arg1) -- Luacid: unused: defined but never referenced
    tbl1[arg1] = SymbolRoblox.named("Roact" .. arg1)
end

tbl1.HostChangeEvent = SymbolRoblox.named("RoactHostChangeEvent")
tbl1.HostEvent = SymbolRoblox.named("RoactHostEvent")

function tbl1.of(arg1)
    return if typeof(arg1) == "table" then arg1[var1] else nil
end

getmetatable(var1).__index = tbl1

getmetatable(var1).__tostring = function(): string
    return "RoactType"
end

return var1
