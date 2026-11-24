-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:11:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
function getUpdatedSelectedCapturesArray(arg1, arg2)
    local updatedSelectedCapturesArray = {}
    local bool1 = false
    for _, value in ipairs(arg1) do
        if value == arg2 then
            bool1 = true
        else
            table.insert(updatedSelectedCapturesArray, value)
        end
    end
    if not bool1 then
        table.insert(updatedSelectedCapturesArray, arg2)
    end
    return updatedSelectedCapturesArray
end

return getUpdatedSelectedCapturesArray
