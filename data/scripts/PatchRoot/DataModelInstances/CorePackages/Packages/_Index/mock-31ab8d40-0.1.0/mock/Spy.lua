-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:51:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local symbols = require(script.Parent.symbols)

local module = {}
module.__index = module

local tbl1 = ({})
setmetatable(tbl1, { __mode = "kv" })

function module.new(arg1)
    local tbl2 = {
        [symbols.Calls] = {}
    }
    setmetatable(tbl2, module)

    local function inner(...)
        local tbl3 = {
            args = table.pack(...),
            result = table.pack(arg1(...))
        }
        table.insert(tbl2[symbols.Calls], tbl3)
        return table.unpack(tbl3.result)
    end

    tbl2.inner = inner
    tbl1[inner] = tbl2

    return tbl2, inner
end

function module.lookup(arg1)
    return tbl1[arg1]
end

return module
