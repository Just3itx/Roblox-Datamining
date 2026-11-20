-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:51:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local symbols = require(script.Parent.symbols)
local Spy = require(script.Parent.Spy)

local module = {}
local tbl1 = {
    __index = function(arg1, arg2)
        local var1 = getmetatable(arg1)
        local var2 = var1[symbols.Children][arg2]
        if var2 ~= nil then
            return if var2 == symbols.None then nil else var2
        end

        local module2 = module.new()
        var1[symbols.Children][arg2] = module2
        return module2
    end,
    __newindex = function(arg1, returnValue, arg2)
        local var1 = getmetatable(arg1)
        if type(arg2) == "function" then
            local _
            _, arg2 = Spy.new(arg2)
        elseif arg2 == nil then
            arg2 = symbols.None
        end

        if returnValue ~= symbols.ReturnValue then
            var1[symbols.Children][returnValue] = arg2

            return
        end

        var1[symbols.ReturnValue] = { arg2, n = 1 }
    end,
    __call = function(arg1, ...)
        local var1 = getmetatable(arg1)
        local tbl1 = {
            args = table.pack(...),
            result = var1[symbols.ReturnValue]
        }
        if tbl1.result == nil then
            tbl1.result = {
                module.new(),
                n = 1
            }
            var1[symbols.ReturnValue] = tbl1.result
        elseif tbl1.result == symbols.None then
            tbl1.result = { n = 1 }
        end

        table.insert(var1[symbols.Calls], tbl1)
        return table.unpack(tbl1.result)
    end
}

function module.new(arg1)
    local tbl2 = {
        [symbols.Calls] = {},
        [symbols.Children] = {},
        [symbols.Lock] = arg1,
        [symbols.ReturnValue] = nil
    }

    for k, value in pairs(tbl1) do
        tbl2[k] = value
    end

    return (setmetatable({}, tbl2))
end

return module
