-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:30:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Markdown = script:FindFirstAncestor("Markdown")
local _Types = require(Markdown.Types)

local EmphasisParser = require(script.Parent.EmphasisParser)
local Flags = require(Markdown.Parent.MarkdownCore).Flags

return ({
    postProcessTokens = function(tbl1)
        local result = {}
        local num1 = 1
        local bool1 = false

        for i = 1, #tbl1 do
            local var1 = tbl1[i]

            local bool2 = bool1 and var1.name == "TABLE_DIVIDER"
            if Flags.FFlagMarkdownTables and var1.isBlock then
                bool1 = var1.name == "TABLE_ROW"
            end

            if not var1.isBlock and var1.name ~= "LINE_BREAK" and not bool2 then
                continue
            end
            if num1 < i then
                for _, value in (EmphasisParser.processEmphasisRun(tbl1, num1, i - 1)) do
                    table.insert(result, value)
                end
            end

            table.insert(result, var1)
            num1 = i + 1
        end

        if num1 <= #tbl1 then
            for _, value in (EmphasisParser.processEmphasisRun(tbl1, num1, #tbl1)) do
                table.insert(result, value)
            end
        end

        return result
    end
}).postProcessTokens
