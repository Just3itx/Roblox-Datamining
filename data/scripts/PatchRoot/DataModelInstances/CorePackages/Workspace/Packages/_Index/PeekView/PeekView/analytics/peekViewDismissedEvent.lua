-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T08:50:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PeekViewParent = script:FindFirstAncestor("PeekView").Parent

local t = require(PeekViewParent.t)
local mutedError = require(PeekViewParent.Loggers).mutedError

local var1 = t.strictInterface({ page = t.string, dismissMethod = t.string })

local var2 = t.strictInterface({
    page = t.string,
    dismissMethod = t.string,
    locale = t.optional(t.string),
    universeId = t.string,
    source = t.string,
    index = t.number
})

local var3 = t.union(var1, var2)

return {
    dismissMethodEnum = {
        topBarTap = "topBarTap",
        scrimTap = "scrimTap",
        swipe = "swipe",
        handleTap = "handleTap"
    },
    logEvent = function(arg1, str1: string, arg2)
        local var4, var5 = var3(arg2)
        if not var4 then
            mutedError(var5)
        end

        arg1:sendEventDeferred(str1, "uiPeekViewDismissed", arg2)
    end
}
