-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T21:01:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialTabsPageParent = script:FindFirstAncestor("SocialTabsPage").Parent

local useIsWideMode = require(SocialTabsPageParent.SocialCommon).Hooks.useIsWideMode

local function usePageSize(): number
    return if useIsWideMode() then 50 else 25
end

return usePageSize
