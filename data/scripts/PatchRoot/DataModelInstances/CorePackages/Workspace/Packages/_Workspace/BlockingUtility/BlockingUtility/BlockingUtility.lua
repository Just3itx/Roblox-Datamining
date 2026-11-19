-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T11:41:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BlockingUtilityParent = script:FindFirstAncestor("BlockingUtility").Parent

local HttpRbxApiService = game:GetService("HttpRbxApiService")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local RobloxReplicatedStorage = game:GetService("RobloxReplicatedStorage")

local Url = require(BlockingUtilityParent.Http).Url

local module = {}
module.__index = module

local UpdatePlayerBlockList = nil
spawn(function()
    UpdatePlayerBlockList = RobloxReplicatedStorage:WaitForChild("UpdatePlayerBlockList", math.huge)
end)

local bindableEvent = Instance.new("BindableEvent")
local bindableEvent2 = Instance.new("BindableEvent")
local bindableEvent3 = Instance.new("BindableEvent")

local bool1 = false
local bindableEvent4 = Instance.new("BindableEvent")
local tbl1 = ({})
local tbl2 = ({})

local function getBlockedUserIdsFromBlockedList() -- Luacid: Inlined by compiler; 1 call site recovered
    local blockedUserIdsFromBlockedList = {}
    for value, _ in tbl1 do
        table.insert(blockedUserIdsFromBlockedList, value)
    end
    return blockedUserIdsFromBlockedList
end

local function getBlockedUserIds()
    if not (Players.LocalPlayer.UserId > 0) then
        return {}
    end

    local num1 = 0

    while not bool1 do
        num1 += wait()
        if num1 > 5 then
            return {}
        end
    end

    return getBlockedUserIdsFromBlockedList()
end

local function isBlocked(arg1): boolean -- Luacid: Inlined by compiler; 5 call sites recovered
    return not not tbl1[arg1]
end

local function isMuted(arg1): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return tbl2[arg1] ~= nil and tbl2[arg1] == true
end

local function BlockPlayerAsync(arg1)
    local localPlayer = Players.LocalPlayer
    if arg1 and localPlayer ~= arg1 then
        local userId = arg1.UserId
        if userId > 0 then
            if isBlocked(userId) then
                return true
            end

            tbl1[userId] = true
            bindableEvent:Fire(userId, true)

            local success, result = pcall(function()
                local apiUrl = Url.APIS_URL .. "user-blocking-api/v1/users/" .. tostring(arg1.UserId) .. "/block-user"
                local input = HttpRbxApiService:PostAsyncFullUrl(apiUrl, "")

                if input then
                    return (HttpService:JSONDecode(input))
                end
            end)

            if success and result then
                if UpdatePlayerBlockList then
                    UpdatePlayerBlockList:FireServer(userId, true)
                end
                bindableEvent2:Fire(userId, true)
            else
                tbl1[userId] = nil
                bindableEvent:Fire(userId, false)
            end

            return success and result
        end
    end

    return false
end

local function UnblockPlayerAsync(arg1)
    if not arg1 then
        return false
    end

    local userId = arg1.UserId

    if not isBlocked(userId) then
        return true
    end

    tbl1[userId] = nil
    bindableEvent:Fire(userId, false)

    local success, result = pcall(function()
        local apiUrl = Url.APIS_URL .. "user-blocking-api/v1/users/" .. tostring(arg1.UserId) .. "/unblock-user"
        local input = HttpRbxApiService:PostAsyncFullUrl(apiUrl, "")

        if input then
            local var1 = HttpService:JSONDecode(input)
            return var1 and not var1.errors
        end
    end)

    if success and result then
        if UpdatePlayerBlockList then
            UpdatePlayerBlockList:FireServer(userId, false)
        end
        bindableEvent2:Fire(userId, false)
    else
        tbl1[userId] = true
        bindableEvent:Fire(userId, true)
    end

    return success and result
end

local function AddPlayerToBlockList(arg1)
    local localPlayer = Players.LocalPlayer
    if arg1 and localPlayer ~= arg1 then
        local userId = arg1.UserId
        if userId > 0 then
            if not isBlocked(userId) then
                tbl1[userId] = true
                bindableEvent:Fire(userId, true)

                if UpdatePlayerBlockList then
                    UpdatePlayerBlockList:FireServer(userId, true)
                end

                if bindableEvent2 then
                    bindableEvent2:Fire(userId, true)
                end
            end

            return true
        end
    end
    return false
end

