-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:11:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function createInspectAndBuyKeyMapper(arg1)
    return function(arg2, ...)
        local var1 = "inspectAndBuy." .. arg2 .. "." .. arg1

        local select2 = select

        for i = 1, select2("#", ...) do
            var1 ..= "." .. tostring(select(i, ...))
        end

        return var1
    end
end
return createInspectAndBuyKeyMapper
