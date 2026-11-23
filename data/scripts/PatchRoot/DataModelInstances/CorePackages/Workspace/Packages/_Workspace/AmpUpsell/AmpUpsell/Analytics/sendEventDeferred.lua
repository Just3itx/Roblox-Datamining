-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T05:40:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AmpUpsellParent = script:FindFirstAncestor("AmpUpsell").Parent
local getPlatformTarget = require(AmpUpsellParent.Analytics).getPlatformTarget

return function(arg1)
    return function(str1: string, str2: string, tbl1)
        arg1:SendEventDeferred(getPlatformTarget(), str1, str2, tbl1)
    end
end
