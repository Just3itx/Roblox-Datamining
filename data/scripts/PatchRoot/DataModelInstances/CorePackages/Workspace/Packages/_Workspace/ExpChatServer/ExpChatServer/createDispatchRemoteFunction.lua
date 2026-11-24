-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T10:01:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxReplicatedStorage = game:GetService("RobloxReplicatedStorage")
local TextChatService = game:GetService("TextChatService")

local ExpChatServerParent = script:FindFirstAncestor("ExpChatServer").Parent
local List = require(ExpChatServerParent.llama).List
local ExpChatShared = require(ExpChatServerParent.ExpChatShared)
local markTextChannelAsDefault = ExpChatShared.markTextChannelAsDefault

local FFlagExpChatWhisperSetDirectChatRequester = require(ExpChatServerParent.SharedFlags).FFlagExpChatWhisperSetDirectChatRequester

local var1 = ExpChatShared.Logger:new("ExpChat/" .. script.Name)

local function canUsersTalkToEachOther(fromUserId: number, toUserId: number): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    if fromUserId == toUserId then
        return false
    end
    local success, result = pcall(function(): boolean
        return TextChatService:CanUsersWhisperAsync(fromUserId, toUserId)
    end)

    local var2 = success and result
    var1:debug("CanUsersChat: {}", tostring(var2))

    return var2
end

local function whisperChannelAlreadyExists(userId: number, num1: number) -- Luacid: Inlined by compiler; 1 call site recovered
    local format = string.format
    local str1 = "RBXWhisper:%d_%d"
    local num2 = userId < num1 and userId or num1

    if num1 < userId then
        num1 = userId or num1
    end

    local var2 = format(str1, num2, num1)

    return (TextChatService:FindFirstChild("TextChannels") or TextChatService):FindFirstChild(var2)
end

local function createWhisperChannel(player: Player, userId: number, num1: number): TextChannel
    local textChannelName = string.format("RBXWhisper:%d_%d", userId < num1 and userId or num1, num1 < userId and userId or num1)

    local var2 = TextChatService:FindFirstChild("TextChannels") or TextChatService
    local textChannel = Instance.new("TextChannel")
    textChannel.Name = textChannelName

    markTextChannelAsDefault(textChannel)
    textChannel.Parent = var2

    if FFlagExpChatWhisperSetDirectChatRequester then
        textChannel:SetDirectChatRequester(player)
    else
        textChannel:AddUserAsync(userId)
    end
    textChannel:AddUserAsync(num1)

    textChannel.ChildRemoved:Connect(function(_: Instance)
        if List.count(textChannel:GetChildren(), function(arg1)
            return arg1:IsA("TextSource")
        end) < 2 then
            textChannel:Destroy()
        end
    end)

    return textChannel
end

local function createInstance(className: string, instanceName: string, parent): Instance -- Luacid: Inlined by compiler; 2 call sites recovered
    local instance = Instance.new(className)
    instance.Name = instanceName
    instance.Parent = parent
    return instance
end

local function createDispatchRemoteFunction()
    local var2 = RobloxReplicatedStorage:FindFirstChild("ExperienceChat")
        or createInstance("Folder", "ExperienceChat", RobloxReplicatedStorage)

    local var3 = var2:FindFirstChild("WhisperChat") or createInstance("RemoteFunction", "WhisperChat", var2)

    if var3:IsA("RemoteFunction") then
        function var3.OnServerInvoke(player: Player, arg1)
            var1:trace("WhisperChat remote invoked with: {}", tostring(arg1))
            local toUserId = tonumber(arg1)
            local userId = player.UserId
            if toUserId then
                local var4 = whisperChannelAlreadyExists(userId, toUserId)

                if var4 then
                    var1:trace("Whisper TextChannel already exists")
                    return var4
                end

                if canUsersTalkToEachOther(userId, toUserId) then
                    var1:trace("Creating whisper TextChannel")
                    return (createWhisperChannel(player, userId, toUserId))
                end
            end

            return nil
        end
    end

    return var3
end

return createDispatchRemoteFunction
