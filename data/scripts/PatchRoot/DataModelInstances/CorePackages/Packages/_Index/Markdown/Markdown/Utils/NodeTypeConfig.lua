-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:31:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UtilsParent = script:FindFirstAncestor("Utils").Parent
local UtilsParentParent = UtilsParent.Parent
local NodeType = require(UtilsParent.Enums.NodeType)

local isInlineElement = require(UtilsParentParent.InlineLayout).Utils.isInlineElement
local Dash = require(UtilsParentParent.Dash)
local ReactIs = require(UtilsParentParent.ReactIs)

local tbl1 = {}
local Root = NodeType.Root
local tbl2 = {
    children = {
        [NodeType.Block] = true,
        [NodeType.TextBlock] = true
    },
    validateRenderResult = 0
}
function tbl2.validateRenderResult(arg1)
    return not (arg1 == nil) and ReactIs.isElement(arg1)
end

tbl1[Root] = tbl2

local Block = NodeType.Block
local tbl3 = {
    children = {
        [NodeType.Block] = true,
        [NodeType.TextBlock] = true
    },
    validateRenderResult = 0
}
function tbl3.validateRenderResult(arg1)
    return arg1 == nil or ReactIs.isElement(arg1) or Dash.all(arg1, ReactIs.isElement)
end

tbl1[Block] = tbl3

local TextBlock = NodeType.TextBlock
local tbl4 = {
    children = {
        [NodeType.InlineSpan] = true,
        [NodeType.InlineLeaf] = true
    },
    validateRenderResult = 0
}
function tbl4.validateRenderResult(arg1)
    return arg1 == nil or ReactIs.isElement(arg1) or Dash.all(arg1, ReactIs.isElement)
end

tbl1[TextBlock] = tbl4

local InlineSpan = NodeType.InlineSpan
local tbl5 = {
    children = {
        [NodeType.InlineSpan] = true,
        [NodeType.InlineLeaf] = true
    },
    validateRenderResult = 0
}
function tbl5.validateRenderResult(arg1)
    return arg1 == nil or isInlineElement(arg1) or Dash.all(arg1, isInlineElement)
end

tbl1[InlineSpan] = tbl5

tbl1[NodeType.InlineLeaf] = {
    children = {},
    validateRenderResult = function(arg1)
        return arg1 == nil or isInlineElement(arg1)
    end
}

return tbl1
