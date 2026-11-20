-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T02:51:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CommonMark = script:FindFirstAncestor("CommonMark")
local _Text = require(CommonMark.node.Text)

local module = {}
module.__index = module

function module.new(characters, delimiterChar: number, _canOpen: boolean, _canClose: boolean, previous)
    return (setmetatable({
        characters = characters,
        delimiterChar = delimiterChar,
        _canOpen = _canOpen,
        _canClose = _canClose,
        previous = previous,
        next = nil,
        _originalLength = #characters
    }, module))
end

function module:canOpen()
    return self._canOpen
end

function module:canClose()
    return self._canClose
end

function module:length(): number
    return #self.characters
end

function module:originalLength()
    return self._originalLength
end

function module:getOpener()
    return self.characters[#self.characters]
end

function module:getCloser()
    return self.characters[1]
end

function module:getOpeners(num1: number)
    if not (num1 >= 1 and num1 <= self:length()) then
        error(`length must be between 1 and {self:length()}, was {num1}`)
    end

    return table.move(self.characters, #self.characters - num1 + 1, #self.characters, 1, {})
end

function module:getClosers(num1: number)
    if not (num1 >= 1 and num1 <= self:length()) then
        error(`length must be between 1 and {self:length()}, was {num1}`)
    end

    return table.move(self.characters, 1, num1, 1, {})
end

return module
