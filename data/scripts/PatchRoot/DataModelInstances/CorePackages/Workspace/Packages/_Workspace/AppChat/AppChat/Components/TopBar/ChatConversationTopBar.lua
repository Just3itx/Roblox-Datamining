-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:31:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local EnumScreens = require(AppChat.EnumScreens)
local FFlagDebugAppChatEnableDomLocators = require(AppChat.Flags.FFlagDebugAppChatEnableDomLocators)
local DomLocators = require(AppChat.Utils.DomLocators)
local ChatTopBarBase = require(script.Parent.ChatTopBarBase)
local createBackFunc = require(script.Parent.createBackFunc)
local useCallButtonEligibility = require(AppChat.Hooks.useCallButtonEligibility)
local GetTopBarStore = require(AppChat.Stores.GetTopBarStore)
local HeaderBarTitleLeftAligned = require(AppChat.Components.ChatConversation.HeaderBarTitleLeftAligned)
local useChatPlacementContext = require(AppChat.Contexts.ChatPlacementContext).useChatPlacementContext
local ConversationChannels = require(AppChat.Models.ConversationChannels)

local Foundation = require(AppChatParent.Foundation)
local React = require(AppChatParent.React)
local useLocalization = require(AppChatParent.Localization).Hooks.useLocalization
local SignalsReact = require(AppChatParent.SignalsReact)
local AppHeaderBar = require(AppChatParent.AppHeaderBar)

local SquadJoinButton = require(AppChatParent.Squads.SquadJoinButton)
local SquadButtonSourceEnum = require(AppChatParent.Squads.Enums).SquadButtonSourceEnum
local SquadComponentAccessWrapper = require(AppChatParent.Squads.SquadComponentAccessWrapper)

local SharedFlags = require(AppChatParent.SharedFlags)
local FFlagFriendsCallingClientGate_DEV = SharedFlags.FFlagFriendsCallingClientGate_DEV
local FFlagFriendsCallingServiceLuaMigration = SharedFlags.FFlagFriendsCallingServiceLuaMigration
local GetFFlagIsSquadEnabled = SharedFlags.GetFFlagIsSquadEnabled
local var1 = require(AppChat.Logger):new(script.Name)

local useSignalState = SignalsReact.useSignalState

local function noOp()
    return nil
end

local function ChatConversationTopBar(tbl1)
    local screenName = tbl1.screenName
    local navigation = tbl1.navigation

    local var2 = GetTopBarStore(false).getScreenTopBar(screenName)
    local var3 = useSignalState(var2)

    local headerText = var3.headerText or {}
    local backButtonEnabled = var3.backButtonEnabled
    local isRoot = var3.isRoot
    local conversationId = var3.conversationId
    local var4 = if FFlagFriendsCallingClientGate_DEV then useCallButtonEligibility(conversationId) else nil
    local navigateToChatDetails = var3.navigateToChatDetails
    local rightPaddingOverride = var3.rightPaddingOverride
    local var5 = useChatPlacementContext()
    local var6 = useLocalization({ headerText = if headerText.shouldLocalize then headerText.raw or nil else nil })

    local navigateToRootStack = navigation.getScreenProps("navigateToRootStack", nil)
    local makeBackButton = AppHeaderBar.makeBackButton

    local backFunc = createBackFunc({ navigation = navigation, navigateToRootStack = navigateToRootStack, isRoot = isRoot })
    local renderLeft = if backButtonEnabled then makeBackButton(backFunc) else nil

    local onActivated = React.useCallback(function()
        if not FFlagFriendsCallingClientGate_DEV or var4 ~= ConversationChannels.CallButtonEligibility.Eligible then
            return
        end
        if not conversationId then
            return
        end

        if FFlagFriendsCallingServiceLuaMigration then
            local FriendsCallingService = game:GetService("FriendsCallingService")
            local success, result = pcall(function()
                FriendsCallingService:StartCall({ conversationId = conversationId })
            end)

            if not success then
                var1:debug("FriendsCallingService:StartCall failed: {}", result)
            end
        else
            local CallingService = game:GetService("CallingService")
            task.spawn(function()
                pcall(function()
                    CallingService:CreateCallAsync({}, conversationId)
                end)
            end)
        end
    end, { conversationId or false, var4 or false })

    local bool1 = FFlagFriendsCallingClientGate_DEV

    if bool1 then
        if conversationId == nil then
            bool1 = false
        else
            bool1 = var4 == ConversationChannels.CallButtonEligibility.Eligible
        end
    end

    local var8 = not FFlagFriendsCallingClientGate_DEV and GetFFlagIsSquadEnabled() and conversationId ~= nil

    local renderRight = bool1 and function()
        local createElement = React.createElement
        local view = Foundation.View
        local tbl2 = { tag = "row align-x-right align-y-center auto-xy" }

        local tbl3 = {
            CallButton = React.createElement(Foundation.IconButton, {
                icon = Foundation.Enums.IconName.Phone,
                isCircular = true,
                size = Foundation.Enums.InputSize.Medium,
                onActivated = onActivated,
                testId = if FFlagDebugAppChatEnableDomLocators then DomLocators.chatConversationTopBarButton("call") else nil
            })
        }
        return createElement(view, tbl2, tbl3)
    end or var8 and function()
        return React.createElement(Foundation.View, { tag = "row align-x-right auto-xy" }, {
            GroupUpButton = React.createElement(
                SquadComponentAccessWrapper,
                { parentChannelId = conversationId },
                React.createElement(SquadJoinButton, {
                    conversationId = conversationId,
                    isFullWidth = false,
                    isInCard = false,
                    layoutOrder = 0,
                    onActivated = function()
                        navigation.navigate(EnumScreens.SquadLobby, { conversationId = conversationId })
                    end,
                    shouldAnimate = true,
                    shouldShowSignifier = true,
                    squadButtonSource = SquadButtonSourceEnum.ChatConversationScreen,
                    squadLocation = var5.chatPlacement
                })
            )
        })
    end or nil

    return React.createElement(ChatTopBarBase, {
        screenName = screenName,
        navigation = navigation,
        renderLeft = noOp,
        renderCenter = function()
            local titleText = headerText.shouldLocalize and var6.headerText or headerText.raw or ""
            return React.createElement(HeaderBarTitleLeftAligned, {
                renderLeft = renderLeft,
                renderRight = renderRight,
                titleText = titleText,
                conversationId = conversationId or "",
                navigateToChatDetails = navigateToChatDetails or function() end,
                ignoreRightMargin = rightPaddingOverride ~= nil
            })
        end
    })
end

return ChatConversationTopBar
