-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T03:11:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CommonMark = script:FindFirstAncestor("CommonMark")
local _Node = require(CommonMark.node.Node)
local _Position = require(CommonMark.parser.beta.Position)

local module = {}
module.__index = module

function module.none()
    return nil
end

function module.of(_node, _position)
    return (setmetatable({ _node = _node, _position = _position }, module))
end

function module:getNode()
    return self._node
end

function module:getPosition()
    return self._position
end

return module
