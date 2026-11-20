-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:40:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local None = require(script.Parent.Parent.None)
local copyDeep = require(script.Parent.copyDeep)

local function joinDeep(...)
    local result = ({})

    local select2 = select

    for i = 1, select2("#", ...) do
        local select = select
        local var1 = select(i, ...)

        if not var1 then
            continue
        end

        for k, value in pairs(var1) do
            if value == None then
                result[k] = nil
            elseif type(value) ~= "table" then
                result[k] = value
            elseif result[k] == nil or type(result[k] ~= "table") then
                result[k] = copyDeep(value)
            else
                result[k] = joinDeep(result[k], value)
            end
        end
    end

    return result
end

return joinDeep
