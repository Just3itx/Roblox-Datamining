-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T04:51:10Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
return function(arg1, num1: number?)
    if typeof(arg1) == "string" then
        arg1 = tonumber(arg1) or (0 / 0)
    end

    if typeof(arg1) ~= "number" then
        return "nan"
    end

    if num1 ~= nil then
        if typeof(num1) ~= "number" then
            error("TypeError: fractionDigits must be a number between 0 and 100")
        end
        if num1 < 0 or num1 > 100 then
            error("RangeError: fractionDigits must be between 0 and 100")
        end
    end

    local str1 = if num1 == nil then "%e" else "%." .. tostring(num1) .. "e"

    return (string.format(str1, arg1):gsub("%+0", "+"):gsub("%-0", "-"):gsub("0*e", "e"))
end
