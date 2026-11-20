-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:31:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function rine(tbl1): boolean | {[any]: any} -- Luacid: Inlined by compiler; 1 call site recovered
    return tbl1 and #tbl1 > 0 and tbl1
end

local function rit(arg1) -- Luacid: unused: defined but never referenced
    if type(arg1) ~= "table" then
        arg1 = false
    end

    return arg1
end

local function dont_crash(): boolean -- Luacid: Inlined by compiler; 3 call sites recovered
    if math.random() <= 0.004 then
        wait()
    end

    return true
end

local function func1() end

local function _(arg1) -- Luacid: unused: defined but never referenced
    return string.gsub(arg1, "([%^%$%(%)%%%.%[%]%*%+%-%?])", "%%%1")
end
local tostring = tostring
local char = string.char
local tbl1 = {}

local var1 = tbl1.silent and (func1 or function(arg1, arg2, ...)
    local str1 = (" [%s] "):format(arg1:upper())
    print("[HTMLParser]" .. str1 .. arg2:format(...) .. (tbl1.nonl or "\n"))
end) or function(arg1, arg2, ...)
    local str1 = (" [%s] "):format(arg1:upper())
    print("[HTMLParser]" .. str1 .. arg2:format(...) .. (tbl1.nonl or "\n"))
end

local var2 = tbl1.noerr and (func1 or function(arg1, ...)
    var1("e", arg1, ...)
end) or function(arg1, ...)
    var1("e", arg1, ...)
end

if not (tbl1.noout and func1) then
    local function _(arg1, ...) -- Luacid: unused: defined but never referenced
        var1("i", arg1, ...)
    end
end
local var3 = tbl1.debug and (function(arg1, ...)
    var1("d", arg1:gsub("#LINE#", (tostring(func1(3)))), ...)
end or func1) or func1

local ElementNode = require(script.ElementNode)
local voidelements = require(script.voidelements)

local module = {}

