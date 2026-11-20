-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T02:50:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CommonMark = script:FindFirstAncestor("CommonMark")
local _HtmlNodeRendererContext = require(CommonMark.renderer.html.HtmlNodeRendererContext)
local _HtmlWriter = require(CommonMark.renderer.html.HtmlWriter)
local LinkedHashMap = require(CommonMark.internal.port.LinkedHashMap)
local _Node = require(CommonMark.node.Node)
local var1 = setmetatable({}, { __index = require(CommonMark.ext.gfm.strikethrough.internal.StrikethroughNodeRenderer) })
var1.__index = var1

function var1.new(_context)
    return (setmetatable({ _context = _context, _html = _context:getWriter() }, var1))
end

function var1:render(arg1)
    local var2 = self._context:extendAttributes(arg1, "del", LinkedHashMap.of())
    self._html:tag("del", var2)
    self:renderChildren(arg1)
    self._html:tag("/del")
end

function var1:renderChildren(arg1)
    local firstChild = arg1:getFirstChild()
    while firstChild ~= nil do
        local next = firstChild:getNext()
        self._context:render(firstChild)
        firstChild = next
    end
end

return var1
