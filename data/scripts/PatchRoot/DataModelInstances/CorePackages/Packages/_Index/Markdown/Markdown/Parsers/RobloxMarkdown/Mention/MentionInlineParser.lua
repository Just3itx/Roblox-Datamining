-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:31:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MarkdownParent = script:FindFirstAncestor("Markdown").Parent
local CommonMark = require(MarkdownParent.CommonMark)
local Mention = require(script.Parent.Mention)

local _byte = string.byte

local var1 = CommonMark.Text.AsciiMatcher.builder():range(48, 57):build()
local var2 = CommonMark.Text.AsciiMatcher.builder():range(65, 90):range(97, 122):range(48, 57):c(95):build()

local module = {}
module.__index = module

function module.new()
    return (setmetatable({}, module))
end

function module.tryParse(_, arg1)
    local var3 = arg1:scanner()
    var3:next()
    if not var3:nextChar(64) then
        return CommonMark.Parser.Beta.ParsedInline.none()
    end

    local var4 = var3:position()
    if var3:match(var1) == 0 then
        return CommonMark.Parser.Beta.ParsedInline.none()
    end
    local content = var3:getSource(var4, var3:position()):getContent()
    local content2

    if var3:nextChar(58) then
        local var5 = var3:position()
        if var3:match(var2) == 0 then
            return CommonMark.Parser.Beta.ParsedInline.none()
        end
        content2 = var3:getSource(var5, var3:position()):getContent()
    else
        content2 = nil
    end

    if not var3:nextChar(62) then
        return CommonMark.Parser.Beta.ParsedInline.none()
    end
    return CommonMark.Parser.Beta.ParsedInline.of(Mention(content, content2), var3:position())
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
