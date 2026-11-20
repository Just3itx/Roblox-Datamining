-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:40:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FoundationParent = script:FindFirstAncestor("Foundation").Parent

local Assets = require(FoundationParent.FoundationCloudAssets).Assets

return function(str1: string): boolean
    return Assets[str1] ~= nil
end
