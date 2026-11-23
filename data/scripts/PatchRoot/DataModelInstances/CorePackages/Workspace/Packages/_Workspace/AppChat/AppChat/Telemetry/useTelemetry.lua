-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:31:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent
local React = require(AppChatParent.React)

local createTelemetryEmitter = require(script.Parent.createTelemetryEmitter)

local function useTelemetry(arg1)
    local var1 = React.useContext(arg1)
    return createTelemetryEmitter(var1)
end

return useTelemetry
