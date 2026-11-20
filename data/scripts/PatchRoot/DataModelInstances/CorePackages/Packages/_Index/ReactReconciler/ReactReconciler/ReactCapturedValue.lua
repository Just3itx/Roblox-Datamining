-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:21:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _ReactInternalTypes = require(script.Parent.ReactInternalTypes)

local getStackByFiberInDevAndProd = require(script.Parent.ReactFiberComponentStack).getStackByFiberInDevAndProd

local module = {}

function module.createCapturedValue(value, source)
    return {
        value = value,
        source = source,
        stack = getStackByFiberInDevAndProd(source)
    }
end

return module
