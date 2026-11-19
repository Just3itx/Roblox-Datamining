-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:31:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")

local StarterGui = game:GetService("StarterGui")
local GuiService = game:GetService("GuiService")
local Players = game:GetService("Players")
local TextChatService = game:GetService("TextChatService")
local bool1 = TextChatService.ChatVersion == Enum.ChatVersion.LegacyChatService

local bool2 = false
local ClassicChat = Players.ClassicChat
local BubbleChat = Players.BubbleChat

local ChatUtil = require(RobloxGui.Modules.ChatUtil)

local CorePackages = game:GetService("CorePackages")
local ExpChat = require(CorePackages.Workspace.Packages.ExpChat)

local SharedFlags = require(CorePackages.Workspace.Packages.SharedFlags)
local getFFlagExpChatAlwaysRunTCS = SharedFlags.getFFlagExpChatAlwaysRunTCS
local FFlagEnableConsoleExpControls = SharedFlags.FFlagEnableConsoleExpControls
local FFlagExpChatWindowSyncUnibar = SharedFlags.FFlagExpChatWindowSyncUnibar

local transparencyStore = ExpChat.Stores.GetTransparencyStore(false)

local function shouldForceLegacyChatToBeHidden(): boolean -- Luacid: Inlined by compiler; 3 call sites recovered
    bool1 = TextChatService.ChatVersion == Enum.ChatVersion.LegacyChatService

    return if getFFlagExpChatAlwaysRunTCS() then bool1 else false
end

local module = {}

local tbl1 = { Visible = true, MessageCount = 0, TopbarEnabled = true, CoreGuiEnabled = true }

local tbl2 = { ChatWindow = nil, GetCore = nil, SetCore = nil }
local tbl3 = {}

local tbl4 = ({})

local function FindInCollectionByKeyAndType(arg1, arg2, str1: string) -- Luacid: Inlined by compiler; 21 call sites recovered
    return if arg1 and arg1[arg2] and arg1[arg2]:IsA(str1) then arg1[arg2] else nil
end

local function DispatchEvent(arg1, ...): boolean
    local inCollectionByKeyAndType = FindInCollectionByKeyAndType(tbl2.ChatWindow, arg1, "BindableEvent")
    if not inCollectionByKeyAndType then
        return false
    end

    inCollectionByKeyAndType:Fire(...)
    return true
end

local function AttemptInvokeFunction(arg1, ...)
    local inCollectionByKeyAndType = FindInCollectionByKeyAndType(tbl2.ChatWindow, arg1, "BindableFunction")
    if inCollectionByKeyAndType then
        return true, inCollectionByKeyAndType:Invoke()
    end
    return false, nil
end

local function DoConnectGetCore(parameterName: string) -- Luacid: unused: defined but never referenced
    StarterGui:RegisterGetCore(parameterName, function(arg1)
        local inCollectionByKeyAndType = FindInCollectionByKeyAndType(tbl2.GetCore, parameterName, "BindableFunction")

        return if inCollectionByKeyAndType then inCollectionByKeyAndType:Invoke(arg1) else nil
    end)
end

function module.ToggleVisibility(_)
    tbl1.Visible = not tbl1.Visible

    if shouldForceLegacyChatToBeHidden() or not DispatchEvent("ToggleVisibility") then
        module.VisibilityStateChanged:fire(tbl1.Visible)
    end

    if not FFlagExpChatWindowSyncUnibar then
        ExpChat.Events.ChatTopBarButtonActivated(tbl1.Visible)
    end
    if tbl1.Visible then
        transparencyStore.resetAllTransparency()
    end
    module.ChatWindowToggled:fire(tbl1.Visible)
end

function module.SetVisible(_, visible)
    tbl1.Visible = visible

    if not FFlagExpChatWindowSyncUnibar then
        ExpChat.Events.ChatTopBarButtonActivated(tbl1.Visible)
    end
    if tbl1.Visible then
        transparencyStore.resetAllTransparency()
    end
    module.ChatWindowToggled:fire(tbl1.Visible)

    if shouldForceLegacyChatToBeHidden() then
        DispatchEvent("SetVisible", false)
        module.VisibilityStateChanged:fire(false)
    elseif not DispatchEvent("SetVisible", tbl1.Visible) then
        module.VisibilityStateChanged:fire(tbl1.Visible)
    end
end

function module.FocusChatBar(_)
    DispatchEvent("FocusChatBar")

    ExpChat.Events.ChatTopBarFocusActivated()
end

function module.FocusSelectChatBar(_, func1: ((...any) -> (...any))?, tbl5)
    if FFlagEnableConsoleExpControls then
        ExpChat.Events.ChatTopBarFocusSelect(func1, tbl5)
    end
end

function module.EnterWhisperState(_, arg1): boolean
    return DispatchEvent("EnterWhisperState", arg1)
end

