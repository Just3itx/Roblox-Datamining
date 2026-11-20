-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:11:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function createSpy(arg1)
    local module = {
        callCount = 0,
        values = {},
        valuesLength = 0
    }

    function module.value(...)
        module.callCount += 1
        module.values = { ... }
        local tbl1 = module
        local select = select
        tbl1.valuesLength = select("#", ...)

        if arg1 ~= nil then
            return arg1(...)
        end
    end

    function module.assertCalledWith(_, ...)
        local select2 = select
        local var1 = select2("#", ...)

        if module.valuesLength ~= var1 then
            error(("Expected %d arguments, but was called with %d arguments"):format(module.valuesLength, var1), 2)
        end

        for i = 1, var1 do
            local select = select
            local var2 = select(i, ...)

            assert(module.values[i] == var2, "value differs; got " .. tostring(module.values[i]) .. ", expected " .. tostring(var2))
        end
    end

    function module.captureValues(_, ...)
        local select2 = select
        local var1 = select2("#", ...)
        local result = {}

        assert(module.valuesLength == var1, "length of expected values differs from stored values")

        for i = 1, var1 do
            local select = select
            result[select(i, ...)] = module.values[i]
        end

        return result
    end

    setmetatable(module, {
        __index = function(_, arg2)
            error(("%q is not a valid member of spy"):format(arg2))
        end
    })

    return module
end

return createSpy
