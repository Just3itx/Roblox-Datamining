-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:51:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RegEx = require(script.Parent.RegEx)

local tbl1 = {}
local tbl2 = {
    __index = tbl1,
    __tostring = function(arg1): string
        return tostring(arg1._innerRegEx)
    end
}

function tbl1:exec(input: string)
    local var1 = self._innerRegEx:match(input)
    if not var1 then
        return nil
    end

    local index = var1:span()
    local var3 = var1:grouparr()

    local tbl3 = { var3[0] }
    for i = 1, var3.n do
        tbl3[i + 1] = var3[i]
    end
    tbl3.n = var3.n + 1
    tbl3.index = index
    tbl3.input = input
    return tbl3
end

function tbl1.test(tbl3, str1: string): boolean
    return tbl3:exec(str1) ~= nil
end

return (setmetatable(tbl1, {
    __call = function(_, source, str1: string?) -- name: new
        str1 = str1 or ""
        local regEx = RegEx.new(source, str1)
        return (setmetatable({
            source = source,
            ignoreCase = str1:find("i") ~= nil,
            global = str1:find("g") ~= nil,
            multiline = str1:find("m") ~= nil,
            _innerRegEx = regEx
        }, tbl2))
    end
}))
