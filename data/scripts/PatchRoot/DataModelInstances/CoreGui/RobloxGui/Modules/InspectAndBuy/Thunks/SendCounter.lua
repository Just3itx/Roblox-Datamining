-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:31:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local Thunk = require(scriptParentParent.Thunk)
local Analytics = require(scriptParentParent.Services.Analytics)

local tbl1 = { Analytics }

local function SendCounter(arg1)
    return Thunk.new(script.Name, tbl1, function(_, arg2)
        arg2[Analytics].sendCounter(arg1)
    end)
end

return SendCounter
