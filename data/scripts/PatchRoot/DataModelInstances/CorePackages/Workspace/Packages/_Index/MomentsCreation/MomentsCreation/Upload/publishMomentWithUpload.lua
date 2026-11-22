-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:31:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreation = script:FindFirstAncestor("MomentsCreation")
local MomentsCreationParent = MomentsCreation.Parent

local _MomentsTypes = require(MomentsCreationParent.MomentsTypes)

local makeMomentMetadata = require(MomentsCreation.Utils.makeMomentMetadata)
local makeRegistrationInfo = require(MomentsCreation.Utils.makeRegistrationInfo)
local uploadMoment = require(MomentsCreation.Upload.uploadMoment)

local function publishMomentWithUpload(arg1, arg2, str1: string, tbl1)
    local momentMetadata = makeMomentMetadata(arg1, str1, arg2, tbl1.resolvedTimeLength, tbl1.commentsEnabled)
    local registrationInfo = makeRegistrationInfo(arg1, momentMetadata)
    uploadMoment(
        arg1,
        momentMetadata,
        registrationInfo,
        tbl1.localizations,
        tbl1.uploadStore,
        tbl1.toastStore,
        nil,
        nil,
        tbl1.creationSessionId
    )
end

return publishMomentWithUpload
