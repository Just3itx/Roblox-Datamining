-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T20:00:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialServerDrivenUiParent = script:FindFirstAncestor("SocialServerDrivenUi").Parent

local var1 = require(SocialServerDrivenUiParent.AppCommonLib).Signal.new()

return {
    requestOpen = function(tbl1)
        var1:fire(tbl1)
    end,
    subscribe = function(func1: (...any) -> (...any))
        return var1:connect(func1)
    end
}
