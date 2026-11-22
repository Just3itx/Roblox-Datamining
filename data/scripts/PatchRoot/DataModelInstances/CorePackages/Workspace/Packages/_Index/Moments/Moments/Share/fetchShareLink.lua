-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T05:21:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local MomentsGetMomentsShareLinkStore = require(MomentsParent.DataHydration.MomentsGetMomentsShareLinkStore)

local function fetchShareLink(tbl1)
    local var1 = MomentsGetMomentsShareLinkStore(false).getAndFetchShareLink(
        tbl1.momentId,
        tbl1.description,
        tbl1.title,
        tbl1.feedItemId
    )
    while var1.status(false) == "NotReady" do
        task.wait()
    end

    if var1.status(false) == "Ready" then
        return var1.data(false)
    end

    return nil
end

return fetchShareLink
