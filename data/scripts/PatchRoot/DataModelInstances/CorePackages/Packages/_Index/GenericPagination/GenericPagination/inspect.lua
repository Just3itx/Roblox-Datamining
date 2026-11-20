-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:31:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {
    _VERSION = "inspect.lua 3.1.0",
    _URL = "http://github.com/kikito/inspect.lua",
    _DESCRIPTION = "human-readable representations of tables",
    _LICENSE = "\t  MIT LICENSE\n\n\t  Copyright (c) 2013 Enrique García Cota\n\n\t  Permission is hereby granted, free of charge, to any person obtaining a\n\t  copy of this software and associated documentation files (the\n\t  \"Software\"), to deal in the Software without restriction, including\n\t  without limitation the rights to use, copy, modify, merge, publish,\n\t  distribute, sublicense, and/or sell copies of the Software, and to\n\t  permit persons to whom the Software is furnished to do so, subject to\n\t  the following conditions:\n\n\t  The above copyright notice and this permission notice shall be included\n\t  in all copies or substantial portions of the Software.\n\n\t  THE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS\n\t  OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF\n\t  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.\n\t  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY\n\t  CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,\n\t  TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE\n\t  SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.\n\t"
}

local tostring = tostring

module.KEY = setmetatable({}, {
    __tostring = function(): string
        return "inspect.KEY"
    end
})
module.METATABLE = setmetatable({}, {
    __tostring = function(): string
        return "inspect.METATABLE"
    end
})

local function rawpairs<T>(arg1: T) -- Luacid: unused: defined but never referenced
    return next, arg1, nil
end

