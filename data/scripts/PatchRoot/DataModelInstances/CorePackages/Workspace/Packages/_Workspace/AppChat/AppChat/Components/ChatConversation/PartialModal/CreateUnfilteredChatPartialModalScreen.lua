-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:31:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local Cryo = require(AppChatParent.Cryo)
local EnumScreens = require(AppChat.EnumScreens)
local React = require(AppChatParent.React)
local useCallback = React.useCallback
local useEffectOnMount = require(AppChatParent.RoactUtils).Hooks.useEffectOnMount

local CreateUnfilteredChatPartialModalContainer = require(script.Parent.CreateUnfilteredChatPartialModalContainer)
local Logger = require(script.Parent.Logger)

local tbl1 = {}

local function CreateUnfilteredChatPartialModalScreen(tbl2)
    local var1 = Cryo.Dictionary.union(tbl1, tbl2)
    local navigation = var1.navigation
    assert(type(navigation) ~= "nil", "CreateUnfilteredChatPartialModalScreen should be wrapped with React Navigation")
    local conversationId = navigation and navigation.getParam and navigation.getParam("conversationId", nil)

    useEffectOnMount(function()
        Logger:info("LearnMorePartialModalScreen mounted")
    end)

    local onDismissed = useCallback(function()
        navigation.goBack()
    end, { navigation })

    local navigateToConversation = useCallback(function(conversationId2)
        navigation.navigate(EnumScreens.ChatConversation, { conversationId = conversationId2 })
    end, { navigation })

    local navigateToToast = useCallback(function(toastTitle)
        var1.navigation.navigate(EnumScreens.RoactChatToast, { toastProps = { toastContent = { toastTitle = toastTitle } } })
    end, { navigation })

    if conversationId == nil then
        Logger:warning("ConversationId is required to open CreateUnfilteredChatPartialModalScreen")
        return nil
    end
    return React.createElement(CreateUnfilteredChatPartialModalContainer, {
        conversationId = conversationId,
        onDismissed = onDismissed,
        navigateToConversation = navigateToConversation,
        navigateToToast = navigateToToast
    })
end

return CreateUnfilteredChatPartialModalScreen
