-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T06:31:21Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local CommonMark = script:FindFirstAncestor("CommonMark")
local _Node = require(CommonMark.node.Node)
local _Position = require(CommonMark.parser.beta.Position)

local module = {}
module.__index = module

module.Type = table.freeze({ WRAP = "WRAP", REPLACE = "REPLACE" })

local function new(_type: string, _node, _position) -- Luacid: Inlined by compiler; 2 call sites recovered
    return (setmetatable({ _type = _type, _node = _node, _position = _position, _includeMarker = false }, module))
end

function module.none()
    return nil
end

function module.wrapTextIn(_node, _position)
    return (new(module.Type.WRAP, _node, _position))
end

function module.replaceWith(_node, _position)
    return (new(module.Type.REPLACE, _node, _position))
end

function module:includeMarker()
    self._includeMarker = true
    return self
end

function module:getType()
    return self._type
end

function module:getNode()
    return self._node
end

function module:getPosition()
    return self._position
end

function module:isIncludeMarker()
    return self._includeMarker
end

return module
