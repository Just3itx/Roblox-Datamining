-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T03:10:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CommonMark = script:FindFirstAncestor("CommonMark")
local _SourceSpan = require(CommonMark.node.SourceSpan)

local module = {}
module.__index = module

local var1 = table.freeze({})

function module.new(kind: string, isBlock: boolean)
    return (setmetatable({
        kind = kind,
        isBlock = isBlock,
        _parent = nil,
        _firstChild = nil,
        _lastChild = nil,
        _prev = nil,
        _next = nil,
        _sourceSpans = nil
    }, module))
end

function module:accept(arg1)
    local var2 = arg1["visit" .. self.kind]
    if var2 == nil then
        if self.isBlock then
            var2 = arg1.visitCustomBlock
        else
            var2 = arg1.visitCustomNode
        end
    end

    var2(arg1, self)
end

function module:getNext()
    return self._next
end

function module:getPrevious()
    return self._prev
end

function module:getFirstChild()
    return self._firstChild
end

function module:getLastChild()
    return self._lastChild
end

function module:getParent()
    return self._parent
end

function module:setParent(_parent)
    if self.isBlock and not _parent.isBlock then
        error("Parent of block must also be block (can not be inline)")
    end
    self._parent = _parent
end

function module:appendChild(arg1)
    arg1:unlink()
    arg1:setParent(self)
    if self._lastChild ~= nil then
        self._lastChild._next = arg1
        arg1._prev = self._lastChild
    else
        self._firstChild = arg1
    end
    self._lastChild = arg1
end

function module:prependChild(arg1)
    arg1:unlink()
    arg1:setParent(self)
    if self._firstChild ~= nil then
        self._firstChild._prev = arg1
        arg1._next = self._firstChild
        self._firstChild = arg1
        return
    end
    self._firstChild = arg1
    self._lastChild = arg1
end

function module:unlink()
    if self._prev ~= nil then
        self._prev._next = self._next
    elseif self._parent ~= nil then
        self._parent._firstChild = self._next
    end
    if self._next ~= nil then
        self._next._prev = self._prev
    elseif self._parent ~= nil then
        self._parent._lastChild = self._prev
    end
    self._parent = nil
    self._next = nil
    self._prev = nil
end

function module:insertAfter(arg1)
    arg1:unlink()
    arg1._next = self._next
    if arg1._next ~= nil then
        arg1._next._prev = arg1
    end
    arg1._prev = self
    self._next = arg1
    arg1._parent = self._parent
    if arg1._next == nil then
        arg1._parent._lastChild = arg1
    end
end

function module:insertBefore(arg1)
    arg1:unlink()
    arg1._prev = self._prev
    if arg1._prev ~= nil then
        arg1._prev._next = arg1
    end
    arg1._next = self
    self._prev = arg1
    arg1._parent = self._parent
    if arg1._prev == nil then
        arg1._parent._firstChild = arg1
    end
end

function module:getSourceSpans()
    return if self._sourceSpans == nil then var1 else self._sourceSpans
end

function module:setSourceSpans(tbl1)
    if #tbl1 == 0 then
        self._sourceSpans = nil
        return
    end
    self._sourceSpans = table.clone(tbl1)
end

function module:addSourceSpan(arg1)
    if self._sourceSpans == nil then
        self._sourceSpans = {}
    end
    table.insert(self._sourceSpans, arg1)
end

function module:toString(): string
    return `{self.kind}\{{self:toStringAttributes()}}`
end

module.toStringAttributesByKind = {}

function module:toStringAttributes()
    local var2 = module.toStringAttributesByKind[self.kind]
    if var2 ~= nil then
        return (var2(self))
    end

    return ""
end

return module
