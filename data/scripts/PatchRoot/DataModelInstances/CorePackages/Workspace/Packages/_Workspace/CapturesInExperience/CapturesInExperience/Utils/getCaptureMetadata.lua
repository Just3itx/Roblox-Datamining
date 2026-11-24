-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:11:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local CaptureType = require(scriptParentParent.Enums.CaptureType)
local _Types = require(scriptParentParent.Types)

local FFlagUseRbxstorageInGallery = require(scriptParentParent.Flags.FFlagUseRbxstorageInGallery)

local FFlagEnableCapturesGalleryRetrievalCoreScript = require(scriptParentParent.Flags.FFlagEnableCapturesGalleryRetrievalCoreScript)
local bool1 = game:DefineFastFlag("DontAssertOnUserIDInCaptureMetadata", false)

return function(arg1)
    if FFlagEnableCapturesGalleryRetrievalCoreScript and arg1.CaptureTime ~= nil then
        return {
            userId = 0,
            placeId = arg1.SourcePlaceId,
            unixTimestamp = arg1.CaptureTime.UnixTimestampMillis
        }
    end

    if FFlagUseRbxstorageInGallery and arg1.type == CaptureType.Video then
        local userId = tonumber(arg1.userId)
        if not bool1 then
            assert(userId ~= nil, "userId should not be nil")
        end

        return {
            userId = userId or 0,
            placeId = arg1.placeId,
            unixTimestamp = arg1.creationTimestamp
        }
    end

    if FFlagUseRbxstorageInGallery and arg1.type ~= CaptureType.Screenshot then
        return nil
    end

    local filePath = arg1.filePath

    local var1, var2, var3 = string.match(filePath, "(%d+)_(%d+)_(%d+)%.?%w*$")

    if var1 == nil or var2 == nil or var3 == nil then
        return nil
    end

    local userId = tonumber(var1)
    local placeId = tonumber(var2)
    local unixTimestamp = tonumber(var3)

    if not bool1 then
        assert(userId ~= nil, "userId should not be nil")
    end
    assert(placeId ~= nil, "placeId should not be nil")
    assert(unixTimestamp ~= nil, "unixTimestamp should not be nil")

    return {
        userId = userId or 0,
        placeId = placeId,
        unixTimestamp = unixTimestamp
    }
end
