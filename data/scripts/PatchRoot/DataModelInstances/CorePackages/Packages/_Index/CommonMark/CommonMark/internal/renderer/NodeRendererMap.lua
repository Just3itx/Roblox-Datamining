-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T06:21:08Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local CommonMark = script:FindFirstAncestor("CommonMark")
local _Node = require(CommonMark.node.Node)
local _NodeRenderer = require(CommonMark.renderer.NodeRenderer)

local module = {}
module.__index = module

function module.new()
    return (setmetatable({ _nodeRenderers = {}, _renderers = {} }, module))
end

function module:add(arg1)
    table.insert(self._nodeRenderers, arg1)
    for _, value in ipairs(arg1:getNodeTypes()) do
        if self._renderers[value] == nil then
            self._renderers[value] = arg1
        end
    end
end

function module:render(arg1)
    local _renderer = self._renderers[arg1.kind]
    if _renderer ~= nil then
        _renderer:render(arg1)
    end
end

function module:beforeRoot(arg1)
    for _, _nodeRenderer in ipairs(self._nodeRenderers) do
        local beforeRoot2 = _nodeRenderer.beforeRoot
        if beforeRoot2 ~= nil then
            beforeRoot2(_nodeRenderer, arg1)
        end
    end
end

function module:afterRoot(arg1)
    for _, _nodeRenderer in ipairs(self._nodeRenderers) do
        local afterRoot2 = _nodeRenderer.afterRoot
        if afterRoot2 ~= nil then
            afterRoot2(_nodeRenderer, arg1)
        end
    end
end

return module
