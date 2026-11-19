-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T08:01:15Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local FoundationParent = script:FindFirstAncestor("Foundation").Parent

local Assets = require(FoundationParent.FoundationCloudAssets).Assets

return function(str1: string): boolean
    return Assets[str1] ~= nil
end
