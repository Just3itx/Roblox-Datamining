-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T01:01:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TrustedContacts = script:FindFirstAncestor("TrustedContacts")
local TrustedContactsParent = TrustedContacts.Parent
local React = require(TrustedContactsParent.React)
local useLocalization = require(TrustedContactsParent.Localization).Hooks.useLocalization

local TrustedConnectionStatus = require(TrustedContacts.Enums).TrustedConnectionStatus

local function useModalTexts(str1: string?)
    local var1 = useLocalization({
        addTFHeader = "Feature.Friends.TrustedFriend.Label.AddTrustedFriend",
        addTFBody = "Feature.Friends.Description.DoMoreWithTrustedFriends",
        acceptTFHeader = "Feature.Friends.TrustedFriend.AddBack.Header",
        acceptTFBody = "Feature.Friends.Description.TrustedFriendsRequestModalBody",
        newTFHeader = "Feature.Friends.TrustedFriend.Info.Modal.Header",
        newTFBody = "Feature.Friends.Description.YouCanDoMoreWithTrustedFriends"
    })

    local var2 = React.useMemo(function()
        return {
            [TrustedConnectionStatus.Friends] = {
                header = var1.addTFHeader,
                description = var1.addTFBody
            },
            [TrustedConnectionStatus.RequestReceived] = {
                header = var1.acceptTFHeader,
                description = var1.acceptTFBody
            },
            [TrustedConnectionStatus.TrustedFriends] = {
                header = var1.newTFHeader,
                description = var1.newTFBody
            }
        }
    end, { var1 })

    local var3 = if str1 then var2[str1] else nil
    return {
        header = if var3 then var3.header else "",
        description = if var3 then var3.description else ""
    }
end

return useModalTexts
