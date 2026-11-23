-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T18:51:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local HttpService = game:GetService("HttpService")
local LogService = game:GetService("LogService")
local MemStorageService = game:GetService("MemStorageService")
local Players = game:GetService("Players")

local CreatorAgentChat = require(BuildExperienceParent.DataHydration.CreatorAgentChat)

local FFlagBuildExperienceAskForLogsSeverityRetention = require(BuildExperience.Flags.FFlagBuildExperienceAskForLogsSeverityRetention)

local StudioClientLogsTool = CreatorAgentChat.StudioClientLogsTool

game:DefineFastInt("MyStatsExperienceAskForLogsMaxEntries", 100)

local function getDefaultMaxEntriesPerSource(): number -- Luacid: Inlined by compiler; 6 call sites recovered
    return math.max(0, game:GetFastInt("MyStatsExperienceAskForLogsMaxEntries"))
end

local tbl1 = {
    [Enum.MessageType.MessageOutput.Value] = "Output",
    [Enum.MessageType.MessageInfo.Value] = "Information",
    [Enum.MessageType.MessageWarning.Value] = "Warning",
    [Enum.MessageType.MessageError.Value] = "Error"
}

local tbl2 = {
    [Enum.MessageType.MessageOutput.Value] = 0,
    [Enum.MessageType.MessageInfo.Value] = 1,
    [Enum.MessageType.MessageWarning.Value] = 2,
    [Enum.MessageType.MessageError.Value] = 3
}

local function getMessageTypeValue(arg1): number? -- Luacid: Inlined by compiler; 3 call sites recovered
    return if typeof(arg1) == "EnumItem" then arg1.Value elseif typeof(arg1) == "number" then arg1 else nil
end

