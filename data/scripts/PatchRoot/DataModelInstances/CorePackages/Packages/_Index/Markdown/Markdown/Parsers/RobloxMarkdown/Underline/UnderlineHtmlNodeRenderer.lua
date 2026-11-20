-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:31:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MarkdownParent = script:FindFirstAncestor("Markdown").Parent
local LinkedHashMap = require(MarkdownParent.CommonMark).Renderer.Html.LinkedHashMap

local module = {}
module.__index = module

function module.new(_context)
    return (setmetatable({ _context = _context, _html = _context:getWriter() }, module))
end

function module.getNodeTypes(_): {string}
    return { "Underline" }
end

function module:render(arg1)
    local var1 = self._context:extendAttributes(arg1, "u", LinkedHashMap.of())
    self._html:tag("u", var1)
    self:renderChildren(arg1)
    self._html:tag("/u")
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
