-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T23:30:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Gifting = script:FindFirstAncestor("Gifting")
local GiftingParent = Gifting.Parent

local t = require(GiftingParent.t)

local UserRelationship = require(Gifting.Enums.UserRelationship)
local GiftModelUtils = require(Gifting.Models.GiftModelUtils)
local _Types = require(Gifting.Types)

local var1 = t.interface({ userId = t.number })

local function formatRecipientResult(arg1)
    local var2, var3 = var1(arg1)
    if not var2 then
        return nil, `recipient: {var3}`
    end

    local userRelationship = UserRelationship.fromValue(arg1.userRelationship)
    if userRelationship == nil then
        return nil, GiftModelUtils.invalidField("recipient.userRelationship", arg1.userRelationship)
    end

    return {
        userId = arg1.userId,
        username = arg1.username or "",
        displayName = arg1.displayName or "",
        thumbnailUrl = arg1.thumbnailUrl or "",
        userRelationship = userRelationship
    }
end

local module = {}

function module.format(arg1)
    local recipients, var3 = GiftModelUtils.formatList("recipients", arg1.recipients or {}, formatRecipientResult)
    if recipients == nil then
        return nil, var3
    end

    return {
        recipients = recipients,
        nextCursor = arg1.nextCursor
    }
end

return module
