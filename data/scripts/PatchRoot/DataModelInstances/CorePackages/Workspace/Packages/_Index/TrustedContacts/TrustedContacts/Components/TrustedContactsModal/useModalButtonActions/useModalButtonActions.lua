-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T01:01:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TrustedContacts = script:FindFirstAncestor("TrustedContacts")
local TrustedContactsParent = TrustedContacts.Parent

local React = require(TrustedContactsParent.React)
local Foundation = require(TrustedContactsParent.Foundation)
local useLocalization = require(TrustedContactsParent.Localization).Hooks.useLocalization

local TFActionsEnum = require(TrustedContacts.TrustedFriendActions.TFActionsEnum)

local useGetTFActionsCallbacks = require(script.Parent.useGetTFActionsCallbacks)

local FFlagTrustedFriendsLinkVPC = require(TrustedContacts.Flags.FFlagTrustedFriendsLinkVPC)

local function useModalButtonActions(str1: string, _: string?, arg1, arg2)
    local var1 = useGetTFActionsCallbacks(str1, arg2)

    local var2 = useLocalization({
        cancel = "CommonUI.Controls.Action.Cancel",
        add = "Feature.Friends.Action.Add",
        addViaLink = "Feature.Friends.Button.AddViaLink",
        ok = "CommonUI.Controls.Action.OK",
        accept = "CommonUI.Controls.Action.Accept"
    })

    local var3 = React.useMemo(function()
        local tbl1 = {
            text = var2.cancel,
            onActivated = var1.onCancelButtonPress,
            icon = nil,
            isLoading = false
        }

        return {
            [TFActionsEnum.RemoveTrustedConnection] = {{
                text = var2.ok,
                onActivated = var1.onOkButtonPress
            }},
            [TFActionsEnum.AddTrustedConnectionViaLink] = {
                {
                    text = var2.addViaLink,
                    onActivated = var1.onAddViaLinkButtonPress
                },
                tbl1
            },
            [TFActionsEnum.AddTrustedFriendDoubleOptin] = {
                {
                    text = var2.add,
                    onActivated = var1.onSendTrustedConnectionRequest
                },
                tbl1
            },
            [TFActionsEnum.AddTrustedFriendWithVpc] = {
                {
                    text = var2.add,
                    icon = Foundation.Enums.IconName.LockClosed,
                    onActivated = var1.onOpenVPCProloguePress
                },
                tbl1
            },
            [TFActionsEnum.AcceptTrustedFriendWithVpcRecipient] = {
                {
                    text = var2.accept,
                    icon = Foundation.Enums.IconName.LockClosed,
                    onActivated = var1.onOpenVPCProloguePress
                },
                tbl1
            },
            [TFActionsEnum.AcceptTrustedFriendViaLink] = {
                {
                    text = var2.accept,
                    onActivated = var1.onAddTrustedFriendFromLink
                },
                tbl1
            },
            [TFActionsEnum.AcceptTrustedFriend] = {
                {
                    text = var2.accept,
                    onActivated = var1.onAcceptRequestReceived
                },
                tbl1
            },
            [TFActionsEnum.AcceptTrustedFriendViaLinkWithVpcRecipient] = FFlagTrustedFriendsLinkVPC
                and {
                    {
                        text = var2.accept,
                        icon = Foundation.Enums.IconName.LockClosed,
                        onActivated = var1.onAddTrustedFriendFromLinkWithVPC
                    },
                    tbl1
                }
                or nil,
            [TFActionsEnum.AcceptTrustedFriendInvalid] = {
                {
                    text = var2.accept,
                    onActivated = function() end,
                    isDisabled = true
                },
                tbl1
            },
            [TFActionsEnum.PendingTrustedConnection] = {
                {
                    text = var2.add,
                    onActivated = function() end,
                    isDisabled = true
                },
                tbl1
            },
            [TFActionsEnum.PendingIncomingTrustedConnection] = {
                {
                    text = var2.accept,
                    onActivated = function() end,
                    isDisabled = true
                },
                tbl1
            }
        }
    end, { arg1, var2, var1 })

    return if arg1 then var3[arg1] else nil
end

return useModalButtonActions
