-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T06:31:26Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local CommonMark = script:FindFirstAncestor("CommonMark")
local _BlockParser = require(CommonMark.parser.block.BlockParser)
local _DefinitionMap = require(CommonMark.node.DefinitionMap)
local _InlineParser = require(CommonMark.parser.InlineParser)
local _Node = require(CommonMark.node.Node)
local _SourceLine = require(CommonMark.parser.SourceLine)
local _SourceSpan = require(CommonMark.node.SourceSpan)

local module = {}

local getDefinitions = table.freeze({})

function module.isContainer(_): boolean
    return false
end

function module.canHaveLazyContinuationLines(_): boolean
    return false
end

function module.canContain(_, _): boolean
    return false
end

function module.addLine(_, _) end

function module.addSourceSpan(arg1, arg2)
    arg1:getBlock():addSourceSpan(arg2)
end

function module.getDefinitions(_)
    return getDefinitions
end

function module.closeBlock(_) end

function module.parseInlines(_, _) end

return module
