-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T01:01:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TrustedContacts = script:FindFirstAncestor("TrustedContacts")

local TrustedConnectionStatus = require(TrustedContacts.Enums).TrustedConnectionStatus
local TFActionsEnum = require(script.Parent.TFActionsEnum)

local tbl1 = {
    [TFActionsEnum.RemoveTrustedConnection] = TrustedConnectionStatus.TrustedFriends,
    [TFActionsEnum.AddTrustedConnectionViaLink] = TrustedConnectionStatus.Friends,
    [TFActionsEnum.AddTrustedFriendDoubleOptin] = TrustedConnectionStatus.Friends,
    [TFActionsEnum.AddTrustedFriendWithVpc] = TrustedConnectionStatus.Friends,
    [TFActionsEnum.PendingTrustedConnection] = TrustedConnectionStatus.Friends,
    [TFActionsEnum.AcceptTrustedFriendViaLinkWithVpcRecipient] = TrustedConnectionStatus.RequestReceived,
    [TFActionsEnum.AcceptTrustedFriendWithVpcRecipient] = TrustedConnectionStatus.RequestReceived,
    [TFActionsEnum.AcceptTrustedFriendViaLink] = TrustedConnectionStatus.RequestReceived,
    [TFActionsEnum.AcceptTrustedFriend] = TrustedConnectionStatus.RequestReceived,
    [TFActionsEnum.AcceptTrustedFriendInvalid] = TrustedConnectionStatus.RequestReceived,
    [TFActionsEnum.PendingIncomingTrustedConnection] = TrustedConnectionStatus.RequestReceived
}

local function normalizeTFActionsEnumToModalVariant(arg1)
    return tbl1[arg1]
end

return normalizeTFActionsEnumToModalVariant
