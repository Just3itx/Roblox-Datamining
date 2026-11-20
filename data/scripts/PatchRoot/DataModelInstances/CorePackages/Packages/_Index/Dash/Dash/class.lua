-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T03:21:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local _Types = require(scriptParent.Types)

local function throwNotImplemented(tbl1: {className: string, methodName: string}) -- Luacid: Inlined by compiler; 7 call sites recovered
    require(scriptParent.Error).new(
        "NotImplemented",
        "The method \"{methodName}\" is not implemented on the class \"{className}\""
    ):throw(
        tbl1
    )
end

local function func1()
    return {}
end

local function class(str1: string, func2: ((...any) -> (...any))?)
    local var1 = func2 or func1
    local module = { name = str1 }

    function module.new(...)
        local var2 = var1(...)
        setmetatable(var2, {
            __index = module,
            __tostring = module.toString,
            __eq = module.equals,
            __lt = module.__lt,
            __le = module.__le,
            __add = module.__add,
            __sub = module.__sub,
            __mul = module.__mul,
            __div = module.__div,
            __mod = module.__mod
        })
        var2.Class = module
        var2:_init(...)
        return var2
    end

    function module._init(_) end

    function module.isInstance(arg1)
        local success, result = pcall(function()
            local var2 = getmetatable(arg1)
            while var2 do
                if var2.__index == module then
                    return true
                end
                var2 = getmetatable(var2.__index)
            end
            return false
        end)
        return success and result
    end

    function module.extend(tbl1, str2: string, arg1)
        local var2 = class(str2, arg1 or module.new)
        setmetatable(var2, { __index = tbl1 })
        return var2
    end

    function module.toString(arg1)
        return arg1.name
    end

    function module.equals(arg1, arg2): boolean
        return rawequal(arg1, arg2)
    end

    function module.__lt(_, _)
        throwNotImplemented({ methodName = "__lt", className = str1 })
    end

    function module.__le(_, _)
        throwNotImplemented({ methodName = "__le", className = str1 })
    end

    function module.__add(_)
        throwNotImplemented({ methodName = "__add", className = str1 })
    end

    function module.__sub(_)
        throwNotImplemented({ methodName = "__sub", className = str1 })
    end

    function module.__mul(_)
        throwNotImplemented({ methodName = "__mul", className = str1 })
    end

    function module.__div(_)
        throwNotImplemented({ methodName = "__div", className = str1 })
    end

    function module.__mod(_)
        throwNotImplemented({ methodName = "__mod", className = str1 })
    end

    return module
end

return class
