-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:31:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreation = script:FindFirstAncestor("MomentsCreation")
local MomentsCreationParent = MomentsCreation.Parent

local MomentsCommon = require(MomentsCreationParent.MomentsCommon)
local Logger = require(MomentsCreation.Logger)

local function completeMomentUpload(assetId: number, tbl1)
    tbl1.uploadStore.setSuccess(assetId)
    MomentsCommon.Analytics.reportMomentsCreationStep("upload", "success")
    local feedStore = tbl1.feedStore
    if feedStore then
        feedStore.prependItem({ assetId = assetId })
    end
    local myCreationsStore = tbl1.myCreationsStore
    if myCreationsStore then
        myCreationsStore.prependItem({ assetId = assetId })
        myCreationsStore.invalidateCount()
    end
    tbl1.onPostedToFeed()
    Logger:debug(
        "event=completion assetId={} MomentsUseBackendPostStatusNotification={} localSuccessToast={}",
        tostring(assetId),
        tostring(true),
        "suppressed"
    )
end

return completeMomentUpload
