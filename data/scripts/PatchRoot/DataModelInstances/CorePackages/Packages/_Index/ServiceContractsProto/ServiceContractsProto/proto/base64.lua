-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:41:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
--!native
local tbl1 = ({})
local tbl2 = ({})

for i = 1, 64 do
    local num1 = i - 1
    local num2 = string.byte("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/", i)

    tbl1[num1] = num2
    tbl2[num2] = num1
end

tbl2[61] = 0

local function buildStringFromCodes(tbl3): string
    local tbl4 = {}

    for i = 1, #tbl3, 4096 do
        local num1 = math.min(i + 4096 - 1, #tbl3)
        local unpack = unpack
        table.insert(tbl4, string.char(unpack(tbl3, i, num1)))
    end

    return table.concat(tbl4, "")
end

return {
    encode = function(str1: string): string
        local num1 = #str1
        local num2 = math.ceil(num1 / 3) * 4

        local num3 = num1 % 3

        if num3 == 0 then
            str1 ..= "\0"
        end

        local tbl3 = table.create(num2, 0)

        for i = 0, num2 / 4 - (if num3 == 0 then 1 else 2) do
            local num4 = i * 3 + 1
            local num5 = i * 4 + 1

            local num6 = bit32.rshift(string.unpack(">J", str1, num4), 8)

            tbl3[num5] = tbl1[bit32.rshift(num6, 18)]
            local num7 = num5 + 1
            tbl3[num7] = tbl1[bit32.band(bit32.rshift(num6, 12), 0x3F)]
            local num8 = num5 + 2
            tbl3[num8] = tbl1[bit32.band(bit32.rshift(num6, 6), 0x3F)]
            tbl3[num5 + 3] = tbl1[bit32.band(num6, 0x3F)]
        end

        if num3 == 1 then
            local num4 = string.byte(str1, num1)

            tbl3[num2 - 3] = tbl1[bit32.rshift(num4, 2)]
            local num5 = num2 - 2
            tbl3[num5] = tbl1[bit32.band(bit32.lshift(num4, 4), 0x3F)]
            tbl3[num2 - 1] = 61
            tbl3[num2] = 61
        elseif num3 == 2 then
            local var1 = string.unpack(">H", str1, num1 - 1)

            tbl3[num2 - 3] = tbl1[bit32.rshift(var1, 10)]
            local num4 = num2 - 2
            tbl3[num4] = tbl1[bit32.band(bit32.rshift(var1, 4), 0x3F)]
            local num5 = num2 - 1
            tbl3[num5] = tbl1[bit32.band(bit32.lshift(var1, 2), 0x3F)]
            tbl3[num2] = 61
        end

        return buildStringFromCodes(tbl3)
    end,
    decode = function(str1: string): string
        local num1 = #str1
        local num2 = math.ceil(num1 / 4) * 3

        local num3 = 0
        if string.byte(str1, num1 - 1) == 61 then
            num3 = 2
        elseif string.byte(str1, num1) == 61 then
            num3 = 1
        end

        local tbl3 = table.create(num2 - num3, 0)

        for i = 0, num2 / 3 - 1 do
            local num4 = i * 4 + 1
            local num5 = i * 3 + 1

            local num6, var1, var2, var3 = string.byte(str1, num4, num4 + 3)

            local num7 = bit32.bor(bit32.lshift(tbl2[num6], 18), bit32.lshift(tbl2[var1], 12), bit32.lshift(tbl2[var2], 6), tbl2[var3])

            tbl3[num5] = bit32.rshift(num7, 16)
            local num8 = num5 + 1
            tbl3[num8] = bit32.band(bit32.rshift(num7, 8), 0xFF)
            tbl3[num5 + 2] = bit32.band(num7, 0xFF)
        end

        if num3 >= 1 then
            tbl3[num2] = nil

            if num3 >= 2 then
                tbl3[num2 - 1] = nil
            end
        end

        return buildStringFromCodes(tbl3)
    end
}
