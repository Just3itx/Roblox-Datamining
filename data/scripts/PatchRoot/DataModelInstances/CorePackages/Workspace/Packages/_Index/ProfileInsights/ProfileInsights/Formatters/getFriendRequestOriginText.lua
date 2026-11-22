-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T10:51:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfileInsights = script:FindFirstAncestor("ProfileInsights")

local FriendRequestOriginSource = require(ProfileInsights.Enums).FriendRequestOriginSource

local function getFriendRequestOriginText(num1: number?, tbl1)
    if num1 == FriendRequestOriginSource.QrCode then
        return tbl1.fromQrCode
    end

    if num1 == FriendRequestOriginSource.PhoneContactImporter then
        return tbl1.fromContacts
    end

    if num1 == FriendRequestOriginSource.PlayerSearch then
        return tbl1.fromSearch
    end

    return nil
end

return getFriendRequestOriginText
