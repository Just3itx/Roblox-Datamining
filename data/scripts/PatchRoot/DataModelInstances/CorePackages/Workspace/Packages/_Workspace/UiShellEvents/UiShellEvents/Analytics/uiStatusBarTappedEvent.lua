-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T19:51:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UiShellEvents = script:FindFirstAncestor("UiShellEvents")
local UiShellEventsParent = UiShellEvents.Parent
local t = require(UiShellEventsParent.t)
local Logger = require(UiShellEvents.Logger)

local var1 = t.strictInterface({ page = t.string })

return function(arg1, str1: string, tbl1)
    local var2, var3 = var1(tbl1)
    if not var2 then
        Logger:error(var3)
    end

    arg1:sendEventDeferred(str1, "uiShellStatusBarTapped", tbl1)
end
