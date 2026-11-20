-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:21:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FFlagViewRecyclerReact084 = require(script:FindFirstAncestor("ViewRecycler").Flags).FFlagViewRecyclerReact084

local tbl1 = {}

local function validateNumber(num1: number, str1: string) -- Luacid: unused: defined but never referenced
    assert(num1 >= 0 and num1 < math.huge, `{str1} must be a finite non-negative number`)
end

function tbl1.validate(arg1, str1: string?)
    local str2 = str1 or "ReachedThreshold"
    if type(arg1) == "number" then
        assert(arg1 >= 0 and arg1 < math.huge, `{str2} must be a finite non-negative number`)

        return
    end
    assert(type(arg1) == "table", `{str2} must be a number or viewport-fraction table`)
    assert(type(arg1.viewportFraction) == "number", `{str2}.viewportFraction must be a number`)
    local viewportFraction = arg1.viewportFraction
    local str3 = `{str2}.viewportFraction`
    assert(viewportFraction >= 0 and viewportFraction < math.huge, `{str3} must be a finite non-negative number`)
end

if FFlagViewRecyclerReact084 then
    function tbl1.equal(arg1, arg2): boolean
        if arg1 == arg2 then
            return true
        end

        return type(arg1) == "table" and type(arg2) == "table" and arg1.viewportFraction == arg2.viewportFraction
    end
end

function tbl1.resolve(arg1, num1: number, num2: number)
    local var1 = arg1 or num2
    return if type(var1) == "number" then var1 else var1.viewportFraction * num1
end

return table.freeze(tbl1)
