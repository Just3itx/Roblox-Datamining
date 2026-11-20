-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:11:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ItemKeyRegistry = require(script.Parent.ItemKeyRegistry)

local function validateUnique(tbl1, str1: string)
    local result = ({})
    local str2 = `{str1}: keys must be strings`
    for _, value in tbl1 do
        assert(type(value) == "string", str2)
        if result[value] ~= nil then
            assert(false, `{str1}: duplicate key "{value}"`)
        end
        result[value] = true
    end
    return result
end

return {
    validateUnique = validateUnique,
    keysFor = function(tbl1, func1: ((...any) -> (...any))?)
        local var1 = table.create(#tbl1)
        for value, value2 in tbl1 do
            local var2 = if func1 ~= nil then func1(value2, value) else ItemKeyRegistry.generatedKey()
            var1[value] = var2
        end
        return var1, (validateUnique(var1, "DataSource"))
    end
}
