-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:51:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local symbols = require(script.Parent.symbols)
local Spy = require(script.Parent.Spy)
local setReturnValue = require(script.Parent.setReturnValue)
local setSideEffect = require(script.Parent.setSideEffect)

local function isKeyInSpec(arg1, arg2) -- Luacid: Inlined by compiler; 2 call sites recovered
    local var1 = arg1[symbols.Spec]
    if not var1 then
        return true
    end

    local success, result = pcall(function()
        return var1[arg2]
    end)
    return success and result
end

local module = {
    is = require(script.Parent.isAMagicMock)
}
local tbl1 = {
    __tostring = function(arg1): string
        local var1 = getmetatable(arg1)
        local tbl1 = { "id=" .. var1[symbols.Address] }

        local var2 = var1[symbols.Name]
        if var2 ~= nil and var2 ~= "mock" then
            table.insert(tbl1, "name=" .. var2)
        end

        return "<MagicMock " .. table.concat(tbl1, " ") .. ">"
    end,
    __index = function(arg1, arg2)
        local var1 = getmetatable(arg1)

        if not isKeyInSpec(var1, arg2) then
            error(string.format("MagicMock Error: Cannot index key %q since it is out of spec.", tostring(arg2)))
        end

        local var2 = var1[symbols.Children][arg2]
        if var2 ~= nil then
            return if var2 == symbols.None then nil else var2
        end

        local module2 = module.new({ name = var1[symbols.Name] .. "." .. tostring(arg2) })
        var1[symbols.Children][arg2] = module2
        return module2
    end,
    __newindex = function(arg1, returnValue, arg2)
        local var1 = getmetatable(arg1)

        if not isKeyInSpec(var1, returnValue) then
            error(string.format("MagicMock Error: Cannot write key %q since it is out of spec", tostring(returnValue)))
        end

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
    end
}

local function isTuple(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    if type(arg1) == "table" and arg1[symbols.isTuple] then
        return not module.is(arg1)
    end
end

local function getReturnValue(arg1, ...)
    if arg1[symbols.ReturnValue] then
        return arg1[symbols.ReturnValue]
    end

    local var1 = arg1[symbols.SideEffect]
    if var1 then
        var1.calls += 1
        if type(var1.value) == "function" or Spy.is(var1.value) then
            return { var1.value(...) }
        end

        if type(var1.value) == "table" then
            local calls = var1.calls
            local var2 = if isTuple(var1.value) then var1.value.values[calls] else var1.value[calls]

            if var2 then
                return { var2 }
            end
            error("MagicMock Error: SideEffect iteration reached")
        else
            error("MagicMock Error: Invalid SideEffect")
        end
    end

    return nil
end

function tbl1.__call(arg1, ...)
    local var1 = getmetatable(arg1)
    local tbl2 = {
        args = table.pack(...),
        result = getReturnValue(var1, ...)
    }
    if tbl2.result == nil then
        tbl2.result = {
            module.new({ name = var1[symbols.Name] .. "()" }),
            n = 1
        }
        var1[symbols.ReturnValue] = tbl2.result
    elseif tbl2.result == symbols.None then
        tbl2.result = { n = 1 }
    elseif isTuple(tbl2.result[1]) then
        tbl2.result = tbl2.result[1].values
    end

    table.insert(var1[symbols.Calls], tbl2)
    return table.unpack(tbl2.result)
end

local function operation(str1: string) -- Luacid: Inlined by compiler; 8 call sites recovered
    return function(arg1, arg2)
        local var1, var2

        if type(arg1) ~= "string" and getmetatable(arg1) then
            var1 = getmetatable(arg1)
            var2 = string.format("__%s()", str1)
        else
            var1 = getmetatable(arg2)
            var2 = string.format("__r_%s()", str1)
        end

        local var3 = var1[symbols.Operations][var2]
        if var3 ~= nil then
            return var3
        end

        local module2 = module.new({ name = var1[symbols.Name] .. "." .. var2 })
        var1[symbols.Operations][var2] = module2
        return module2
    end
end

tbl1.__add = operation("add")
tbl1.__sub = operation("sub")
tbl1.__div = operation("div")
tbl1.__mul = operation("mul")
tbl1.__mod = operation("mod")
tbl1.__pow = operation("pow")
tbl1.__unm = operation("neg")
tbl1.__concat = operation("concat")

function module.new(arg1)
    local var1 = arg1 or {}

    local function getName() -- Luacid: Inlined by compiler; 1 call site recovered
        if var1.name then
            return var1.name
        end

        if not var1.spec then
            return "mock"
        end

        return tostring(var1.spec)
    end

    local tbl2 = {}
    local tbl3 = {
        [symbols.isMagicMock] = true,
        [symbols.Address] = tostring(tbl2),
        [symbols.Name] = getName(),
        [symbols.Operations] = {},
        [symbols.Calls] = {},
        [symbols.Children] = {},
        [symbols.Spec] = var1.spec or nil,
        [symbols.ReturnValue] = nil,
        [symbols.SideEffect] = nil
    }

    for k, value in pairs(tbl1) do
        tbl3[k] = value
    end

    local var2 = setmetatable(tbl2, tbl3)
    if var1.returnValue then
        setReturnValue(var2, var1.returnValue)
    end
    if var1.sideEffect then
        setSideEffect(var2, var1.sideEffect)
    end

    return var2
end

function module.is(arg1): boolean
    local var1 = getmetatable(arg1)
    return if var1 then var1[symbols.isMagicMock] ~= nil else false
end

return module
