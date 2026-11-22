-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T05:31:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local MomentsGetMomentsStore = require(MomentsParent.DataHydration.MomentsGetMomentsStore)

local function fetchMomentsByIds(tbl1, str1: string?)
    return MomentsGetMomentsStore(false).getMomentsByIds(tbl1, str1)
end

return fetchMomentsByIds
