-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:11:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent

local Roact = require(scriptParentParentParentParent.Roact)
local Otter = require(scriptParentParentParentParent.Otter)
local t = require(scriptParentParentParentParent.t)

local var1 = Roact.PureComponent:extend("AnimatedComponent")

var1.validateProps = t.strictInterface({ values = t.table, render = t.callback, options = t.optional(t.table) })

function var1.update(arg1, arg2)
    local tbl1 = ({})
    for k, value in pairs(arg2) do
        if type(k) == "function" then
            k(value)
        else
            tbl1[k] = value
        end
    end
    for k, _ in pairs(arg1.state) do
        if not arg2[k] then
            tbl1[k] = Roact.None
        end
    end
    if next(tbl1) ~= nil then
        arg1:setState(tbl1)
    end
end

function var1.init(arg1)
    arg1:update(arg1.props.values)
    arg1.motor = Otter.createGroupMotor(arg1.props.values)
    arg1.motor:onStep(function(arg2)
        arg1:update(arg2)
    end)
end

function var1.didUpdate(arg1, arg2)
    local values = arg1.props.values
    local options = arg1.props.options

    local bool1 = values ~= arg2.values
    local bool2 = options ~= arg2.options

    if not bool1 and not bool2 then
        return
    end

    local tbl1 = ({})
    for k, value in pairs(values) do
        tbl1[k] = Otter.spring(value, options)
    end
    arg1.motor:setGoal(tbl1)
end

function var1.render(arg1)
    local state = arg1.state
    return arg1.props.render(state)
end

function var1.willUnmount(arg1)
    if arg1.motor then
        arg1.motor:destroy()
        arg1.motor = nil
    end
end

return function(values, render, options)
    return Roact.createElement(var1, { values = values, options = options, render = render })
end
