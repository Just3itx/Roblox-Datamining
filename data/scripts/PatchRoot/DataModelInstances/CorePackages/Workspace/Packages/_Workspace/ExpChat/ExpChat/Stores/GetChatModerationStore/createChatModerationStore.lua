-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:21:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Chat = game:GetService("Chat")
local RobloxReplicatedStorage = game:GetService("RobloxReplicatedStorage")

local ExpChatParent = script:FindFirstAncestor("ExpChat").Parent

local Signals = require(ExpChatParent.Signals)
local createSignal = Signals.createSignal
local createComputed = Signals.createComputed

local GetChatStatusStore = require(script.Parent.Parent.GetChatStatusStore)

local engineFeature = game:GetEngineFeature("EnableChatModerationModeLoggingRefactor")

return function()
    local var1, var2 = createSignal(false)
    local var3, var4 = createSignal(false)
    local chatStatusStore = GetChatStatusStore(false)

    local moderateChatSettingUpdated = nil

    local function setIsSettingEnabled(enabled: boolean) -- Luacid: Inlined by compiler; 1 call site recovered
        if engineFeature then
            Chat:RequestModerationModeEnabled(enabled)
        elseif moderateChatSettingUpdated then
            moderateChatSettingUpdated:FireServer(enabled)
        end
    end

    local function initialize()
        setIsSettingEnabled(false)
    end

    local connection = nil
    if engineFeature then
        local function func1() -- Luacid: Inlined by compiler; 1 call site recovered
            var2(Chat.ModerationMode ~= "Unsupported")
            var4(Chat.ModerationMode == "Enabled")
        end
        connection = Chat:GetPropertyChangedSignal("ModerationMode"):Connect(func1)
        func1()
    else
        coroutine.wrap(function()
            moderateChatSettingUpdated = RobloxReplicatedStorage:WaitForChild("ModerateChatSettingUpdated", 10)
            if moderateChatSettingUpdated then
                moderateChatSettingUpdated.OnClientEvent:Connect(function(bool1: boolean)
                    var2(true)
                    var4(bool1)
                end)
            end
        end)()
    end

    return {
        getIsSettingVisible = createComputed(function(arg1)
            return var1(arg1) and chatStatusStore.getChatStatus(arg1) == "Enabled"
        end),
        getIsSettingEnabled = createComputed(function(arg1)
            return var3(arg1) and chatStatusStore.getChatStatus(arg1) == "Enabled"
        end),
        setIsSettingEnabled = setIsSettingEnabled,
        initialize = initialize,
        cleanup = function()
            if connection then
                connection:Disconnect()
                connection = nil
            end
        end
    }
end
