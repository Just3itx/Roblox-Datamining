-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:40:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent

local module = {}
local var1 = require(scriptParent.Symbols.Symbol).named("ThunkTag")

function module.middleware(arg1)
    local var2 = arg1 or {}

    return function(arg2, arg3)
        return function(arg4)
            if arg4[var1] ~= true then
                return arg2(arg4)
            end

            local tbl1 = ({})

            for _, value in pairs(arg4.requiredServices) do
                local var3 = var2[value]

                if var3 == nil then
                    error(("Service with key %s is a dependency but was not provided"):format(tostring(value)))
                end

                tbl1[value] = var3
            end

            return arg4(arg3, tbl1)
        end
    end
end

function module.new(type: string, requiredServices, arg1)
    assert(typeof(type) == "string", "Bad arg #1: name must be a string")
    assert(
        requiredServices == nil or typeof(requiredServices) == "table",
        "Bad arg #2: requiredServices must be a table or nil"
    )

    assert(typeof(arg1) == "function", "Bad arg #3: onInvoke must be a function")

    return (setmetatable({
        [var1] = true,
        type = type,
        requiredServices = requiredServices or {}
    }, {
        __call = function(_, ...)
            return arg1(...)
        end
    }))
end

function module.test(arg1, arg2, arg3)
    assert(typeof(arg1) == "table" and arg1[var1] == true, "Test Error - Bad arg #1: Must provide a valid thunk")

    if #arg1.requiredServices > 0 then
        for _, value in ipairs(arg1.requiredServices) do
            assert(arg3[value] ~= nil, "Test Error - Bad arg #3: Missing required service " .. tostring(value))
        end
    end

    return arg1(arg2, arg3)
end

return module
