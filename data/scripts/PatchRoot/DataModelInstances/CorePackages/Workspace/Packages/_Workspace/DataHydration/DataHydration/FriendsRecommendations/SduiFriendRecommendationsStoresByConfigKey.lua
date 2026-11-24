-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:10:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local createSduiFriendRecommendationsStore = require(script.Parent.createSduiFriendRecommendationsStore)

local tbl1 = ({})

return {
    get = function(str1: string?)
        local str2 = str1 or "Home"
        local var1 = tbl1[str2]
        if var1 == nil then
            var1 = createSduiFriendRecommendationsStore()
            tbl1[str2] = var1
        end
        return var1
    end,
    dispose = function(str1: string)
        local var1 = tbl1[str1]
        if var1 then
            var1.dispose()
            tbl1[str1] = nil
        end
    end
}