function module.GetVisibility(_)
    local bool3, var1 = AttemptInvokeFunction("GetVisibility")
    return if bool3 then var1 else tbl1.Visible
end

function module.GetMessageCount(_)
    local bool3, var1 = AttemptInvokeFunction("GetMessageCount")
    return if bool3 then var1 else tbl1.MessageCount
end

function module.TopbarEnabledChanged(_, topbarEnabled)
    tbl1.TopbarEnabled = topbarEnabled
    DispatchEvent("TopbarEnabledChanged", tbl1.TopbarEnabled)
end

function module.IsFocused(_, arg1)
    local bool3, var1 = AttemptInvokeFunction("IsFocused", arg1)
    return if bool3 then var1 else false
end

function module.ClassicChatEnabled(_)
    return ClassicChat
end

function module.IsBubbleChatOnly(_): boolean
    return BubbleChat and not ClassicChat
end

function module.IsDisabled(_): boolean
    return not (BubbleChat or ClassicChat)
end

function SetInitialChatTypes(chatTypes)
    if bool2 then
        return
    end
    bool2 = true

    local bubbleChatEnabled = chatTypes.BubbleChatEnabled
    local classicChatEnabled = chatTypes.ClassicChatEnabled
    if type(bubbleChatEnabled) == "boolean" then
        BubbleChat = bubbleChatEnabled
    end
    if type(classicChatEnabled) == "boolean" then
        ClassicChat = classicChatEnabled
    end

    if not (ClassicChat or BubbleChat) then
        module.ChatDisabled:fire()
    end
    if BubbleChat and not ClassicChat then
        module.BubbleChatOnlySet:fire()
    end
end

module.ChatBarFocusChanged = ChatUtil.Signal()
module.VisibilityStateChanged = ChatUtil.Signal()
module.ChatWindowToggled = ChatUtil.Signal()
module.MessagesChanged = ChatUtil.Signal()

module.BubbleChatOnlySet = ChatUtil.Signal()
module.ChatDisabled = ChatUtil.Signal()

local Chat = game:GetService("Chat")
Chat:GetPropertyChangedSignal("IsAutoMigrated"):Connect(function()
    if Chat.IsAutoMigrated and not DispatchEvent("SetVisible", false) then
        module.VisibilityStateChanged:fire(false)
    end
end)

StarterGui.CoreGuiChangedSignal:connect(function(coreGuiType: Enum.CoreGuiType, enabled: boolean)
    if coreGuiType == Enum.CoreGuiType.All or coreGuiType == Enum.CoreGuiType.Chat then
        tbl1.CoreGuiEnabled = enabled
        DispatchEvent("CoreGuiEnabled", tbl1.CoreGuiEnabled)
    end
end)

GuiService:AddSpecialKey(Enum.SpecialKey.ChatHotkey)
GuiService.SpecialKeyPressed:connect(function(key: Enum.SpecialKey, modifiers: string)
    if GuiService.MenuIsOpen then
        return
    end

    if not shouldForceLegacyChatToBeHidden() then
        DispatchEvent("SpecialKeyPressed", key, modifiers)
    end
end)

function DoConnectSetCore(parameterName: string)
    StarterGui:RegisterSetCore(parameterName, function(arg1)
        local inCollectionByKeyAndType = FindInCollectionByKeyAndType(tbl2.SetCore, parameterName, "BindableEvent")
        if inCollectionByKeyAndType then
            inCollectionByKeyAndType:Fire(arg1)
            return
        end
        if tbl4[parameterName] == nil then
            tbl4[parameterName] = {}
        end
        table.insert(tbl4[parameterName], arg1)
    end)
end

DoConnectSetCore("ChatMakeSystemMessage")
DoConnectSetCore("ChatWindowPosition")
DoConnectSetCore("ChatWindowSize")
DoConnectSetCore("ChatBarDisabled")
local str1 = "ChatWindowPosition"

StarterGui:RegisterGetCore("ChatWindowPosition", function(arg1)
    local inCollectionByKeyAndType = FindInCollectionByKeyAndType(tbl2.GetCore, str1, "BindableFunction")

    return if inCollectionByKeyAndType then inCollectionByKeyAndType:Invoke(arg1) else nil
end)

local str2 = "ChatWindowSize"

StarterGui:RegisterGetCore("ChatWindowSize", function(arg1)
    local inCollectionByKeyAndType = FindInCollectionByKeyAndType(tbl2.GetCore, str2, "BindableFunction")

    return if inCollectionByKeyAndType then inCollectionByKeyAndType:Invoke(arg1) else nil
end)

local str3 = "ChatBarDisabled"

StarterGui:RegisterGetCore("ChatBarDisabled", function(arg1)
    local inCollectionByKeyAndType = FindInCollectionByKeyAndType(tbl2.GetCore, str3, "BindableFunction")

    return if inCollectionByKeyAndType then inCollectionByKeyAndType:Invoke(arg1) else nil
end)

