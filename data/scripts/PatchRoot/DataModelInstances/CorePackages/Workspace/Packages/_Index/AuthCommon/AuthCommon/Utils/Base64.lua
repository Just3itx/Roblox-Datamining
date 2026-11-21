-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:50:19Z
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

function module.MakeDecoder(str1: string?, str2: string?, str3: string?)
    local decoder = ({})
    for k, value in pairs(module.MakeEncoder(str1, str2, str3)) do
        decoder[value] = k
    end
    return decoder
end

local encoder = module.MakeEncoder()
local decoder = module.MakeDecoder()

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

function module.EncodeUrl(str1: string, bool1: boolean?)
    local var1 = module.Encode(str1, nil, bool1)
    return module.ToUrlSafeBase64(var1)
end

function module.Decode(str1: string, tbl1, bool1: boolean?)
    local var1 = tbl1 or decoder

    local var2 = nil
    local var3 = nil
    for k, value in pairs(var1) do
        if value == 62 then
            var2 = k
        elseif value == 63 then
            var3 = k
        end
    end

    str1 = str1:gsub(("[^%%w%%%s%%%s%%=]"):format(char(var2), (char(var3))), "")

    local tbl2 = ({})
    local tbl3 = ({})
    local num1 = 1
    local num2 = #str1
    local num3 = if str1:sub(-2) == "==" then 2 elseif str1:sub(-1) == "=" then 1 else 0
    local num4 = 1
    local num5 = if num3 > 0 then num2 - 4 else num2

    for i = num4, num5, 4 do
        local var4, var5, var6, var7 = str1:byte(i, i + 3)
        local var8

        if bool1 then
            local var9 = var4 * 16777216 + var5 * 65536 + var6 * 256 + var7
            var8 = tbl2[var9]
            if not var8 then
                local var10 = var1[var4] * 262144 + var1[var5] * 4096 + var1[var6] * 64 + var1[var7]
                var8 = char(extract(var10, 16, 8), extract(var10, 8, 8), (extract(var10, 0, 8)))
                tbl2[var9] = var8
            end
        else
            local var9 = var1[var4] * 262144 + var1[var5] * 4096 + var1[var6] * 64 + var1[var7]
            var8 = char(extract(var9, 16, 8), extract(var9, 8, 8), (extract(var9, 0, 8)))
        end
        tbl3[num1] = var8
        num1 += 1
    end
    if num3 == 1 then
        local var4, var5, var6 = str1:byte(num2 - 3, num2 - 1)
        local var7 = var1[var4] * 262144 + var1[var5] * 4096 + var1[var6] * 64
        local var8 = extract(var7, 16, 8)
        local var9 = extract(var7, 8, 8)
        tbl3[num1] = char(var8, var9)
    elseif num3 == 2 then
        local var4, var5 = str1:byte(num2 - 3, num2 - 2)
        local var6 = extract(var1[var4] * 262144 + var1[var5] * 4096, 16, 8)
        tbl3[num1] = char(var6)
    end
    return concat(tbl3)
end

function module.DecodeUrl(str1: string, bool1: boolean?)
    local urlSafeBase64 = module.FromUrlSafeBase64(str1)
    return module.Decode(urlSafeBase64, nil, bool1)
end

function module.ToUrlSafeBase64(str1: string)
    str1 = string.gsub(str1, "+", "-")
    str1 = string.gsub(str1, "/", "_")
    return (string.gsub(str1, "=", ""))
end

function module.FromUrlSafeBase64(str1: string)
    str1 = str1:gsub("[^%w%-_]", "")

    local num1 = (4 - #str1 % 4) % 4
    str1 ..= string.rep("=", num1)
    str1 = string.gsub(str1, "_", "/")
    return (string.gsub(str1, "-", "+"))
end

return module
