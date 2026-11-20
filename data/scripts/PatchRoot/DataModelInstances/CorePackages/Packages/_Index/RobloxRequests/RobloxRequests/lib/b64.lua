-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:31:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
function enc(arg1)
    return (arg1:gsub(".", function(arg2): string
        local str1 = ""
        local var1 = arg2:byte()
        for i = 8, 1, -1 do
            str1 ..= if var1 % 2 ^ i - var1 % 2 ^ (i - 1) > 0 then "1" else "0"
        end

        return str1
    end) .. "0000"):gsub("%d%d%d?%d?%d?%d?", function(arg2): string
        if #arg2 < 6 then
            return ""
        end

        local num1 = 0
        for i = 1, 6 do
            num1 += if arg2:sub(i, i) ~= "1" then 0 else 2 ^ (6 - i) or 0
        end

        return ("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"):sub(num1 + 1, num1 + 1)
    end) .. ({ "", "==", "=" })[#arg1 % 3 + 1]
end

function dec(arg1)
    return (string.gsub(arg1, "[^ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=]", ""):gsub(".", function(arg2)
        if arg2 == "=" then
            return ""
        end

        local str1 = ""
        local var1 = ("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"):find(arg2) - 1
        for i = 6, 1, -1 do
            str1 ..= if var1 % 2 ^ i - var1 % 2 ^ (i - 1) > 0 then "1" else "0"
        end

        return str1
    end):gsub(
        "%d%d%d?%d?%d?%d?%d?%d?",
        function(arg2): string
            if #arg2 ~= 8 then
                return ""
            end

            local num1 = 0
            for i = 1, 8 do
                num1 += if arg2:sub(i, i) ~= "1" then 0 else 2 ^ (7 - i) or 0
            end

            return string.char(num1)
        end
    ))
end

function safe_enc(arg1, arg2)
    if arg2 == nil then
        arg2 = true
    end

    local tbl1 = {}
    local str1 = ""

    while #arg1 > 0 do
        table.insert(tbl1, arg1:sub(1, 204798))
        arg1 = arg1:sub(204799)
    end

    for i, value in ipairs(tbl1) do
        if arg2 then
            print(("[http] Encoding B64 chunk %s/%s"):format(i, #tbl1))
        end
        str1 ..= enc(value)

        wait()
    end

    return str1
end

return {
    encode = safe_enc,
    decode = dec
}
