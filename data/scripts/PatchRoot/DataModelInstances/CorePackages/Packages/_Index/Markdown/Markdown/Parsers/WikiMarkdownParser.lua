-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:31:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Markdown = script:FindFirstAncestor("Markdown")
local MarkdownParent = Markdown.Parent
local Dash = require(MarkdownParent.Dash)

local BuildTree = require(script.BuildTree)
local PostProcessTree = require(script.PostProcessTree)
local Tokenize = require(script.Tokenize)
local _Types = require(Markdown.Types)
local UnindentTags = require(script.Parent.UnindentTags)
local IndexTree = require(script.Parent.IndexTree)
local DefaultParserOptions = require(script.Parent.DefaultParserOptions)

local module = {}

function module.safeParse(str1: string, arg1)
    local success, result = xpcall(function()
        return module.parse(str1, arg1)
    end, function(arg2): string
        return `{arg2}\n{debug.traceback()}`
    end)
    return success, result
end

function module.parse(str1: string, arg1)
    local var1 = Dash.joinDeep(DefaultParserOptions, arg1 or {})
    local var2 = UnindentTags(str1)
    local var3 = Tokenize(var2)
    local tree = BuildTree(var3, var1)
    tree.children = PostProcessTree(tree, var1)
    return IndexTree(tree)
end

return module
