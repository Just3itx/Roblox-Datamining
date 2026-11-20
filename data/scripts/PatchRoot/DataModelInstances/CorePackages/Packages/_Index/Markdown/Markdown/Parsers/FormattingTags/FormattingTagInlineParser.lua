-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:31:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MarkdownParent = script:FindFirstAncestor("Markdown").Parent
local CommonMark = require(MarkdownParent.CommonMark)
local FormattingTag = require(script.Parent.FormattingTag)

local _byte = string.byte

local tbl1 = { [98] = true, [105] = true, [117] = true, [115] = true }

local module = {}
module.__index = module

function module.new()
    return (setmetatable({}, module))
end

function module.tryParse(_, arg1)
    local var1 = arg1:scanner()
    local var2 = var1:position()
    var1:next()
    var1:nextChar(47)
    if not tbl1[var1:peek()] then
        return CommonMark.Parser.Beta.ParsedInline.none()
    end
    var1:next()
    if not var1:nextChar(62) then
        return CommonMark.Parser.Beta.ParsedInline.none()
    end
    local content = var1:getSource(var2, var1:position()):getContent()
    return CommonMark.Parser.Beta.ParsedInline.of(FormattingTag.text(content), var1:position())
end

local Factory = {}
Factory.__index = Factory

function Factory.new()
    return (setmetatable({}, Factory))
end

function Factory.getTriggerCharacters(_): {boolean}
    return { [60] = true }
end

function Factory.create(_)
    return module.new()
end

module.Factory = Factory

return module
