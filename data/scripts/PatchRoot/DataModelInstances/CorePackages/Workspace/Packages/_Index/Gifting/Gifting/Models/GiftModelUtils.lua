-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T23:30:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Gifting = script:FindFirstAncestor("Gifting")
local GiftingParent = Gifting.Parent

local t = require(GiftingParent.t)

local ItemType = require(Gifting.Enums.ItemType)
local _Types = require(Gifting.Types)

local module = {}

function module.invalidField(str1: string, itemType): string
    return `invalid {str1}: {tostring(itemType)}`
end

module.nonEmptyString = t.intersection(t.string, function(str1: string): (boolean, string)
    return str1 ~= "", "non-empty string expected, got empty string"
end)

local var1 = t.interface({ itemId = module.nonEmptyString })

local var2 = t.interface({ year = t.number, month = t.number, day = t.number })

local var3 = t.interface({ userId = t.number })

local var4 = t.interface({ areFriends = t.boolean, mutualFriendsCount = t.number, userAccountSinceYear = t.number })

function module.formatList(str1: string, arg1, func1: (...any) -> (...any))
    local var5, var6 = t.table(arg1)
    if not var5 then
        return nil, `{str1}: {var6}`
    end

    local result = {}
    for value, value2 in arg1 do
        local var7, var8 = func1(value2)
        if var7 == nil then
            return nil, `{str1}[{value}]: {var8}`
        end
        table.insert(result, var7)
    end
    return result
end

function module.formatItem(arg1)
    local var5, var6 = var1(arg1)
    if not var5 then
        return nil, `item: {var6}`
    end

    local itemType = ItemType.fromValue(arg1.itemType)
    if itemType == nil or itemType == ItemType.Invalid then
        return nil, module.invalidField("itemType", arg1.itemType)
    end

    return {
        itemType = itemType,
        itemId = arg1.itemId
    }
end

function module.formatDateInfo(friendSinceDate)
    local var5, var6 = var2(friendSinceDate)
    if not var5 then
        return nil, `date: {var6}`
    end

    return {
        year = friendSinceDate.year,
        month = friendSinceDate.month,
        day = friendSinceDate.day
    }
end

function module.formatGiftSenderInfo(arg1)
    local var5, var6 = var3(arg1)
    if not var5 then
        return nil, `sender: {var6}`
    end

    return {
        userId = arg1.userId,
        username = arg1.username or "",
        displayName = arg1.displayName or ""
    }
end

function module.formatUserRelationshipDetail(arg1)
    local var5, var6 = var4(arg1)
    if not var5 then
        return nil, `userRelationshipDetail: {var6}`
    end

    local var7

    if arg1.friendSinceDate == nil then
        var7 = nil
    else
        local var8
        var7, var8 = module.formatDateInfo(arg1.friendSinceDate)
        if var7 == nil then
            return nil, `userRelationshipDetail.friendSinceDate: {var8}`
        end
    end

    return {
        areFriends = arg1.areFriends,
        mutualFriendsCount = arg1.mutualFriendsCount,
        friendSinceYear = if t.number(arg1.friendSinceYear) then arg1.friendSinceYear else nil,
        friendSinceDate = var7,
        userAccountSinceYear = arg1.userAccountSinceYear
    }
end

return module
