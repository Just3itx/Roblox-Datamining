-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T11:11:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(arg1)
    local bool1 = false
    local bool2 = false
    local bool3 = true

    local num1 = 1
    for k, _ in pairs(arg1) do
        if type(k) == "string" then
            bool2 = true
        else
            if type(k) ~= "number" then
                return false
            end

            if num1 ~= k then
                bool3 = false
            end

            bool1 = true
        end

        if bool2 and bool1 then
            return false
        end

        num1 += 1
    end

    return not bool1 or bool3
end
