-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:21:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function getKey(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    return arg1.stable_key
end

local function valuesEqual(arg1, arg2, tbl1)
    if arg1 == arg2 then
        return true
    end
    if type(arg1) ~= "table" or type(arg2) ~= "table" then
        return false
    end
    local tbl2 = tbl1 or {}
    if tbl2[arg1] == arg2 then
        return true
    end
    tbl2[arg1] = arg2
    for value, value2 in arg1 do
        if not valuesEqual(value2, arg2[value], tbl2) then
            return false
        end
    end
    for value in arg2 do
        if arg1[value] == nil then
            return false
        end
    end
    return true
end

local function itemContentsEqual(arg1, arg2)
    for value, value2 in arg1 do
        if value ~= "position" and not valuesEqual(value2, arg2[value]) then
            return false
        end
    end
    for value in arg2 do
        if value ~= "position" and arg1[value] == nil then
            return false
        end
    end
    return true
end

return {
    build = function(tbl1, tbl2)
        local var1 = tbl2 == nil and {} or tbl2.items
        local var2 = tbl2 == nil and {} or tbl2.byKey
        local items = table.create(#tbl1)
        local byKey = ({})
        local bool1 = false
        for i = #tbl1, 1, -1 do
            local var4 = tbl1[i]
            local key = getKey(var4)

            if byKey[key] ~= nil then
                continue
            end

            local var5 = var2[key]
            if var5 == nil or var5 ~= var4 and not itemContentsEqual(var5, var4) then
                var5 = var4
            end

            table.insert(items, var5)
            byKey[key] = var5
            bool1 = bool1 or var1[#items] ~= var5
        end

        return if tbl2 == nil or bool1 or #items ~= #var1 then { items = items, byKey = byKey } else tbl2
    end,
    getKey = getKey
}
