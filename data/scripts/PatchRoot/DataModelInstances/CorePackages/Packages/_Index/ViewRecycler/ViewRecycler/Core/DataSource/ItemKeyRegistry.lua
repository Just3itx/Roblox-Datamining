-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:11:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local num1 = 0

local function generatedKey(): string -- Luacid: Inlined by compiler; 5 call sites recovered
    num1 += 1
    return `view-recycler:{num1}`
end

return {
    create = function(func1: ((...any) -> (...any))?, str1: string) -- name: createItemKeyRegistry
        local tbl1 = ({})
        local str2 = `{str1}: keys must be strings`
        local str3 = `{str1}: setItem must preserve the existing key`

        local function resolve(arg1, num2: number) -- Luacid: Inlined by compiler; 4 call sites recovered
            local var1 = if func1 ~= nil then func1(arg1, num2) else generatedKey()
            assert(type(var1) == "string", str2)
            return var1
        end

        return {
            claim = function(arg1, num2: number)
                local var1 = resolve(arg1, num2)

                if tbl1[var1] ~= nil then
                    assert(false, `{str1}: duplicate key "{var1}"`)
                end
                tbl1[var1] = true
                return var1
            end,
            assertPreserved = function(arg1, arg2, arg3)
                if func1 ~= nil then
                    assert(resolve(arg2, arg3) == arg1, str3)
                end
            end,
            release = function(arg1)
                if tbl1[arg1] == nil then
                    assert(false, `{str1}: cannot release missing key "{arg1}"`)
                end
                tbl1[arg1] = nil
            end,
            adopt = function(arg1)
                tbl1[arg1] = true
            end,
            replace = function(str4: string, arg1, num2: number)
                local var1 = resolve(arg1, num2)

                if tbl1[str4] == nil then
                    assert(false, `{str1}: cannot replace missing key "{str4}"`)
                end
                if var1 ~= str4 and tbl1[var1] ~= nil then
                    assert(false, `{str1}: duplicate key "{var1}"`)
                end
                if var1 ~= str4 then
                    tbl1[str4] = nil
                    tbl1[var1] = true
                end
                return var1
            end,
            rebuild = function(tbl2)
                local var1 = table.create(#tbl2)
                local tbl3 = ({})
                for value, value2 in tbl2 do
                    local var2 = resolve(value2, value)

                    if tbl3[var2] ~= nil then
                        assert(false, `{str1}: duplicate key "{var2}"`)
                    end
                    var1[value] = var2
                    tbl3[var2] = true
                end
                tbl1 = tbl3
                return var1
            end,
            clear = function()
                tbl1 = {}
            end,
            snapshot = function()
                return table.clone(tbl1)
            end,
            restore = function(arg1)
                tbl1 = table.clone(arg1)
            end
        }
    end,
    generatedKey = generatedKey
}
