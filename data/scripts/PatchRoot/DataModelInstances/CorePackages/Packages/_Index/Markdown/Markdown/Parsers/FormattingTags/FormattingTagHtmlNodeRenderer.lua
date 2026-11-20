-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:31:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MarkdownParent = script:FindFirstAncestor("Markdown").Parent
local CommonMark = require(MarkdownParent.CommonMark)
local _FormattingTag = require(script.Parent.FormattingTag)

local LinkedHashMap = CommonMark.Renderer.Html.LinkedHashMap

local var1 = table.freeze({ b = "strong", i = "em", u = "u", s = "del" })

local module = {}
module.__index = module

function module.new(_context)
    return (setmetatable({ _context = _context, _html = _context:getWriter() }, module))
end

function module.getNodeTypes(_): {string}
    return { "FormattingTag", "FormattingTagText" }
end

function module:render(arg1)
    if arg1.kind == "FormattingTagText" then
        self._html:text(arg1.literal)
        return
    end
    local var2 = var1[arg1.tagName]
    local var3 = self._context:extendAttributes(arg1, var2, LinkedHashMap.of())
    self._html:tag(var2, var3)
    self:renderChildren(arg1)
    self._html:tag("/" .. var2)
end

function module:renderChildren(arg1)
    local firstChild = arg1:getFirstChild()
    while firstChild ~= nil do
        local next = firstChild:getNext()
        self._context:render(firstChild)
        firstChild = next
    end
end

return module
