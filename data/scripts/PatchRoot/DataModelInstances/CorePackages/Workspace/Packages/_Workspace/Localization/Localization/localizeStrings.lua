-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T23:41:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local LocalizationParent = script:FindFirstAncestor("Localization").Parent
local ArgCheck = require(LocalizationParent.ArgCheck)

local function localizeStrings(arg1, arg2)
    local result = ({})

    for k, value in pairs(arg2) do
        if typeof(value) == "table" then
            if typeof(value[1]) == "string" then
                local success, result2 = pcall(function()
                    return arg1:Format(value[1], value)
                end)

                ArgCheck.isEqual(
                    success,
                    true,
                    string.format("LocalizationConsumer finding value for translation key[%s]: %s", k, value[1])
                )

                result[k] = success and result2 or ""
            else
                local error = error
                local format = string.format

                local var1 = value[1]
                error(format("%s[1] in stringsToBeLocalized must be a string, got %s instead", k, typeof(var1)))
            end
        elseif typeof(value) == "string" then
            local success, result2 = pcall(function()
                return arg1:Format(value)
            end)

            ArgCheck.isEqual(
                success,
                true,
                string.format("LocalizationConsumer finding value for translation key[%s]: %s", k, value)
            )

            result[k] = success and result2 or ""
        else
            error(string.format("%s in stringsToBeLocalized must be a string or table, got %s instead", k, typeof(value)))
        end
    end

    return result
end

return localizeStrings
