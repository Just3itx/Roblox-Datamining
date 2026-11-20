-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:50:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ReactUtilsParent = script:FindFirstAncestor("ReactUtils").Parent
local _GoodSignal = require(ReactUtilsParent.GoodSignal)

local useEventConnection = require(script.Parent.useEventConnection)

local function EventConnection(tbl1)
    useEventConnection(tbl1.event, tbl1.callback, { tbl1.event, tbl1.callback })
end

return EventConnection
