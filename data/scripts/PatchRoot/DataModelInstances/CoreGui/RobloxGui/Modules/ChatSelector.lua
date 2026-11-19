-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:21:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")
local RobloxGui = CoreGui:WaitForChild("RobloxGui")
local _Modules = RobloxGui:WaitForChild("Modules")

local StarterGui = game:GetService("StarterGui")
local _UserInputService = game:GetService("UserInputService")
local _GuiService = game:GetService("GuiService")

local Players = game:GetService("Players")

local ChatUtil = require(RobloxGui.Modules.ChatUtil)

local ClassicChat = Players.ClassicChat
local BubbleChat = Players.BubbleChat

local VRService = game:GetService("VRService")

local SharedFlags = require(CorePackages.Workspace.Packages.SharedFlags)
local FFlagEnableConsoleExpControls = SharedFlags.FFlagEnableConsoleExpControls
local _FFlagChromeChatGamepadSupportFix = SharedFlags.FFlagChromeChatGamepadSupportFix

local NewChat = nil

local visibility = nil
local tbl1 = ({})
local tbl2 = {
    Visible = not VRService.VREnabled
}
local module = {}

function module.ToggleVisibility(_)
    if NewChat then
        NewChat:ToggleVisibility()
        return
    end
    tbl2.Visible = not tbl2.Visible
end

function module.SetVisible(_, visible)
    if NewChat then
        NewChat:SetVisible(visible)
        return
    end
    tbl2.Visible = visible
end

function module.FocusChatBar(_)
    if NewChat then
        NewChat:FocusChatBar()
    end
end

function module.FocusSelectChatBar(_, func1: ((...any) -> (...any))?, tbl3)
    if NewChat and FFlagEnableConsoleExpControls then
        NewChat:FocusSelectChatBar(func1, tbl3)
    end
end

function module.EnterWhisperState(_, arg1)
    if NewChat then
        return NewChat:EnterWhisperState(arg1)
    end
end

function module.GetVisibility(_)
    if NewChat then
        return NewChat:GetVisibility()
    end
    return tbl2.Visible
end

function module.GetMessageCount(_)
    if NewChat then
        return NewChat:GetMessageCount()
    end
    return 0
end

function module.TopbarEnabledChanged(_, ...)
    if NewChat then
        return NewChat:TopbarEnabledChanged(...)
    end
end

function module.IsFocused(_, arg1)
    if NewChat then
        return NewChat:IsFocused(arg1)
    end
    return false
end

function module.ClassicChatEnabled(_)
    if NewChat then
        return NewChat:ClassicChatEnabled()
    end
    return ClassicChat
end

function module.IsBubbleChatOnly(_)
    if NewChat then
        return NewChat:IsBubbleChatOnly()
    end
    return BubbleChat and not ClassicChat
end

function module.IsDisabled(_)
    if NewChat then
        return NewChat:IsDisabled()
    end
    return not (BubbleChat or ClassicChat)
end

function module.HideTemp(_, str1: string, bool1: boolean)
    local function isHideTempKeysEmpty(): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
        return next(tbl1) == nil
    end

    if isHideTempKeysEmpty() then
        visibility = module:GetVisibility()
    end

    if bool1 then
        tbl1[str1] = bool1
    else
        tbl1[str1] = nil
    end

    module:SetVisible(visibility and not not isHideTempKeysEmpty())
end

module.ChatBarFocusChanged = ChatUtil.Signal()
module.ChatWindowToggled = ChatUtil.Signal()
module.ChatActiveChanged = ChatUtil.Signal()
module.ChatActiveChanged:connect(function(arg1)
    module:SetVisible(arg1)
end)

module.VisibilityStateChanged = ChatUtil.Signal()
module.MessagesChanged = ChatUtil.Signal()

module.BubbleChatOnlySet = ChatUtil.Signal()
module.ChatDisabled = ChatUtil.Signal()

local bool1 = false
local tbl3 = {}

local function NonFunc() end

StarterGui:RegisterSetCore("ChatMakeSystemMessage", function(arg1) -- name: MakeSystemMessageQueueingFunction
    if bool1 then
        return
    end

    table.insert(tbl3, arg1)
end)

StarterGui:RegisterSetCore("ChatWindowPosition", NonFunc)
StarterGui:RegisterGetCore("ChatWindowPosition", NonFunc)
StarterGui:RegisterSetCore("ChatWindowSize", NonFunc)
StarterGui:RegisterGetCore("ChatWindowSize", NonFunc)
StarterGui:RegisterSetCore("ChatBarDisabled", NonFunc)
StarterGui:RegisterGetCore("ChatBarDisabled", NonFunc)

StarterGui:RegisterGetCore("ChatActive", function()
    return module:GetVisibility()
end)
StarterGui:RegisterSetCore("ChatActive", function(arg1)
    module.ChatActiveChanged:fire(arg1)
end)

local function ConnectSignals(arg1, tbl4, str1: string) -- Luacid: Inlined by compiler; 7 call sites recovered
    if arg1[str1] then
        arg1[str1]:connect(function(...)
            tbl4[str1]:fire(...)
        end)
    end
end
coroutine.wrap(function()
    NewChat = require(RobloxGui.Modules.NewChat)

    ConnectSignals(NewChat, module, "ChatBarFocusChanged")
    ConnectSignals(NewChat, module, "VisibilityStateChanged")
    ConnectSignals(NewChat, module, "ChatWindowToggled")
    ConnectSignals(NewChat, module, "ChatActiveChanged")
    ConnectSignals(NewChat, module, "BubbleChatOnlySet")
    ConnectSignals(NewChat, module, "ChatDisabled")
    while Players.LocalPlayer == nil do
        Players.ChildAdded:wait()
    end

    local _localPlayer = Players.LocalPlayer

    ConnectSignals(NewChat, module, "MessagesChanged")

    StarterGui:RegisterGetCore("UseNewLuaChat", function(): boolean
        return true
    end)
    NewChat:SetVisible(tbl2.Visible)
    StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType.Chat))

    bool1 = true
    for _, value in pairs(tbl3) do
        pcall(function()
            StarterGui:SetCore("ChatMakeSystemMessage", value)
        end)
    end
end)()

return module
