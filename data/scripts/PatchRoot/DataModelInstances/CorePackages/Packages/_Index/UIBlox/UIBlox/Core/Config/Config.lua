-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:11:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}

function module.new(defaultConfig)
    local module2 = {
        defaultConfig = defaultConfig,
        defaultConfigKeys = {}
    }
    for k in pairs(defaultConfig) do
        table.insert(module2.defaultConfigKeys, k)
    end

    module2._currentConfig = setmetatable({}, {
        __index = function(_, arg1)
            local str1 = ("Invalid global configuration key %q. Valid configuration keys are: %s"):format(
                tostring(arg1),
                table.concat(module2.defaultConfigKeys, ", ")
            )

            error(str1, 3)
        end
    })

    function module2.set(...)
        return module.set(module2, ...)
    end

    function module2.get(...)
        return module.get(module2, ...)
    end

    function module2.scoped(...)
        return module.scoped(module2, ...)
    end

    module2.set(defaultConfig)

    return module2
end

function module.set(arg1, arg2)
    local tbl1 = {}
    local tbl2 = {}

    for k, value in pairs(arg2) do
        if arg1.defaultConfig[k] == nil then
            table.insert(tbl1, k)
        elseif typeof(value) ~= "boolean" then
            table.insert(tbl2, tostring(k) .. " (type " .. typeof(value) .. ")")
        else
            arg1._currentConfig[k] = value
        end
    end
    if next(tbl1) ~= nil then
        local str1 = ("Invalid global configuration keys %s. Valid configuration keys are: %s"):format(
            table.concat(tbl1, ", "),
            table.concat(arg1.defaultConfigKeys, ", ")
        )

        error(str1, 3)
    end

    if next(tbl2) ~= nil then
        local str1 = ("Invalid global configuration types for keys %s. All configuration values must be boolean."):format(
            table.concat(tbl2, ", ")
        )

        error(str1, 3)
    end
end

function module.get(arg1)
    return arg1._currentConfig
end

return module
