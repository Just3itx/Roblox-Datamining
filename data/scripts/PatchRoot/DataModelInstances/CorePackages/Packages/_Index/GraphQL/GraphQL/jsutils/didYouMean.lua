-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:50:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local _LuauPolyfill = require(scriptParentParentParent.LuauPolyfill)

return {
    didYouMean = function(arg1, arg2)
        if not arg2 then
            arg2 = arg1
            arg1 = nil
        end

        local str1 = " Did you mean "
        if arg1 then
            str1 ..= arg1 .. " "
        end

        local tbl1 = ({})
        for i = 1, #arg2 do
            tbl1[i] = ("%q"):format(arg2[i])
        end

        local num1 = #tbl1
        if num1 == 0 then
            return ""
        elseif num1 == 1 then
            return str1 .. tbl1[1] .. "?"
        elseif num1 == 2 then
            return str1 .. tbl1[1] .. " or " .. tbl1[2] .. "?"
        end

        local tbl2 = {}
        table.move(tbl1, 1, 5, 1, tbl2)
        local var1 = table.remove(tbl2)

        return str1 .. table.concat(tbl2, ", ") .. ", or " .. tostring(var1) .. "?"
    end
}
