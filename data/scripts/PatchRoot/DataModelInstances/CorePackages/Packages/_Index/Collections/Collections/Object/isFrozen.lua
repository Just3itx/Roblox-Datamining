-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T02:41:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local __DEV__ = _G.__DEV__
local scriptParentParentParent = script.Parent.Parent.Parent

local _ES7Types = require(scriptParentParentParent.ES7Types)

return function(arg1): boolean
    if __DEV__ then
        print("Luau now has a direct table.isfrozen call that can save the overhead of this library function call")
    end
    return table.isfrozen(arg1)
end
