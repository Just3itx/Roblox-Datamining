-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T15:21:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(tbl1)
    if tbl1.mutualFriendsCount == 0 then
        return ""
    elseif tbl1.mutualFriendsCount == 1 then
        return tbl1.localized.singularMutualConnection
    end

    return tbl1.localized.mutualConnections
end
