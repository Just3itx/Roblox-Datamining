-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T01:01:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TrustedContactsParent = script:FindFirstAncestor("TrustedContacts").Parent

local React = require(TrustedContactsParent.React)
local UserProfiles = require(TrustedContactsParent.UserProfiles)

local useLocalization = require(TrustedContactsParent.Localization).Hooks.useLocalization

local Foundation = require(TrustedContactsParent.Foundation)
local Dialog = Foundation.Dialog
local DialogSize = Foundation.Enums.DialogSize
local ButtonVariant = Foundation.Enums.ButtonVariant

local FFlagTCShareLinkErrorModalTextRename = require(TrustedContactsParent.SharedFlags).FFlagTCShareLinkErrorModalTextRename
local FFlagTCShareLinkWrongRecipient = require(TrustedContactsParent.SharedFlags).FFlagTCShareLinkWrongRecipient

local function TrustedFriendsShareLinkErrorModal(tbl1)
    local navigation = tbl1.navigation
    local param = navigation.getParam("extraProps")
    local usernameFromId

    if FFlagTCShareLinkWrongRecipient then
        local recipientUserId = param.recipientUserId
        local var1 = UserProfiles.Hooks.useUserProfilesFetch({
            userIds = recipientUserId and { recipientUserId } or {},
            query = UserProfiles.Queries.userProfilesCombinedNameAndUsernameByUserIds
        })
        if recipientUserId and var1.data then
            usernameFromId = UserProfiles.Selectors.getUsernameFromId(var1.data, recipientUserId)
        else
            usernameFromId = nil
        end
    else
        usernameFromId = nil
    end

    local var1 = useLocalization({
        expiredTitle = "Feature.Friends.Title.TrustedFriendsExpiredLink",
        expiredDescription = if FFlagTCShareLinkErrorModalTextRename then "Feature.Friends.Description.TrustedFriendsExpiredLink" else "Feature.Friends.Description.TrustedConnectionExpiredLink",
        invalidTitle = "Feature.Friends.Title.TrustedFriendsInvalidLink",
        invalidDescription = "Feature.Friends.Description.TrustedFriendsInvalidLink",
        wrongRecipientDescription = usernameFromId and {
            "Feature.Friends.Description.TrustedFriendsWrongAccount",
            username = usernameFromId
        } or nil,
        ok = "CommonUI.Controls.Action.OK"
    })

    local onActivated = React.useCallback(function()
        navigation.pop()
        param.closeModal()
    end, { navigation, param.closeModal })

    local createElement = React.createElement
    local root = Dialog.Root
    local tbl2 = {
        size = DialogSize.Medium
    }
    local tbl3 = {
        Title = React.createElement(
            Dialog.Title,
            {
                LayoutOrder = 1,
                text = if param.errorType == "Expired" then var1.expiredTitle else var1.invalidTitle
            }
        ),
        BodyText = React.createElement(Dialog.Text, {
            LayoutOrder = 2,
            Text = if param.errorType == "Expired" then var1.expiredDescription elseif FFlagTCShareLinkWrongRecipient and usernameFromId then var1.wrongRecipientDescription else var1.invalidDescription
        }),
        DialogActions = React.createElement(
            Dialog.Actions,
            {
                LayoutOrder = 3,
                actions = {{
                    text = var1.ok,
                    variant = ButtonVariant.Emphasis,
                    onActivated = onActivated
                }}
            }
        )
    }
    return createElement(root, tbl2, tbl3)
end

return TrustedFriendsShareLinkErrorModal
