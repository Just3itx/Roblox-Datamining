-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T03:41:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local MomentsComments = require(MomentsParent.DataHydration.MomentsComments)
local MomentsCreateCommentsMockNetwork = require(MomentsParent.DataHydration.MomentsCreateCommentsMockNetwork)
local _MomentsStoreTypes = require(MomentsParent.DataHydration.MomentsStoreTypes)

local createCommentCollectionStore = require(script.Parent.GetCommentCollectionStore.createCommentCollectionStore)

local createCommentSessionFiltersStore = require(script.Parent.GetCommentSessionFiltersStore.createCommentSessionFiltersStore)

local function createCommentsMockHarness(tbl1)
    local network = MomentsCreateCommentsMockNetwork({
        latencySeconds = if tbl1 == nil then nil else tbl1.latencySeconds,
        postOutcome = if tbl1 == nil then nil else tbl1.postOutcome
    })
    local commentsEntityStore = MomentsComments.createMomentsCommentsStore({ network = network })

    local sessionFilters = createCommentSessionFiltersStore()
    local collectionStore = createCommentCollectionStore({ sessionFilters = sessionFilters })

    collectionStore.selectFeed("feed-1", commentsEntityStore.getOwnerGeneration(false))
    local bool1 = false

    return {
        network = network,
        commentsEntityStore = commentsEntityStore,
        collectionStore = collectionStore,
        sessionFilters = sessionFilters,
        dispose = function()
            if bool1 then
                return
            end
            bool1 = true
            collectionStore.dispose()
            commentsEntityStore.dispose()
        end
    }
end
return createCommentsMockHarness
