-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:21:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ContextActionService = game:GetService("ContextActionService")
local GuiService = game:GetService("GuiService")
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent

local React = require(ExpChatParent.React)
local RoactUtils = require(ExpChatParent.RoactUtils)
local SharedFlags = require(ExpChatParent.SharedFlags)
local _ExpChatShared = require(ExpChatParent.ExpChatShared)
local chatTabNavigationSignal = require(ExpChatParent.ChatUIPrimitives).chatTabNavigationSignal

local Config = require(ExpChat.Config)
local FocusChatHotKeyActivated = require(ExpChat.Actions.FocusChatHotKeyActivated)
local getTabShortcutBehavior = require(script.Parent.getTabShortcutBehavior)
local chatFocusRequestSignal = require(script.Parent.chatFocusRequestSignal)
local FocusNavigationExperiment = require(script.Parent.FocusNavigationExperiment)
local FFlagExpChatGenericChatFocus = require(ExpChat.Flags.FFlagExpChatGenericChatFocus)
local useSelectedTabType = require(ExpChat.useSelectedTabType)
local GetChannelTabsStore = require(ExpChat.Stores.GetChannelTabsStore)
local GetFocusNavigationStore = require(ExpChat.Stores.GetFocusNavigationStore)
local getAdjacentTabName = require(ExpChat.TabNavigation.getAdjacentTabName)
local selectTabByType = require(ExpChat.TabNavigation.selectTabByType)
local shouldNavigateTabs = require(ExpChat.TabNavigation.shouldNavigateTabs)

local useSelector = RoactUtils.Hooks.RoactRodux.useSelector
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local useStore = RoactUtils.Hooks.RoactRodux.useStore

local FFlagExpChatTabShortcutNav = SharedFlags.FFlagExpChatTabShortcutNav
local FFlagExpChatUseChannelTabsStore = SharedFlags.FFlagExpChatUseChannelTabsStore

local function getActiveTabState(arg1)
    if FFlagExpChatUseChannelTabsStore then
        local var1 = GetChannelTabsStore(false).getChannelTabsState(false)
        return var1.selectedTabName, var1.allChannelTabs
    end
    local channelTabs = arg1:getState().ChannelTabs
    if channelTabs == nil or channelTabs.allChannelTabs == nil then
        return nil, {}
    end
    local tbl1 = ({})
    for name, allChannelTab in channelTabs.allChannelTabs do
        local tbl2 = {
            name = name,
            tabIndex = allChannelTab.TabIndex,
            type = allChannelTab.Type
        }
        tbl1[name] = tbl2
    end
    return channelTabs.selectedTabName, tbl1
end

local Tab = Enum.KeyCode.Tab
local tbl1 = {
    [Enum.KeyCode.ButtonR1] = 1,
    [Enum.KeyCode.ButtonL1] = -1
}

local HighValue = Enum.ContextActionPriority.High.Value

local function selectIsChatHotkeyEnabled(arg1)
    return arg1.ChatVisibility.isChatHotkeyEnabled.value
end

local function selectDevDefinedFocusKeyCode(arg1)
    return arg1.ChatLayout.ChatInputBarSettings.KeyboardKeyCode
end

