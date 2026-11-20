-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:40:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}

local Language = require(script.Language)
local keyword = Language.keyword
local builtin = Language.builtin
local libraries = Language.libraries

module.language = Language

local tbl1 = ({})
local tbl2 = ({})

for value, value2 in {
    { "^[%c%s]*[%a_][%w_]*[%c%s]*", "var" },
    { "^[%c%s]*0[xX][%da-fA-F_]+[%c%s]*", "number" },
    { "^[%c%s]*0[bB][01_]+[%c%s]*", "number" },
    { "^[%c%s]*%d+%.?%d*[eE][%+%-]?%d+[%c%s]*", "number" },
    { "^[%c%s]*%d+[%._]?[%d_eE]*[%c%s]*", "number" },
    { "^[%c%s]*(['\"])%1[%c%s]*", "string" },
    { "^[%c%s]*(['\"])[^\n]-([^\\]%1)[%c%s]*", "string" },
    { "^[%c%s]*(['\"]).-\n[%c%s]*", "string" },
    { "^[%c%s]*(['\"])[^\n]*[%c%s]*", "string" },
    { "^[%c%s]*%[(=*)%[.-%]%1%][%c%s]*", "string" },
    { "^[%c%s]*%[=*%[.-.*[%c%s]*", "string" },
    { "^[%c%s]*`[^\n]-`[%c%s]*", "string_inter" },
    { "^[%c%s]*%-%-%[(=*)%[.-%]%1%][%c%s]*", "comment" },
    { "^[%c%s]*%-%-%[=*%[.-.*[%c%s]*", "comment" },
    { "^[%c%s]*%-%-.-\n[%c%s]*", "comment" },
    { "^[%c%s]*%-%-.*[%c%s]*", "comment" },
    { "^[%c%s]*[:;<>/~%*%(%)%-={},%.#%^%+%%]+[%c%s]*", "operator" },
    { "^[%c%s]*[%[%]]+[%c%s]*", "operator" },
    { "^[%c%s]*[%z\1-\127\194-\244][\128-\191]+[%c%s]*", "iden" },
    { "^.", "iden" }
} do
    tbl1[value] = value2[1]
    tbl2[value] = value2[2]
end

function module.scan(str1: string)
    local num1 = 1
    local num2 = #str1
    local str2 = ""
    local str3 = ""
    local str4 = ""
    local str5 = ""

    local thread = coroutine.create(function()
        while num1 <= num2 do
            local bool1 = false
            for i, value in ipairs(tbl1) do
                local var1, var2 = string.find(str1, value, num1)
                if var1 == nil then
                    continue
                end

                num1 = var2 + 1
                bool1 = true

                local str6 = string.sub(str1, var1, var2)
                local var3 = tbl2[i]
                local var4

                if var3 == "var" then
                    local var5 = string.gsub(str6, "[%c%s]+", "")

                    if keyword[var5] then
                        var4 = "keyword"
                    elseif builtin[var5] then
                        var4 = "builtin"
                    elseif string.find(str2, "%.[%s%c]*$") and str5 ~= "comment" then
                        local var6 = string.gsub(str3, "[%c%s]+", "")
                        local var7 = libraries[var6]
                        if var7 and var7[var5] and not string.find(str4, "%.[%s%c]*$") then
                            var4 = "builtin"
                        else
                            var4 = "iden"
                        end
                    else
                        var4 = "iden"
                    end
                elseif var3 ~= "string_inter" then
                    var4 = var3
                elseif string.find(str6, "[^\\]{") then
                    local num3 = #str6
                    local num4 = 1
                    local bool2 = true
                    var4 = nil

                    while num4 <= num3 do
                        local var5, var6 = string.find(str6, "^.-[^\\][{}]", num4)
                        if var5 == nil then
                            coroutine.yield("string", string.sub(str6, num4))
                            break
                        end

                        if bool2 then
                            num4 = var6 + 1
                            coroutine.yield("string", string.sub(str6, var5, var6))
                            bool2 = false
                        else
                            local str7 = string.sub(str6, var5, var6 - 1)
                            num4 = var6

                            for value2, value3 in module.scan(str7) do
                                coroutine.yield(value2, value3)
                            end

                            bool2 = true
                        end
                    end
                else
                    var4 = "string"
                end

                str4 = str3
                str3 = str2
                str2 = str6
                str5 = var4 or var3
                if var4 then
                    coroutine.yield(var4, str6)
                end

                break
            end

            if not bool1 then
                return
            end
        end
    end)

    return function()
        if coroutine.status(thread) == "dead" then
            return
        end

        local var1, var2, var3 = coroutine.resume(thread)
        if var1 and var2 then
            return var2, var3
        end
    end
end

function module.navigator()
    local module2 = {
        Source = "",
        TokenCache = table.create(50),
        _RealIndex = 0,
        _UserIndex = 0,
        _ScanThread = nil
    }

    function module2.Destroy(arg1)
        arg1.Source = nil
        arg1._RealIndex = nil
        arg1._UserIndex = nil
        arg1.TokenCache = nil
        arg1._ScanThread = nil
    end

    function module2.SetSource(arg1, source)
        arg1.Source = source

        arg1._RealIndex = 0
        arg1._UserIndex = 0
        table.clear(arg1.TokenCache)

        arg1._ScanThread = coroutine.create(function()
            for value, value2 in module.scan(arg1.Source) do
                local var1 = arg1
                var1._RealIndex += 1
                arg1.TokenCache[arg1._RealIndex] = { value, value2 }
                coroutine.yield(value, value2)
            end
        end)
    end

    function module2.Next()
        local tbl3 = module2
        tbl3._UserIndex += 1

        if module2._RealIndex >= module2._UserIndex then
            return table.unpack(module2.TokenCache[module2._UserIndex])
        elseif coroutine.status(module2._ScanThread) ~= "dead" then
            local var1, var2, var3 = coroutine.resume(module2._ScanThread)
            if var1 and var2 then
                return var2, var3
            end
        end
    end

    function module2.Peek(arg1)
        local var1 = module2._UserIndex + arg1

        if var1 <= module2._RealIndex then
            if var1 > 0 then
                return table.unpack(module2.TokenCache[var1])
            end

            return
        end

        if coroutine.status(module2._ScanThread) == "dead" then
            return
        end

        local var2 = nil
        local var3 = nil

        for _ = 1, var1 - module2._RealIndex do
            local var4
            var4, var2, var3 = coroutine.resume(module2._ScanThread)
            if not (var4 or var2) then
                break
            end
        end

        return var2, var3
    end

    return module2
end

return module
