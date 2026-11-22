-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T02:41:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function textEncode(str1: string) -- Luacid: Inlined by compiler; 1 call site recovered
    local result = {}

    for i = 1, #str1 do
        table.insert(result, (string.byte(str1, i)))
    end

    return result
end

local function imul32(num1: number, num2: number): number -- Luacid: unused: defined but never referenced
    local num3 = bit32.rshift(num1, 16)
    local num4 = bit32.band(num1, 0xFFFF)
    local num5 = bit32.rshift(num2, 16)
    local num6 = bit32.band(num2, 0xFFFF)

    local num7 = num4 * num6
    local num8 = num3 * num6 + num4 * num5
    local num9 = num3 * num5

    local num10 = num7 + bit32.lshift(bit32.band(num8, 0xFFFF), 16)
    local _ = num9 + bit32.rshift(num8, 16)

    return bit32.band(num10, 0xFFFFFFFF)
end

return {
    textEncode = textEncode,
    hashStringWithFnv1a32 = function(str1: string): string
        local tbl1 = textEncode(str1)
        local num1 = 0x811C9DC5
        for _, value in ipairs(tbl1) do
            local num2 = bit32.bxor(num1, value)
            local num3 = bit32.rshift(num2, 16)
            local num4 = bit32.band(num2, 0xFFFF)

            local num5 = num4 * 403
            local num6 = num3 * 403 + num4 * 256
            local num7 = num3 * 256

            local num8 = num5 + bit32.lshift(bit32.band(num6, 0xFFFF), 16)
            local _ = num7 + bit32.rshift(num6, 16)

            num1 = bit32.band(num8, 0xFFFFFFFF)
        end

        return string.format("%08x", num1)
    end
}
