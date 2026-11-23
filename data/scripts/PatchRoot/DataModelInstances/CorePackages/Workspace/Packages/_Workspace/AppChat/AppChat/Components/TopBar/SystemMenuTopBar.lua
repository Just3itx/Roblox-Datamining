-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:31:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local ChatTopBarBase = require(script.Parent.ChatTopBarBase)
local GetTopBarStore = require(AppChat.Stores.GetTopBarStore)
local createSystemMenuButton = require(AppChat.Components.SelectChatMembers.createSystemMenuButton)

local Roact = require(AppChatParent.Roact)
local useLocalization = require(AppChatParent.Localization).Hooks.useLocalization
local useSignalState = require(AppChatParent.SignalsReact).useSignalState

local function SystemMenuTopBar(tbl1)
    local screenName = tbl1.screenName
    local navigation = tbl1.navigation

    local var1 = GetTopBarStore(false).getScreenTopBar(screenName)
    local var2 = useSignalState(var1)

    local systemButtonEnabled = var2.systemButtonEnabled
    local systemButtonActivated = var2.systemButtonActivated
    local systemButtonText = var2.systemButtonText or "Feature.Chat.Action.Add"

    local localizedStrings = useLocalization({
        systemButtonText = systemButtonText,
        networkErrorText = "Feature.Chat.Response.NetworkError",
        invalidParticipantText = "Feature.Chat.Toast.Error.InvalidUserSelected",
        cannotExpandToGroupChatActivePartyText = "Feature.Squads.Description.OneOnOneExpandedChatFeaturesActivePartyError"
    })

    return Roact.createElement(ChatTopBarBase, {
        screenName = screenName,
        navigation = navigation,
        renderRight = function()
            return createSystemMenuButton(
                {
                    localizedStrings = localizedStrings,
                    isDisabled = not systemButtonEnabled,
                    onActivated = systemButtonActivated
                }
            )
        end
    })
end

return SystemMenuTopBar
