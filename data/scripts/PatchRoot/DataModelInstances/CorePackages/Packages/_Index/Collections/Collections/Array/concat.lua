-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T02:31:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local __DEV__ = _G.__DEV__
local scriptParent = script.Parent
local scriptParentParentParent = scriptParent.Parent.Parent
local isArray = require(scriptParent.isArray)
local _ES7Types = require(scriptParentParentParent.ES7Types)

local function concat(arg1, ...)
    local num1 = 0
    local tbl1, num2

    if isArray(arg1) then
        tbl1 = table.clone(arg1)
        num2 = #arg1
    else
        num2 = num1 + 1
        tbl1 = {}
        tbl1[num2] = arg1
    end

    local select2 = select

    for i = 1, select2("#", ...) do
        local select = select
        local var1 = select(i, ...)
        local str1 = typeof(var1)
        if var1 == nil then
            continue
        end
        if str1 == "table" then
            if __DEV__ and not isArray(var1) then
                error(
                    "Array.concat(...) only works with array-like tables but it received an object-like table.\nYou can avoid this error by wrapping the object-like table into an array. Example: `concat({1, 2}, {a = true})` should be `concat({1, 2}, { {a = true} }`"
                )
            end
            for j = 1, #var1 do
                num2 += 1
                tbl1[num2] = var1[j]
            end
        else
            num2 += 1
            tbl1[num2] = var1
        end
    end

    return tbl1
end

return concat
