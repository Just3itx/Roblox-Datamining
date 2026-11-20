-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:31:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MarkdownParent = script:FindFirstAncestor("Markdown").Parent
local forEachArgs = require(MarkdownParent.Dash).forEachArgs
local concat = table.concat

local function joinTags(...)
    local tbl1 = {}
    forEachArgs(function(arg1)
        if typeof(arg1) == "string" then
            table.insert(tbl1, arg1)
            return
        end

        if typeof(arg1) ~= "table" then
            return
        end

        for value, value2 in arg1 do
            if value2 then
                table.insert(tbl1, value)
            end
        end
    end, ...)

    return concat(tbl1, " ")
end

return joinTags
