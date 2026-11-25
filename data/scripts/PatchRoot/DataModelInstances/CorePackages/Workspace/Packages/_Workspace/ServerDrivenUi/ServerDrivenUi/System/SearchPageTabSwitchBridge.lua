-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:40:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUiParent = script:FindFirstAncestor("ServerDrivenUi").Parent

local var1 = require(ServerDrivenUiParent.AppCommonLib).Signal.new()

return {
    switchTab = function(str1: string, str2: string)
        var1:fire(str1, str2)
    end,
    connect = function(func1: (...any) -> (...any))
        return var1:connect(func1)
    end
}
