-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:31:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local Cryo = require(AppChatParent.Cryo)
local React = require(AppChatParent.React)
local useCallback = React.useCallback
local useEffectOnMount = require(AppChatParent.RoactUtils).Hooks.useEffectOnMount

local LearnMorePartialModalContainer = require(script.Parent.LearnMorePartialModalContainer)
local Logger = require(script.Parent.Logger)

local tbl1 = {}

local function LearnMorePartialModalScreen(tbl2)
    local navigation = Cryo.Dictionary.union(tbl1, tbl2).navigation
    assert(type(navigation) ~= "nil", "LearnMorePartialModalScreen should be wrapped with React Navigation")
    local conversationId = navigation and navigation.getParam and navigation.getParam("conversationId", nil)

    useEffectOnMount(function()
        Logger:info("LearnMorePartialModalScreen mounted")
    end)

    local onDismissed = useCallback(function()
        navigation.goBack()
    end, { navigation })

    return React.createElement(LearnMorePartialModalContainer, { conversationId = conversationId, onDismissed = onDismissed })
end

return LearnMorePartialModalScreen
