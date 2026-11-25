-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T03:11:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Stats = game:GetService("Stats")
local UserInputService = game:GetService("UserInputService")

local scriptParentParent = script.Parent.Parent
local React = require(scriptParentParent.React)

local format = require(script.Parent.format)
local gameplay = require(script.Parent.gameplay)
local isToggleChord = require(script.Parent.isToggleChord)

local tbl1 = {
    "RRakRecvToAppPop",
    "RAppPopToDeserialize",
    "RDeserializeToPBQ",
    "RQToS",
    "RBscQ"
}
local tbl2 = {
    "LQToS",
    "LBcsQ",
    "LRakRecvToAppPop",
    "LAppPopToSerialize",
    "LDeserializeToProcess"
}
local function stageValue(arg1, str1: string) -- Luacid: Inlined by compiler; 9 call sites recovered
    local var1 = arg1:FindFirstChild(str1)
    if not var1 then
        return nil
    end
    local success, result = pcall(function()
        return var1:GetValue()
    end)
    return if success and typeof(result) == "number" then result else nil
end

local function sumStages(arg1, tbl3, num1: number)
    local num2 = 0
    for _, value in tbl3 do
        local var1 = stageValue(arg1, value)

        if var1 and var1 >= 0 and var1 <= num1 then
            num2 += var1
        end
    end
    return num2
end

local function readSplit(arg1)
    local success, result = pcall(function()
        return arg1.Network.ServerStatsItem.DataPingDetails
    end)
    if not (success and result) then
        return nil, nil, nil, nil
    end

    local var1 = stageValue(result, "MeasuredTotal")

    if not var1 or var1 <= 0 then
        return nil, nil, nil, nil
    end

    return var1, sumStages(result, tbl1, var1), sumStages(result, tbl2, var1), (stageValue(result, "RakPing"))
end

local function readPings(arg1)
    local success, result = pcall(function()
        return arg1.Network.ServerStatsItem["Data Ping"]:GetValue()
    end)
    local lastMs, serverMs, clientMs, var4 = readSplit(arg1)

    local success2, result2 = pcall(function(): number
        return Players.LocalPlayer:GetNetworkPing()
    end)
    local serverStatsItem = arg1.Network:FindFirstChild("ServerStatsItem")
    local Stats2 = if serverStatsItem then serverStatsItem:FindFirstChild("Stats") else nil
    local var5 = if Stats2 then stageValue(Stats2, "isLimitedByCongestionControl") else nil
    local var6 = if Stats2 then stageValue(Stats2, "packetlossLastSecond") else nil
    local var7 = if Stats2 then stageValue(Stats2, "messagesInResendQueue") else nil
    local var8 = gameplay.peerStatsPlausible(var6, var7)
    local tbl3 = {
        dataMs = 0,
        rakMs = 0,
        lastMs = 0,
        serverMs = 0,
        clientMs = 0,
        splitRakMs = 0,
        loss = 0,
        resendMsgs = 0,
        resendBytes = 0,
        sendKbps = 0,
        receiveKbps = 0,
        congested = 0,
        peerStatsInvalid = 0
    }

    if not success or typeof(result) ~= "number" then
        result = nil
    end

    tbl3.dataMs = result
    tbl3.rakMs = if success2 and typeof(result2) == "number" and result2 >= 0 then result2 * 1000 else nil
    tbl3.lastMs = lastMs
    tbl3.serverMs = serverMs
    tbl3.clientMs = clientMs
    if not var8 then
        var4 = nil
    end

    tbl3.splitRakMs = var4
    if not var8 then
        var6 = nil
    end

    tbl3.loss = var6
    if not var8 then
        var7 = nil
    end

    tbl3.resendMsgs = var7
    tbl3.resendBytes = if Stats2 and var8 then stageValue(Stats2, "bytesInResendQueue") else nil
    tbl3.sendKbps = if serverStatsItem then stageValue(serverStatsItem, "Send kBps") else nil
    tbl3.receiveKbps = if serverStatsItem then stageValue(serverStatsItem, "Receive kBps") else nil
    tbl3.congested = if var5 and var8 then var5 ~= 0 else nil
    tbl3.peerStatsInvalid = not var8
    return tbl3
end

local function readAuthorityMode(): string? -- Luacid: Inlined by compiler; 1 call site recovered
    local success, result = pcall(function(): Enum.AuthorityMode
        return workspace.AuthorityMode
    end)
    return if success and typeof(result) == "EnumItem" then result.Name else nil
end