local function RemovePlayerFromBlockList(arg1): boolean
    if not arg1 then
        return false
    end

    local userId = arg1.UserId

    if isBlocked(userId) then
        tbl1[userId] = nil
        bindableEvent:Fire(userId, false)

        if UpdatePlayerBlockList then
            UpdatePlayerBlockList:FireServer(userId, false)
        end

        if bindableEvent2 then
            bindableEvent2:Fire(userId, false)
        end
    end

    return true
end

local function MutePlayer(arg1)
    local localPlayer = Players.LocalPlayer
    if not arg1 or localPlayer == arg1 then
        return
    end

    local userId = arg1.UserId

    if userId > 0 and not isMuted(userId) then
        tbl2[userId] = true
        bindableEvent3:Fire(userId, true)
    end
end

local function UnmutePlayer(arg1)
    if arg1 then
        local userId = arg1.UserId
        tbl2[userId] = nil
        bindableEvent3:Fire(userId, false)
    end
end

local bindableEvent5 = Instance.new("BindableEvent")
local bindableEvent6 = Instance.new("BindableEvent")
local bindableEvent7 = Instance.new("BindableEvent")
local bindableEvent8 = Instance.new("BindableEvent")

bindableEvent.Event:Connect(function(userId: number | User, arg1) -- name: blockedStatusChanged
    local player = Players:GetPlayerByUserId(userId)
    if not player then
        return
    end

    if arg1 then
        bindableEvent5:Fire(player)
        return
    end
    bindableEvent6:Fire(player)
end)
bindableEvent3.Event:Connect(function(userId: number | User, bool2: boolean) -- name: muteStatusChanged
    local player = Players:GetPlayerByUserId(userId)
    if not player then
        return
    end

    if bool2 then
        bindableEvent7:Fire(player)
        return
    end
    bindableEvent8:Fire(player)
end)
StarterGui:RegisterGetCore("PlayerBlockedEvent", function()
    return bindableEvent5
end)
StarterGui:RegisterGetCore("PlayerUnblockedEvent", function()
    return bindableEvent6
end)
StarterGui:RegisterGetCore("PlayerMutedEvent", function()
    return bindableEvent7
end)
StarterGui:RegisterGetCore("PlayerUnmutedEvent", function()
    return bindableEvent8
end)

task.spawn(function()
    game:GetService("RobloxReplicatedStorage"):WaitForChild("SendPlayerBlockList", math.huge).OnClientEvent:Connect(
        function(arg1)
            local tbl3 = {}
            for value, _ in arg1 do
                tbl3[tonumber(value)] = true
            end
            local var1 = tbl1
            tbl1 = tbl3
            bool1 = true

            for value in tbl3 do
                if not var1[value] then
                    bindableEvent:Fire(value, true)
                end
            end
            for value in var1 do
                if not tbl3[value] then
                    bindableEvent:Fire(value, false)
                end
            end

            bindableEvent4:Fire()
        end
    )
end)
task.spawn(function()
    game:GetService("RobloxReplicatedStorage"):WaitForChild("UpdateLocalPlayerBlockList", math.huge).OnClientEvent:Connect(
        function(arg1, arg2)
            tbl1[arg1] = if arg2 then true else nil
            bindableEvent:Fire(arg1, arg2)
        end
    )
end)

function module.BlockPlayerAsync(_, arg1)
    return (BlockPlayerAsync(arg1))
end

function module.UnblockPlayerAsync(_, arg1)
    return (UnblockPlayerAsync(arg1))
end

function module.MutePlayer(_, arg1)
    return MutePlayer(arg1)
end

function module.UnmutePlayer(_, arg1)
    return UnmutePlayer(arg1)
end

function module.IsPlayerBlockedByUserId(_, arg1): boolean
    return isBlocked(arg1)
end

function module.GetBlockedStatusChangedEvent(_): RBXScriptSignal
    return bindableEvent.Event
end

function module.GetAfterBlockedStatusChangedEvent(_): RBXScriptSignal
    return bindableEvent2.Event
end

function module.GetMutedStatusChangedEvent(_): RBXScriptSignal
    return bindableEvent3.Event
end

function module.IsPlayerMutedByUserId(_, arg1): boolean
    return isMuted(arg1)
end

function module.GetBlockedUserIdsAsync(_)
    return (getBlockedUserIds())
end

function module.AddPlayerToBlockList(_, arg1): boolean
    return (AddPlayerToBlockList(arg1))
end

function module.RemovePlayerFromBlockList(_, arg1): boolean
    return (RemovePlayerFromBlockList(arg1))
end

return module
