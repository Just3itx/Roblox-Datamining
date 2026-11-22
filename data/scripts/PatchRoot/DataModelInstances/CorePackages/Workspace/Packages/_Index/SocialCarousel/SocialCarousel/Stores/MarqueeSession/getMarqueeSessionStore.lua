-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T18:11:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local createMarqueeSessionStore = require(script.Parent.createMarqueeSessionStore)

local tbl1 = ({})

return {
    getMarqueeSessionStore = function(str1: string)
        local var1 = tbl1[str1]
        if var1 ~= nil then
            return var1
        end
        local marqueeSessionStore = createMarqueeSessionStore()
        tbl1[str1] = marqueeSessionStore
        return marqueeSessionStore
    end,
    resetMarqueeSessionStores = function()
        table.clear(tbl1)
    end
}