local function GameplayPopLatencyOverlay(arg1)
    local experienceService = arg1.experienceService

    local authorizeToggle = arg1.authorizeToggle
    local authorizationVersion = arg1.authorizationVersion

    local var1 = arg1.userInputService or UserInputService
    local var2 = arg1.stats or Stats
    local var3 = arg1.runService or RunService
    local var4, var5 = React.useState(false)
    local var6, var7 = React.useState("")

    React.useEffect(function()
        local connection = var1.InputBegan:Connect(function(input: InputObject)
            if not isToggleChord(input, var1) or var1:GetFocusedTextBox() ~= nil then
                return
            end
            local function toggle() -- Luacid: Inlined by compiler; 2 call sites recovered
                var5(function(arg2): boolean
                    return not arg2
                end)
            end
            if not authorizeToggle then
                toggle()
                return
            end

            task.spawn(function()
                if authorizeToggle() then
                    toggle()
                end
            end)
        end)

        return function()
            connection:Disconnect()
        end
    end, { authorizeToggle, var1 })

    React.useEffect(function()
        var5(false)
    end, { authorizationVersion })

    React.useEffect(function()
        if not var4 then
            return
        end

        local bool1 = true

        local num1 = 0
        local num2 = 0
        local connection = var3.Heartbeat:Connect(function(deltaTime: number)
            num1 += 1
            num2 = math.max(num2, deltaTime)
        end)

        local tbl3 = ({})
        local tbl4 = {}
        local num3 = os.clock() - 1
        task.spawn(function()
            local function poll()
                local now = os.clock()
                local tbl5 = readPings(var2)
                local success, result = pcall(function()
                    return experienceService:GetConnectedServerInfo()
                end)
                local success2, result2 = pcall(function()
                    return experienceService:GetConnectedServerProbeSnapshot()
                end)
                if not success then
                    result = nil
                end

                if result and result.popCode then
                    pcall(function()
                        experienceService:SetConnectedServerProbingActive(true)
                    end)
                end
                local var8 = success2 and (result2 or {}) or {}
                local var9 = gameplay.currentRegion(result)
                local var10 = if var9 then gameplay.recentProbe(var8, var9, 5) else nil
                tbl5.probeLoss = if var10 then var10.loss else nil
                tbl5.probeSilentPops = if var10 then var10.silentPops else nil
                tbl5.probeDown = if var10 then var10.allSilent else nil
                local probeTargets = {}
                for _, value in var8 do
                    local popCode = value.popCode
                    if not var9 or typeof(popCode) ~= "string" or string.upper(string.sub(popCode, 1, 3)) ~= var9 then
                        continue
                    end

                    table.insert(probeTargets, popCode)
                    local lastSampleEpochMs = value.lastSampleEpochMs
                    local var11 = tbl3[popCode]
                    if typeof(lastSampleEpochMs) ~= "number" or not (lastSampleEpochMs > 0) or lastSampleEpochMs == var11 then
                        continue
                    end

                    if var11 and var11 < lastSampleEpochMs then
                        table.insert(tbl4, lastSampleEpochMs - var11)
                        if #tbl4 > 20 then
                            table.remove(tbl4, 1)
                        end
                    end
                    tbl3[popCode] = lastSampleEpochMs
                end

                tbl5.probeIntervalMs = format.historyMedian(tbl4)
                tbl5.probeTargets = probeTargets

                local var11 = now - num3
                if not bool1 or not (var11 >= 1) then
                    return
                end

                tbl5.fps = if num1 > 0 then num1 / var11 else nil
                tbl5.worstFrameMs = if num1 > 0 then num2 * 1000 else nil
                num1 = 0
                num2 = 0
                num3 = now
                var7(gameplay.render(result, var8, tbl5, (readAuthorityMode())))
            end

            local bool2 = false

            while bool1 do
                local success, result = pcall(poll)
                if not (success or bool2) then
                    warn("[GameplayPopOverlay] poll failed: " .. tostring(result))
                    bool2 = true
                end
                task.wait(0.2)
            end
        end)
        return function()
            bool1 = false
            connection:Disconnect()
            pcall(function()
                experienceService:SetConnectedServerProbingActive(false)
            end)
        end
    end, { var4 })

    if not var4 then
        return nil
    end

    return React.createElement("Frame", {
        Name = "GameplayPopOverlay",
        AnchorPoint = Vector2.new(1, 0),
        Position = UDim2.new(1, -12, 0, 64),
        Size = UDim2.fromOffset(460, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundColor3 = format.COLOR_BG,
        BackgroundTransparency = 0.15,
        BorderSizePixel = 0
    }, {
        Corner = React.createElement("UICorner", { CornerRadius = UDim.new(0, 6) }),
        Stroke = React.createElement("UIStroke", { Color = format.COLOR_BORDER, Thickness = 1 }),
        Padding = React.createElement("UIPadding", {
            PaddingTop = UDim.new(0, 8),
            PaddingBottom = UDim.new(0, 8),
            PaddingLeft = UDim.new(0, 10),
            PaddingRight = UDim.new(0, 10)
        }),
        Panel = React.createElement("TextLabel", {
            Size = UDim2.fromScale(1, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            Font = Enum.Font.Code,
            TextSize = format.TEXT_SIZE,
            TextColor3 = format.COLOR_HEADER,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Top,
            RichText = true,
            TextWrapped = true,
            Text = var6
        })
    })
end

return GameplayPopLatencyOverlay
