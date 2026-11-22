-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:31:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreation = script:FindFirstAncestor("MomentsCreation")
local MomentsCreationParent = MomentsCreation.Parent

local _MomentsTypes = require(MomentsCreationParent.MomentsTypes)
local isStudio = require(MomentsCreationParent.MomentsCommon.isStudio)

local createMoment = require(MomentsCreation.Upload.createMoment)
local getTagsForMoment = require(MomentsCreation.Utils.getTagsForMoment)
local makeMomentMetadata = require(MomentsCreation.Utils.makeMomentMetadata)
local makeRegistrationInfo = require(MomentsCreation.Utils.makeRegistrationInfo)

local function publishMomentWithTags(arg1, arg2, str1: string, str2: string?, num1: number?, bool1: boolean?, callback: ((...any) -> (...any))?): boolean
    if isStudio() then
        print(`[moments-creation] dev publish (not uploaded): "{str1}"`)
        return false
    end

    local momentMetadata = makeMomentMetadata(arg1, str1, arg2, num1, bool1)
    local registrationInfo = makeRegistrationInfo(arg1, momentMetadata, getTagsForMoment(momentMetadata))

    task.spawn(function()
        if not createMoment(arg1, momentMetadata, registrationInfo, str2) and callback ~= nil then
            task.defer(function()
                callback()
            end)
        end
    end)
    return true
end

return publishMomentWithTags
