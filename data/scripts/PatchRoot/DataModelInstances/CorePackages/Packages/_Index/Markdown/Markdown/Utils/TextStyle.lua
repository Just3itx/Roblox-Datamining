-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:40:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Markdown = script:FindFirstAncestor("Markdown")
local MarkdownParent = Markdown.Parent
local Dash = require(MarkdownParent.Dash)
local _Types = require(Markdown.Types)
local _InlineLayout = require(MarkdownParent.InlineLayout)
local InlineEngineTag = require(MarkdownParent.MarkdownCore).Enums.InlineEngineTag

return {
    getCodeTextStyles = function(arg1)
        return Dash.joinDeep(arg1.textStyles, arg1.codeStyles)
    end,
    getBaseTextElementEngineTags = function(arg1)
        if not arg1 then
            return nil
        end

        local baseTextElementEngineTags = {}
        if arg1.bold then
            table.insert(baseTextElementEngineTags, { name = InlineEngineTag.BOLD, attributes = {} })
        end

        if arg1.italic then
            table.insert(baseTextElementEngineTags, { name = InlineEngineTag.ITALIC, attributes = {} })
        end

        if arg1.strike then
            table.insert(baseTextElementEngineTags, { name = InlineEngineTag.STRIKE, attributes = {} })
        end

        if arg1.color then
            table.insert(baseTextElementEngineTags, { name = InlineEngineTag.FONT, attributes = { color = arg1.color } })
        end

        if arg1.underline then
            table.insert(baseTextElementEngineTags, { name = InlineEngineTag.UNDERLINE, attributes = {} })
        end

        return baseTextElementEngineTags
    end,
    normalizeStyleFont = function(arg1)
        if not arg1 then
            return arg1
        end

        local var1 = Dash.omit(arg1, { "font" })
        if var1.fontFace == nil and arg1.font ~= nil then
            var1.fontFace = if typeof(arg1.font) == "Font" then arg1.font else Font.fromEnum(arg1.font)
        end

        return var1
    end
}
