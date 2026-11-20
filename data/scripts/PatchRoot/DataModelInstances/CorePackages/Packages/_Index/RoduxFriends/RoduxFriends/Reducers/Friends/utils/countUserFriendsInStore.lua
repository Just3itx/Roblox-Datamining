-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:51:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(arg1)
    local result = ({})
    for k, value in pairs(arg1) do
        result[k] = #value
    end

    return result
end
