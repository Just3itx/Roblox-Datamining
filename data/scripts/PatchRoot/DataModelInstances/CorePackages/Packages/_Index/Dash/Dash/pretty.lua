-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T03:31:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local _Types = require(scriptParent.Types)

local append = require(scriptParent.append)
local assign = require(scriptParent.assign)
local cycles = require(scriptParent.cycles)
local includes = require(scriptParent.includes)
local join = require(scriptParent.join)
local map = require(scriptParent.map)
local keys = require(scriptParent.keys)
local slice = require(scriptParent.slice)

local concat = table.concat
local insert = table.insert
local sort = table.sort

local function indentLines(tbl1, indent: string) -- Luacid: Inlined by compiler; 2 call sites recovered
    return map(tbl1, function(str1: string): string
        return indent .. str1
    end)
end

local function sortObjectKeys(tbl1) -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = keys(tbl1)
    sort(var1, function(arg1, arg2): boolean
        if type(arg1) == "number" and type(arg2) == "number" then
            return arg1 < arg2
        end

        return tostring(arg1) < tostring(arg2)
    end)

    return var1
end

local function constructValueOptions(tbl1, tbl2)
    return (assign({
        visited = {},
        indent = "\t",
        depth = 2
    }, tbl1, {
        depth = if tbl1.depth then tbl1.depth - 1 or nil else nil,
        cycles = tbl1.cycles
            or cycles(tbl2, tbl1.depth, { visited = {}, refs = {}, nextRef = 0, depth = tbl1.depth, omit = tbl1.omit or {} })
    }))
end

local function insertClosedBracket(tbl1, multiline: boolean, bool1: boolean) -- Luacid: Inlined by compiler; 1 call site recovered
    if not multiline then
        tbl1[#tbl1] = ("%s}"):format(tbl1[#tbl1])

        return
    end

    if bool1 then
        tbl1[#tbl1] = tbl1[#tbl1] .. "}"
        return
    end
    insert(tbl1, "}")
end
local var1 = nil

local function prettyLines(arg1, tbl1): {any} | {string}
    local tbl2 = tbl1 or {}
    if type(arg1) ~= "table" then
        return if type(arg1) == "string" and tbl2 and not tbl2.noQuotes then { ("\"%s\""):format(arg1) } else { tostring(arg1) }
    end

    local var2 = constructValueOptions(tbl2, arg1)

    if var2.depth == -1 then
        return { "..." }
    end
    if var2.visited[arg1] then
        return { "&" .. var2.cycles.refs[arg1] }
    end

    var2.visited[arg1] = true

    local multiline = var2.multiline
    local str1 = if multiline then "," else ", "

    local ref = var2.cycles.refs[arg1]
    local tbl3 = { (ref and ("<%s>"):format(ref) or "") .. "{" }

    local var3 = join(var2, { noQuotes = true, multiline = false })

    local num1 = 0
    local bool1 = true
    local var4 = sortObjectKeys(arg1)

    if #arg1 > 0 and var2.arrayLength then
        tbl3[1] = ("#%d %s"):format(#arg1, tbl3[1])
    end

    for _, value in ipairs(var4) do
        if type(value) == "number" and value == num1 + 1 then
            num1 = value
        end

        if var2.omit and includes(var2.omit, value) then
            continue
        end

        local var5 = arg1[value]
        local bool2 = type(value) == "number" and value >= 1 and value <= num1

        if bool1 then
            bool1 = false
        else
            tbl3[#tbl3] = tbl3[#tbl3] .. str1
        end

        if multiline then
            if bool2 then
                append(tbl3, indentLines(prettyLines(var5, var2), var2.indent))
            else
                local var6 = indentLines(prettyLines(value, var3), var2.indent)
                local var7 = prettyLines(var5, var2)
                local var8 = indentLines(slice(var7, 2), var2.indent)

                var6[#var6] = ("%s = %s"):format(var6[#var6], var7[1])
                append(tbl3, var6)
                append(tbl3, var8)
            end
        elseif bool2 then
            tbl3[#tbl3] = tbl3[#tbl3] .. var1(var5, var2)
        else
            tbl3[#tbl3] = tbl3[#tbl3] .. var1(value, var3) .. " = " .. var1(var5, var2)
        end
    end

    insertClosedBracket(tbl3, multiline, bool1)
    return tbl3
end

var1 = function(arg1, tbl1)
    return concat(prettyLines(arg1, tbl1), "\n")
end

return var1
