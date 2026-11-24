-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:41:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function composeRefs(...)
    local tbl1 = { ... }
    return function(current)
        for _, value in tbl1 do
            if type(value) == "function" then
                value(current)
            elseif value ~= nil then
                value.current = current
            end
        end
    end
end

return composeRefs
