-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:20:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Markdown = script:FindFirstAncestor("Markdown")
local DefaultParserOptions = require(Markdown.Parsers.DefaultParserOptions)
local NodeType = require(Markdown.Enums.NodeType)
local _Types = require(Markdown.Types)

local nodeConfiguration = DefaultParserOptions.nodeConfiguration

local var1 = table.freeze({ [NodeType.InlineSpan] = true, [NodeType.InlineLeaf] = true })

local var2 = table.freeze({ [NodeType.Root] = true, [NodeType.Block] = true })

local module = {}

function module.create(name: string)
    local var3 = nodeConfiguration[name]
    if var3 == nil then
        error(`{name} isn't a renderer node`)
    end
    return {
        name = name,
        type = var3.type,
        children = {},
        offset = 0
    }
end

function module.offsetAt(arg1, arg2, num1: number): number
    return if var1[arg2.type] or arg1.type == NodeType.Root and num1 == 1 then 0 else 1
end

function module.append(arg1, str1: string, attributes)
    local var3 = module.create(str1)
    var3.attributes = attributes
    local children = arg1.children
    local index = #children + 1
    children[index] = var3
    var3.index = index
    var3.offset = module.offsetAt(arg1, var3, index)
    return var3
end

function module.appendText(arg1, text: string)
    local var3 = module.append(arg1, "TEXT")
    var3.text = text
    return var3
end

function module.isInline(arg1): boolean
    return var1[arg1.type] == true
end

function module.holdsBlocks(arg1): boolean
    return var2[arg1.type] == true
end

return module
