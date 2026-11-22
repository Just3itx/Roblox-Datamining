-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:10:41Z
-- Luau bytecode version: 14 | Luau type version: 3
local scriptParent = script.Parent
local Signal = require(scriptParent.AppCommonLib).Signal

return {
    ReloadPage = Signal.new(),
    ReportMutedError = Signal.new()
}
