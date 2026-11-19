-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T11:11:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(arg1, arg2)
    local result = ({})

    for k, value in pairs(arg1) do
        if arg2[k] ~= arg1[k] then
            result[k] = value
        end
    end

    for k, value in pairs(arg2) do
        if arg2[k] ~= arg1[k] then
            result[k] = value
        end
    end

    return result
end
