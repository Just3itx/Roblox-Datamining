-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:50:45Z
-- Luau bytecode version: 14 | Luau type version: 3
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local _MomentsTypes = require(DataHydrationParent.MomentsTypes)

local tbl1 = {}

for _, value in require(script.Parent.MomentFixtures).buildMomentFeedItems(1, 10) do
    table.insert(tbl1, value.moment)
end

return tbl1
