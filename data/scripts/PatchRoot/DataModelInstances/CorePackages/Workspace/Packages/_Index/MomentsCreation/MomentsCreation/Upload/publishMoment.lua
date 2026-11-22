-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:31:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreation = script:FindFirstAncestor("MomentsCreation")
local MomentsCreationParent = MomentsCreation.Parent

local _MomentsTypes = require(MomentsCreationParent.MomentsTypes)

local isAvatarMoment = require(MomentsCreation.Utils.isAvatarMoment)
local makeMomentMetadata = require(MomentsCreation.Utils.makeMomentMetadata)
local makeRegistrationInfo = require(MomentsCreation.Utils.makeRegistrationInfo)
local createMoment = require(MomentsCreation.Upload.createMoment)
local FFlagMomentsCreateAvatarPosts = require(MomentsCreationParent.SharedFlags).FFlagMomentsCreateAvatarPosts

local function publishMoment(arg1, arg2, str1: string, str2: string?, num1: number?, bool1: boolean?)
    if FFlagMomentsCreateAvatarPosts and isAvatarMoment(arg1) then
        return require(MomentsCreation.Upload.createAvatarMoment)(arg1, arg2, str1, str2, bool1)
    end

    local momentMetadata = makeMomentMetadata(arg1, str1, arg2, num1, bool1)
    local registrationInfo = makeRegistrationInfo(arg1, momentMetadata)
    createMoment(arg1, momentMetadata, registrationInfo, str2)
    return nil
end

return publishMoment