local function RegisterCoreGuiConnections(arg1)
    if type(arg1) ~= "table" then
        return
    end

    local chatWindow = arg1.ChatWindow
    local setCore = arg1.SetCore
    local getCore = arg1.GetCore

    if type(chatWindow) == "table" then
        for _, value in pairs(tbl3) do
            value:disconnect()
        end

        if type(chatWindow.ChatTypes) == "table" then
            SetInitialChatTypes(chatWindow.ChatTypes)
        end

        tbl3 = {}
        tbl2.ChatWindow = {}

        tbl2.ChatWindow.ToggleVisibility = FindInCollectionByKeyAndType(chatWindow, "ToggleVisibility", "BindableEvent")

        tbl2.ChatWindow.SetVisible = FindInCollectionByKeyAndType(chatWindow, "SetVisible", "BindableEvent")

        tbl2.ChatWindow.FocusChatBar = FindInCollectionByKeyAndType(chatWindow, "FocusChatBar", "BindableEvent")

        tbl2.ChatWindow.EnterWhisperState = FindInCollectionByKeyAndType(chatWindow, "EnterWhisperState", "BindableEvent")

        tbl2.ChatWindow.TopbarEnabledChanged = FindInCollectionByKeyAndType(chatWindow, "TopbarEnabledChanged", "BindableEvent")

        tbl2.ChatWindow.IsFocused = FindInCollectionByKeyAndType(chatWindow, "IsFocused", "BindableFunction")

        tbl2.ChatWindow.SpecialKeyPressed = FindInCollectionByKeyAndType(chatWindow, "SpecialKeyPressed", "BindableEvent")

        local function DoConnect(str4: string)
            tbl2.ChatWindow[str4] = FindInCollectionByKeyAndType(chatWindow, str4, "BindableEvent")
            if tbl2.ChatWindow[str4] then
                table.insert(tbl3, (tbl2.ChatWindow[str4].Event:connect(function(...)
                    module[str4]:fire(...)
                end)))
            end
        end
        DoConnect("ChatBarFocusChanged")
        DoConnect("VisibilityStateChanged")
        DoConnect("ChatWindowToggled")
        DoConnect("MessagesChanged")

        tbl2.ChatWindow.MessagePosted = FindInCollectionByKeyAndType(chatWindow, "MessagePosted", "BindableEvent")

        if tbl2.ChatWindow.MessagePosted then
            table.insert(tbl3, (tbl2.ChatWindow.MessagePosted.Event:connect(function(message: string)
                game:GetService("Players"):Chat(message)
            end)))
        end
        module:SetVisible(tbl1.Visible)
        module:TopbarEnabledChanged(tbl1.TopbarEnabled)
        local coreGuiEnabled = FindInCollectionByKeyAndType(chatWindow, "CoreGuiEnabled", "BindableEvent")

        if coreGuiEnabled then
            tbl2.ChatWindow.CoreGuiEnabled = coreGuiEnabled
            coreGuiEnabled:Fire(tbl1.CoreGuiEnabled)
        end
    else
        error("Table 'ChatWindow' must be provided!")
    end

    if type(setCore) ~= "table" or type(getCore) ~= "table" then
        if type(setCore) ~= "nil" or type(getCore) ~= "nil" then
            error("Both 'SetCore' and 'GetCore' must be tables if provided!")
        end

        return
    end

    tbl2.SetCore = {}
    tbl2.GetCore = {}

    local function addSetCore(parameterName: string)
        local inCollectionByKeyAndType = FindInCollectionByKeyAndType(setCore, parameterName, "BindableEvent")
        if not inCollectionByKeyAndType then
            return
        end

        tbl2.SetCore[parameterName] = inCollectionByKeyAndType
        if not tbl4[parameterName] then
            return
        end

        for _, value in pairs(tbl4[parameterName]) do
            inCollectionByKeyAndType:Fire(value)
        end
        tbl4[parameterName] = nil
    end

    addSetCore("ChatMakeSystemMessage")
    addSetCore("ChatWindowPosition")
    addSetCore("ChatWindowSize")
    addSetCore("ChatBarDisabled")

    tbl2.GetCore.ChatWindowPosition = FindInCollectionByKeyAndType(getCore, "ChatWindowPosition", "BindableFunction")

    tbl2.GetCore.ChatWindowSize = FindInCollectionByKeyAndType(getCore, "ChatWindowSize", "BindableFunction")

    tbl2.GetCore.ChatBarDisabled = FindInCollectionByKeyAndType(getCore, "ChatBarDisabled", "BindableFunction")
end

ExpChat.listenToDispatch(function(arg1)
    if arg1.type == "FocusChatHotKeyActivated" then
        module:SetVisible(true)
    end
end)

StarterGui:RegisterSetCore("CoreGuiChatConnections", RegisterCoreGuiConnections)

return module