function module.parse(arg1, arg2, pageUrl)
    local var4 = rine(tbl1) or {}

    var4.looplimit = var4.looplimit or 100000000

    local var5 = tostring(arg1)
    local var6 = arg2 or var4.looplimit or 100000000
    local bool1 = false

    if not var4.keep_comments then
        var5 = var5:gsub("<!%-%-.-%-%->", "")
    end

    local tbl2 = {}

    if not var4.keep_danger_placeholders then
        local i = 0
        local tbl3 = ({})

        repeat
            local var7 = char(i)
            if not var5:match(var7) then
                if tbl2["<"] and tbl2[">"] then
                    var3("[FindPH]:#LINE# Done!", i)
                    break
                end

                if not tbl3[i] then
                    if not tbl2["<"] then
                        tbl2["<"] = var7
                    elseif not tbl2[">"] then
                        tbl2[">"] = var7
                    end
                    tbl3[i] = true
                    var3("c:{%s}||cc:{%d}||tpr[c]:{%s}", tostring(c), var7:byte(), (tostring(tbl2[c])))
                    var3("busy[i]:{%s},i:{%d}", tostring(tbl3[i]), i)
                    var3("[FindPH]:#LINE# Success! || i=%d", i)
                else
                    var3("[FindPH]:#LINE# Busy! || i=%d", i)
                end
                var3("c:{%s}||cc:{%d}||tpr[c]:{%s}", c, var7:byte(), (tostring(tbl2[c])))
                var3("%s", (tostring(tbl3[i])))
            else
                var3("[FindPH]:#LINE# Text contains this byte! || i=%d", i)
            end

            i += if i == 31 then 96 else 1
        until i == 255

        if not (tbl2["<"] and tbl2[">"]) then
            var2(
                "Impossible to find at least two unused byte codes in this HTML-code. We need it to escape bracket-contained placeholders inside tags."
            )
            var2(
                "Consider enabling 'keep_danger_placeholders' option (to silence this error, if parser wasn't failed with current HTML-code) or manually replace few random bytes, to free up the codes."
            )
        else
            var3("[FindPH]:#LINE# Found! || '<'=%d, '>'=%d", tbl2["<"]:byte(), tbl2[">"]:byte())
        end

        local function g(arg3, ...): string
            local tbl4 = { ... }
            local var7 = tbl4[arg3]
            tbl4[arg3] = tbl4[arg3]:gsub("(.)", tbl2)
            if tbl4[arg3] ~= var7 then
                bool1 = true
                var3("[g]:#LINE# orig: %s", (tostring(var7)))
                var3("[g]:#LINE# replaced: %s", (tostring(tbl4[arg3])))
            end
            var3(
                "[g]:#LINE# called, id: %s, arg[id]: %s, args { " .. ("{%s}, "):rep(#tbl4):gsub(", $", "") .. " }",
                arg3,
                tbl4[arg3],
                ...
            )
            var3("[g]:#LINE# concat(arg): %s", table.concat(tbl4))
            return table.concat(tbl4)
        end

        var5 = var5:gsub("(=[%s]-)(%b'')", function(...): string
            return g(2, ...)
        end):gsub("(=[%s]-)(%b\"\")", function(...): string
            return g(2, ...)
        end):gsub("(<" .. (var4.tpl_skip_pattern or "[^!]") .. ")([^>]+)(>)", function(...): string
            return g(2, ...)
        end):gsub("(" .. (tbl2["<"] or "__FAILED__") .. ")(" .. (var4.tpl_marker_pattern or "[^%w%s]") .. ")([%g%s]-)(%2)(>)([^>]*>)", function(...): string
            return g(5, ...)
        end)
    end

    local num1 = 0
    local var7 = ElementNode:new(num1, (tostring(var5)))
    var7.page_url = pageUrl
    local var8 = var7
    local num2 = 1
    local bool2 = true
    local tbl3 = {}

    while true do
        dont_crash()

        if num1 == var6 then
            var2("Main loop reached loop limit (%d). Consider either increasing it or checking HTML-code for syntax errors", var6)
            break
        end

        local var9, var10, var11 = var7._text:find("<([%w-]+)[^>]*>", num2)

        var3("[MainLoop]:#LINE# openstart=%s || tpos=%s || name=%s", tostring(var9), tostring(var10), (tostring(var11)))

        if not var11 then
            break
        end
        num1 += 1
        var8 = ElementNode:new(num1, tostring(var11), var8 or {}, bool2, var9, var10)

        var8.page_url = pageUrl

        local var12 = var8:gettext()
        local var13 = nil
        local num3 = 1

        while true do
            dont_crash()

            if var13 == var6 then
                var2(
                    "Tag parsing loop reached loop limit (%d). Consider either increasing it or checking HTML-code for syntax errors",
                    var6
                )
                break
            end

            local var14 = nil
            local var15, var16, _, var17, var18, var19
            var15, num3, var16, _, var17, var18, var19 = var12:find("%s+([^%s=/>]+)([%s]-)(=?)([%s]-)(['\"]?)", num3)

            var3(
                "[TagLoop]:#LINE# start=%s || apos=%s || k=%s || zsp='%s' || eq='%s', quote=[%s]",
                tostring(var15),
                tostring(num3),
                tostring(var16),
                tostring(var18),
                tostring(var17),
                (tostring(var19))
            )
            if not var16 or var16 == "/>" or var16 == ">" then
                break
            end
            if var17 == "=" then
                local var20 = if var19 == "" then "=([^%s>]*)" else var19 .. "([^" .. var19 .. "]*)" .. var19
                local var21
                var21, num3, var14 = var12:find(var20, num3)
                var3(
                    "[TagLoop]:#LINE# start=%s || apos=%s || v=%s || pattern=%s",
                    tostring(var21),
                    tostring(num3),
                    tostring(var14),
                    (tostring(var20))
                )
            end
            local var20 = var14 or ""
            if bool1 then
                for k, value in pairs(tbl2) do
                    var20 = var20:gsub(value, k)
                    var3("[TagLoop]:#LINE# rv=%s || rk=%s", tostring(value), (tostring(k)))
                end
            end

            var3("[TagLoop]:#LINE# k=%s || v=%s", tostring(var16), (tostring(var20)))
            var8:addattribute(var16, var20)
            var13 = (var13 or 0) + 1
        end

        if voidelements[var8.name:lower()] then
            var8:close()
            bool2 = false
        else
            tbl3[var8.name] = tbl3[var8.name] or {}
            table.insert(tbl3[var8.name], var8)
        end

        local var14 = var8
        num2 = var10
        local var15 = nil

        while true do
            dont_crash()

            if var15 == var6 then
                var2(
                    "Tag closing loop reached loop limit (%d). Consider either increasing it or checking HTML-code for syntax errors",
                    var6
                )
                break
            end

            local var16, var17, var18
            var16, var10, var17, var18 = var7._text:find("[^<]*<(/?)([%w-]+)", var10)
            var3(
                "[TagCloseLoop]:#LINE# closestart=%s || closeend=%s || closing=%s || closename=%s",
                tostring(var16),
                tostring(var10),
                tostring(var17),
                (tostring(var18))
            )
            if not var17 or var17 == "" then
                break
            end
            var14 = table.remove(tbl3[var18] or {}) or var14
            local var19 = var7._text:find("<", var16)
            var3("[TagCloseLoop]:#LINE# closestart=%s", (tostring(var19)))
            var14:close(var19, var10 + 1)
            var8 = var14.parent

            var15 = (var15 or 0) + 1
            bool2 = true
        end
    end
    if bool1 then
        var3("tpl")
        for k, value in pairs(tbl2) do
            var7._text = var7._text:gsub(value, k)
        end
    end

    return var7
end

return module
