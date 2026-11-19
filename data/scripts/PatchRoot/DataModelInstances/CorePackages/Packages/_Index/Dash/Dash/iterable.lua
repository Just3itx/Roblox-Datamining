-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T06:51:08Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local _Types = require(scriptParent.Types)

local function iterable(tbl1)
    local num1 = 1
    local bool1 = true
    local var1 = nil

    return function()
        if bool1 then
            local var2 = tbl1[num1]
            if var2 ~= nil then
                local num2 = num1
                num1 += 1
                return num2, var2
            end

            bool1 = false
        end

        repeat
            var1 = next(tbl1, var1)
        until typeof(var1) ~= "number" or not (var1 > 0) or not (var1 < num1) or var1 % 1 ~= 0

        if var1 == nil then
            return nil
        end
        return var1, tbl1[var1]
    end
end
return iterable
