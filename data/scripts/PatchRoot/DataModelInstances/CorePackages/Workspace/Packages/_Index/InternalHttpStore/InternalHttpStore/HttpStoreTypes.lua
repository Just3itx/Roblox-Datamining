-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T02:21:15Z
-- Luau bytecode version: 14 | Luau type version: 3
local scriptParentParent = script.Parent.Parent

local _Signals = require(scriptParentParent.Signals)
local _HttpSignals = require(scriptParentParent.HttpSignals)

return {
    HttpResponseStatus = table.freeze({ NotStarted = "NotStarted", Fetching = "Fetching", Success = "Success", Failed = "Failed" })
}
