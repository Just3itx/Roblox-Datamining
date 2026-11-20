-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:51:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local _LuauPolyfill = require(scriptParentParentParent.LuauPolyfill)

local _source = require(script.Parent.source)

local _tokenKind = require(script.Parent.tokenKind)

local Location = ({})
Location.__index = Location

function Location.new(startToken, endToken, source)
    return (setmetatable(
        {
            start = startToken.start,
            _end = endToken._end,
            startToken = startToken,
            endToken = endToken,
            source = source
        },
        Location
    ))
end

function Location:toJSON()
    return {
        start = self.start,
        _end = self._end
    }
end

local Token = ({})
Token.__index = Token

function Token.new(kind, start: number, _end: number, line: number, column: number, prev, value: string?)
    return (setmetatable(
        {
            kind = kind,
            start = start,
            _end = _end,
            line = line,
            column = column,
            value = value,
            prev = prev,
            next = nil
        },
        Token
    ))
end

function Token:toJSON()
    return {
        kind = self.kind,
        value = self.value,
        line = self.line,
        column = self.column
    }
end

return {
    Location = Location,
    Token = Token,
    isNode = function(arg1): boolean
        return typeof(arg1) == "table" and typeof(arg1.kind) == "string"
    end
}
