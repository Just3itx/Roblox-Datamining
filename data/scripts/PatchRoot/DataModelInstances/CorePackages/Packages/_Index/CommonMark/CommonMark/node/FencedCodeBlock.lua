-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T06:30:46Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local CommonMark = script:FindFirstAncestor("CommonMark")
local Node = require(CommonMark.node.Node)

local function checkFenceLengths(_openingFenceLength: number?, _closingFenceLength: number?) -- Luacid: Inlined by compiler; 2 call sites recovered
    if _openingFenceLength ~= nil and _closingFenceLength ~= nil and _closingFenceLength < _openingFenceLength then
        error("fence lengths required to be: closingFenceLength >= openingFenceLength")
    end
end

local function getOpeningFenceLength(arg1)
    return arg1._openingFenceLength
end

local function setOpeningFenceLength(arg1, _openingFenceLength: number?)
    if _openingFenceLength ~= nil and _openingFenceLength < 3 then
        error("openingFenceLength needs to be >= 3")
    end
    checkFenceLengths(_openingFenceLength, arg1._closingFenceLength)
    arg1._openingFenceLength = _openingFenceLength
end

local function getClosingFenceLength(arg1)
    return arg1._closingFenceLength
end

local function setClosingFenceLength(arg1, _closingFenceLength: number?)
    if _closingFenceLength ~= nil and _closingFenceLength < 3 then
        error("closingFenceLength needs to be >= 3")
    end
    checkFenceLengths(arg1._openingFenceLength, _closingFenceLength)
    arg1._closingFenceLength = _closingFenceLength
end

local function FencedCodeBlock()
    local node = Node.new("FencedCodeBlock", true)
    node.fenceCharacter = nil
    node._openingFenceLength = nil
    node._closingFenceLength = nil
    node.fenceIndent = 0
    node.info = nil
    node.literal = nil
    node.getOpeningFenceLength = getOpeningFenceLength
    node.setOpeningFenceLength = setOpeningFenceLength
    node.getClosingFenceLength = getClosingFenceLength
    node.setClosingFenceLength = setClosingFenceLength
    return node
end

return FencedCodeBlock
