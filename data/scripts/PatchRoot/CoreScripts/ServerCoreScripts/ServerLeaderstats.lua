-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:41:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local RobloxReplicatedStorage = game:GetService("RobloxReplicatedStorage")

local input = ({})
local num1 = 0

local LeaderstatsOrder = Instance.new("StringValue")
LeaderstatsOrder.Name = "LeaderstatsOrder"
LeaderstatsOrder.Parent = RobloxReplicatedStorage

function updateStats()
    LeaderstatsOrder.Value = HttpService:JSONEncode(input)
end

updateStats()

local function addLeaderstat(name) -- Luacid: Inlined by compiler; 2 call sites recovered
    if input[name] then
        return
    end
    input[name] = num1
    num1 += 1
    updateStats()
end

local function isValidStat(arg1)
    return arg1:IsA("StringValue")
        or arg1:IsA("IntValue")
        or arg1:IsA("BoolValue")
        or arg1:IsA("NumberValue")
        or arg1:IsA("DoubleConstrainedValue")
        or arg1:IsA("IntConstrainedValue")
end

local function isValidContainer(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    return arg1:IsA("ValueBase") or arg1:IsA("Folder") or arg1:IsA("Configuration") or arg1:IsA("Model")
end

local tbl1 = ({})

local function getLeaderstatConnections(arg1, arg2) -- Luacid: Inlined by compiler; 3 call sites recovered
    if tbl1[arg1] then
        return tbl1[arg1].leaderstats[arg2]
    end

    return nil
end

local function leaderstatChildAdded(arg1, arg2, arg3)
    if not isValidStat(arg3) then
        return
    end

    local leaderstatConnections = getLeaderstatConnections(arg1, arg2)

    if not leaderstatConnections then
        return
    end
    assert(leaderstatConnections ~= nil)

    local connection = arg3:GetPropertyChangedSignal("Name"):Connect(function()
        addLeaderstat(arg3.Name)
    end)
    leaderstatConnections.leaderStatNameChanged[arg3] = connection
    addLeaderstat(arg3.Name)
end

local function leaderstatChildRemoved(arg1, arg2, arg3: Instance) -- Luacid: Inlined by compiler; 1 call site recovered
    local leaderstatConnections = getLeaderstatConnections(arg1, arg2)

    if not leaderstatConnections then
        return
    end
    assert(leaderstatConnections ~= nil)

    if not leaderstatConnections.leaderStatNameChanged[arg3] then
        return
    end

    leaderstatConnections.leaderStatNameChanged[arg3]:Disconnect()
    leaderstatConnections.leaderStatNameChanged[arg3] = nil
end

local function leaderstatsAdded(arg1, arg2)
    if not tbl1[arg1] then
        return
    end

    local childAdded = arg2.ChildAdded:Connect(function(child: Instance)
        leaderstatChildAdded(arg1, arg2, child)
    end)
    local childRemoved = arg2.ChildRemoved:Connect(function(child: Instance)
        leaderstatChildRemoved(arg1, arg2, child)
    end)

    tbl1[arg1].leaderstats[arg2] = {
        childAdded = childAdded,
        childRemoved = childRemoved,
        leaderStatNameChanged = {}
    }

    for _, child in arg2:GetChildren() do
        leaderstatChildAdded(arg1, arg2, child)
    end
end

local function disconnectTableOfConnections(tbl2) -- Luacid: Inlined by compiler; 8 call sites recovered
    for _, value in tbl2 do
        value:Disconnect()
    end
end

local function leaderstatsRemoved(arg1, arg2) -- Luacid: unused: defined but never referenced
    if not tbl1[arg1] then
        return
    end

    local leaderstat = tbl1[arg1].leaderstats[arg2]
    if not leaderstat then
        return
    end

    leaderstat.childAdded:Disconnect()
    leaderstat.childRemoved:Disconnect()
    disconnectTableOfConnections(leaderstat.leaderStatNameChanged)
    tbl1[arg1].leaderstats[arg2] = nil
end

local function playerChildNameChanged(arg1, arg2) -- Luacid: unused: defined but never referenced
    if arg2.Name == "leaderstats" then
        leaderstatsAdded(arg1, arg2)
        return
    end

    if not tbl1[arg1] then
        return
    end

    local leaderstat = tbl1[arg1].leaderstats[arg2]
    if not leaderstat then
        return
    end

    leaderstat.childAdded:Disconnect()
    leaderstat.childRemoved:Disconnect()
    disconnectTableOfConnections(leaderstat.leaderStatNameChanged)
    tbl1[arg1].leaderstats[arg2] = nil
end

local function playerChildAdded(arg1, arg2)
    if not isValidContainer(arg2) or not tbl1[arg1] then
        return
    end

    local connection = arg2:GetPropertyChangedSignal("Name"):Connect(function()
        local var1 = arg1
        local var2 = arg2

        if var2.Name == "leaderstats" then
            leaderstatsAdded(var1, var2)
            return
        end

        if not tbl1[var1] then
            return
        end

        local leaderstat = tbl1[var1].leaderstats[var2]
        if not leaderstat then
            return
        end

        leaderstat.childAdded:Disconnect()
        leaderstat.childRemoved:Disconnect()
        disconnectTableOfConnections(leaderstat.leaderStatNameChanged)
        tbl1[var1].leaderstats[var2] = nil
    end)

    tbl1[arg1].namedChanged[arg2] = connection

    if arg2.Name == "leaderstats" then
        leaderstatsAdded(arg1, arg2)
        return
    end

    if not tbl1[arg1] then
        return
    end

    local leaderstat = tbl1[arg1].leaderstats[arg2]
    if not leaderstat then
        return
    end

    leaderstat.childAdded:Disconnect()
    leaderstat.childRemoved:Disconnect()
    disconnectTableOfConnections(leaderstat.leaderStatNameChanged)
    tbl1[arg1].leaderstats[arg2] = nil
end

local function playerChildRemoved(arg1, arg2) -- Luacid: unused: defined but never referenced
    if not tbl1[arg1] then
        return
    end

    if tbl1[arg1].namedChanged[arg2] then
        tbl1[arg1].namedChanged[arg2]:Disconnect()
        tbl1[arg1].namedChanged[arg2] = nil
    end

    if arg2.Name ~= "leaderstats" then
        return
    end

    if not tbl1[arg1] then
        return
    end

    local leaderstat = tbl1[arg1].leaderstats[arg2]
    if not leaderstat then
        return
    end

    leaderstat.childAdded:Disconnect()
    leaderstat.childRemoved:Disconnect()
    disconnectTableOfConnections(leaderstat.leaderStatNameChanged)
    tbl1[arg1].leaderstats[arg2] = nil
end

local function playerAdded(arg1)
    local childRemoved = arg1.ChildRemoved:Connect(function(child: Instance)
        local var1 = arg1

        if not tbl1[var1] then
            return
        end

        if tbl1[var1].namedChanged[child] then
            tbl1[var1].namedChanged[child]:Disconnect()
            tbl1[var1].namedChanged[child] = nil
        end

        if child.Name ~= "leaderstats" then
            return
        end

        if not tbl1[var1] then
            return
        end

        local leaderstat = tbl1[var1].leaderstats[child]
        if not leaderstat then
            return
        end

        leaderstat.childAdded:Disconnect()
        leaderstat.childRemoved:Disconnect()
        disconnectTableOfConnections(leaderstat.leaderStatNameChanged)
        tbl1[var1].leaderstats[child] = nil
    end)
    local childAdded = arg1.ChildAdded:Connect(function(child: Instance)
        playerChildAdded(arg1, child)
    end)
    tbl1[arg1] = {
        childAdded = childAdded,
        childRemoved = childRemoved,
        namedChanged = {},
        leaderstats = {}
    }

    for _, child in arg1:GetChildren() do
        playerChildAdded(arg1, child)
    end
end

Players.PlayerAdded:Connect(playerAdded)

Players.PlayerRemoving:Connect(function(player: Player) -- name: playerRemoving
    if not tbl1[player] then
        return
    end

    tbl1[player].childAdded:Disconnect()
    tbl1[player].childRemoved:Disconnect()
    disconnectTableOfConnections(tbl1[player].namedChanged)
    for _, leaderstat in tbl1[player].leaderstats do
        leaderstat.childAdded:Disconnect()
        leaderstat.childRemoved:Disconnect()
        disconnectTableOfConnections(leaderstat.leaderStatNameChanged)
    end

    tbl1[player] = nil
end)
for _, player in Players:GetPlayers() do
    playerAdded(player)
end
