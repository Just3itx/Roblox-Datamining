-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:20:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local Object = require(scriptParentParentParent.LuauPolyfill).Object

local SwitchRouter = require(scriptParent.SwitchRouter)
local BackBehavior = require(scriptParentParent.BackBehavior)

return function(arg1, arg2)
    local tbl1 = {
        resetOnBlur = false,
        backBehavior = BackBehavior.InitialRoute
    }

    if arg2 then
        tbl1 = Object.assign(tbl1, arg2)
    end

    return SwitchRouter(arg1, tbl1)
end