local function ShortcutNavReceiver(tbl2)
    local var1 = tbl2.contextActionService or ContextActionService

    local var2 = useSelector(selectIsChatHotkeyEnabled)
    local var3 = useSelectedTabType()
    local var4 = useSelector(selectDevDefinedFocusKeyCode)
    local var5 = useDispatch()

    local var6 = useStore()
    local var7 = if FocusNavigationExperiment.isExposureLoggingEnabled then React.useRef(false) else nil

    React.useEffect(function()
        var1:BindCoreAction("ExpChatFocusHotKey", function(_: string, userInputState, arg1) -- name: handleAction
            if not var2 then
                return Enum.ContextActionResult.Pass
            end

            if userInputState ~= Enum.UserInputState.Begin or arg1 == nil then
                return Enum.ContextActionResult.Pass
            end
            local keyCode = arg1.KeyCode
            if keyCode ~= Config.ChatInputBarDefaultFocusKeyCode and keyCode ~= var4 then
                return Enum.ContextActionResult.Pass
            end
            if var3 == nil then
                return Enum.ContextActionResult.Pass
            end

            local tabShortcutBehavior = getTabShortcutBehavior(var3)
            if not tabShortcutBehavior.canOpenChat() then
                return Enum.ContextActionResult.Pass
            end

            var5(FocusChatHotKeyActivated())

            return tabShortcutBehavior.focus({ keyCode = keyCode }) or Enum.ContextActionResult.Sink
        end, false, Enum.UserInputType.Keyboard)

        return function()
            var1:UnbindCoreAction("ExpChatFocusHotKey")
        end
    end, {
        var2,
        var3,
        var4,
        var1,
        var5
    })

    React.useEffect(function()
        if not FFlagExpChatGenericChatFocus or var3 == nil then
            return
        end

        local tabShortcutBehavior = getTabShortcutBehavior(var3)
        local connection = chatFocusRequestSignal:connect(function()
            if tabShortcutBehavior.focus ~= nil and tabShortcutBehavior.canOpenChat() then
                tabShortcutBehavior.focus({ keyCode = Enum.KeyCode.None })
            end
        end)
        return function()
            connection.disconnect()
        end
    end, { var3 })

    React.useEffect(function()
        if not FFlagExpChatTabShortcutNav then
            return
        end

        local function tryNavigateTabs(num1: number, bool1: boolean?): boolean
            local var8, var9 = getActiveTabState(var6)
            if var8 == nil then
                return false
            end
            if var9[var8] == nil then
                return false
            end

            local focusNavigationStore = GetFocusNavigationStore(false)
            local tbl3 = {}
            for _, value in var9 do
                table.insert(tbl3, { name = value.name, tabIndex = value.tabIndex })
            end

            if not shouldNavigateTabs({
                isTabBarVisible = focusNavigationStore.getIsTabBarVisible(false),
                tabCount = #tbl3,
                isChatFocused = bool1 == true or focusNavigationStore.getIsChatFocused()
            }) then
                return false
            end

            local channelName = getAdjacentTabName(tbl3, var8, num1)
            if channelName == nil then
                return false
            end
            local var10 = var9[channelName]

            if var7 and not var7.current then
                var7.current = true
                FocusNavigationExperiment.logExposure()
            end
            if not FocusNavigationExperiment.isTabNavEnabled then
                return false
            end

            selectTabByType(var5, { channelName = channelName, tabType = var10.type, shouldReorderTabs = false })

            focusNavigationStore.clearChatInputBarFocusRequest()
            getTabShortcutBehavior(var10.type).focus({ keyCode = Tab })
            focusNavigationStore.requestTabNavFocus(channelName)
            return true
        end

        var1:BindCoreActionAtPriority("ExpChatTabShortcutNav", function(_: string, userInputState, arg1) -- name: handleTabNav
            if userInputState ~= Enum.UserInputState.Begin or arg1 == nil then
                return Enum.ContextActionResult.Pass
            end
            local var8 = tbl1[arg1.KeyCode]
            if arg1.KeyCode == Tab then
                var8 = if arg1:IsModifierKeyDown(Enum.ModifierKey.Shift) then -1 else 1
            end

            if var8 == nil then
                return Enum.ContextActionResult.Pass
            end

            if tryNavigateTabs(var8) then
                return Enum.ContextActionResult.Sink
            end

            return Enum.ContextActionResult.Pass
        end, false, HighValue, Tab, Enum.KeyCode.ButtonR1, Enum.KeyCode.ButtonL1)

        local connection = chatTabNavigationSignal:connect(function(num1: number)
            tryNavigateTabs(num1, true)
        end)

        return function()
            var1:UnbindCoreAction("ExpChatTabShortcutNav")
            connection.disconnect()
        end
    end, { var1, var5, var6 })

    React.useEffect(function()
        if not FFlagExpChatTabShortcutNav then
            return
        end

        var1:BindCoreActionAtPriority("ExpChatShortcutNavEscape", function(_: string, userInputState, _) -- name: handleEscape
            if userInputState ~= Enum.UserInputState.Begin then
                return Enum.ContextActionResult.Pass
            end
            if not GetFocusNavigationStore(false).getIsChatFocused() then
                return Enum.ContextActionResult.Pass
            end
            GuiService.SelectedCoreObject = nil
            return Enum.ContextActionResult.Sink
        end, false, HighValue, Enum.KeyCode.Escape)

        return function()
            var1:UnbindCoreAction("ExpChatShortcutNavEscape")
        end
    end, { var1 })

    return nil
end

return ShortcutNavReceiver
