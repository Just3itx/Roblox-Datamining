-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T05:10:49Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
return function(callback)
    local function makeKeyString(arg1): string -- Luacid: Inlined by compiler; 3 call sites recovered
        if type(arg1) == "string" then
            return string.format("%s", arg1)
        end
        return string.format("[%s]", tostring(arg1))
    end

    local function makeValueString(arg1): string
        local str1 = type(arg1)
        if str1 == "string" then
            return string.format("%q", arg1)
        elseif str1 == "function" or str1 == "table" then
            return string.format("<%s>", tostring(arg1))
        end
        return string.format("%s", tostring(arg1))
    end

    local function printKeypair(arg1, arg2, str1: string, str2: string)
        local keyString = makeKeyString(arg1)
        local valueString = makeValueString(arg2)

        local str3 = str2 and string.format(" -- %s", str2) or ""
        callback(string.format("%s%s = %s,%s", str1, keyString, valueString, str3))
    end

    return function(arg1, arg2)
        local var1 = arg2 or "  "

        if type(arg1) ~= "table" then
            error("tutils.Print must be passed a table", 2)
        end

        local tbl1 = ({})

        local function recurse(arg3, arg4, arg5)
            tbl1[arg3] = true

            local str1 = string.rep(var1, arg5)
            local str2 = string.rep(var1, arg5 + 1)

            if arg4 then
                local var2 = callback
                local format = string.format
                local keyString = makeKeyString(arg4)
                var2(format("%s%s = %s {", str1, keyString, makeValueString(arg3)))
            else
                callback(string.format("%s%s {", str1, makeValueString(arg3)))
            end

            for k, value in pairs(arg3) do
                if type(value) ~= "table" then
                    local keyString = makeKeyString(k)
                    local valueString = makeValueString(value)

                    callback(string.format("%s%s = %s,%s", str2, keyString, valueString, ""))
                elseif tbl1[value] then
                    printKeypair(k, value, str2, "Possible cycle")
                else
                    recurse(value, k, arg5 + 1)
                end
            end

            callback(string.format("%s}%s", str1, if arg5 > 0 then "," else ""))
        end

        recurse(arg1, nil, 0)
    end
end
