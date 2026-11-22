-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T02:10:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InlineRichText = script:FindFirstAncestor("InlineRichText")
local _Types = require(InlineRichText.Types)
local InlineRichTextParent = InlineRichText.Parent
local Cryo = require(InlineRichTextParent.Cryo)

local tokenize = require(script.Parent.tokenize)
local buildTree = require(script.Parent.buildTree)
local DefaultParserOptions = require(script.Parent.DefaultParserOptions)

local function parseXml(str1: string, arg1): boolean
    return pcall(function()
        local var1 = tokenize(str1)
        return buildTree(var1, {
            TagConfigurations = Cryo.Dictionary.join(DefaultParserOptions.TagConfigurations, arg1 and arg1.TagConfigurations or {}),
            TagAliases = Cryo.Dictionary.join(DefaultParserOptions.TagAliases, arg1 and arg1.TagAliases or {})
        })
    end)
end

return parseXml
