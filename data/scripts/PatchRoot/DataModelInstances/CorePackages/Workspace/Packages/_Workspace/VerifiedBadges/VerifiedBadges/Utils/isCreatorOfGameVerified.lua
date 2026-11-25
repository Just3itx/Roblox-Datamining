-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T21:21:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function isCreatorOfGameVerified(tbl1, tbl2)
    local creator = nil
    if tbl2.shouldUseV2GameDetails then
        if tbl1.GameDetailsV2 and tbl1.GameDetailsV2[tbl2.universeId] then
            creator = tbl1.GameDetailsV2[tbl2.universeId].creator
        end
    elseif tbl1.GameDetails and tbl1.GameDetails[tbl2.universeId] then
        creator = tbl1.GameDetails[tbl2.universeId].creator
    end

    if creator == nil or creator.id == nil then
        return false
    end
    local str1 = tostring(creator.id)

    if creator and tbl1.VerifiedBadges then
        if tbl1.VerifiedBadges.VerifiedUsers and creator.type == Enum.CreatorType.User.Name then
            return tbl1.VerifiedBadges.VerifiedUsers[tostring(str1)] == true
        end

        if tbl1.VerifiedBadges.VerifiedGroups and creator.type == Enum.CreatorType.Group.Name then
            return tbl1.VerifiedBadges.VerifiedGroups[tostring(str1)] == true
        end
    end
    return false
end

return isCreatorOfGameVerified
