-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:50:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}
module.__index = module

function module.new(_id, _parent)
    local result = {}
    setmetatable(result, module)

    result._id = _id
    result._parent = _parent
    result._children = {}
    return result
end

function module.getValue(arg1)
    return arg1._value
end

function module.getLabel(arg1)
    return arg1._label
end

function module:getChildren()
    return self._children
end

function module:getId()
    return self._id
end

function module:getStackDepth()
    if self._parent == nil then
        return 0
    end

    return 1 + self._parent:getStackDepth()
end

function module.setLabelAndValue(arg1, _label, _value)
    arg1._label = _label
    arg1._value = _value
end

function module:getOrMakeChildById(arg1)
    for _, _child in ipairs(self._children) do
        if _child:getId() == arg1 then
            return _child
        end
    end

    local module2 = module.new(arg1, self)
    table.insert(self._children, module2)
    return module2
end

function module:removeChildren()
    if not self._children then
        return
    end

    for _, _child in ipairs(self._children) do
        _child:removeChildren()
    end

    self._id = nil
    self._parent = nil
    self._children = nil
end

function module:removeChild(arg1)
    for _, _child in ipairs(self._children) do
        if _child:getId() == arg1 then
            _child:removeChildren()
            return
        end
    end
end

return module
