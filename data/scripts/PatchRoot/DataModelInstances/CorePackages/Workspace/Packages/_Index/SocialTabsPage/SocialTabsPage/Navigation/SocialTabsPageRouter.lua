-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T21:10:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local SocialTabsPage = script:FindFirstAncestor("SocialTabsPage")

local tbl1 = {}

for _, value in require(SocialTabsPage.Common.TabConfig).routeOrder do
    table.insert(tbl1, { [value.id] = { getScreen = value.getScreen } })
end

return tbl1
