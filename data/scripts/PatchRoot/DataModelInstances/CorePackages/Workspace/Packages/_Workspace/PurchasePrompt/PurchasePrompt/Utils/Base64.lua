-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:50:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}

function module.MakeEncoder(str1: string?, str2: string?, str3: string?)
    local encoder = ({})
    for k, value in pairs({
        [0] = "A",
        "B",
        "C",
        "D",
        "E",
        "F",
        "G",
        "H",
        "I",
        "J",
        "K",
        "L",
        "M",
        "N",
        "O",
        "P",
        "Q",
        "R",
        "S",
        "T",
        "U",
        "V",
        "W",
        "X",
        "Y",
        "Z",
        "a",
        "b",
        "c",
        "d",
        "e",
        "f",
        "g",
        "h",
        "i",
        "j",
        "k",
        "l",
        "m",
        "n",
        "o",
        "p",
        "q",
        "r",
        "s",
        "t",
        "u",
        "v",
        "w",
        "x",
        "y",
        "z",
        "0",
        "1",
        "2",
        "3",
        "4",
        "5",
        "6",
        "7",
        "8",
        "9",
        str1 or "+",
        str2 or "/",
        str3 or "="
    }) do
        encoder[k] = value:byte()
    end
    return encoder
end

local encoder = module.MakeEncoder()

local char = string.char
local concat = table.concat
local extract = bit32.extract

function module.Encode(str1: string, tbl1, bool1: boolean?)
    local var1 = tbl1 or encoder
    local tbl2 = ({})
    local num1 = 1
    local num2 = #str1
    local num3 = num2 % 3
    local tbl3 = ({})

    for i = 1, num2 - num3, 3 do
        local var2, var3, var4 = str1:byte(i, i + 2)
        local var5 = var2 * 65536 + var3 * 256 + var4
        local var6

        if bool1 then
            var6 = tbl3[var5]
            if not var6 then
                var6 = char(var1[extract(var5, 18, 6)], var1[extract(var5, 12, 6)], var1[extract(var5, 6, 6)], var1[extract(var5, 0, 6)])

                tbl3[var5] = var6
            end
        else
            var6 = char(var1[extract(var5, 18, 6)], var1[extract(var5, 12, 6)], var1[extract(var5, 6, 6)], var1[extract(var5, 0, 6)])
        end

        tbl2[num1] = var6
        num1 += 1
    end
    if num3 == 2 then
        local var2, var3 = str1:byte(num2 - 1, num2)
        local var4 = var2 * 65536 + var3 * 256

        local var5 = var1[extract(var4, 18, 6)]
        local var6 = var1[extract(var4, 12, 6)]
        local var7 = var1[extract(var4, 6, 6)]
        local var8 = var1[64]
        tbl2[num1] = char(var5, var6, var7, var8)
    elseif num3 == 1 then
        local var2 = str1:byte(num2) * 65536

        local var3 = var1[extract(var2, 18, 6)]
        local var4 = var1[extract(var2, 12, 6)]
        local var5 = var1[64]
        local var6 = var1[64]
        tbl2[num1] = char(var3, var4, var5, var6)
    end
    return concat(tbl2)
end

return module
