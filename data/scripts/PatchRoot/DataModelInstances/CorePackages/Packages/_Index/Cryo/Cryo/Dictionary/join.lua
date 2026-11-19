-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T10:41:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local None = require(script.Parent.Parent.None)

local function join(...)
    local select2 = select
    local var1 = select2("#", ...)
    if var1 == 0 then
        return {}
    elseif var1 == 1 then
        local var2 = table.clone(...)
        setmetatable(var2, nil)
        return var2
    end

    local var2 = table.clone(select(1, ...))
    setmetatable(var2, nil)

    for i = 2, var1 do
        local select = select
        local var3 = select(i, ...)

        for k, value in pairs(var3) do
            if value == None then
                var2[k] = nil
            else
                var2[k] = value
            end
        end
    end

    return var2
end

return join