local function smartQuote(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    if arg1:match("\"") and not arg1:match("'") then
        return "'" .. arg1 .. "'"
    end

    return "\"" .. arg1:gsub("\"", "\\\"") .. "\""
end

local tbl1 = {
    ["\7"] = "\\a",
    ["\8"] = "\\b",
    ["\f"] = "\\f",
    ["\n"] = "\\n",
    ["\r"] = "\\r",
    ["\t"] = "\\t",
    ["\11"] = "\\v"
}
local tbl2 = ({})
for i = 0, 31 do
    local str1 = string.char(i)
    if not tbl1[str1] then
        tbl1[str1] = "\\" .. i
        tbl2[str1] = string.format("\\%03d", i)
    end
end

local function escape(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    return (arg1:gsub("\\", "\\\\"):gsub("(%c)%f[0-9]", tbl2):gsub("%c", tbl1))
end

local function isIdentifier(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    return type(arg1) == "string" and arg1:match("^[_%a][_%a%d]*$")
end

local function isSequenceKey(arg1, num1: number): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return type(arg1) == "number" and arg1 >= 1 and arg1 <= num1 and math.floor(arg1) == arg1
end

local tbl3 = {
    number = 1,
    boolean = 2,
    string = 3,
    table = 4,
    ["function"] = 5,
    userdata = 6,
    thread = 7
}

local function sortKeys(arg1, arg2): boolean
    local str1 = type(arg1)
    local str2 = type(arg2)

    if str1 == str2 and (str1 == "string" or str1 == "number") then
        return arg1 < arg2
    end

    local var1 = tbl3[str1]
    local var2 = tbl3[str2]

    if var1 and var2 then
        return tbl3[str1] < tbl3[str2]
    end

    if var1 then
        return true
    end

    if var2 then
        return false
    end

    return str1 < str2
end

local function getSequenceLength(tbl4: {any}): number -- Luacid: unused: defined but never referenced
    local num1 = 1
    local var1 = rawget(tbl4, num1)
    while var1 ~= nil do
        num1 += 1
        var1 = rawget(tbl4, num1)
    end
    return num1 - 1
end

local function getNonSequentialKeys(tbl4: {any})
    local num1 = 1
    local var1 = rawget(tbl4, num1)
    local num2 = 0
    local tbl5 = ({})

    while var1 ~= nil do
        num1 += 1
        var1 = rawget(tbl4, num1)
    end
    local num3 = num1 - 1

    for k, _ in next, tbl4 do
        if not isSequenceKey(k, num3) then
            num2 += 1
            tbl5[num2] = k
        end
    end
    table.sort(tbl5, sortKeys)
    return tbl5, num2, num3
end

local function countTableAppearances(arg1, arg2)
    arg2 = arg2 or {}

    if type(arg1) == "table" then
        if not arg2[arg1] then
            arg2[arg1] = 1

            for k, value in next, arg1 do
                countTableAppearances(k, arg2)
                countTableAppearances(value, arg2)
            end
            countTableAppearances(getmetatable(arg1), arg2)
            return arg2
        end
        arg2[arg1] += 1
    end

    return arg2
end

local function func1<T>(tbl4: {T}): ({T}, number) -- Luacid: Inlined by compiler; 1 call site recovered
    local tbl5 = ({})
    local num1 = #tbl4
    for i = 1, num1 do
        tbl5[i] = tbl4[i]
    end
    return tbl5, num1
end

local function makePath(arg1, ...)
    local tbl4 = { ... }
    local tbl5, num1 = func1(arg1)

    for i = 1, #tbl4 do
        tbl5[num1 + i] = tbl4[i]
    end
    return tbl5
end

local function processRecursive(arg1, arg2, arg3, arg4)
    if arg2 == nil then
        return nil
    end
    if arg4[arg2] then
        return arg4[arg2]
    end

    local var1 = arg1(arg2, arg3)
    local tbl4

    if type(var1) == "table" then
        tbl4 = {}
        arg4[arg2] = tbl4

        for k, value in next, var1 do
            local var2 = processRecursive(arg1, k, makePath(arg3, k, module.KEY), arg4)
            if var2 ~= nil then
                tbl4[var2] = processRecursive(arg1, value, makePath(arg3, var2), arg4)
            end
        end

        local var2 = processRecursive(arg1, getmetatable(var1), makePath(arg3, module.METATABLE), arg4)
        if type(var2) ~= "table" then
            var2 = nil
        end

        setmetatable(tbl4, var2)
    else
        tbl4 = var1
    end

    return tbl4
end

local tbl4 = {}
local tbl5 = { __index = tbl4 }

function tbl4:puts(...)
    local tbl6 = { ... }
    local buffer2 = self.buffer
    local buffer2Len = #buffer2
    for i = 1, #tbl6 do
        buffer2Len += 1
        buffer2[buffer2Len] = tbl6[i]
    end
end

function tbl4:down(callback)
    self.level += 1
    callback()
    self.level -= 1
end

function tbl4:tabify()
    self:puts(self.newline, string.rep(self.indent, self.level))
end

function tbl4:alreadyVisited(arg1): boolean
    return self.ids[arg1] ~= nil
end

function tbl4:getId(arg1)
    local var1 = self.ids[arg1]
    if not var1 then
        local str1 = type(arg1)
        var1 = (self.maxIds[str1] or 0) + 1
        self.maxIds[str1] = var1
        self.ids[arg1] = var1
    end
    return (tostring(var1))
end

function tbl4:putKey(arg1)
    if isIdentifier(arg1) then
        return self:puts(arg1)
    end
    self:puts("[")
    self:putValue(arg1)
    self:puts("]")
end

function tbl4:putTable(arg1)
    if arg1 == module.KEY or arg1 == module.METATABLE then
        self:puts((tostring(arg1)))
        return
    end

    if self:alreadyVisited(arg1) then
        self:puts("<table ", self:getId(arg1), ">")
        return
    end

    if self.level >= self.depth then
        self:puts("{...}")
        return
    end
    if self.tableAppearances[arg1] > 1 then
        self:puts("<", self:getId(arg1), ">")
    end

    local tbl6, num1, num2 = getNonSequentialKeys(arg1)
    local var1 = getmetatable(arg1)

    self:puts("{")
    self:down(function()
        local num3 = 0
        for i = 1, num2 do
            if num3 > 0 then
                self:puts(",")
            end
            self:puts(" ")
            self:putValue(arg1[i])
            num3 += 1
        end

        for i = 1, num1 do
            local var2 = tbl6[i]
            if num3 > 0 then
                self:puts(",")
            end
            self:tabify()
            self:putKey(var2)
            self:puts(" = ")
            self:putValue(arg1[var2])
            num3 += 1
        end

        if type(var1) ~= "table" then
            return
        end

        if num3 > 0 then
            self:puts(",")
        end
        self:tabify()
        self:puts("<metatable> = ")
        self:putValue(var1)
    end)

    if num1 > 0 or type(var1) == "table" then
        self:tabify()
    elseif num2 > 0 then
        self:puts(" ")
    end

    self:puts("}")
end

function tbl4:putValue(arg1)
    local str1 = type(arg1)

    if str1 == "string" then
        self:puts((smartQuote((escape(arg1)))))
    elseif str1 == "number" or str1 == "boolean" or str1 == "nil" or str1 == "cdata" or str1 == "ctype" then
        self:puts((tostring(arg1)))
    elseif str1 == "table" then
        self:putTable(arg1)
    else
        self:puts("<", str1, " ", self:getId(arg1), ">")
    end
end

function module.inspect(arg1, arg2): string
    arg2 = arg2 or {}

    local depth = arg2.depth or math.huge
    local newline = arg2.newline or "\n"
    local indent = arg2.indent or "  "
    local process = arg2.process

    if process then
        arg1 = processRecursive(process, arg1, {}, {})
    end

    local var2 = setmetatable({
        depth = depth,
        level = 0,
        buffer = {},
        ids = {},
        maxIds = {},
        newline = newline,
        indent = indent,
        tableAppearances = countTableAppearances(arg1)
    }, tbl5)

    var2:putValue(arg1)

    return table.concat(var2.buffer)
end

setmetatable(module, {
    __call = function(_, ...)
        return module.inspect(...)
    end
})

return module
