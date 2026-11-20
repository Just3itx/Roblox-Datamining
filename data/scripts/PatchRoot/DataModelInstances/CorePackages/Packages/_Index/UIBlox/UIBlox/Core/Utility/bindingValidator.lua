-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:31:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function bindingValidator(arg1)
    return function(arg2): boolean
        local var1 = string.match(tostring(arg2), "RoactBinding")

        if typeof(arg2) ~= "table" or not var1 then
            warn(string.format("RoactBinding expected, got %s", typeof(arg2)))
            return false
        end

        local success, result = pcall(function()
            return arg2:getValue()
        end)

        if not success then
            warn("getValue() not defined")
            return false
        end

        local var2, var3 = arg1(result)
        if var2 then
            return true
        end

        warn(string.format("RoactBinding value: %s", var3))
        return false
    end
end

return bindingValidator
