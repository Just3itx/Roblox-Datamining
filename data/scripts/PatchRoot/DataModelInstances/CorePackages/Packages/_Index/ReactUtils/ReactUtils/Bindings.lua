-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:50:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ReactUtils = script:FindFirstAncestor("ReactUtils")

local React = require(ReactUtils.Parent.React)

local module = {}

function module.map(arg1, func1: (...any) -> (...any))
    return arg1:map(func1)
end

function module.binding<T>(arg1: T): T
    return arg1
end

function module.useBinding(arg1)
    local var1, var2 = React.useBinding(arg1)
    return module.binding(var1), var2
end

function module.createBinding(arg1)
    local var1, var2 = React.createBinding(arg1)
    return module.binding(var1), var2
end

function module.joinBindings2(first, second)
    return module.binding(React.joinBindings({ first = first, second = second }))
end

function module.mapBindings2(first, second, func1: (...any) -> (...any))
    return module.map(module.binding(React.joinBindings({ first = first, second = second })), function(arg1)
        return func1(arg1.first, arg1.second)
    end)
end

function module.joinBindings3(first, second, third)
    return module.binding(React.joinBindings({ first = first, second = second, third = third }))
end

function module.mapBindings3(first, second, third, func1: (...any) -> (...any))
    return module.map(module.binding(React.joinBindings({ first = first, second = second, third = third })), function(arg1)
        return func1(arg1.first, arg1.second, arg1.third)
    end)
end

function module.mapBindings4(first, second, third, fourth, func1: (...any) -> (...any))
    return module.map(
        module.binding(React.joinBindings({ first = first, second = second, third = third, fourth = fourth })),
        function(arg1)
            return func1(arg1.first, arg1.second, arg1.third, arg1.fourth)
        end
    )
end

return module
