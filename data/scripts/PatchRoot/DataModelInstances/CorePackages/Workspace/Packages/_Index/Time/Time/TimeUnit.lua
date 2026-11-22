-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T23:41:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local var1 = setmetatable({}, {
    __index = function(_, arg1)
        error(("Invalid TimeUnit \"%s\""):format(tostring(arg1)), 2)
    end
})

var1.Seconds = "Seconds"
var1.Minutes = "Minutes"
var1.Hours = "Hours"
var1.Days = "Days"
var1.Months = "Months"
var1.Years = "Years"

var1.Weeks = "Weeks"

return var1
