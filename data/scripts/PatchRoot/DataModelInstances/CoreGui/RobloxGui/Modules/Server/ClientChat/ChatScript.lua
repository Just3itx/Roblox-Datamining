-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:30:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local StarterGui = game:GetService("StarterGui")
local GuiService = game:GetService("GuiService")
local Chat = game:GetService("Chat")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ClientChatModules = Chat:WaitForChild("ClientChatModules")
local ChatSettings = require(ClientChatModules:WaitForChild("ChatSettings"))

local function DoEverything()
    local chatMain = require(script:WaitForChild("ChatMain"))

    local tbl1 = {
        ChatWindow = {},
        SetCore = {},
        GetCore = {}
    }
    tbl1.ChatWindow.ChatTypes = {}
    tbl1.ChatWindow.ChatTypes.BubbleChatEnabled = ChatSettings.BubbleChatEnabled
    tbl1.ChatWindow.ChatTypes.ClassicChatEnabled = ChatSettings.ClassicChatEnabled

    local function ConnectEvent(bindableEventName: string) -- Luacid: Inlined by compiler; 6 call sites recovered
        local bindableEvent = Instance.new("BindableEvent")
        bindableEvent.Name = bindableEventName
        tbl1.ChatWindow[bindableEventName] = bindableEvent

        bindableEvent.Event:connect(function(...)
            chatMain[bindableEventName](chatMain, ...)
        end)
    end
    local function ConnectFunction(bindableFunctionName: string) -- Luacid: Inlined by compiler; 3 call sites recovered
        local bindableFunction = Instance.new("BindableFunction")
        bindableFunction.Name = bindableFunctionName
        tbl1.ChatWindow[bindableFunctionName] = bindableFunction

        function bindableFunction.OnInvoke(...)
            return chatMain[bindableFunctionName](chatMain, ...)
        end
    end
    local function ReverseConnectEvent(bindableEventName: string) -- Luacid: Inlined by compiler; 4 call sites recovered
        local bindableEvent = Instance.new("BindableEvent")
        bindableEvent.Name = bindableEventName
        tbl1.ChatWindow[bindableEventName] = bindableEvent

        chatMain[bindableEventName]:connect(function(...)
            bindableEvent:Fire(...)
        end)
    end

    local function ConnectSetCore(bindableEventName: string) -- Luacid: Inlined by compiler; 4 call sites recovered
        local bindableEvent = Instance.new("BindableEvent")
        bindableEvent.Name = bindableEventName
        tbl1.SetCore[bindableEventName] = bindableEvent

        bindableEvent.Event:connect(function(...)
            chatMain[bindableEventName .. "Event"]:fire(...)
        end)
    end
    local function ConnectGetCore(bindableFunctionName: string) -- Luacid: Inlined by compiler; 3 call sites recovered
        local bindableFunction = Instance.new("BindableFunction")
        bindableFunction.Name = bindableFunctionName
        tbl1.GetCore[bindableFunctionName] = bindableFunction

        function bindableFunction.OnInvoke(...)
            return chatMain["f" .. bindableFunctionName](...)
        end
    end

    ConnectEvent("ToggleVisibility")
    ConnectEvent("SetVisible")
    ConnectEvent("FocusChatBar")
    ConnectEvent("EnterWhisperState")
    ConnectFunction("GetVisibility")
    ConnectFunction("GetMessageCount")
    ConnectEvent("TopbarEnabledChanged")
    ConnectFunction("IsFocused")
    ReverseConnectEvent("ChatBarFocusChanged")
    ReverseConnectEvent("VisibilityStateChanged")
    ReverseConnectEvent("MessagesChanged")
    ReverseConnectEvent("MessagePosted")

    local function ConnectSignal(bindableEventName: string)
        local bindableEvent = Instance.new("BindableEvent")
        bindableEvent.Name = bindableEventName
        tbl1.ChatWindow[bindableEventName] = bindableEvent

        bindableEvent.Event:connect(function(...)
            chatMain[bindableEventName]:fire(...)
        end)
    end

    ConnectSignal("CoreGuiEnabled")
    ConnectSetCore("ChatMakeSystemMessage")
    ConnectSetCore("ChatWindowPosition")
    ConnectSetCore("ChatWindowSize")
    ConnectGetCore("ChatWindowPosition")
    ConnectGetCore("ChatWindowSize")
    ConnectSetCore("ChatBarDisabled")
    ConnectGetCore("ChatBarDisabled")
    ConnectEvent("SpecialKeyPressed")
    SetCoreGuiChatConnections(tbl1)
end

function SetCoreGuiChatConnections(arg1)
    local num1 = 0

    while num1 < 10 do
        num1 += 1
        local success, result = pcall(function()
            StarterGui:SetCore("CoreGuiChatConnections", arg1)
        end)

        if success then
            break
        end

        if not success and num1 == 10 then
            error("Error calling SetCore CoreGuiChatConnections: " .. result)
        end
        wait()
    end
end

function checkBothChatTypesDisabled(): boolean
    return not (ChatSettings.BubbleChatEnabled == nil or ChatSettings.ClassicChatEnabled == nil)
        and not (ChatSettings.BubbleChatEnabled or ChatSettings.ClassicChatEnabled)
end

if GuiService:IsTenFootInterface() then
    ReplicatedStorage:WaitForChild("DefaultChatSystemChatEvents").GetInitDataRequest:InvokeServer()

    return
end

if not checkBothChatTypesDisabled() then
    DoEverything()
    return
end
local tbl1 = {
    ChatWindow = {}
}
tbl1.ChatWindow.ChatTypes = {}
tbl1.ChatWindow.ChatTypes.BubbleChatEnabled = false
tbl1.ChatWindow.ChatTypes.ClassicChatEnabled = false
SetCoreGuiChatConnections(tbl1)
