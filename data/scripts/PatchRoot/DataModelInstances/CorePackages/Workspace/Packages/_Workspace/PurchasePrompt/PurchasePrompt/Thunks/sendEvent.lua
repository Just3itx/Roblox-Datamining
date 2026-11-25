-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:41:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local Analytics = require(scriptParentParent.Services.Analytics)
local Thunk = require(scriptParentParent.Thunk)

local tbl1 = { Analytics }

local function sendEvent(arg1, arg2)
    return Thunk.new(script.Name, tbl1, function(_, arg3)
        arg3[Analytics].signalEvent(arg1, arg2)
    end)
end

return sendEvent
