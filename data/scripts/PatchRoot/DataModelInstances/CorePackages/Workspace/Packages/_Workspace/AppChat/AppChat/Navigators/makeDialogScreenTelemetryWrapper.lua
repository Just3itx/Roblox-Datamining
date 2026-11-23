-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:01:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local ChatDialogTelemetryLayer = require(AppChat.Telemetry.Layers.ChatDialogTelemetryLayer)
local React = require(AppChatParent.React)

return function(arg1)
    return function(tbl1)
        local conversationId = if tbl1.navigation then tbl1.navigation.getParam("conversationId") else nil

        local value = React.useMemo(function()
            return { conversationId = conversationId }
        end, { conversationId })
        return React.createElement(ChatDialogTelemetryLayer.Provider, { value = value }, React.createElement(arg1, tbl1))
    end
end
