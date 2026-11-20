-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:50:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local getCalls = require(script.Parent.getCalls)
local cmpLiteralArgs = require(script.Parent.cmpLiteralArgs)
local cmpPredicateArgs = require(script.Parent.cmpPredicateArgs)
local fmtArgs = require(script.Parent.fmtArgs)

local module = {}

function module.args(arg1, arg2)
    local calls = getCalls(arg1)
    local callsLen = #calls
    if callsLen == 0 then
        return false, "mock was not called"
    end

    local var1 = nil
    for i = 1, callsLen do
        local var2
        var2, var1 = arg2(calls[i].args)
        if var2 then
            return true
        end
    end

    local var2 = var1 or fmtArgs(calls[callsLen].args) .. " did not match"

    if callsLen > 1 then
        var2 ..= " (+" .. callsLen - 1 .. " other calls)"
    end

    return false, var2
end

function module.literals(arg1, ...)
    local tbl1 = table.pack(...)
    return module.args(arg1, function(arg2)
        return cmpLiteralArgs(tbl1, arg2)
    end)
end

function module.predicates(arg1, ...)
    local tbl1 = table.pack(...)
    return module.args(arg1, function(arg2)
        return cmpPredicateArgs(tbl1, arg2)
    end)
end

return module
