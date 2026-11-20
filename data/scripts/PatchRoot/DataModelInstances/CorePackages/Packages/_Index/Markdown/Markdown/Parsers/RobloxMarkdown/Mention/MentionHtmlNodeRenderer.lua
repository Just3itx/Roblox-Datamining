-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:31:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MarkdownParent = script:FindFirstAncestor("Markdown").Parent
local CommonMark = require(MarkdownParent.CommonMark)
local _Mention = require(script.Parent.Mention)

local LinkedHashMap = CommonMark.Renderer.Html.LinkedHashMap

local module = {}
module.__index = module

function module.new(_context)
    return (setmetatable({ _context = _context, _html = _context:getWriter() }, module))
end

function module.getNodeTypes(_): {string}
    return { "Mention" }
end

function module:render(arg1)
    local linkedHashMap = LinkedHashMap.new()
    linkedHashMap:put("id", arg1.id)
    if arg1.name ~= nil then
        linkedHashMap:put("name", arg1.name)
    end
    self._html:tag("mention", self._context:extendAttributes(arg1, "mention", linkedHashMap))
    self._html:tag("/mention")
end

return module
