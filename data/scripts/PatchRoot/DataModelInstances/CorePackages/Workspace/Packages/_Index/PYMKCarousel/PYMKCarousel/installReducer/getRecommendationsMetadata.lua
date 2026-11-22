-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T13:31:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PYMKCarousel = script:FindFirstAncestor("PYMKCarousel")
local getDeepValue = require(PYMKCarousel.dependencies).SocialLibraries.Dictionary.getDeepValue

return function(arg1, str1: string)
    return getDeepValue(arg1, string.format("metadata.%s", str1)) or {}
end
