-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:50:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local LuauPolyfill = require(scriptParentParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local String = LuauPolyfill.String

function dedent(arg1, ...)
    local tbl1 = { ... }

    local str1 = ""

    if Array.isArray(arg1) then
        for i = 1, #arg1 do
            str1 ..= arg1[i]
            if i <= #tbl1 then
                str1 ..= tbl1[i]
            end
        end
    else
        str1 = arg1
    end

    local var1 = removeTrailingSpacesAndTabs(removeLeadingNewLines(str1))
    local str2 = ""
    for i = 1, string.len(var1) do
        local str3 = string.sub(var1, i, i)
        if str3 ~= " " and str3 ~= "\t" then
            break
        end

        str2 ..= str3
    end

    return removeCommonIndent(var1, str2)
end

function removeLeadingNewLines(str1: string): string
    local var1 = String.findOr(str1, { "\n*" })

    if var1 ~= nil and var1.index == 1 then
        str1 = string.sub(str1, string.len(var1.match) + 1)
    end
    return str1
end

function removeTrailingSpacesAndTabs(str1: string)
    local num1 = 1
    local var1 = nil

    while true do
        local var2 = String.findOr(str1, { " +", "\t+" }, num1)
        local tbl1

        if var2 == nil then
            tbl1 = var1
        else
            if var1 == nil then
                tbl1 = var2
            else
                local index = var1.index

                if index + string.len(var1.match) == var2.index then
                    tbl1 = {
                        index = var1.index,
                        match = var1.match .. var2.match
                    }
                else
                    tbl1 = var2
                end
            end

            num1 = var2.index + string.len(var2.match)
        end
        if var2 == nil or string.len(str1) < num1 then
            if tbl1 ~= nil then
                local index = tbl1.index

                if index + string.len(tbl1.match) == string.len(str1) + 1 then
                    return string.sub(str1, 1, tbl1.index - 1)
                end
            end

            return str1
        end

        var1 = tbl1
    end
end

function removeCommonIndent(str1: string, str2: string)
    local var1 = string.gsub(str1, str2, "", 1)
    return (string.gsub(var1, "\n" .. str2, "\n"))
end

return {
    dedent = dedent
}
