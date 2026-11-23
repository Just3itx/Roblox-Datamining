-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:11:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local EnumScreens = require(AppChat.EnumScreens)
local AppChatParent = AppChat.Parent

local FocusNavigationUtils = require(AppChatParent.FocusNavigationUtils)
local InputHandlers = require(AppChatParent.InputHandlers)
local React = require(AppChatParent.React)
local ReactFocusNavigation = require(AppChatParent.ReactFocusNavigation)
local RoactUtils = require(AppChatParent.RoactUtils)
local SquadExternalContractProvider = require(AppChatParent.SquadsCore.SquadExternalContractProvider)
local mutedError = require(AppChatParent.Loggers).mutedError

local FocusNavigationEventNameEnum = FocusNavigationUtils.FocusNavigationEventNameEnum
local getFirstFocusableDescendant = FocusNavigationUtils.getFirstFocusableDescendant
local flushPendingActivationOnFocus = FocusNavigationUtils.flushPendingActivationOnFocus
local FFlagAppChatConsoleFocusFixes = require(AppChat.Flags.FFlagAppChatConsoleFocusFixes)

local FFlagAppChatDebounceConversationFocusActivation = require(AppChat.Flags.FFlagAppChatDebounceConversationFocusActivation)

local SquadExternalContractContext = SquadExternalContractProvider.SquadExternalContractContext
local SquadPromptType = require(AppChatParent.SquadsCore.Enums).SquadPromptType
local leaveSquad = require(AppChatParent.SquadsCore.Thunks).leaveSquad
local useCurrentSquadParentChannelId = require(AppChatParent.SquadsCore.Hooks).useCurrentSquadParentChannelId

local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch

local tbl1 = {
    [Enum.KeyCode.ButtonX] = FocusNavigationEventNameEnum.SquadJoin,
    [Enum.KeyCode.ButtonB] = FocusNavigationEventNameEnum.NavigateBack,
    [Enum.KeyCode.Escape] = FocusNavigationEventNameEnum.NavigateBack
}

local function ConversationStackNavigationFocusListener(tbl2)
    local var1 = useDispatch()
    local var2 = React.useContext(ReactFocusNavigation.FocusNavigationContext)
    local var3 = React.useContext(SquadExternalContractContext)
    local var4 = useCurrentSquadParentChannelId()

    local var5 = React.useCallback(function(arg1)
        local childNavigation = tbl2.navigation.getChildNavigation("ConversationStackNavigator")

        if not var2 or not childNavigation or childNavigation.state.index ~= 1 then
            return
        end

        local value = var2.focusedGuiObject:getValue()

        if value == nil or not value:IsDescendantOf(tbl2.rightContainerRef.current) then
            return
        end
        if FFlagAppChatConsoleFocusFixes
            and tbl2.conversationPanelRef.current
            and value:IsDescendantOf(tbl2.conversationPanelRef.current)
            and tbl2.conversationTopBarRef.current
        then
            local firstFocusableDescendant = getFirstFocusableDescendant(tbl2.conversationTopBarRef.current)
            if firstFocusableDescendant then
                var2:focusGuiObject(firstFocusableDescendant, true)
                arg1:cancel()
                return
            end
        end

        var2:focusGuiObject(tbl2.leftContainerRef.current, true)
        arg1:cancel()
    end, {
        tbl2.navigation,
        tbl2.leftContainerRef,
        tbl2.rightContainerRef,
        tbl2.conversationTopBarRef,
        tbl2.conversationPanelRef,
        var2
    })

    local var6 = React.useCallback(function(arg1)
        local function joinConversationSquad(conversationId: string)
            if var4 == nil or var4 == conversationId then
                tbl2.navigation.navigate(EnumScreens.SquadLobby, { conversationId = conversationId })
                return
            end
            var1(leaveSquad(SquadPromptType.JoinAnotherSquad, var3.setSquadPrompt, function()
                tbl2.navigation.navigate(EnumScreens.SquadLobby, { conversationId = conversationId })
            end, var3.squadLocation, true))
        end

        local childNavigation = tbl2.navigation.getChildNavigation("ConversationStackNavigator")
        if not childNavigation or childNavigation.state.index ~= 1 then
            return
        end

        if FFlagAppChatDebounceConversationFocusActivation then
            local conversationId = flushPendingActivationOnFocus()
            if conversationId ~= nil then
                joinConversationSquad(conversationId)
                arg1:cancel()
                return
            end
        end

        local var6 = childNavigation.state.routes[1]
        if var6.routeName ~= EnumScreens.ChatConversation or not var6.params then
            mutedError("ConversationStackNavigationFocusListener: Found" .. tostring(var6.routeName) .. " at root.")
            return
        end

        local conversationId = var6.params.conversationId
        if conversationId then
            joinConversationSquad(conversationId)
            arg1:cancel()
            return
        end
        mutedError("ConversationStackNavigationFocusListener: Missing conversationId for ChatConversation.")
    end, {
        var4,
        var1,
        tbl2.navigation,
        var3.setSquadPrompt,
        var3.squadLocation
    })

    local var7 = React.useMemo(function()
        return {
            [FocusNavigationEventNameEnum.NavigateBack] = {
                handler = InputHandlers.onRelease(var5)
            },
            [FocusNavigationEventNameEnum.SquadJoin] = {
                handler = InputHandlers.onRelease(var6)
            }
        }
    end, { var5, var6 })

    local var8 = ReactFocusNavigation.useEventMap(tbl1)
    local ref = ReactFocusNavigation.useEventHandlerMap(var7, var8)

    return React.createElement("Frame", { Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1, ref = ref }, tbl2.children)
end

return ConversationStackNavigationFocusListener
