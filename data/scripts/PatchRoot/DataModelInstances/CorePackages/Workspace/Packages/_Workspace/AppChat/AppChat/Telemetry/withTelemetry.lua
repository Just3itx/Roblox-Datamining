-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:31:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent
local React = require(AppChatParent.React)

local createTelemetryEmitter = require(script.Parent.createTelemetryEmitter)

return function(arg1)
    return function(arg2)
        assert(type(arg2) == "function", "Expect renderCallback to be a function.")

        return React.createElement(arg1.Consumer, {
            render = function(func1: (...any) -> (...any))
                local telemetryEmitter = createTelemetryEmitter(func1)
                return arg2(telemetryEmitter)
            end
        })
    end
end
