-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T20:21:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserLibParent = script:FindFirstAncestor("UserLib").Parent

local Constants = require(script.Parent.Constants)
local SharedFlags = require(UserLibParent.SharedFlags)

local tbl1 = {
    [Constants.RbxthumbTypes.Avatar] = SharedFlags.FFlagAXBackgroundsInAvatarThumbnails,
    [Constants.RbxthumbTypes.AvatarBust] = SharedFlags.FFlagAXBackgroundsInAvatarBustThumbnails,
    [Constants.RbxthumbTypes.AvatarHeadShot] = SharedFlags.FFlagAXBackgroundsInHeadshotThumbnails,
    [Constants.RbxthumbTypes.Outfit] = SharedFlags.FFlagAXBackgroundsInOutfitThumbnails
}

return function(str1: string, avatarHeadShot, num1: number, bool1: boolean?, bool2: boolean?, bool3: boolean?): string
    local str2 = string.format("rbxthumb://type=%s&id=%s&w=%d&h=%d", avatarHeadShot, tostring(str1), num1, num1)
    if bool1 then
        str2 ..= "&filters=circular"
    end
    if bool2 then
        str2 ..= "&timestamp=" .. os.time()
    end
    if tbl1[avatarHeadShot] then
        str2 ..= "&includeBackground=true"
    end
    if bool3 and avatarHeadShot == Constants.RbxthumbTypes.AvatarHeadShot then
        str2 ..= "&includeprofileframe=true"
    end
    return str2
end
