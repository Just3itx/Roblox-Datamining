-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:11:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(arg1)
    if not arg1 or type(arg1) ~= "table" then
        return nil
    end

    local tbl1 = ({})

    for value, value2 in arg1 do
        if type(value) == "string" and (type(value2) == "string" or type(value2) == "number" or type(value2) == "boolean") then
            tbl1[value] = tostring(value2)
        end
    end

    return if next(tbl1) then tbl1 else nil
end
