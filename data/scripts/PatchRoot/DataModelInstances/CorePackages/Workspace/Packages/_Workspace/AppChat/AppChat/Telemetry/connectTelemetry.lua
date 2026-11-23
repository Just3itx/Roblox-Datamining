-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:30:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local Cryo = require(AppChatParent.Cryo)
local React = require(AppChatParent.React)
local useTelemetry = require(AppChat.Telemetry.useTelemetry)

local function connectTelemetry(arg1)
    return function(arg2)
        return function(arg3)
            local telemetry = useTelemetry(arg1)
            return React.createElement(arg2, Cryo.Dictionary.union(arg3, { telemetry = telemetry }))
        end
    end
end

return connectTelemetry
