-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:01:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(arg1, arg2)
    local result = ({})
    for k, value in pairs(arg1) do
        if not arg2[k] then
            error("tables did not have matching indices")
            return
        end

        result[k] = value < arg2[k] and value or arg2[k]
    end

    return result
end
