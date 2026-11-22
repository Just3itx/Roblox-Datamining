-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:00:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local Signals = require(MomentsParent.Signals)
local MomentsGetMomentsCommentsStore = require(MomentsParent.DataHydration.MomentsGetMomentsCommentsStore)

local GetCommentCollectionStore = require(Moments.Components.Comments.GetCommentCollectionStore)
local createCommentsSheetStore = require(script.Parent.createCommentsSheetStore)

local var1 = MomentsGetMomentsCommentsStore(false)
local commentCollectionStore = GetCommentCollectionStore(false)
local ownerGeneration = var1.getOwnerGeneration(false)

local tbl1 = {
    store = createCommentsSheetStore(),
    stopObservingOwner = nil
}

tbl1.stopObservingOwner = Signals.createEffect(function(arg1)
    local ownerGeneration2 = var1.getOwnerGeneration(arg1)
    if ownerGeneration2 == ownerGeneration then
        return
    end
    ownerGeneration = ownerGeneration2
    tbl1.store.reset()
    commentCollectionStore.clear()
end)

return Signals.createComputed(function(_)
    return tbl1.store
end)
