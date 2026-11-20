-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:20:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Markdown = script:FindFirstAncestor("Markdown")
local MarkdownParent = Markdown.Parent
local Parent = require(script.Parent)
local CommonMark = require(MarkdownParent.CommonMark)
local _Types = require(Markdown.Types)

local function createParser(tbl1)
    local var1 = (tbl1 == nil or tbl1.extensions == nil) and {} or tbl1.extensions
    local parseOptions = (tbl1 == nil or tbl1.parserOptions == nil) and {} or table.clone(tbl1.parserOptions)
    local var3

    if parseOptions.extensions == nil then
        var3 = var1
    else
        var3 = table.clone(parseOptions.extensions)
        table.move(var1, 1, #var1, #var3 + 1, var3)
        table.freeze(var3)
    end
    parseOptions.extensions = var3

    table.freeze(parseOptions)
    local var4 = Parent.build(var3)

    local module = ({})
    module.parseOptions = parseOptions
    function module.parseDocument(str1: string)
        return CommonMark.parse(str1, parseOptions)
    end
    function module.toRendererAst(arg1, arg2)
        return var4.toRendererAst(arg1, arg2)
    end
    function module.parse(str1: string, arg1)
        return (module.toRendererAst(module.parseDocument(str1), arg1))
    end
    function module.safeParse(str1: string, arg1)
        if arg1 == nil then
            return pcall(module.parse, str1)
        end
        return pcall(module.parse, str1, arg1)
    end
    return module
end

return createParser
