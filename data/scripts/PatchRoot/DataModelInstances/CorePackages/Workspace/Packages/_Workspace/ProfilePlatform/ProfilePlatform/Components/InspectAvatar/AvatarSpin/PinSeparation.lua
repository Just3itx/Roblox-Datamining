-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:01:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}

function module.resolve(tbl1, tbl2)
    local var1 = table.clone(tbl1)
    table.sort(var1, function(tbl3, tbl4): boolean
        if tbl3.priority == tbl4.priority then
            return tbl3.id < tbl4.id
        end

        return tbl3.priority > tbl4.priority
    end)

    local previouslyHidden = tbl2.previouslyHidden or {}
    local hysteresis = tbl2.hysteresis or 0
    local tbl3 = {}
    local result = {}
    for _, value in var1 do
        local var2 = tbl2.minDistance + (if previouslyHidden[value.id] then hysteresis else 0)
        local bool1 = false
        for _, value2 in tbl3 do
            if (value.position - value2.position).Magnitude < var2 then
                bool1 = true
                break
            end
        end

        if bool1 then
            result[value.id] = true
        else
            table.insert(tbl3, value)
        end
    end
    return result
end

function module.pinStatesEqual(tbl1, tbl2)
    for value, value2 in tbl1 do
        local var1 = tbl2[value]
        if not var1 or var1.position ~= value2.position or var1.opacity ~= value2.opacity or var1.isFocused ~= value2.isFocused then
            return false
        end
    end
    for value in tbl2 do
        if not tbl1[value] then
            return false
        end
    end
    return true
end

return module
