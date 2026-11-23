-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:31:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local React = require(AppChatParent.React)
local Foundation = require(AppChatParent.Foundation)
local SignalsReact = require(AppChatParent.SignalsReact)
local BuilderIcons = require(AppChatParent.BuilderIcons)

local GetSelectedUsersStore = require(AppChat.Stores.GetSelectedUsersStore)

return React.memo(function() -- name: FriendCountLabel
    local selectedUsersStore = GetSelectedUsersStore(false)
    local var1 = SignalsReact.useSignalBinding(selectedUsersStore.getSelectedUserIdsCount())
    local var2 = SignalsReact.useSignalBinding(selectedUsersStore.getMaxSize())

    local var3 = Foundation.Hooks.useTokens()
    return React.createElement(Foundation.View, {
        tag = "col auto-xy padding-y-small gap-small align-x-center"
    }, {
        React.createElement(Foundation.Icon, {
            style = var3.Color.Content.Emphasis,
            name = BuilderIcons.Migration.uiblox["icons/actions/friend_sort/add_friends"].name,
            variant = Foundation.Enums.IconVariant.Filled,
            size = Foundation.Enums.IconSize.Large,
            LayoutOrder = 1
        }),
        Label = React.createElement(Foundation.Text, {
            tag = "auto-xy text-truncate-end text-caption-large content-emphasis",
            Text = React.joinBindings({ var1, var2 }):map(function(arg1): string
                return `{arg1[1]}/{arg1[2]}`
            end),
            LayoutOrder = 2
        })
    })
end)
