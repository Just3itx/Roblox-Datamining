-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:40:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local ArgCheck = require(AppChatParent.ArgCheck)
local Cryo = require(AppChatParent.Cryo)
local Roact = require(AppChatParent.Roact)
local RoactNavigation = require(AppChatParent.RoactNavigation)
local SignalsReact = require(AppChatParent.SignalsReact)

local createChatTopBar = require(AppChat.createChatTopBar)
local GetTopBarStore = require(AppChat.Stores.GetTopBarStore)

local function TopBarFromStore(arg1)
    local navigation = arg1.navigation
    local activeChildNavigationOptions = RoactNavigation.getActiveChildNavigationOptions(navigation)
    local state = navigation.state
    local var1 = state.routes[state.index]

    local var2 = GetTopBarStore(false).getScreenTopBar(var1.routeName)
    local var3 = SignalsReact.useSignalState(var2)
    ArgCheck.isType(var3, "table", "screenTopBar")

    local conversationId = var1.params and var1.params.conversationId
    local conversationId2 = var3.conversationId
    if conversationId and conversationId2 and conversationId ~= conversationId2 then
        var3 = Cryo.Dictionary.union(var3, { headerText = { raw = "", shouldLocalize = false } })
    end

    return createChatTopBar(Cryo.Dictionary.join(var3, activeChildNavigationOptions, { navigation = navigation }))
end

return function(navigation)
    return Roact.createElement(TopBarFromStore, { navigation = navigation })
end
