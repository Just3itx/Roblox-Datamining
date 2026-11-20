-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:41:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _CorePackages = game:GetService("CorePackages")

local scriptParent = script.Parent
local ScreenList = require(scriptParent.ScreenList)

return function(arg1, arg2)
    return {
        ScreenList = ScreenList((arg1 or {}).ScreenList, arg2)
    }
end
