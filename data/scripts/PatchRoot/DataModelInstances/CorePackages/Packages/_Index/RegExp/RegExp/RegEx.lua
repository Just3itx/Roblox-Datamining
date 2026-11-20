-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:51:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local var1 = (setmetatable({}, { __mode = "k" }))
local tbl1 = ({})
local tbl2 = ({})
local tbl3 = ({})
local var2 = nil

local function to_str_arr(s, arg2)
    if arg2 then
        s = string.sub(s, utf8.offset(s, arg2))
    end
    local n = utf8.len(s)
    if n <= 1999 then
        return {
            n = n,
            s = s,
            utf8.codepoint(s, 1, #s)
        }
    end

    local num1 = math.ceil(n / 1999)
    local var4 = table.create(n)
    local num2 = 1
    for i = 1, num1 do
        local tbl4 = table.pack(
            utf8.codepoint(
                s,
                utf8.offset(s, i * 1999 - 1998),
                utf8.offset(s, i * 1999 - (if i ~= num1 then -1 else 1998 - ((n - 1) % 1999 + 1) or -1)) - 1
            )
        )
        table.move(tbl4, 1, tbl4.n, num2, var4)
        num2 += tbl4.n
    end
    var4.s = s
    var4.n = n
    return var4
end

local function from_str_arr(tbl4: {any}): string
    local var3 = tbl4.n or #tbl4
    if var3 <= 7997 then
        return utf8.char(table.unpack(tbl4))
    end
    local num1 = math.ceil(var3 / 7997)
    local var4 = table.create(num1)
    for i = 1, num1 do
        local char = utf8.char
        local num2 = i * 7997 - 7996
        local var5 = i * 7997 - (if i ~= num1 then 0 else 7997 - ((var3 - 1) % 7997 + 1) or 0)
        var4[i] = char(table.unpack(tbl4, num2, var5))
    end
    return table.concat(var4)
end

local function utf8_sub(str1: string, num1: number?, arg1): string -- Luacid: Inlined by compiler; 26 call sites recovered
    arg1 = utf8.offset(str1, arg1)
    return string.sub(str1, utf8.offset(str1, num1), arg1 and arg1 - 1)
end

local tbl4 = {
    a = "anchored",
    i = "caseless",
    m = "multiline",
    s = "dotall",
    u = "unicode",
    U = "ungreedy",
    x = "extended"
}

local tbl5 = {
    alnum = true,
    alpha = true,
    ascii = true,
    blank = true,
    cntrl = true,
    digit = true,
    graph = true,
    lower = true,
    print = true,
    punct = true,
    space = true,
    upper = true,
    word = true,
    xdigit = true
}

local tbl6 = {
    [68] = { "class", "digit", true },
    [83] = { "class", "space", true },
    [87] = { "class", "word", true },
    [100] = { "class", "digit", false },
    [115] = { "class", "space", false },
    [119] = { "class", "word", false },
    [72] = { "class", "blank", true },
    [86] = { "class", "vertical_tab", true },
    [104] = { "class", "blank", false },
    [118] = { "class", "vertical_tab", false },
    [78] = { 78 },
    [82] = { 82 },
    [66] = 8,
    [110] = 10,
    [114] = 13,
    [116] = 9
}

local tbl7 = {
    [98] = {
        98,
        { "class", "word", false }
    },
    [66] = {
        66,
        { "class", "word", false }
    },
    [75] = { 75 },
    [71] = { 71 },
    [74] = { 74 },
    [90] = { 90 },
    [122] = { 122 }
}

local tbl8 = {
    [33] = true,
    [34] = true,
    [35] = true,
    [36] = true,
    [37] = true,
    [38] = true,
    [39] = true,
    [40] = true,
    [41] = true,
    [42] = true,
    [43] = true,
    [44] = true,
    [45] = true,
    [46] = true,
    [47] = true,
    [58] = true,
    [59] = true,
    [60] = true,
    [61] = true,
    [62] = true,
    [63] = true,
    [64] = true,
    [91] = true,
    [92] = true,
    [93] = true,
    [94] = true,
    [95] = true,
    [96] = true,
    [123] = true,
    [124] = true,
    [125] = true,
    [126] = true
}

local tbl9 = { 36 }
local tbl10 = { 46 }
local tbl11 = { 94 }
local tbl12 = { 124 }

local function check_re(str1: string, str2: string, arg1) -- Luacid: Inlined by compiler; 5 call sites recovered
    return if str1 == "Match" then function(...)
        local select = select

        if select("#", ...) < 1 then
            error("missing argument #1 (Match expected)", 2)
        end
        local var3, var4 = ...
        if not var1[var3] or var1[var3].name ~= "Match" then
            error(string.format("invalid argument #1 to %q (Match expected, got %s)", str2, typeof(var3)), 2)
        else
            var3 = var1[var3]
        end
        if str2 == "group" or str2 == "span" then
            var4 = if var4 == nil then 0 else var4
        end

        return arg1(var3, var4)
    end else function(...)
        local select = select
        local var3 = select("#", ...)
        if var3 < 1 then
            error("missing argument #1 (RegEx expected)", 2)
        elseif var3 < 2 then
            error("missing argument #2 (string expected)", 2)
        end
        local var4, var5, var6, var7, var8, var9 = ...
        if not var1[var4] or var1[var4].name ~= "RegEx" then
            if type(var4) ~= "string" and type(var4) ~= "number" then
                error(string.format("invalid argument #1 to %q (RegEx expected, got %s)", str2, typeof(var4)), 2)
            end
            var4 = tbl1.fromstring(var4)
        elseif str2 == "sub" then
            if type(var6) == "number" then
                var6 ..= ""
            elseif type(var6) ~= "string" then
                error(string.format("invalid argument #3 to 'sub' (string expected, got %s)", typeof(var6)), 2)
            end
        elseif type(var5) == "number" then
            var5 ..= ""
        elseif type(var5) ~= "string" then
            error(string.format("invalid argument #2 to %q (string expected, got %s)", str2, typeof(var5)), 2)
        end
        if str2 ~= "sub" and str2 ~= "split" then
            local str3 = typeof(var6)
            if str3 ~= "nil" then
                var6 = tonumber(var6)
                if not var6 then
                    error(string.format("invalid argument #3 to %q (number expected, got %s)", str2, str3), 2)
                elseif var6 < 0 then
                    var6 = #var5 + math.floor(var6 + 0.5) + 1
                else
                    var6 = math.max(math.floor(var6 + 0.5), 1)
                end
            end
        end
        local var10 = var1[var4]
        if str2 == "match" or str2 == "matchiter" then
            var7 = ...
        elseif str2 == "sub" then
            var9 = ...
        end

        return arg1(var10, var5, var6, var7, var8, var9)
    end
end

local function match_tostr(arg1): string
    local spans = var1[arg1].spans
    local var3 = spans[0][1]
    local var4 = spans[0][2]
    if var4 <= var3 then
        return string.format("Match (%d..%d, empty)", var3, var4 - 1)
    end
    return string.format("Match (%d..%d): %s", var3, var4 - 1, (utf8_sub(spans.input, var3, var4)))
end

local function new_match(spans, groupId, source, input)
    spans.source = source
    spans.input = input
    local var3 = newproxy(true)
    local var4 = getmetatable(var3)
    var4.__metatable = var2
    var4.__index = setmetatable(spans, tbl3)
    var4.__tostring = match_tostr

    var1[var3] = { name = "Match", spans = spans, group_id = groupId }
    return var3
end

local group = check_re("Match", "group", function(arg1, arg2)
    local span = arg1.spans[type(arg2) == "number" and arg2 or arg1.group_id[arg2]]
    if not span then
        return nil
    end
    return utf8_sub(arg1.spans.input, span[1], span[2])
end)

tbl3.group = group

local span = check_re("Match", "span", function(arg1, arg2)
    local span = arg1.spans[type(arg2) == "number" and arg2 or arg1.group_id[arg2]]
    if not span then
        return nil
    end
    return span[1], span[2] - 1
end)

tbl3.span = span

local groups = check_re("Match", "groups", function(arg1)
    local spans = arg1.spans
    if not (spans.n > 0) then
        return utf8_sub(spans.input, spans[0][1], spans[0][2])
    end

    local var3 = table.create(spans.n)
    for i = 0, spans.n do
        local span = spans[i]
        if span then
            var3[i] = utf8_sub(spans.input, span[1], span[2])
        end
    end
    return table.unpack(var3, 1, spans.n)
end)

tbl3.groups = groups

local groupdict = check_re("Match", "groupdict", function(arg1)
    local spans = arg1.spans
    local result = ({})
    for k, value in pairs(arg1.group_id) do
        local span = spans[value]
        if span then
            result[k] = utf8_sub(spans.input, span[1], span[2])
        end
    end
    return result
end)

tbl3.groupdict = groupdict

local grouparr = check_re("Match", "groupdict", function(arg1)
    local spans = arg1.spans
    local var3 = table.create(spans.n)
    for i = 0, spans.n do
        local span = spans[i]
        if span then
            var3[i] = utf8_sub(spans.input, span[1], span[2])
        end
    end
    var3.n = spans.n
    return var3
end)

tbl3.grouparr = grouparr

local tbl13 = { CR = 0, LF = 1, CRLF = 2, ANYRLF = 3, ANY = 4, NUL = 5 }

local function is_newline(arg1, arg2, arg3): boolean
    local newline = arg3.newline
    local var3 = arg1[arg2]
    if newline == 0 then
        return var3 == 13
    elseif newline == 2 then
        return var3 == 10 and arg1[arg2 - 1] == 32
    end

    if newline == 3 then
        return var3 == 10 or var3 == 13
    elseif newline == 4 then
        return var3 == 10 or var3 == 11 or var3 == 12 or var3 == 13 or var3 == 133 or var3 == 8232 or var3 == 8233
    elseif newline == 5 then
        return var3 == 0
    end

    return var3 == 10
end

local function tkn_char_match(arg1, arg2, arg3, arg4, arg5)
    local var3 = arg2[arg3]
    if not var3 then
        return false
    end

    if arg4.ignoreCase and var3 >= 97 and var3 <= 122 then
        var3 -= 32
    end
    if type(arg1) == "number" then
        return arg1 == var3
    end

    if arg1[1] == "charset" then
        for _, value in ipairs(arg1[3]) do
            if tkn_char_match(value, arg2, arg3, arg4, arg5) then
                return not arg1[2]
            end
        end
        return arg1[2]
    elseif arg1[1] == "range" then
        local ignoreCase

        if arg1[2] <= var3 and var3 <= arg1[3] then
            ignoreCase = true
        else
            ignoreCase = arg4.ignoreCase

            if ignoreCase then
                if var3 >= 65 and var3 <= 90 and var3 + 32 >= arg1[2] then
                    ignoreCase = var3 + 32 <= arg1[3]
                else
                    ignoreCase = false
                end
            end
        end

        return ignoreCase
    end

    if arg1[1] ~= "class" then
        if arg1[1] ~= "category" then
            if arg1[1] == 46 then
                return arg4.dotAll or not is_newline(arg2, arg3, arg5)
            elseif arg1[1] == 78 then
                return not is_newline(arg2, arg3, arg5)
            elseif arg1[1] == 82 then
                if arg5.newline_seq == 0 then
                    return var3 == 10 or var3 == 13
                end

                return var3 == 10 or var3 == 11 or var3 == 12 or var3 == 13 or var3 == 133 or var3 == 8232 or var3 == 8233
            end

            return false
        end

        local var4 = (false)[var3] or "Cn"
        local var5 = arg1[3]
        local num1 = #var5
        if num1 ~= 3 then
            return if var4:sub(1, num1) == var5 then not arg1[2] else arg1[2]
        end

        local bool1 = false
        if var5 == "Xan" or var5 == "Xwd" then
            bool1 = var4:find("^[LN]")

            if not bool1 then
                if var5 == "Xwd" then
                    bool1 = var3 == 95
                else
                    bool1 = false
                end
            end
        elseif var5 == "Xps" or var5 == "Xsp" then
            if var4:sub(1, 1) == "Z" then
                bool1 = true
            elseif var3 >= 9 then
                bool1 = var3 <= 13
            else
                bool1 = false
            end
        elseif var5 == "Xuc" then
            bool1 = tkn_char_match(false, arg2, arg3, arg4, arg5)
        end
        return if arg1[2] then not bool1 else bool1
    end

    local var4 = arg1[2]
    local var5 = arg1[3]
    local bool1 = false

    if var4 == "xdigit" then
        if var3 >= 48 and var3 <= 57 or var3 >= 65 and var3 <= 70 then
            bool1 = true
        elseif var3 >= 97 then
            bool1 = var3 <= 102
        else
            bool1 = false
        end
    elseif var4 == "ascii" then
        bool1 = var3 <= 127
    elseif var4 == "vertical_tab" then
        bool1 = var3 >= 10 and var3 <= 13 or var3 == 8232 or var3 == 8233
    elseif arg4.unicode then
        local var6 = (false)[var3] or "Cn"
        local var7 = var6:sub(1, 1)
        if var4 == "alnum" then
            bool1 = var7 == "L" or var6 == "Nl" or var6 == "Nd"
        elseif var4 == "alpha" then
            bool1 = var7 == "L" or var6 == "Nl"
        elseif var4 == "blank" then
            bool1 = var6 == "Zs" or var3 == 9
        elseif var4 == "cntrl" then
            bool1 = var6 == "Cc"
        elseif var4 == "digit" then
            bool1 = var6 == "Nd"
        elseif var4 == "graph" then
            if var7 == "P" then
                bool1 = false
            else
                bool1 = var7 ~= "C"
            end
        elseif var4 == "lower" then
            bool1 = var6 == "Ll"
        elseif var4 == "print" then
            bool1 = var7 ~= "C"
        elseif var4 == "punct" then
            bool1 = var7 == "P"
        elseif var4 == "space" then
            if var7 == "Z" then
                bool1 = true
            elseif var3 >= 9 then
                bool1 = var3 <= 13
            else
                bool1 = false
            end
        elseif var4 == "upper" then
            bool1 = var6 == "Lu"
        elseif var4 == "word" then
            bool1 = var7 == "L" or var6 == "Nl" or var6 == "Nd" or var6 == "Pc"
        end
    elseif var4 == "alnum" then
        if var3 >= 48 and var3 <= 57 or var3 >= 65 and var3 <= 90 then
            bool1 = true
        elseif var3 >= 97 then
            bool1 = var3 <= 122
        else
            bool1 = false
        end
    elseif var4 == "alpha" then
        if var3 >= 65 and var3 <= 90 then
            bool1 = true
        elseif var3 >= 97 then
            bool1 = var3 <= 122
        else
            bool1 = false
        end
    elseif var4 == "blank" then
        bool1 = var3 == 9 or var3 == 32
    elseif var4 == "cntrl" then
        bool1 = var3 <= 31 or var3 == 127
    elseif var4 == "digit" then
        if var3 >= 48 then
            bool1 = var3 <= 57
        else
            bool1 = false
        end
    elseif var4 == "graph" then
        if var3 >= 33 then
            bool1 = var3 <= 126
        else
            bool1 = false
        end
    elseif var4 == "lower" then
        if var3 >= 97 then
            bool1 = var3 <= 122
        else
            bool1 = false
        end
    elseif var4 == "print" then
        if var3 >= 32 then
            bool1 = var3 <= 126
        else
            bool1 = false
        end
    elseif var4 == "punct" then
        bool1 = tbl8[var3]
    elseif var4 == "space" then
        bool1 = var3 >= 9 and var3 <= 13 or var3 == 32
    elseif var4 == "upper" then
        if var3 >= 65 then
            bool1 = var3 <= 90
        else
            bool1 = false
        end
    elseif var4 == "word" then
        bool1 = var3 >= 48 and var3 <= 57 or var3 >= 65 and var3 <= 90 or var3 >= 97 and var3 <= 122 or var3 == 95
    end
    return if var5 then not bool1 else bool1
end

local function find_alternation(arg1, arg2, arg3)
    while true do
        local var3 = arg1[arg2]
        local bool1 = type(var3) == "table"
        if var3 == tbl12 then
            break
        end
        if bool1 and var3[1] == 40 then
            arg3 = arg3 and arg3 + var3.count

            arg2 = var3[3]
        elseif bool1 and var3[1] == "quantifier" and type(var3[5]) == "table" and var3[5][1] == 40 then
            arg3 = arg3 and arg3 + var3[5].count

            arg2 = var3[5][3]
        else
            if not var3 or bool1 and var3[1] == 41 then
                return nil, arg3
            end

            if arg3 then
                if bool1 and var3[1] == "quantifier" then
                    arg3 += var3[3]
                else
                    arg3 += 1
                end
            end
        end

        arg2 += 1
    end

    return arg2, arg3
end

local function re_rawfind(token, arg1, arg2, flags, verbFlags, bool1: boolean)
    local var3 = arg2
    local var4 = var3
    local num1 = 0
    local tbl14 = {}
    local var5, var6

    while num1 do
        local var7

        if num1 == 0 then
            var7 = num1 + 1
            local var8 = find_alternation(token, var7)
            if var8 then
                table.insert(tbl14, 1, { "alternation", var8, var4 })
            end
        else
            local var8 = token[num1]
            local var9 = type(var8) == "table" and var8[1]

            if not var8 then
                break
            end
            if var8 == "ACCEPT" then
                var7 = num1
                local bool2 = true

                repeat
                    num1 += 1
                    local bool3 = type(token[num1]) == "table"
                    local var10 = token[num1]
                    if bool3 and (var10[1] == 40 or var10[1] == "quantifier" and type(var10[5]) == "table" and var10[5][1] == 40) then
                        num1 = var10[1] == "quantifier" and var10[5][3] or var10[3]
                    elseif bool3 and var10[1] == 41 and (var10[4] == 33 or var10[4] == 61) then
                        var7 = num1
                        bool2 = false
                        break
                    end
                until not var10

                if bool2 then
                    break
                end
            elseif var8 == "PRUNE" or var8 == "SKIP" then
                table.insert(tbl14, 1, { var8, var4 })
                var7 = num1 + 1
            elseif var9 == 40 then
                table.insert(tbl14, 1, { "group", num1, var4, nil, var8[2], var8[3], var8[4] })
                var7 = num1 + 1
                local func6 = find_alternation
                local var10 = (var8[4] == 33 or var8[4] == 61) and var8[5] and 0
                local var11, var12 = func6(token, var7, var10)
                if var11 then
                    table.insert(tbl14, 1, { "alternation", var11, var4 })
                end
                if var12 then
                    var4 -= var12
                end
            elseif var9 == 41 and var8[4] ~= 33 then
                if var8[4] == 33 or var8[4] == 61 then
                    while true do
                        var5 = nil
                        var6 = table.remove(tbl14, 1)
                        if var6[1] == "group" and var6[2] == var8[3] then
                            break
                        end

                        if var6[1] == "matchStart" and not var5 then
                            local _ = var8[4]
                        end
                    end

                    if (var8[4] == 33 or var8[4] == 61) and not var8[5] then
                        var4 = var6[3]
                    end
                    if var5 then
                        table.insert(tbl14, 1, var5)
                    end
                elseif var8[4] == 62 then
                    repeat
                        local var10 = table.remove(tbl14, 1)
                    until not var10 or var10[1] == "group" and var10[2] == var8[3]
                else
                    for _, value in ipairs(tbl14) do
                        if value[1] ~= "group" or value[2] ~= var8[3] then
                            continue
                        end

                        if value.jmp then
                            num1 = value.jmp
                        end
                        value[4] = var4
                        if value[7] == "quantifier" and value[10] + 1 < value[9] then
                            if token[var8[3]][4] ~= "lazy" or value[10] + 1 < value[8] then
                                num1 = var8[3]
                            end
                            local var10 = token[var8[3]]
                            table.insert(tbl14, 1, {
                                "group",
                                value[2],
                                var4,
                                nil,
                                var10[5][2],
                                var10[5][3],
                                "quantifier",
                                var10[2],
                                var10[3],
                                value[10] + 1,
                                value[11],
                                var10[4]
                            })

                            if value[11] then
                                table.insert(tbl14, 1, { "alternation", value[11], var4 })
                            end
                        end

                        break
                    end
                end

                var7 = num1 + 1
            elseif var9 == 75 then
                table.insert(tbl14, 1, { "matchStart", var4 })
                var7 = num1 + 1
            elseif var9 == 124 then
                var7 = num1

                repeat
                    num1 += 1
                    local bool2 = type(token[num1]) == "table"
                    local var10 = token[num1]
                    if bool2 and (var10[1] == 40 or var10[1] == "quantifier" and type(var10[5]) == "table" and var10[5][1] == 40) then
                        num1 = var10[1] == "quantifier" and var10[5][3] or var10[3]
                    end
                until bool2 and var10[1] == 41 or not var10

                if token[num1] then
                    for _, value in ipairs(tbl14) do
                        if value[1] == "group" and value[6] == num1 then
                            var7 = value[6]
                            break
                        end
                    end
                else
                    var7 = num1
                end
            elseif var9 == "recurmatch" then
                table.insert(tbl14, 1, { "group", var8[3], var4, nil, nil, token[var8[3]][3], nil, jmp = num1 })
                var7 = var8[3] + 1
                local var10, _ = find_alternation(token, var7)
                if var10 then
                    table.insert(tbl14, 1, { "alternation", var10, var4 })
                end
            else
                local var10 = nil
                if var8 == "FAIL" then
                    var10 = false
                elseif var9 == 41 then
                    repeat
                        local var11 = table.remove(tbl14, 1)
                    until var11[1] == "group" and var11[2] == var8[3]
                elseif var9 == "quantifier" then
                    if type(var8[5]) == "table" and var8[5][1] == 40 then
                        local var11 = find_alternation(token, num1 + 1)
                        if var11 then
                            table.insert(tbl14, 1, { "alternation", var11, var4 })
                        end
                        table.insert(
                            tbl14,
                            if var11 then 2 else 1,
                            {
                                "group",
                                num1,
                                var4,
                                nil,
                                var8[5][2],
                                var8[5][3],
                                "quantifier",
                                var8[2],
                                var8[3],
                                0,
                                var11,
                                var8[4]
                            }
                        )

                        if var8[4] == "lazy" and var8[2] == 0 then
                            num1 = var8[5][3]
                        end

                        var10 = true
                    else
                        local var11 = nil
                        local var12 = nil
                        local num2 = 1
                        local bool2 = type(var8[5]) == "table" and var8[5][1] == "backref"
                        if bool2 then
                            num2 = 0
                            local var13 = var8[5][2]
                            for _, value in ipairs(tbl14) do
                                if value[1] == "group" and value[5] == var13 then
                                    var11 = value[3]
                                    var12 = value[4]
                                    num2 = var12 - var11
                                    break
                                end
                            end
                        end

                        local var13 = var4 + var8[2] * num2
                        local num3 = 0

                        while num3 < var8[3] do
                            if bool2 then
                                if not (var11 and var12) then
                                    break
                                end
                                local str1 = utf8_sub(arg1.s, var11, var12)
                                local s = arg1.s
                                local var14 = var4 + num2
                                local num4 = utf8.offset(s, var14)
                                if str1 ~= string.sub(s, utf8.offset(s, var4), num4 and num4 - 1) then
                                    break
                                end
                            elseif not tkn_char_match(var8[5], arg1, var4, flags, verbFlags) then
                                break
                            end

                            var4 += num2
                            num3 += 1
                        end
                        var10 = var8[2] <= num3
                        if var10 and var8[4] ~= "possessive" then
                            if var8[4] ~= "lazy" then
                                local var14 = var4
                                var4 = var13
                                var13 = var14
                            end

                            table.insert(
                                tbl14,
                                1,
                                {
                                    "quantifier",
                                    num1,
                                    var13,
                                    math.min(var4, arg1.n + 1),
                                    (if var8[4] == "lazy" then 1 else -1) * num2
                                }
                            )
                            var4 = var13
                        end
                    end
                elseif var9 == "backref" then
                    local var11 = nil
                    local var12 = nil
                    local var13 = var8[2]
                    for _, value in ipairs(tbl14) do
                        if value[1] == "group" and value[5] == var13 then
                            var11 = value[3]
                            var12 = value[4]
                            break
                        end
                    end

                    if var11 and var12 then
                        local var14 = var4 + (var12 - var11)
                        local str1 = utf8_sub(arg1.s, var11, var12)
                        local s = arg1.s
                        local num2 = utf8.offset(s, var14)
                        var10 = str1 == string.sub(s, utf8.offset(s, var4), num2 and num2 - 1)
                        var4 = var14
                    end
                else
                    local var11 = arg1[var4]
                    if var9 == 36 or var9 == 90 or var9 == 122 then
                        if var4 == arg1.n + 1 then
                            var10 = true
                        else
                            var10 = var9 == 36 and flags.multiline and is_newline(arg1, var4 + 1, verbFlags)

                            if not var10 then
                                if var9 == 90 and var4 == arg1.n then
                                    var10 = is_newline(arg1, var4, verbFlags)
                                else
                                    var10 = false
                                end
                            end
                        end
                    elseif var9 == 94 or var9 == 65 or var9 == 71 then
                        if var4 == 1 then
                            var10 = true
                        else
                            var10 = var9 == 94 and flags.multiline and is_newline(arg1, var4 - 1, verbFlags)

                            if not var10 then
                                if var9 == 71 then
                                    var10 = var4 == var3
                                else
                                    var10 = false
                                end
                            end
                        end
                    elseif var9 == 66 or var9 == 98 then
                        local var12 = var4 == 1 or flags.multiline and is_newline(arg1, var4 - 1, verbFlags)
                        local var13 = var4 == arg1.n + 1 or flags.multiline and is_newline(arg1, var4, verbFlags)
                        local var14 = if tkn_char_match(var8[2], arg1[var4 - 1], flags) then 0 else tkn_char_match(var8[2], var11, flags) and 1
                        if var14 == 0 then
                            var10 = var13 or not tkn_char_match(var8[2], var11, flags)
                        elseif var14 then
                            var10 = var12 or not tkn_char_match(var8[2], arg1[var4 - 1], flags)
                        end
                        if var9 == 66 then
                            var10 = not var10
                        end
                    else
                        var10 = tkn_char_match(var8, arg1, var4, flags, verbFlags)
                        var4 += 1
                    end
                end
                if not var10 then
                    while true do
                        local var11 = tbl14[1] and tbl14[1][1]
                        local var12 = tbl14[1]
                        if not var11 or var11 == "PRUNE" or var11 == "SKIP" then
                            if var11 then
                                table.clear(tbl14)
                            end
                            if arg1.n < arg2 then
                                return not bool1 and nil
                            end
                            arg2 = var11 == "SKIP" and var12[2] or arg2 + 1
                            var4 = arg2
                            num1 = 0
                            break
                        end

                        if var11 == "alternation" then
                            num1 = var12[2]
                            var4 = var12[3]
                            local var13, var14 = find_alternation(token, num1 + 1)
                            if var13 then
                                var12[2] = var13
                            else
                                table.remove(tbl14, 1)
                            end
                            if var14 then
                                var4 -= var14
                            end

                            break
                        end

                        if var11 == "group" then
                            if var12[7] == "quantifier" then
                                if var12[12] == "greedy" and var12[10] >= var12[8] or var12[12] == "lazy" and var12[10] < var12[9] and not var12[13] then
                                    num1 = var12[12] == "greedy" and var12[6] or var12[2]
                                    var4 = var12[3]
                                    if var12[12] == "greedy" then
                                        table.remove(tbl14, 1)
                                        break
                                    end
                                    if var12[10] >= var12[8] then
                                        var12[13] = true
                                        break
                                    end
                                end
                            elseif var12[7] == 33 then
                                table.remove(tbl14, 1)
                                num1 = var12[6]
                                var4 = var12[3]
                                break
                            end
                        elseif var11 == "quantifier" and math.sign(var12[4] - var12[3]) == math.sign(var12[5]) then
                            var12[3] += var12[5]
                            num1 = var12[2]
                            var4 = var12[3]
                            break
                        end

                        table.remove(tbl14, 1)
                    end
                end
                var7 = num1 + 1
            end
        end

        num1 = var7
    end

    if bool1 then
        return true
    end
    local bool2 = false
    local var7 = table.create(token.group_n)
    local groupN = token.group_n
    var7[0] = { arg2, var4 }
    var7.n = groupN
    for _, value in ipairs(tbl14) do
        if value[1] == "matchStart" and not bool2 then
            var7[0][1] = value[2]
            bool2 = true
        elseif value[1] == "group" and value[5] and not var7[value[5]] then
            var7[value[5]] = { value[3], value[4] }
        end
    end
    return var7
end

local function func6(arg1, arg2, arg3)
    return (re_rawfind(arg1.token, to_str_arr(arg2, arg3), 1, arg1.flags, arg1.verb_flags, true))
end

local str1 = "test"

function tbl2.test(...)
    local select = select
    local var3 = select("#", ...)
    if var3 < 1 then
        error("missing argument #1 (RegEx expected)", 2)
    elseif var3 < 2 then
        error("missing argument #2 (string expected)", 2)
    end
    local var4, var5, var6, var7, var8, var9 = ...
    if not var1[var4] or var1[var4].name ~= "RegEx" then
        if type(var4) ~= "string" and type(var4) ~= "number" then
            error(string.format("invalid argument #1 to %q (RegEx expected, got %s)", str1, typeof(var4)), 2)
        end
        var4 = tbl1.fromstring(var4)
    elseif str1 == "sub" then
        if type(var6) == "number" then
            var6 ..= ""
        elseif type(var6) ~= "string" then
            error(string.format("invalid argument #3 to 'sub' (string expected, got %s)", typeof(var6)), 2)
        end
    elseif type(var5) == "number" then
        var5 ..= ""
    elseif type(var5) ~= "string" then
        error(string.format("invalid argument #2 to %q (string expected, got %s)", str1, typeof(var5)), 2)
    end
    if str1 ~= "sub" and str1 ~= "split" then
        local str2 = typeof(var6)
        if str2 ~= "nil" then
            var6 = tonumber(var6)
            if not var6 then
                error(string.format("invalid argument #3 to %q (number expected, got %s)", str1, str2), 2)
            elseif var6 < 0 then
                var6 = #var5 + math.floor(var6 + 0.5) + 1
            else
                var6 = math.max(math.floor(var6 + 0.5), 1)
            end
        end
    end
    local var10 = var1[var4]
    if str1 == "match" or str1 == "matchiter" then
        var7 = ...
    elseif str1 == "sub" then
        var9 = ...
    end

    return func6(var10, var5, var6, var7, var8, var9)
end

local function func7(arg1, input, arg2, source)
    local var3 = re_rawfind(arg1.token, to_str_arr(input, arg2), 1, arg1.flags, arg1.verb_flags, false)
    if not var3 then
        return nil
    end
    return (new_match(var3, arg1.group_id, source, input))
end

local str2 = "match"

function tbl2.match(...)
    local select = select
    local var3 = select("#", ...)
    if var3 < 1 then
        error("missing argument #1 (RegEx expected)", 2)
    elseif var3 < 2 then
        error("missing argument #2 (string expected)", 2)
    end
    local var4, var5, var6, var7, var8, var9 = ...
    if not var1[var4] or var1[var4].name ~= "RegEx" then
        if type(var4) ~= "string" and type(var4) ~= "number" then
            error(string.format("invalid argument #1 to %q (RegEx expected, got %s)", str2, typeof(var4)), 2)
        end
        var4 = tbl1.fromstring(var4)
    elseif str2 == "sub" then
        if type(var6) == "number" then
            var6 ..= ""
        elseif type(var6) ~= "string" then
            error(string.format("invalid argument #3 to 'sub' (string expected, got %s)", typeof(var6)), 2)
        end
    elseif type(var5) == "number" then
        var5 ..= ""
    elseif type(var5) ~= "string" then
        error(string.format("invalid argument #2 to %q (string expected, got %s)", str2, typeof(var5)), 2)
    end
    if str2 ~= "sub" and str2 ~= "split" then
        local str3 = typeof(var6)
        if str3 ~= "nil" then
            var6 = tonumber(var6)
            if not var6 then
                error(string.format("invalid argument #3 to %q (number expected, got %s)", str2, str3), 2)
            elseif var6 < 0 then
                var6 = #var5 + math.floor(var6 + 0.5) + 1
            else
                var6 = math.max(math.floor(var6 + 0.5), 1)
            end
        end
    end
    local var10 = var1[var4]
    if str2 == "match" or str2 == "matchiter" then
        var7 = ...
    elseif str2 == "sub" then
        var9 = ...
    end

    return func7(var10, var5, var6, var7, var8, var9)
end

local function func8(arg1, arg2, arg3, source)
    local var3 = to_str_arr(arg2, arg3)
    local num1 = 1
    return function()
        local var4 = num1 <= var3.n + 1 and re_rawfind(arg1.token, var3, num1, arg1.flags, arg1.verb_flags, false)

        if not var4 then
            return nil
        end
        num1 = var4[0][2] + (if var4[0][1] >= var4[0][2] then 1 else 0)
        return (new_match(var4, arg1.group_id, source, var3.s))
    end
end

local str3 = "matchall"

function tbl2.matchall(...)
    local select = select
    local var3 = select("#", ...)
    if var3 < 1 then
        error("missing argument #1 (RegEx expected)", 2)
    elseif var3 < 2 then
        error("missing argument #2 (string expected)", 2)
    end
    local var4, var5, var6, var7, var8, var9 = ...
    if not var1[var4] or var1[var4].name ~= "RegEx" then
        if type(var4) ~= "string" and type(var4) ~= "number" then
            error(string.format("invalid argument #1 to %q (RegEx expected, got %s)", str3, typeof(var4)), 2)
        end
        var4 = tbl1.fromstring(var4)
    elseif str3 == "sub" then
        if type(var6) == "number" then
            var6 ..= ""
        elseif type(var6) ~= "string" then
            error(string.format("invalid argument #3 to 'sub' (string expected, got %s)", typeof(var6)), 2)
        end
    elseif type(var5) == "number" then
        var5 ..= ""
    elseif type(var5) ~= "string" then
        error(string.format("invalid argument #2 to %q (string expected, got %s)", str3, typeof(var5)), 2)
    end
    if str3 ~= "sub" and str3 ~= "split" then
        local str4 = typeof(var6)
        if str4 ~= "nil" then
            var6 = tonumber(var6)
            if not var6 then
                error(string.format("invalid argument #3 to %q (number expected, got %s)", str3, str4), 2)
            elseif var6 < 0 then
                var6 = #var5 + math.floor(var6 + 0.5) + 1
            else
                var6 = math.max(math.floor(var6 + 0.5), 1)
            end
        end
    end
    local var10 = var1[var4]
    if str3 == "match" or str3 == "matchiter" then
        var7 = ...
    elseif str3 == "sub" then
        var9 = ...
    end

    return func8(var10, var5, var6, var7, var8, var9)
end

local function insert_tokenized_sub(tbl14: {any}, tbl15: {any}, arg1, arg2)
    for _, value in ipairs(arg2) do
        if type(value) == "table" then
            if value[1] ~= "condition" then
                table.move(value, 1, #value, #tbl14 + 1, tbl14)
            elseif arg1[value[2]] then
                if value[3] then
                    insert_tokenized_sub(tbl14, tbl15, arg1, value[3])
                else
                    table.move(tbl15, arg1[value[2]][1], arg1[value[2]][2] - 1, #tbl14 + 1, tbl14)
                end
            elseif value[4] then
                insert_tokenized_sub(tbl14, tbl15, arg1, value[4])
            end
        elseif arg1[value] then
            table.move(tbl15, arg1[value][1], arg1[value][2] - 1, #tbl14 + 1, tbl14)
        end
    end
    tbl14.n = #tbl14
    return tbl14
end

local function func9(arg1, arg2, arg3, arg4, arg5, source)
    if arg5 ~= nil and type(arg5) ~= "number" and type(arg5) ~= "string" then
        error(string.format("invalid argument #5 to 'sub' (string expected, got %s)", typeof(arg5)), 3)
    end
    local tbl14 = { l = false, o = false, u = false }

    for value in string.gmatch(arg5 or "", utf8.charpattern) do
        if tbl14[value] ~= false then
            error("invalid regular expression substitution flag " .. value, 3)
        end
        tbl14[value] = true
    end
    local str4 = type(arg2)
    if str4 == "number" then
        arg2 ..= ""
    elseif str4 ~= "string" and str4 ~= "function" and (not tbl14.o or str4 ~= "table") then
        error(
            string.format(
                "invalid argument #2 to 'sub' (string/function%s expected, got %s)",
                if tbl14.o then "/table" else "",
                typeof(arg2)
            ),
            3
        )
    end

    if tonumber(arg4) then
        arg4 = tonumber(arg4)
        arg4 = arg4 <= -1 and math.huge or arg4 ~= arg4 and math.huge or arg4
    elseif arg4 == nil then
        arg4 = math.huge
    else
        error(string.format("invalid argument #4 to 'sub' (number expected, got %s)", typeof(arg4)), 3)
    end

    if arg4 < 1 then
        return arg3, 0
    end
    local num1 = 0
    if str4 == "string" then
        local var3 = to_str_arr(arg2)
        if tbl14.l then
            arg2 = var3
        else
            local var4 = table.create(3)
            local groupN = arg1.token.group_n
            local num2 = 0
            local tbl15 = {}

            while num2 < var3.n do
                local num3 = num2

                repeat
                    num2 += 1
                until not var3[num2] or var3[num2] == 36 or var3[num2] == 92 or (var3[num2] == 58 or var3[num2] == 125) and tbl15[1]

                num1 += num2 - num3 - 1
                if num2 - num3 > 1 then
                    table.insert(var4, table.move(var3, num3 + 1, num2 - 1, 1, table.create(num2 - num3 - 1)))
                end
                if var3[num2] == 58 then
                    local var5 = tbl15[1]
                    if var5[2] then
                        error("malformed substitution pattern", 3)
                    end
                    var5[2] = table.move(var4, var5[3], #var4, 1, table.create(#var4 + 1 - var5[3]))
                    for i = #var4, var5[3], -1 do
                        var4[i] = nil
                    end
                elseif var3[num2] == 125 then
                    local var5 = table.remove(tbl15, 1)
                    local tbl16 = table.move(var4, var5[3], #var4, 1, table.create(#var4 + 1 - var5[3]))
                    for i = #var4, var5[3], -1 do
                        var4[i] = nil
                    end
                    table.insert(var4, { "condition", var5[1], not (var5[2] == true) and (var5[2] or tbl16), var5[2] and tbl16 })
                elseif var3[num2] then
                    num2 += 1
                    local var5 = var3[num2]
                    if not var5 then
                        if var3[num2 - 1] == 92 then
                            error("replacement string must not end with a trailing backslash", 3)
                        end
                        local var6 = var4[#var4]
                        if type(var6) == "table" then
                            table.insert(var6, var3[num2 - 1])
                        else
                            table.insert(var4, { var3[num2 - 1] })
                        end
                    elseif var5 == 92 and var3[num2 - 1] == 36 then
                        local var6 = var4[#var4]
                        if type(var6) == "table" then
                            table.insert(var6, 36)
                        else
                            table.insert(var4, { 36 })
                        end
                        num2 -= 1
                        num1 += 1
                    elseif var5 == 48 then
                        table.insert(var4, 0)
                    elseif var5 > 48 and var5 <= 57 then
                        local var6 = var5 - 48
                        while var3[num2 + 1] and var3[num2 + 1] >= 48 and var3[num2 + 1] <= 57 do
                            var6 ..= var3[num2 + 1] - 48
                            num2 += 1
                        end
                        local var7 = tonumber(var6)
                        if not tbl14.u and groupN < var7 then
                            error("reference to non-existent subpattern", 3)
                        end
                        table.insert(var4, var7)
                    elseif var5 == 123 and var3[num2 - 1] == 36 then
                        num2 += 1
                        local num4 = num2

                        while var3[num2]
                            and (var3[num2] >= 48 and var3[num2] <= 57
                                or var3[num2] >= 65 and var3[num2] <= 90
                                or var3[num2] >= 97 and var3[num2] <= 122
                                or var3[num2] == 95) do
                            num2 += 1
                        end
                        if (var3[num2] == 125 or var3[num2] == 58 and (var3[num2 + 1] == 43 or var3[num2 + 1] == 45)) and num2 ~= num4 then
                            local str5 = utf8_sub(var3.s, num4, num2)
                            local var6

                            if var3[num4] >= 48 and var3[num4] <= 57 then
                                var6 = tonumber(str5)
                                if not tbl14.u and groupN < var6 then
                                    error("reference to non-existent subpattern", 3)
                                end
                            else
                                var6 = arg1.group_id[str5]
                                if not tbl14.u and (not var6 or groupN < var6) then
                                    error("reference to non-existent subpattern", 3)
                                end
                            end
                            if var3[num2] == 58 then
                                num2 += 1
                                table.insert(tbl15, { var6, var3[num2] == 45, #var4 + 1 })
                            else
                                table.insert(var4, var6)
                            end
                        else
                            error("malformed substitution pattern", 3)
                        end
                    else
                        local var6 = nil
                        if var3[num2 - 1] ~= 36 then
                            var6 = tbl6[var3[num2]]
                            if type(var6) ~= "number" then
                                var6 = nil
                            end
                        elseif var5 ~= 36 then
                            local var7 = var4[#var4]
                            if type(var7) == "table" then
                                table.insert(var7, 36)
                            else
                                table.insert(var4, { 36 })
                            end
                        end

                        local var7 = var4[#var4]
                        if type(var7) == "table" then
                            table.insert(var7, var6 or var3[num2])
                        else
                            table.insert(var4, { var6 or var3[num2] })
                        end
                        num1 += 1
                    end
                end
            end

            if tbl15[1] then
                error("malformed substitution pattern", 3)
            end
            if var4[2] or type(var4[1]) ~= "table" or var4[1][1] == "condition" then
                arg2 = var4
                str4 = "subst_string"
            else
                arg2 = var4[1]
                var3.n = #var4[1]
            end
        end
    end

    arg3 = to_str_arr(arg3)
    local num2 = 0
    local num3 = 1
    local num4 = 0

    while num3 <= arg3.n + num2 + 1 do
        local var3 = re_rawfind(arg1.token, arg3, num3, arg1.flags, arg1.verb_flags, false)
        if not var3 then
            break
        end

        local var4 = nil
        if str4 == "string" then
            var4 = arg2
        elseif str4 == "subst_string" then
            var4 = insert_tokenized_sub(table.create(num1), arg3, var3, arg2)
        else
            local var5, var6

            if str4 == "table" then
                var5 = utf8_sub(arg3.s, var3[0][1], var3[0][2])
                var6 = arg2[var5]
            else
                var5 = new_match(var3, arg1.group_id, source, arg3.s)
                var6 = arg2(var5)
            end
            if var6 == var5 or tbl14.o and not var6 then
                local n = var3[0][2] - var3[0][1]
                var4 = table.move(arg3, var3[0][1], var3[0][2] - 1, 1, table.create(n))
                var4.n = n
            elseif type(var6) == "string" then
                var4 = to_str_arr(var6)
            elseif type(var6) == "number" then
                var4 = to_str_arr(var6 .. "")
            elseif tbl14.o then
                error(string.format("invalid replacement value (a %s)", type(var6)), 3)
            else
                var4 = { n = 0 }
            end
        end

        local var5 = var3[0][2] - var3[0][1]
        local num5 = math.min(var4.n, var5)
        for i = 0, num5 - 1 do
            arg3[var3[0][1] + i] = var4[i + 1]
        end
        local var6 = var3[0][1] + num5
        num3 = var3[0][2]
        if var4.n < var5 then
            for _ = 1, var5 - var4.n do
                table.remove(arg3, var6)
                num2 -= 1
                num3 -= 1
            end
        elseif var5 < var4.n then
            for i = 1, var4.n - var5 do
                table.insert(arg3, var6 + i - 1, var4[num5 + i])
                num2 += 1
                num3 += 1
            end
        end
        if var5 <= 0 then
            num3 += 1
        end
        num4 += 1
        if arg4 < num4 + 1 then
            break
        end
    end

    return from_str_arr(arg3), num4
end

local str4 = "sub"

function tbl2.sub(...)
    local select = select
    local var3 = select("#", ...)
    if var3 < 1 then
        error("missing argument #1 (RegEx expected)", 2)
    elseif var3 < 2 then
        error("missing argument #2 (string expected)", 2)
    end
    local var4, var5, var6, var7, var8, var9 = ...
    if not var1[var4] or var1[var4].name ~= "RegEx" then
        if type(var4) ~= "string" and type(var4) ~= "number" then
            error(string.format("invalid argument #1 to %q (RegEx expected, got %s)", str4, typeof(var4)), 2)
        end
        var4 = tbl1.fromstring(var4)
    elseif str4 == "sub" then
        if type(var6) == "number" then
            var6 ..= ""
        elseif type(var6) ~= "string" then
            error(string.format("invalid argument #3 to 'sub' (string expected, got %s)", typeof(var6)), 2)
        end
    elseif type(var5) == "number" then
        var5 ..= ""
    elseif type(var5) ~= "string" then
        error(string.format("invalid argument #2 to %q (string expected, got %s)", str4, typeof(var5)), 2)
    end
    if str4 ~= "sub" and str4 ~= "split" then
        local str5 = typeof(var6)
        if str5 ~= "nil" then
            var6 = tonumber(var6)
            if not var6 then
                error(string.format("invalid argument #3 to %q (number expected, got %s)", str4, str5), 2)
            elseif var6 < 0 then
                var6 = #var5 + math.floor(var6 + 0.5) + 1
            else
                var6 = math.max(math.floor(var6 + 0.5), 1)
            end
        end
    end
    local var10 = var1[var4]
    if str4 == "match" or str4 == "matchiter" then
        var7 = ...
    elseif str4 == "sub" then
        var9 = ...
    end

    return func9(var10, var5, var6, var7, var8, var9)
end

local function func10(arg1, arg2, arg3): {string}
    if tonumber(arg3) then
        arg3 = tonumber(arg3)
        arg3 = arg3 <= -1 and math.huge or arg3 ~= arg3 and math.huge or arg3
    elseif arg3 == nil then
        arg3 = math.huge
    else
        error(string.format("invalid argument #3 to 'split' (number expected, got %s)", typeof(arg3)), 3)
    end

    arg2 = to_str_arr(arg2)
    local num1 = 1
    local num2 = 0
    local num3 = 0
    local result = {}

    while num1 <= arg2.n + 1 do
        num2 += 1
        local var3 = num2 <= arg3 and re_rawfind(arg1.token, arg2, num1, arg1.flags, arg1.verb_flags, false)

        if not var3 then
            break
        end

        table.insert(result, (utf8_sub(arg2.s, num1 - num3, var3[0][1])))
        num3 = if var3[0][1] >= var3[0][2] then 1 else 0
        num1 = var3[0][2] + num3
    end
    table.insert(result, string.sub(arg2.s, utf8.offset(arg2.s, num1 - num3)))
    return result
end

local str5 = "split"

function tbl2.split(...)
    local select = select
    local var3 = select("#", ...)
    if var3 < 1 then
        error("missing argument #1 (RegEx expected)", 2)
    elseif var3 < 2 then
        error("missing argument #2 (string expected)", 2)
    end
    local var4, var5, var6, var7, var8, var9 = ...
    if not var1[var4] or var1[var4].name ~= "RegEx" then
        if type(var4) ~= "string" and type(var4) ~= "number" then
            error(string.format("invalid argument #1 to %q (RegEx expected, got %s)", str5, typeof(var4)), 2)
        end
        var4 = tbl1.fromstring(var4)
    elseif str5 == "sub" then
        if type(var6) == "number" then
            var6 ..= ""
        elseif type(var6) ~= "string" then
            error(string.format("invalid argument #3 to 'sub' (string expected, got %s)", typeof(var6)), 2)
        end
    elseif type(var5) == "number" then
        var5 ..= ""
    elseif type(var5) ~= "string" then
        error(string.format("invalid argument #2 to %q (string expected, got %s)", str5, typeof(var5)), 2)
    end
    if str5 ~= "sub" and str5 ~= "split" then
        local str6 = typeof(var6)
        if str6 ~= "nil" then
            var6 = tonumber(var6)
            if not var6 then
                error(string.format("invalid argument #3 to %q (number expected, got %s)", str5, str6), 2)
            elseif var6 < 0 then
                var6 = #var5 + math.floor(var6 + 0.5) + 1
            else
                var6 = math.max(math.floor(var6 + 0.5), 1)
            end
        end
    end
    local var10 = var1[var4]
    if str5 == "match" or str5 == "matchiter" then
        var7 = ...
    elseif str5 == "sub" then
        var9 = ...
    end

    return func10(var10, var5, var6, var7, var8, var9)
end

local function re_index(arg1, arg2) -- Luacid: unused: defined but never referenced
    return tbl2[arg2] or var1[arg1].flags[arg2]
end

local function re_tostr(arg1)
    return var1[arg1].pattern_repr .. var1[arg1].flag_repr
end

local tbl14 = { [58] = true, [33] = true, [61] = true, [62] = true, [124] = true }

local function tokenize_ptn(tbl15: {any}, flags)
    if flags.unicode then
        return "USE_UNICODE_DATA has always been false, so you cannot also use the unicode flag"
    end
    local n = tbl15.n
    local num1 = 1
    local tbl16 = ({})
    local num2 = 0
    local tbl17 = ({})
    local tbl18 = { newline = 1, newline_seq = 1, not_empty = 0 }

    while true do
        local bool1 = false

        if not (num1 <= n) then
            break
        end

        local var3 = tbl15[num1]
        if var3 == 40 then
            local var4 = nil
            if tbl15[num1 + 1] == 42 then
                num1 += 2
                local num3 = num1

                while tbl15[num1]
                    and (tbl15[num1] >= 48 and tbl15[num1] <= 57
                        or tbl15[num1] >= 65 and tbl15[num1] <= 90
                        or tbl15[num1] >= 97 and tbl15[num1] <= 122
                        or tbl15[num1] == 95
                        or tbl15[num1] == 58) do
                    num1 += 1
                end
                if tbl15[num1] ~= 41 and tbl15[num1 - 1] ~= 58 then
                    return "quantifier doesn't follow a repeatable pattern"
                end
                local newline = utf8_sub(tbl15.s, num3, num1)
                if newline == "positive_lookahead:"
                    or newline == "negative_lookhead:"
                    or newline == "positive_lookbehind:"
                    or newline == "negative_lookbehind:"
                    or newline:find("^[pn]l[ab]:$")
                then
                    var4 = {
                        40,
                        nil,
                        nil,
                        if newline:find("^n") then 33 else 61,
                        newline:find("b", 3, true) and 1
                    }
                elseif newline == "atomic:" then
                    var4 = {
                        40,
                        nil,
                        nil,
                        62,
                        nil
                    }
                elseif newline == "ACCEPT" or newline == "FAIL" or newline == "F" or newline == "PRUNE" or newline == "SKIP" then
                    var4 = if newline == "F" then "FAIL" else newline
                else
                    if tbl13[newline] then
                        tbl18.newline = newline
                    elseif newline == "BSR_ANYCRLF" or newline == "BSR_UNICODE" then
                        tbl18.newline_seq = if newline == "BSR_UNICODE" then 1 else 0
                    else
                        if newline ~= "NOTEMPTY" and newline ~= "NOTEMPTY_ATSTART" then
                            return "unknown or malformed verb"
                        end

                        tbl18.not_empty = if newline == "NOTEMPTY" then 1 else 2
                    end
                    if tbl16[1] then
                        return "this verb must be placed at the beginning of the regex"
                    end
                end
            elseif tbl15[num1 + 1] == 63 then
                num1 += 2
                if tbl15[num1] == 35 then
                    local var5 = table.find(tbl15, 41, num1)
                    if not var5 then
                        return "unterminated parenthetical"
                    end
                    num1 = var5 + 1
                    continue
                end
                if not tbl15[num1] then
                    return "unterminated parenthetical"
                end
                var4 = {
                    40,
                    nil,
                    nil,
                    tbl15[num1],
                    nil
                }

                if tbl15[num1] == 48 and tbl15[num1 + 1] == 41 then
                    var4[1] = "recurmatch"
                    var4[2] = 0
                    var4[3] = 0
                    var4[5] = nil
                elseif tbl15[num1] > 48 and tbl15[num1] <= 57 then
                    local num3 = num1 + 1
                    while tbl15[num3] >= 48 and tbl15[num3] <= 48 do
                        num3 += 1
                    end
                    if tbl15[num3] ~= 41 then
                        return "invalid group structure"
                    end
                    local var5 = tonumber((utf8_sub(tbl15.s, num1, num3)))
                    var4[1] = "recurmatch"
                    var4[2] = var5
                    var4[4] = nil
                    num1 = num3
                elseif tbl15[num1] == 60 and tbl15[num1 + 1] == 33 or tbl15[num1 + 1] == 61 then
                    num1 += 1
                    var4[4] = tbl15[num1]
                    var4[5] = 1
                elseif tbl15[num1] == 124 then
                    var4[5] = num2
                elseif tbl15[num1] == 80 or tbl15[num1] == 60 or tbl15[num1] == 39 then
                    if tbl15[num1] == 80 then
                        num1 += 1
                    end
                    if tbl15[num1] == 61 then
                        local num3 = num1 + 1

                        while tbl15[num1]
                            and (tbl15[num1] >= 48 and tbl15[num1] <= 57
                                or tbl15[num1] >= 65 and tbl15[num1] <= 90
                                or tbl15[num1] >= 97 and tbl15[num1] <= 122
                                or tbl15[num1] == 95) do
                            num1 += 1
                        end
                        if not tbl15[num1] then
                            return "unterminated parenthetical"
                        end

                        if tbl15[num1] ~= 41 or num1 == num3 then
                            return "invalid group structure"
                        end
                        var4 = { nil, nil }
                        local s = tbl15.s
                        local num4 = utf8.offset(s, num1)
                        local num5 = utf8.offset(s, num3)
                        local num6 = num4 and num4 - 1
                        var4[1], var4[2] = "backref", string.sub(s, num5, num6)
                    else
                        if tbl15[num1] ~= 60 and (tbl15[num1 - 1] == 80 or tbl15[num1] ~= 39) then
                            return "invalid group structure"
                        end

                        local num3 = if tbl15[num1] == 39 then 39 else 62
                        local num4 = num1 + 1
                        local num5 = num1 + 1
                        if tbl15[num5] == 41 then
                            return "missing character in subpattern"
                        end

                        if tbl15[num5] >= 48 and tbl15[num5] <= 57 then
                            return "subpattern name must not begin with a digit"
                        end

                        if not (tbl15[num5] >= 65 and tbl15[num5] <= 90) and not (tbl15[num5] >= 97 and tbl15[num5] <= 122) and tbl15[num5] ~= 95 then
                            return "invalid character in subpattern"
                        end
                        num1 = num5 + 1

                        while tbl15[num1]
                            and (tbl15[num1] >= 48 and tbl15[num1] <= 57
                                or tbl15[num1] >= 65 and tbl15[num1] <= 90
                                or tbl15[num1] >= 97 and tbl15[num1] <= 122
                                or tbl15[num1] == 95) do
                            num1 += 1
                        end
                        if not tbl15[num1] then
                            return "unterminated parenthetical"
                        end

                        if tbl15[num1] ~= num3 then
                            return "invalid character in subpattern"
                        end
                        local str6 = utf8_sub(tbl15.s, num4, num1)
                        num2 += 1
                        if (tbl17[str6] or num2) ~= num2 then
                            return "subpattern name already exists"
                        end
                        for k, value in pairs(tbl17) do
                            if str6 ~= k and num2 == value then
                                return "different names for subpatterns of the same number aren't permitted"
                            end
                        end
                        tbl17[str6] = num2
                        var4[2] = num2
                        var4[4] = nil
                    end
                elseif not tbl14[tbl15[num1]] then
                    return "invalid group structure"
                end
            else
                num2 += 1
                var4 = {
                    40,
                    num2,
                    nil,
                    nil
                }
            end
            if var4 then
                table.insert(tbl16, var4)
            end
        elseif var3 == 41 then
            local num3 = #tbl16 + 1
            local num4 = 0
            local num5 = -1
            local num6 = 0
            local num7 = 0

            while true do
                num3 -= 1
                local var4 = tbl16[num3]
                local bool2 = type(tbl16[num3]) == "table"
                if bool2 and var4[1] == 40 then
                    num7 += 1
                    if num4 and var4.count then
                        num4 += var4.count
                    end
                    if not var4[3] then
                        if var4[4] == 124 then
                            num2 = var4[5] + math.max(num6, num7)
                        end
                        if num4 ~= num5 and num5 ~= -1 then
                            num4 = nil
                        end

                        break
                    end
                elseif var4 == tbl12 then
                    local var5

                    if num4 == num5 or num5 == -1 then
                        var5 = 0
                    else
                        num4 = nil
                        var5 = nil
                    end

                    num6 = math.max(num6, num7)
                    num5 = num4
                    num4 = var5
                    num7 = 0
                elseif num4 then
                    if bool2 and var4[1] == "quantifier" then
                        if var4[2] == var4[3] then
                            num4 += var4[2]
                        else
                            num4 = nil
                        end
                    else
                        num4 += 1
                    end
                end
                if num3 < 1 then
                    num4 = num5
                    break
                end
            end

            if num3 < 1 then
                return "unmatched ) in regular expression"
            end
            local var4 = tbl16[num3]
            local num8 = #tbl16 + 1
            local tbl19 = {
                41,
                var4[2],
                num3,
                var4[4],
                var4[5],
                count = num4
            }

            if (var4[4] == 33 or var4[4] == 61) and var4[5] and not num4 then
                return "lookbehind assertion is not fixed width"
            end
            var4[3] = num8
            table.insert(tbl16, tbl19)
        elseif var3 == 46 then
            table.insert(tbl16, tbl10)
        elseif var3 == 91 then
            local bool2 = false
            local var4 = nil
            local num3 = num1 + 1

            if tbl15[num3] == 94 then
                num1 = num3 + 1
                bool2 = true
            elseif tbl15[num3] == 46 or tbl15[num3] == 58 or tbl15[num3] == 61 then
                var4 = tbl15[num3]
                num1 = num3
            else
                num1 = num3
            end

            local tbl19

            if tbl15[num1] == 91 or tbl15[num1] == 92 then
                tbl19 = {}
            else
                tbl19 = { tbl15[num1] }
                num1 += 1
            end
            while tbl15[num1] ~= 93 do
                if not tbl15[num1] then
                    return "unterminated character class"
                end

                if tbl15[num1] == 45 and tbl19[1] and type(tbl19[1]) == "number" then
                    if tbl15[num1 + 1] == 93 then
                        table.insert(tbl19, 1, 45)
                    else
                        num1 += 1
                        local var5 = tbl15[num1]
                        if var5 == 91 then
                            if tbl15[num1 + 1] == 46 or tbl15[num1 + 1] == 58 or tbl15[num1 + 1] == 61 then
                                local num4 = num1 + 2
                                repeat
                                    num4 = table.find(tbl15, 93, num4)
                                until not num4 or tbl15[num4 - 1] ~= 92

                                if not num4 then
                                    return "unterminated character class"
                                end

                                if tbl15[num4 - 1] == tbl15[num1 + 1] and num4 - 1 ~= num1 + 1 then
                                    return "invalid range in character class"
                                end
                            end
                            if tbl19[1] > 91 then
                                return "invalid range in character class"
                            end
                        elseif var5 == 92 then
                            num1 += 1
                            if tbl15[num1] == 120 then
                                local var6 = nil
                                local var7 = nil
                                local num4 = num1 + 1
                                if tbl15[num4] and tbl15[num4] >= 48 and tbl15[num4] <= 57
                                    or tbl15[num4] >= 65 and tbl15[num4] <= 70
                                    or tbl15[num4] >= 97 and tbl15[num4] <= 102
                                then
                                    var6 = tbl15[num4] - (if tbl15[num4] >= 65 and tbl15[num4] <= 90 then 55 else tbl15[num4] >= 97 and tbl15[num4] <= 122 and 87 or 48)
                                    num1 = num4 + 1
                                    if tbl15[num1] and tbl15[num1] >= 48 and tbl15[num1] <= 57
                                        or tbl15[num1] >= 65 and tbl15[num1] <= 70
                                        or tbl15[num1] >= 97 and tbl15[num1] <= 102
                                    then
                                        var7 = tbl15[num1] - (if tbl15[num1] >= 65 and tbl15[num1] <= 90 then 55 else tbl15[num1] >= 97 and tbl15[num1] <= 122 and 87 or 48)
                                    else
                                        num1 -= 1
                                    end
                                else
                                    num1 = num4 - 1
                                end
                                var5 = if var6 then var7 and 16 * var6 + var7 or var6 or 0 else 0
                            elseif tbl15[num1] >= 48 and tbl15[num1] <= 55 then
                                var5 = tbl15[num1] - 48
                                local var6 = nil
                                local var7 = nil
                                local num4 = num1 + 1
                                if tbl15[num4] and tbl15[num4] >= 48 and tbl15[num4] <= 55 then
                                    var6 = tbl15[num4] - 48
                                    num1 = num4 + 1
                                    if tbl15[num1] and tbl15[num1] >= 48 and tbl15[num1] <= 55 then
                                        var7 = tbl15[num1] - 48
                                    else
                                        num1 -= 1
                                    end
                                else
                                    num1 = num4 - 1
                                end
                                if var6 then
                                    var5 = var7 and 64 * var5 + 8 * var6 + var7 or 8 * var5 + var6 or var5
                                end
                            else
                                var5 = tbl6[tbl15[num1]] or tbl15[num1]
                                if type(var5) ~= "number" then
                                    return "invalid range in character class"
                                end
                            end
                        elseif var5 < tbl19[1] then
                            return "invalid range in character class"
                        end
                        tbl19[1] = { "range", tbl19[1], var5 }
                    end
                elseif tbl15[num1] == 91 then
                    if tbl15[num1 + 1] == 46 or tbl15[num1 + 1] == 58 or tbl15[num1 + 1] == 61 then
                        local num4 = num1 + 2
                        repeat
                            num4 = table.find(tbl15, 93, num4)
                        until not num4 or tbl15[num4 - 1] ~= 92

                        if not num4 then
                            return "unterminated character class"
                        end

                        if tbl15[num4 - 1] ~= tbl15[num1 + 1] or num4 - 1 == num1 + 1 then
                            table.insert(tbl19, 1, 91)
                        else
                            if tbl15[num4 - 1] == 46 or tbl15[num4 - 1] == 61 then
                                return "POSIX collating elements aren't supported"
                            end

                            if tbl15[num4 - 1] == 58 then
                                local bool3 = tbl15[num1 + 3] == 94
                                local str6 = utf8_sub(tbl15.s, num1 + (if bool3 then 3 else 2), num4 - 1)

                                if not tbl5[str6] then
                                    return "unknown POSIX class name"
                                end
                                table.insert(tbl19, 1, { "class", str6, bool3 })
                                num1 = num4
                            end
                        end
                    else
                        table.insert(tbl19, 1, 91)
                    end
                elseif tbl15[num1] == 92 then
                    num1 += 1
                    if tbl15[num1] == 120 then
                        local var5 = nil
                        local var6 = nil
                        local num4 = num1 + 1
                        if tbl15[num4] == 123 then
                            num1 = num4 + 1
                            local num5 = num1

                            while tbl15[num1]
                                and (tbl15[num1] >= 48 and tbl15[num1] <= 57
                                    or tbl15[num1] >= 65 and tbl15[num1] <= 70
                                    or tbl15[num1] >= 97 and tbl15[num1] <= 102) do
                                num1 += 1
                            end
                            if tbl15[num1] ~= 125 or num1 == num5 then
                                return "malformed hexadecimal character"
                            end

                            if num1 - num5 > 4 then
                                return "character offset too large"
                            end

                            table.insert(tbl19, 1, tonumber(utf8_sub(tbl15.s, num5, num1), 16))
                        else
                            if tbl15[num4] and tbl15[num4] >= 48 and tbl15[num4] <= 57
                                or tbl15[num4] >= 65 and tbl15[num4] <= 70
                                or tbl15[num4] >= 97 and tbl15[num4] <= 102
                            then
                                var5 = tbl15[num4] - (if tbl15[num4] >= 65 and tbl15[num4] <= 90 then 55 else tbl15[num4] >= 97 and tbl15[num4] <= 122 and 87 or 48)
                                num1 = num4 + 1
                                if tbl15[num1] and tbl15[num1] >= 48 and tbl15[num1] <= 57
                                    or tbl15[num1] >= 65 and tbl15[num1] <= 70
                                    or tbl15[num1] >= 97 and tbl15[num1] <= 102
                                then
                                    var6 = tbl15[num1] - (if tbl15[num1] >= 65 and tbl15[num1] <= 90 then 55 else tbl15[num1] >= 97 and tbl15[num1] <= 122 and 87 or 48)
                                else
                                    num1 -= 1
                                end
                            else
                                num1 = num4 - 1
                            end
                            table.insert(tbl19, 1, if var5 then var6 and 16 * var5 + var6 or var5 or 0 else 0)
                        end
                    elseif tbl15[num1] >= 48 and tbl15[num1] <= 55 then
                        local var5 = tbl15[num1] - 48
                        local var6 = nil
                        local var7 = nil
                        local num4 = num1 + 1
                        if tbl15[num4] and tbl15[num4] >= 48 and tbl15[num4] <= 55 then
                            var6 = tbl15[num4] - 48
                            num1 = num4 + 1
                            if tbl15[num1] and tbl15[num1] >= 48 and tbl15[num1] <= 55 then
                                var7 = tbl15[num1] - 48
                            else
                                num1 -= 1
                            end
                        else
                            num1 = num4 - 1
                        end
                        local num5 = 1

                        if var6 then
                            var5 = var7 and 64 * var5 + 8 * var6 + var7 or 8 * var5 + var6 or var5
                        end

                        table.insert(tbl19, num5, var5)
                    elseif tbl15[num1] ~= 69 then
                        if tbl15[num1] == 81 then
                            local num4 = num1 + 1
                            repeat
                                num1 = table.find(tbl15, 92, num1 + 1)
                            until not num1 or tbl15[num1 + 1] == 69

                            table.move(tbl15, num4, num1 and num1 - 1 or #tbl15, #tbl16 + 1, tbl16)
                            if not num1 then
                                break
                            end

                            num1 += 1
                        elseif tbl15[num1] == 78 then
                            if tbl15[num1 + 1] ~= 123 or tbl15[num1 + 2] ~= 85 or tbl15[num1 + 3] ~= 43 or not flags.unicode then
                                return "invalid escape sequence"
                            end

                            num1 += 4
                            local num4 = num1

                            while tbl15[num1]
                                and (tbl15[num1] >= 48 and tbl15[num1] <= 57
                                    or tbl15[num1] >= 65 and tbl15[num1] <= 70
                                    or tbl15[num1] >= 97 and tbl15[num1] <= 102) do
                                num1 += 1
                            end
                            if tbl15[num1] ~= 125 or num1 == num4 then
                                return "malformed Unicode code point"
                            end
                            table.insert(tbl19, 1, tonumber((utf8_sub(tbl15.s, num4, num1))))
                        else
                            if tbl15[num1] == 80 or tbl15[num1] == 112 then
                                return "USE_UNICODE_DATA in regexp has always been disabled. Do not use the flag \\p"
                            end

                            if tbl15[num1] == 111 then
                                local num4 = num1 + 1
                                if tbl15[num4] ~= 123 then
                                    return "malformed octal code"
                                end
                                num1 = num4 + 1
                                local num5 = num1

                                while tbl15[num1] and tbl15[num1] >= 48 and tbl15[num1] <= 55 do
                                    num1 += 1
                                end
                                if tbl15[num1] ~= 125 or num1 == num5 then
                                    return "malformed octal code"
                                end

                                local var5 = tonumber(utf8_sub(tbl15.s, num5, num1), 8)
                                if var5 > 65535 then
                                    return "character offset too large"
                                end
                                table.insert(tbl19, 1, var5)
                            else
                                local var5 = tbl6[tbl15[num1]]
                                table.insert(tbl19, 1, type(var5) == "string" and { "class", var5, false } or var5 or tbl15[num1])
                            end
                        end
                    end
                elseif flags.ignoreCase and tbl15[num1] >= 97 and tbl15[num1] <= 122 then
                    table.insert(tbl19, 1, tbl15[num1] - 32)
                else
                    table.insert(tbl19, 1, tbl15[num1])
                end
                num1 += 1
            end
            if tbl15[num1 - 1] == var4 and num1 - 1 ~= num3 then
                return if var4 == 58 then "POSIX named classes are only support within a character set" else "POSIX collating elements aren't supported"
            end
            if not (tbl19[2] or bool2) then
                table.insert(tbl16, tbl19[1])
            else
                table.insert(tbl16, { "charset", bool2, tbl19 })
            end
        elseif var3 == 92 then
            num1 += 1
            local var4 = tbl15[num1]
            if not var4 then
                return "pattern may not end with a trailing backslash"
            end

            if var4 >= 48 and var4 <= 57 then
                local num3 = num1

                while tbl15[num1 + 1] and tbl15[num1 + 1] >= 48 and tbl15[num1 + 1] <= 57 do
                    num1 += 1
                end
                local var5 = tonumber((utf8_sub(tbl15.s, num3, num1 + 1)))
                if num2 < var5 and num1 ~= num3 then
                    local var6 = nil
                    local var7 = nil
                    local var8

                    if tbl15[num3] <= 55 then
                        var8 = tbl15[num3] - 48
                        local num4 = num3 + 1
                        if tbl15[num4] and tbl15[num4] >= 48 and tbl15[num4] <= 55 then
                            var6 = tbl15[num4] - 48
                            num1 = num4 + 1
                            if tbl15[num1] and tbl15[num1] >= 48 and tbl15[num1] <= 55 then
                                var7 = tbl15[num1] - 48
                            else
                                num1 -= 1
                            end
                        else
                            num1 = num4 - 1
                        end
                    else
                        num1 = num3
                        var8 = nil
                    end

                    if var8 then
                        local var9 = var6 and (var7 and 64 * var8 + 8 * var6 + var7 or 8 * var8 + var6)

                        if var9 then
                            var8 = var9
                        elseif not var8 then
                            bool1 = true
                        end
                    else
                        bool1 = true
                    end

                    if bool1 then
                        var8 = tbl15[num3]
                    end

                    table.insert(tbl16, var8)
                else
                    table.insert(tbl16, { "backref", var5 })
                end
            elseif var4 ~= 69 then
                if var4 == 81 then
                    local num3 = num1 + 1
                    repeat
                        num1 = table.find(tbl15, 92, num1 + 1)
                    until not num1 or tbl15[num1 + 1] == 69

                    table.move(tbl15, num3, num1 and num1 - 1 or #tbl15, #tbl16 + 1, tbl16)
                    if not num1 then
                        break
                    end

                    num1 += 1
                elseif var4 ~= 78 then
                    if var4 == 80 or var4 == 112 then
                        return "USE_UNICODE_DATA in regexp has always been disabled. Do not use the flag \\p"
                    end

                    if var4 == 103 and (tbl15[num1 + 1] == 123 or tbl15[num1 + 1] >= 48 and tbl15[num1 + 1] <= 57) then
                        local bool2 = false
                        num1 += 1
                        if tbl15[num1] == 123 then
                            num1 += 1
                            bool2 = true
                        elseif tbl15[num1] < 48 or tbl15[num1] > 57 then
                            return "malformed reference code"
                        end

                        local num3 = num1

                        while tbl15[num1]
                            and (tbl15[num1] >= 48 and tbl15[num1] <= 57
                                or tbl15[num1] >= 65 and tbl15[num1] <= 70
                                or tbl15[num1] >= 97 and tbl15[num1] <= 102) do
                            num1 += 1
                        end
                        if bool2 and tbl15[num1] ~= 125 then
                            return "malformed reference code"
                        end
                        table.insert(tbl16, { "backref", tonumber((utf8_sub(tbl15.s, num3, num1 + (if bool2 then 0 else 1)))) })
                        if not bool2 then
                            num1 -= 1
                        end
                    elseif var4 == 111 then
                        local num3 = num1 + 1
                        if tbl15[num3 + 1] ~= 123 then
                            return "malformed octal code"
                        end
                        num1 = num3 + 1
                        local num4 = num1

                        while tbl15[num1] and tbl15[num1] >= 48 and tbl15[num1] <= 55 do
                            num1 += 1
                        end
                        if tbl15[num1] ~= 125 or num1 == num4 then
                            return "malformed octal code"
                        end

                        local var5 = tonumber(utf8_sub(tbl15.s, num4, num1), 8)
                        if var5 > 65535 then
                            return "character offset too large"
                        end
                        table.insert(tbl16, var5)
                    elseif var4 == 120 then
                        local var5 = nil
                        local var6 = nil
                        local num3 = num1 + 1
                        if tbl15[num3] == 123 then
                            num1 = num3 + 1
                            local num4 = num1

                            while tbl15[num1]
                                and (tbl15[num1] >= 48 and tbl15[num1] <= 57
                                    or tbl15[num1] >= 65 and tbl15[num1] <= 70
                                    or tbl15[num1] >= 97 and tbl15[num1] <= 102) do
                                num1 += 1
                            end
                            if tbl15[num1] ~= 125 or num1 == num4 then
                                return "malformed hexadecimal code"
                            end

                            if num1 - num4 > 4 then
                                return "character offset too large"
                            end

                            table.insert(tbl16, tonumber(utf8_sub(tbl15.s, num4, num1), 16))
                        else
                            if tbl15[num3]
                                and (tbl15[num3] >= 48 and tbl15[num3] <= 57
                                    or tbl15[num3] >= 65 and tbl15[num3] <= 70
                                    or tbl15[num3] >= 97 and tbl15[num3] <= 102)
                            then
                                var5 = tbl15[num3] - (if tbl15[num3] >= 65 and tbl15[num3] <= 90 then 55 else tbl15[num3] >= 97 and tbl15[num3] <= 122 and 87 or 48)
                                num1 = num3 + 1
                                if tbl15[num1]
                                    and (tbl15[num1] >= 48 and tbl15[num1] <= 57
                                        or tbl15[num1] >= 65 and tbl15[num1] <= 70
                                        or tbl15[num1] >= 97 and tbl15[num1] <= 102)
                                then
                                    var6 = tbl15[num1] - (if tbl15[num1] >= 65 and tbl15[num1] <= 90 then 55 else tbl15[num1] >= 97 and tbl15[num1] <= 122 and 87 or 48)
                                else
                                    num1 -= 1
                                end
                            else
                                num1 = num3 - 1
                            end
                            table.insert(tbl16, if var5 then var6 and 16 * var5 + var6 or var5 or 0 else 0)
                        end
                    else
                        table.insert(tbl16, tbl7[var4] or tbl6[var4] or var4)
                    end
                elseif tbl15[num1 + 1] == 123 and tbl15[num1 + 2] == 85 and tbl15[num1 + 3] == 43 and flags.unicode then
                    num1 += 4
                    local num3 = num1

                    while tbl15[num1]
                        and (tbl15[num1] >= 48 and tbl15[num1] <= 57
                            or tbl15[num1] >= 65 and tbl15[num1] <= 70
                            or tbl15[num1] >= 97 and tbl15[num1] <= 102) do
                        num1 += 1
                    end
                    if tbl15[num1] ~= 125 or num1 == num3 then
                        return "malformed Unicode code point"
                    end
                    table.insert(tbl16, tonumber((utf8_sub(tbl15.s, num3, num1))))
                else
                    table.insert(tbl16, tbl6[78])
                end
            end
        elseif var3 == 42 or var3 == 43 or var3 == 63 or var3 == 123 then
            local var4 = nil
            local huge = nil
            if var3 == 123 then
                local num3 = num1 + 1
                local var5 = nil

                while tbl15[num1 + 1]
                    and (tbl15[num1 + 1] >= 48 and tbl15[num1 + 1] <= 57 or tbl15[num1 + 1] == 44 and not var5 and num1 + 1 ~= num3) do
                    num1 += 1
                    if tbl15[num1] == 44 then
                        var5 = num1
                    end
                end

                if tbl15[num1 + 1] == 125 then
                    num1 += 1
                    if not var5 then
                        var4 = tonumber((utf8_sub(tbl15.s, num3, num1)))
                        huge = var4
                    else
                        var4 = tonumber((utf8_sub(tbl15.s, num3, var5)))

                        if var5 + 1 == num1 then
                            huge = math.huge
                        else
                            huge = tonumber((utf8_sub(tbl15.s, var5 + 1, num1)))
                        end

                        if huge < var4 then
                            return "numbers out of order in {} quantifier"
                        end
                    end
                else
                    table.move(tbl15, num3 - 1, num1, #tbl16 + 1, tbl16)
                end
            else
                var4 = if var3 == 43 then 1 else 0
                huge = if var3 == 63 then 1 else math.huge
            end

            if var4 then
                local str6 = if flags.ungreedy then "lazy" else "greedy"
                if tbl15[num1 + 1] == 43 or tbl15[num1 + 1] == 63 then
                    num1 += 1
                    str6 = if tbl15[num1] == 43 then "possessive" elseif flags.ungreedy then "greedy" else "lazy"
                end
                local num3 = #tbl16
                local var5 = tbl16[num3]
                if not var5
                    or type(var5) == "table" and (var5[1] == "quantifier" or var5[1] == 40 or tbl7[var5[1]])
                    or var5 == tbl12
                    or type(var5) == "string"
                then
                    return "quantifier doesn't follow a repeatable pattern"
                end
                if huge == 0 then
                    table.remove(tbl16)
                elseif var4 ~= 1 or huge ~= 1 then
                    if type(var5) == "table" and var5[1] == 41 then
                        num3 = var5[3]
                    end
                    tbl16[num3] = {
                        "quantifier",
                        var4,
                        huge,
                        str6,
                        tbl16[num3]
                    }
                end
            end
        elseif var3 == 124 then
            table.insert(tbl16, tbl12)
            local num3 = #tbl16
            repeat
                num3 -= 1
                local var4 = tbl16[num3]
                local bool2 = type(tbl16[num3]) == "table"
                if bool2 and var4[1] == 41 then
                    num3 = tbl16[num3][3]
                elseif bool2 and var4[1] == 40 then
                    if var4[4] == 124 then
                        num2 = var4[5]
                    end

                    break
                end
            until not var4
        elseif var3 == 36 or var3 == 94 then
            table.insert(tbl16, var3 == 94 and tbl11 or tbl9)
        elseif flags.ignoreCase and var3 >= 97 and var3 <= 122 then
            table.insert(tbl16, var3 - 32)
        elseif flags.extended and (var3 >= 9 and var3 <= 13 or var3 == 32 or var3 == 35) then
            if var3 == 35 then
                repeat
                    num1 += 1
                until not tbl15[num1] or tbl15[num1] == 10 or tbl15[num1] == 13
            end
        else
            table.insert(tbl16, var3)
        end
        num1 += 1
    end
    local num3 = 0
    for _, value in ipairs(tbl16) do
        if type(value) == "table"
            and (value[1] == 40 or value[1] == "quantifier" and type(value[5]) == "table" and value[5][1] == 40)
        then
            if value[1] == "quantifier" then
                value = value[5]
            end
            if not value[3] then
                return "unterminated parenthetical"
            end

            if value[2] then
                num3 = math.max(num3, value[2])
            end
        elseif type(value) == "table" and (value[1] == "backref" or value[1] == "recurmatch") then
            if not tbl17[value[2]] and (type(value[2]) ~= "number" or num2 < value[2]) then
                return "reference to a non-existent or invalid subpattern"
            end

            if value[1] == "recurmatch" and value[2] ~= 0 then
                for i, value2 in ipairs(tbl16) do
                    if type(value2) == "table" and value2[1] == 40 and value2[2] == value[2] then
                        value[3] = i
                        break
                    end
                end
            elseif type(value[2]) == "string" then
                value[2] = tbl17[value[2]]
            end
        end
    end
    tbl16.group_n = num3
    return tbl16, tbl17, tbl18
end

if not tonumber(256) then
    error(string.format("expected number for options.cacheSize, got %s", "number"), 2)
end
local var3 = tonumber(256)
local var4 = nil
local var5 = nil
if var3 then
    if var3 < 0 or var3 ~= var3 then
        error("cache size cannot be a negative number or a NaN", 2)
    elseif var3 == math.huge then
        var4 = { nil }
        var5 = { nil }
    elseif var3 >= 4294967296 then
        error("cache size too large", 2)
    else
        var4 = table.create(256)
        var5 = table.create(256)
    end
end

if var3 then
    function tbl1.pruge()
        table.clear(var5)
        table.clear(var4)
    end
end

local function new_re(arg1, flags, flagRepr: string, patternRepr)
    local var6 = var3 and string.format("%s|%s", arg1.s, flagRepr)
    local var7 = var3 and var4[table.find(var5, var6)]
    local var8, var9, var10

    if var7 then
        var8, var9, var10 = table.unpack(var7, 1, 3)
    else
        var8, var9, var10 = tokenize_ptn(arg1, flags)
        if type(var8) == "string" then
            error(var8, 2)
        end
        if var3 and var8[1] then
            table.insert(var5, 1, var6)
            table.insert(var4, 1, { var8, var9, var10 })
            if var3 ~= math.huge then
                table.remove(var5, var3 + 1)
                table.remove(var4, var3 + 1)
            end
        end
    end

    local var11 = newproxy(true)
    var1[var11] = {
        name = "RegEx",
        flags = flags,
        flag_repr = flagRepr,
        pattern_repr = patternRepr,
        token = var8,
        group_id = var9,
        verb_flags = var10
    }
    local var12 = getmetatable(var11)
    var12.__index = setmetatable(flags, tbl2)
    var12.__tostring = re_tostr
    var12.__metatable = var2

    return var11
end

local function escape_fslash(arg1)
    return (if #arg1 % 2 == 0 then "\\" else "") .. arg1 .. "."
end

local function sort_flag_chr(arg1, arg2): boolean
    return arg1:lower() < arg2:lower()
end

function tbl1.new(...)
    local select = select

    if select("#", ...) == 0 then
        error("missing argument #1 (string expected)", 2)
    end
    local var6, var7 = ...
    if type(var6) == "number" then
        var6 ..= ""
    elseif type(var6) ~= "string" then
        error(string.format("invalid argument #1 (string expected, got %s)", typeof(var6)), 2)
    end
    if type(var7) ~= "string" and type(var7) ~= "number" and var7 ~= nil then
        error(string.format("invalid argument #2 (string expected, got %s)", typeof(var7)), 2)
    end

    local tbl15 = {
        anchored = false,
        caseless = false,
        multiline = false,
        dotall = false,
        unicode = false,
        ungreedy = false,
        extended = false
    }

    local tbl16 = {}
    for value in string.gmatch(var7 or "", utf8.charpattern) do
        if tbl15[tbl4[value]] ~= false then
            error("invalid regular expression flag " .. value, 3)
        end
        tbl15[tbl4[value]] = true
        table.insert(tbl16, value)
    end
    table.sort(tbl16, sort_flag_chr)
    local flagRepr = table.concat(tbl16)
    return (new_re(to_str_arr(var6), tbl15, flagRepr, string.format("/%s/", var6:gsub("(\\*)/", escape_fslash))))
end

function tbl1.fromstring(...)
    local select = select

    if select("#", ...) == 0 then
        error("missing argument #1 (string expected)", 2)
    end
    local var6 = ...
    if type(var6) == "number" then
        var6 ..= ""
    elseif type(var6) ~= "string" then
        error(string.format("invalid argument #1 (string expected, got %s)", typeof(var6), 2))
    end
    local var7 = to_str_arr(var6)
    local var8 = var7[1]
    local var9

    if not var8 then
        error("empty regex", 2)
        var9 = 1
    elseif var8 == 92 or var8 >= 48 and var8 <= 57 or var8 >= 65 and var8 <= 90 or var8 >= 97 and var8 <= 122 then
        error("delimiter must not be alphanumeric or a backslash", 2)
        var9 = 1
    else
        var9 = 1
    end

    repeat
        var9 = table.find(var7, var8, var9 + 1)
        local var10

        if var9 then
            var10 = 1
        else
            error(string.format("no ending delimiter ('%s') found", utf8.char(var8)), 2)
            var10 = 1
        end

        while var7[var9 - var10] == 92 do
            var10 += 1
        end
    until var10 % 2 == 1

    local tbl15 = {
        anchored = false,
        caseless = false,
        multiline = false,
        dotall = false,
        unicode = false,
        ungreedy = false,
        extended = false
    }
    local tbl16 = {}

    while var9 < var7.n do
        local str6 = utf8.char(table.remove(var7))
        var7.n -= 1
        if tbl15[tbl4[str6]] ~= false then
            error("invalid regular expression flag " .. str6, 3)
        end
        tbl15[tbl4[str6]] = true
        table.insert(tbl16, str6)
    end
    table.sort(tbl16, sort_flag_chr)
    local flagRepr = table.concat(tbl16)
    table.remove(var7, 1)
    table.remove(var7)
    var7.n -= 2
    var7.s = string.sub(var7.s, 2, 1 + var7.n)
    return (new_re(var7, tbl15, flagRepr, string.sub(var6, 1, 2 + var7.n)))
end

local tbl15 = { ["\0"] = "\\x00", ["\n"] = "\\n", ["\t"] = "\\t", ["\r"] = "\\r", ["\f"] = "\\f" }

function tbl1.escape(...)
    local select = select

    if select("#", ...) == 0 then
        error("missing argument #1 (string expected)", 2)
    end
    local var6, var7, var8 = ...
    if type(var6) == "number" then
        var6 ..= ""
    elseif type(var6) ~= "string" then
        error(string.format("invalid argument #1 to 'escape' (string expected, got %s)", typeof(var6)), 2)
    end
    if var8 == nil then
        var8 = ""
    elseif type(var8) == "number" then
        var8 ..= ""
    elseif type(var8) ~= "string" then
        error(string.format("invalid argument #3 to 'escape' (string expected, got %s)", typeof(var8)), 2)
    end
    if utf8.len(var8) > 1 or var8:match("^[%a\\]$") then
        error("delimiter have not be alphanumeric", 2)
    end
    return (string.gsub(var6, "[\0\f\n\r\t]", tbl15):gsub(
        string.format(
            "[\\%s#()%%%%*+.?[%%]^{|%s]",
            if var7 then "%s" else "",
            (if var8:find("^[%%%]]$") then "%" else "") .. var8
        ),
        "\\%1"
    ))
end

function tbl1.type(...)
    local select = select

    if select("#", ...) == 0 then
        error("missing argument #1", 2)
    end
    return var1[...] and var1[...].name
end

for k, value in pairs(tbl2) do
    tbl1[k] = value
end

tbl2 = { __index = tbl2 }

var2 = tbl1.fromstring("/The\\s*metatable\\s*is\\s*(?:locked|inaccessible)(?#Nice try :])/i")
getmetatable(var2).__metatable = var2

local function readonly_table()
    error("Attempt to modify a readonly table", 2)
end

tbl3 = { __index = tbl3, __metatable = var2, __newindex = readonly_table }

tbl1.Match = setmetatable({}, tbl3)

return (setmetatable({}, { __index = tbl1, __metatable = var2, __newindex = readonly_table }))
