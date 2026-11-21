-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T12:31:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Constants = require(script.Parent.Constants)

local var1 = Constants.DEFAULT_BACKGROUND_ASSET_IDS[1]
local var2 = Constants.DEFAULT_BACKGROUND_ASSET_IDS[2]

return {
    getDisplayBackgroundId = function(num1: number?, str1: string)
        return if num1 and num1 ~= -1 then num1 elseif str1 == "dark" then var1 else var2
    end
}
