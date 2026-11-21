-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T06:40:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local ChatBoxContextMenu = require(script.Components.ChatBoxContextMenu)
local ChatLineReportRoot = require(script.Components.ChatLineReportRoot)
local Constants = require(script.Common.Constants)

return {
    ["jest.config"] = script["jest.config"],
    ChatBoxContextMenu = ChatBoxContextMenu,
    ChatLineReportRoot = ChatLineReportRoot,
    Constants = Constants,
    Helpers = {
        getMessageText = require(script.Common.getMessageText),
        isSystemMessage = require(script.Common.isSystemMessage)
    }
}