local function getMessageTypeLabel(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    local messageTypeValue = getMessageTypeValue(arg1)

    if messageTypeValue ~= nil then
        return tbl1[messageTypeValue] or tostring(messageTypeValue)
    end

    if typeof(arg1) == "EnumItem" then
        return arg1.Name
    end

    if typeof(arg1) == "string" and arg1 ~= "" then
        return arg1
    end

    return nil
end

local function encodeContext(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    if typeof(arg1) ~= "table" or next(arg1) == nil then
        return nil
    end

    return HttpService:JSONEncode(arg1)
end

local function getSeverityRank(arg1) -- Luacid: Inlined by compiler; 4 call sites recovered
    local messageTypeValue = arg1.messageTypeValue
    return if messageTypeValue == nil then 0 else tbl2[messageTypeValue] or 0
end

local function trimToCapBySeverity(tbl3, num1: number)
    while num1 < #tbl3 do
        local num2 = 1
        local severityRank = getSeverityRank(tbl3[1])
        for i = 2, #tbl3 do
            local severityRank2 = getSeverityRank(tbl3[i])
            if severityRank2 < severityRank then
                num2 = i
                severityRank = severityRank2
            end
        end

        table.remove(tbl3, num2)
    end
end

local function selectRetainedBySeverity(tbl3, num1: number)
    local result = {}
    if num1 <= 0 then
        return result
    end

    local num2 = #tbl3
    if num2 <= num1 then
        table.move(tbl3, 1, num2, 1, result)
        return result
    end

    local tbl4 = ({})
    for _, value in tbl3 do
        local severityRank = getSeverityRank(value)
        tbl4[severityRank] = (tbl4[severityRank] or 0) + 1
    end

    local num3 = 0

    for i = 3, 0, -1 do
        local var1 = tbl4[i] or 0
        if not (var1 < num1) then
            num3 = i
            break
        end

        num1 -= var1
    end

    local var1 = (tbl4[num3] or 0) - num1
    for _, value in tbl3 do
        local severityRank = getSeverityRank(value)

        if num3 < severityRank then
            table.insert(result, value)
        elseif severityRank == num3 then
            if var1 > 0 then
                var1 -= 1
            else
                table.insert(result, value)
            end
        end
    end

    return result
end

local function pushCapped(tbl3, tbl4: {contextJson: number, message: any, messageType: number, messageTypeValue: number, timestamp: number}, num1: number) -- Luacid: Inlined by compiler; 3 call sites recovered
    if num1 <= 0 then
        return
    end
    table.insert(tbl3, tbl4)
    if not (num1 < #tbl3) then
        return
    end

    if FFlagBuildExperienceAskForLogsSeverityRetention then
        trimToCapBySeverity(tbl3, num1)
        return
    end
    table.remove(tbl3, 1)
end

local function toLogEntry(message, arg2, timestamp, arg4)
    if typeof(message) ~= "string" then
        message = tostring(message or "")
    end

    if typeof(timestamp) ~= "number" then
        timestamp = nil
    end

    return {
        message = message,
        messageType = getMessageTypeLabel(arg2),
        messageTypeValue = getMessageTypeValue(arg2),
        timestamp = timestamp,
        contextJson = encodeContext(arg4)
    }
end

local tbl3 = {}
local connection = nil
local connection2 = nil
local bool1 = false
local num1 = getDefaultMaxEntriesPerSource()

local connection3 = nil
local connection4 = nil
local num2 = 0
local bool2 = false
local var1 = nil
local var2 = nil

local function collectClientLogs(arg1, num3: number?)
    local var3 = arg1 or LogService
    local num4 = num3 or getDefaultMaxEntriesPerSource()

    local result = {}

    for _, value in (var3:GetLogHistory()) do
        if typeof(value) == "table" then
            pushCapped(result, toLogEntry(value.message, value.messageType, value.timestamp, value.context), num4)
        end
    end

    return result
end

local function trimServerLogs(num3: number)
    if FFlagBuildExperienceAskForLogsSeverityRetention then
        trimToCapBySeverity(tbl3, num3)
        return
    end
    while num3 < #tbl3 do
        table.remove(tbl3, 1)
    end
end

local function stopServerLogCollection(bool3: boolean?)
    if connection ~= nil then
        connection:Disconnect()
        connection = nil
    end
    if connection2 ~= nil then
        connection2:Disconnect()
        connection2 = nil
    end
    if connection3 ~= nil then
        connection3:Disconnect()
        connection3 = nil
    end
    if connection4 ~= nil then
        connection4:Disconnect()
        connection4 = nil
    end
    num2 += 1
    bool2 = false
    var1 = nil
    bool1 = false
    if bool3 == true then
        tbl3 = {}
    end
end

local function startServerLogCollection(tbl4): boolean
    local tbl5 = tbl4 or {}
    if (tbl5.dataModel or game).GameId == 0 then
        return false
    end
    if bool1 then
        return true
    end

    local var3 = tbl5.logService or LogService
    num1 = tbl5.maxEntriesPerSource or getDefaultMaxEntriesPerSource()
    trimServerLogs(num1)

    connection = var3.ServerMessageOut:Connect(function(message: string, messageType: Enum.MessageType, timestamp: number, arg1)
        pushCapped(tbl3, toLogEntry(message, messageType, timestamp, arg1), num1)
        if var1 ~= nil then
            var1()
        end
    end)

    connection2 = var3.ServerContextOut:Connect(function(arg1)
        if typeof(arg1) ~= "table" or arg1._structuredContext == nil then
            return
        end

        pushCapped(tbl3, toLogEntry(arg1._message, arg1._messageType, arg1._timestamp, arg1._structuredContext), num1)

        if var1 ~= nil then
            var1()
        end
    end)

    var3:RequestServerOutput()

    bool1 = true
    if var2 ~= nil then
        var2(tbl5)
    end
    return true
end

local function getCollectedServerLogs(num3: number?)
    local num4 = num3 or getDefaultMaxEntriesPerSource()
    if FFlagBuildExperienceAskForLogsSeverityRetention then
        return (selectRetainedBySeverity(tbl3, num4))
    end

    local collectedServerLogs = {}
    local num5 = #tbl3 - num4 + 1

    for i = math.max(1, num5), #tbl3 do
        table.insert(collectedServerLogs, tbl3[i])
    end
    return collectedServerLogs
end

local function getLogSnapshotKey(num3: number): string -- Luacid: Inlined by compiler; 2 call sites recovered
    return `BuildExperiencePlaytestLogs:{num3}`
end

local function writeLogSnapshot(arg1, logSnapshotKey: string, tbl4) -- Luacid: Inlined by compiler; 1 call site recovered
    local success, result = pcall(HttpService.JSONEncode, HttpService, tbl4)
    if not success or typeof(result) ~= "string" then
        return
    end
    pcall(arg1.SetItem, arg1, logSnapshotKey, result)
end

var2 = function(tbl4)
    local var3 = tbl4.dataModel or game
    local gameId = var3.GameId
    local placeId = var3.PlaceId
    local placeVersion = var3.PlaceVersion

    if typeof(gameId) ~= "number" or gameId == 0 or typeof(placeId) ~= "number" or typeof(placeVersion) ~= "number" then
        return
    end

    local var4 = tbl4.logService or LogService
    local var5 = tbl4.memStorageService or MemStorageService
    local var6 = tbl4.playersService or Players
    local var7 = tbl4.maxEntriesPerSource or getDefaultMaxEntriesPerSource()
    local logSnapshotKey = getLogSnapshotKey(gameId)

    num2 += 1
    local num3 = num2
    bool2 = false
    pcall(var5.SetItem, var5, logSnapshotKey, "")

    local function persistNow()
        if num3 ~= num2 then
            return
        end
        local success, result = pcall(collectClientLogs, var4, var7)
        if not success then
            return
        end
        writeLogSnapshot(var5, logSnapshotKey, {
            schemaVersion = 1,
            universeId = gameId,
            placeId = placeId,
            placeVersion = placeVersion,
            clientLogs = result,
            serverLogs = getCollectedServerLogs(var7)
        })
    end

    local function scheduleWrite()
        if num3 ~= num2 or bool2 then
            return
        end
        bool2 = true
        local function writeAfterDelay()
            if num3 ~= num2 then
                return
            end
            bool2 = false
            persistNow()
        end
        if tbl4.schedule ~= nil then
            tbl4.schedule(1, writeAfterDelay)
            return
        end
        task.delay(1, writeAfterDelay)
    end

    var1 = scheduleWrite
    connection3 = var4.MessageOut:Connect(scheduleWrite)
    local localPlayer = var6.LocalPlayer
    connection4 = var6.PlayerRemoving:Connect(function(player: Player)
        if player == localPlayer then
            persistNow()
        end
    end)
    scheduleWrite()
end

local function readLogSnapshot(tbl4)
    local universeId = tbl4.universeId
    local placeId = tbl4.placeId
    if typeof(universeId) ~= "number" or universeId == 0 or typeof(placeId) ~= "number" then
        return nil
    end

    local var3 = tbl4.memStorageService or MemStorageService
    local success, result = pcall(var3.GetItem, var3, (getLogSnapshotKey(universeId)))
    if not success or typeof(result) ~= "string" or result == "" then
        return nil
    end

    local success2, result2 = pcall(HttpService.JSONDecode, HttpService, result)

    if success2 and typeof(result2) == "table" then
        if result2.schemaVersion == 1
            and result2.universeId == universeId
            and result2.placeId == placeId
            and typeof(result2.placeVersion) == "number"
            and typeof(result2.clientLogs) == "table"
            and typeof(result2.serverLogs) == "table"
        then
            return result2
        end

        return nil
    end

    return nil
end

local function logsAreStale(placeVersion, minimumPlaceVersion: number?): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return not (minimumPlaceVersion == nil) and (typeof(placeVersion) ~= "number" or placeVersion < minimumPlaceVersion)
end

return {
    startServerLogCollection = startServerLogCollection,
    stopServerLogCollection = stopServerLogCollection,
    collectToolResultContent = function(tbl4)
        local tbl5 = tbl4 or {}
        local var3 = tbl5.dataModel or game
        if var3.GameId ~= 0 then
            if logsAreStale(var3.PlaceVersion, tbl5.minimumPlaceVersion) then
                return StudioClientLogsTool.formatStaleLogsContent()
            end

            local var4 = tbl5.maxEntriesPerSource or getDefaultMaxEntriesPerSource()
            startServerLogCollection(tbl5)
            return StudioClientLogsTool.formatLogsContent(collectClientLogs(tbl5.logService, var4), (getCollectedServerLogs(var4)))
        end

        local var4 = readLogSnapshot(tbl5)
        if var4 ~= nil then
            if logsAreStale(var4.placeVersion, tbl5.minimumPlaceVersion) then
                return StudioClientLogsTool.formatStaleLogsContent()
            end
            return StudioClientLogsTool.formatLogsContent(var4.clientLogs, var4.serverLogs)
        end
        return StudioClientLogsTool.formatNotInGameContent()
    end
}
