-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T06:11:24Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local CommonMark = script:FindFirstAncestor("CommonMark")
local _Delimiter = require(CommonMark.internal.Delimiter)
local _Position = require(CommonMark.parser.beta.Position)
local _Text = require(CommonMark.node.Text)

local module = {}
module.__index = module

local function new(markerNode, markerPosition, bracketNode, bracketPosition, contentPosition, previous, previousDelimiter) -- Luacid: Inlined by compiler; 2 call sites recovered
    return (setmetatable({
        markerNode = markerNode,
        markerPosition = markerPosition,
        bracketNode = bracketNode,
        bracketPosition = bracketPosition,
        contentPosition = contentPosition,
        previous = previous,
        previousDelimiter = previousDelimiter,
        allowed = true,
        bracketAfter = false,
        contentNestingDepth = 0
    }, module))
end

function module.link(bracketNode, bracketPosition, contentPosition, previous, previousDelimiter)
    return (new(nil, nil, bracketNode, bracketPosition, contentPosition, previous, previousDelimiter))
end

function module.withMarker(markerNode, markerPosition, bracketNode, bracketPosition, contentPosition, previous, previousDelimiter)
    return (new(markerNode, markerPosition, bracketNode, bracketPosition, contentPosition, previous, previousDelimiter))
end

return module
