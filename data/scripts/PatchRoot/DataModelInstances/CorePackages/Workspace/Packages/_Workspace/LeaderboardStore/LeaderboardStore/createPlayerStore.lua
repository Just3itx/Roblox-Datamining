-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T23:20:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local Signals = require(scriptParentParent.Signals)

local createSignalMap = require(scriptParentParent.CoreScriptsRoactCommon).Utilities.createSignalMap

local createRBXEventSignal = require(script.Parent.createRBXEventSignal)
local isValidStat = require(script.Parent.isValidStat)
local getScoreValue = require(script.Parent.getScoreValue)
local _LeaderboardStoreTypes = require(script.Parent.LeaderboardStoreTypes)

local FFlagPlayerListFixLeaderstatsStacking = require(scriptParentParent.SharedFlags).FFlagPlayerListFixLeaderstatsStacking

local function createPlayerStore(getPlayer, callback: (...any) -> (...any), callback2: (...any) -> (...any), callback3: (...any) -> (...any), callback4: (...any) -> (...any), callback5: ((...any) -> (...any))?)
    local tbl1 = {}
    local tbl2 = ({})

    local order, var2 = Signals.createSignal(0)
    local stats = createSignalMap()
    local getTeam = "Neutral"
    local getPlayerEntry = { order = order, stats = stats }

    local function getPlayerTeam() -- Luacid: Inlined by compiler; 1 call site recovered
        return getPlayer.Team or "Neutral"
    end

    local function addStatConnection(name: string, str2: string, arg2) -- Luacid: Inlined by compiler; 3 call sites recovered
        if tbl2[name] == nil then
            tbl2[name] = {}
        end
        tbl2[name][str2] = arg2
    end

    local function _removeStatConnection(str2: string, str3: string) -- Luacid: unused: defined but never referenced
        local var3 = tbl2[str2]
        if var3 == nil then
            return
        end

        local var4 = var3[str3]
        if not var4 then
            return
        end

        if var4.Disconnect then
            var4:Disconnect()
        end
        var3[str3] = nil
    end

    local function onStatAdded(arg2)
        local value = arg2.Value
        local var3, var4 = createRBXEventSignal(arg2.Changed, value)
        local computed = Signals.createComputed(function(arg3)
            return getScoreValue(var3(arg3))
        end)

        callback(arg2)

        stats.setData(arg2.Name, computed, false)

        local effect = Signals.createEffect(function(arg3)
            computed(arg3)
            callback3(getTeam, arg2.Name)
            callback4(getTeam, arg2.Name)
        end)

        addStatConnection(arg2.Name, "StatChanged", {
            Disconnect = function()
                effect()
                var4:Disconnect()
            end
        })

        local connection = arg2.ChildAdded:Connect(function()
            callback(arg2)
        end)
        addStatConnection(arg2.Name, "StatChildAdded", connection)

        local connection2 = arg2.ChildRemoved:Connect(function()
            callback(arg2)
        end)
        addStatConnection(arg2.Name, "StatChildRemoved", connection2)
    end

    local function onStatRemoved(arg2: Instance)
        local var3 = tbl2[arg2.Name]
        if var3 == nil then
            return
        end

        for _, value in pairs(var3) do
            if value.Disconnect then
                value:Disconnect()
            end
        end
        tbl2[arg2.Name] = nil
        stats.removeData(arg2.Name, false)
        callback2(arg2)
    end

    local function leaderstatsAdded(arg2)
        local leaderstatsChildAdded = arg2.ChildAdded:Connect(function(child: Instance)
            if isValidStat(child) then
                onStatAdded(child)
            end
        end)
        tbl1.leaderstatsChildAdded = leaderstatsChildAdded

        local leaderstatsChildRemoved = arg2.ChildRemoved:Connect(function(child: Instance)
            if isValidStat(child) then
                onStatRemoved(child)
            end
        end)
        tbl1.leaderstatsChildRemoved = leaderstatsChildRemoved

        local children = arg2:GetChildren()
        for _, child in ipairs(children) do
            if isValidStat(child) then
                onStatAdded(child)
            end
        end
    end

    local function onPlayerChildAdded(arg2)
        local bool1 = arg2.Name == "leaderstats"
        local var3 = arg2:IsA("ValueBase") or arg2:IsA("Folder") or arg2:IsA("Model")
        if not (bool1 or var3) then
            return
        end

        local leaderstatNameChanged = arg2.Changed:Connect(function(arg3)
            if arg3 == "Name" and arg2.Name == "leaderstats" then
                leaderstatsAdded(arg2)
            end
        end)

        tbl1.LeaderstatNameChanged = leaderstatNameChanged

        if arg2.Name == "leaderstats" then
            leaderstatsAdded(arg2)
        end
    end

    local function onPlayerChildRemoved(arg2: Instance)
        if arg2.Name == "leaderstats" then
            local children = arg2:GetChildren()
            for _, child in ipairs(children) do
                if isValidStat(child) then
                    onStatRemoved(child)
                end
            end

            if FFlagPlayerListFixLeaderstatsStacking then
                callback5()
            end
        end
        callback4(getTeam)
    end

    local function connectPlayerEvents()
        local playerChildAdded = getPlayer.ChildAdded:Connect(function(child: Instance)
            onPlayerChildAdded(child)
        end)
        tbl1.PlayerChildAdded = playerChildAdded

        local playerChildRemoved = getPlayer.ChildRemoved:Connect(function(child: Instance)
            onPlayerChildRemoved(child)
        end)
        tbl1.PlayerChildRemoved = playerChildRemoved

        local leaderstats = getPlayer:FindFirstChild("leaderstats")
        if leaderstats then
            leaderstatsAdded(leaderstats)
            return
        end
        for _, child in ipairs(getPlayer:GetChildren()) do
            onPlayerChildAdded(child)
        end
    end

    getTeam = getPlayerTeam()

    connectPlayerEvents()

    return {
        getPlayer = function()
            return getPlayer
        end,
        getPlayerEntry = function()
            return getPlayerEntry
        end,
        getStatValue = function(str2: string, arg2)
            local data = stats.getData(str2, false)
            if data then
                return data(arg2)
            end
            return nil
        end,
        getTeam = function()
            return getTeam
        end,
        setOrder = function(num1: number)
            var2(num1)
        end,
        setTeam = function(arg2)
            getTeam = arg2
        end,
        destroy = function()
            for _, value in pairs(tbl2) do
                for _, value2 in pairs(value) do
                    if value2.Disconnect then
                        value2:Disconnect()
                    end
                end
            end
            tbl2 = {}

            for _, value in pairs(tbl1) do
                if value.Disconnect then
                    value:Disconnect()
                end
            end
            tbl1 = {}
        end
    }
end
return createPlayerStore
