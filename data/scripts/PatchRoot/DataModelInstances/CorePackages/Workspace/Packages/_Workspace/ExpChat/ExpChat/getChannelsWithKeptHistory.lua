-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T08:50:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(tbl1, num1: number)
    local result = {}
    if num1 <= 0 then
        return result
    end

    for _, value in tbl1 do
        local textChannel = value.TextChannel
        if textChannel then
            result[textChannel.Name] = value
        end
    end

    return result
end
