-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T21:11:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserRelationshipModalsParent = script:FindFirstAncestor("UserRelationshipModals").Parent

local React = require(UserRelationshipModalsParent.React)
local Foundation = require(UserRelationshipModalsParent.Foundation)
local Dialog = Foundation.Dialog
local DialogSize = Foundation.Enums.DialogSize
local ButtonVariant = Foundation.Enums.ButtonVariant

local useLocalization = require(UserRelationshipModalsParent.Localization).Hooks.useLocalization

local UserTile = require(UserRelationshipModalsParent.UserTile)
local UserTile2 = UserTile.UserTile
local LayoutMode = UserTile.LayoutMode
local num1 = game:DefineFastInt("PromptFriendRequestModalInputDelayMs", 1000)

local function PromptFriendRequestModal(tbl1)
    local var1 = useLocalization({
        titleText = "InGame.FriendPlayerPrompt.Title.SendFriendRequest.FriendsRename",
        sendText = "InGame.FriendPlayerPrompt.Action.Send"
    })

    local createElement = React.createElement
    local root = Dialog.Root
    local tbl2 = {
        size = DialogSize.Medium,
        onClose = tbl1.onClose
    }
    local tbl3 = {
        DialogTitle = React.createElement(Dialog.Title, { text = var1.titleText }),
        Avatar = React.createElement(Foundation.View, {
            tag = "row align-x-center size-full-3000",
            LayoutOrder = 2
        }, {
            UserTile = React.createElement(
                UserTile2,
                {
                    userId = tbl1.userId,
                    title = tbl1.displayName,
                    subtitle = "@" .. tbl1.username,
                    layoutMode = LayoutMode.compact
                }
            )
        }),
        Buffer = React.createElement(Foundation.View, { tag = "size-full-500", LayoutOrder = 3 }),
        DialogActions = 0
    }

    local createElement2 = React.createElement
    local actions = Dialog.Actions
    local tbl4 = {
        LayoutOrder = 4,
        actions = {{
            text = var1.sendText,
            variant = ButtonVariant.Emphasis,
            onActivated = tbl1.onSendClicked,
            inputDelay = if tbl1.inputDelay == nil then num1 / 1000 else tbl1.inputDelay
        }}
    }
    tbl3.DialogActions = createElement2(actions, tbl4)
    return createElement(root, tbl2, tbl3)
end

return PromptFriendRequestModal
