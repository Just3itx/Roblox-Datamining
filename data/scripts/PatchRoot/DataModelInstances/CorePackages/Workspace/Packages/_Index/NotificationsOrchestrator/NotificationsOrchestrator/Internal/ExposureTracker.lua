-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T08:31:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")

local NotificationsOrchestrator = script:FindFirstAncestor("NotificationsOrchestrator")
local NotificationsOrchestratorParent = NotificationsOrchestrator.Parent

local createSessionScopedSignal = require(NotificationsOrchestratorParent.SignalsUtils).createSessionScopedSignal
local LocalUserIdStore = require(NotificationsOrchestratorParent.LocalUserIdStore).LocalUserIdStore

local SafeAppStorageService = require(NotificationsOrchestratorParent.AvatarExperienceCommon).Lib.SafeAppStorageService

local FIntNotificationsOrchestratorExposureTrackerVersion = require(NotificationsOrchestrator.Flags.FIntNotificationsOrchestratorExposureTrackerVersion)
local _Types = require(NotificationsOrchestrator.Types)

local var1, var2 = createSessionScopedSignal({})

local function currentUserId() -- Luacid: Inlined by compiler; 2 call sites recovered
    local currentUserId2 = LocalUserIdStore.getCurrentUserId(false)
    if currentUserId2 ~= "" then
        return currentUserId2
    end
    local localPlayer = Players.LocalPlayer
    if localPlayer == nil or not (localPlayer.UserId > 0) then
        return "default_userid"
    end

    return tostring(localPlayer.UserId)
end

local function systemNow(): number
    return os.time()
end

local func1 = systemNow

local function now(): number -- Luacid: Inlined by compiler; 2 call sites recovered
    return func1()
end

local function currentVersionKey(): string -- Luacid: Inlined by compiler; 2 call sites recovered
    return tostring(FIntNotificationsOrchestratorExposureTrackerVersion)
end

local function emptyRecord() -- Luacid: Inlined by compiler; 3 call sites recovered
    return {
        count = 0,
        lastShownAt = 0,
        shownAt = {}
    }
end

local function decodeShownAt(shownAt)
    if typeof(shownAt) ~= "table" then
        return {}
    end
    local result = {}
    for _, value in shownAt do
        if typeof(value) == "number" then
            table.insert(result, value)
        end
    end
    return result
end

local function decodeRecord(count)
    if typeof(count) == "number" then
        return {
            count = count,
            lastShownAt = 0,
            shownAt = {}
        }
    end
    if typeof(count) ~= "table" then
        return nil
    end

    return {
        count = if typeof(count.count) ~= "number" then 0 else count.count,
        lastShownAt = if typeof(count.lastShownAt) ~= "number" then 0 else count.lastShownAt,
        shownAt = decodeShownAt(count.shownAt)
    }
end

local function decodeRecords(tbl1)
    local result = ({})
    for value, value2 in tbl1 do
        if typeof(value) ~= "string" then
            continue
        end

        local var3 = decodeRecord(value2)
        if var3 ~= nil then
            result[value] = var3
        end
    end

    return result
end

local function readTracker()
    local item = SafeAppStorageService.getItem("NotificationsOrchestratorGlobalTracker")
    if item == "" then
        return {}
    end

    local success, result = pcall(function()
        return HttpService:JSONDecode(item)
    end)
    if not success or typeof(result) ~= "table" then
        return {}
    end

    local result2 = ({})
    for value, value2 in result do
        if typeof(value) == "string" then
            result2[value] = value2
        end
    end
    return result2
end

local function writeTracker(input) -- Luacid: Inlined by compiler; 9 call sites recovered
    SafeAppStorageService.setItem("NotificationsOrchestratorGlobalTracker", HttpService:JSONEncode(input))
    SafeAppStorageService.flush()
end

local function dropOlderVersions(tbl1): boolean -- Luacid: Inlined by compiler; 8 call sites recovered
    local var3 = FIntNotificationsOrchestratorExposureTrackerVersion
    local bool1 = false
    for value in tbl1 do
        local var4 = tonumber(value)
        if var4 ~= nil and var4 < var3 then
            tbl1[value] = nil
            bool1 = true
        end
    end

    return bool1
end

local function loadTracker() -- Luacid: Inlined by compiler; 4 call sites recovered
    local tbl1 = readTracker()

    if dropOlderVersions(tbl1) then
        writeTracker(tbl1)
    end

    return tbl1
end

local function recordsForCurrentUser(tbl1)
    local var3 = tbl1[currentVersionKey()]

    if typeof(var3) ~= "table" then
        return {}
    end

    local var4 = var3[currentUserId()]

    if typeof(var4) ~= "table" then
        return {}
    end
    return (decodeRecords(var4))
end

local function readPersistedRecords() -- Luacid: Inlined by compiler; 1 call site recovered
    local func2 = recordsForCurrentUser
    local tbl1 = readTracker()

    if dropOlderVersions(tbl1) then
        writeTracker(tbl1)
    end

    return (func2(tbl1))
end

local function writePersistedRecords(tbl1)
    local tbl2 = loadTracker()
    local str1 = currentVersionKey()

    local tbl3 = ({})
    local var3 = tbl2[str1]
    if typeof(var3) == "table" then
        for value, value2 in var3 do
            if typeof(value) == "string" then
                tbl3[value] = value2
            end
        end
    end
    tbl3[currentUserId()] = tbl1
    tbl2[str1] = tbl3
    writeTracker(tbl2)
end

local function initialize()
    loadTracker()
end

local function snapshot(tbl1) -- Luacid: Inlined by compiler; 2 call sites recovered
    if tbl1 == nil then
        return emptyRecord()
    end

    return {
        count = tbl1.count,
        lastShownAt = tbl1.lastShownAt,
        shownAt = table.clone(tbl1.shownAt)
    }
end

local function retainRecent(shownAt, num1: number, seconds: number) -- Luacid: Inlined by compiler; 1 call site recovered
    local num2 = num1 - seconds
    local result = {}
    for _, value in shownAt do
        if num2 <= value then
            table.insert(result, value)
        end
    end
    return result
end

local function record(arg1, arg2)
    local lastShownAt = now()

    if arg2 == "session" then
        local var3 = table.clone(var1(false))
        local var4 = var3[arg1]
        var3[arg1] = {
            count = (if var4 == nil then 0 else var4.count) + 1,
            lastShownAt = lastShownAt,
            shownAt = {}
        }
        var2(var3)
        return
    end

    local tbl1 = readPersistedRecords()
    local var3 = tbl1[arg1]
    local var4 = var3 == nil and {
        count = 0,
        lastShownAt = 0,
        shownAt = {}
    }
        or {
            count = var3.count,
            lastShownAt = var3.lastShownAt,
            shownAt = table.clone(var3.shownAt)
        }
    var4.count += 1
    var4.lastShownAt = lastShownAt
    if typeof(arg2) == "table" and arg2.kind == "rolling" then
        table.insert(var4.shownAt, lastShownAt)
        var4.shownAt = retainRecent(var4.shownAt, lastShownAt, arg2.seconds)
    end
    tbl1[arg1] = var4
    writePersistedRecords(tbl1)
end

local function getExposure(arg1, arg2)
    if arg2 == "session" then
        return snapshot(var1(false)[arg1])
    end

    return snapshot(recordsForCurrentUser((loadTracker()))[arg1])
end

local function getCount(arg1, arg2)
    local var3

    if arg2 == "session" then
        local var4 = var1(false)[arg1]
        var3 = var4 == nil and {
            count = 0,
            lastShownAt = 0,
            shownAt = {}
        }
            or {
                count = var4.count,
                lastShownAt = var4.lastShownAt,
                shownAt = table.clone(var4.shownAt)
            }
    else
        local var4 = recordsForCurrentUser((loadTracker()))[arg1]

        var3 = var4 == nil and {
            count = 0,
            lastShownAt = 0,
            shownAt = {}
        }
            or {
                count = var4.count,
                lastShownAt = var4.lastShownAt,
                shownAt = table.clone(var4.shownAt)
            }
    end

    if typeof(arg2) ~= "table" or arg2.kind ~= "rolling" then
        return var3.count
    end

    local shownAt = var3.shownAt
    local var4 = now() - arg2.seconds
    local tbl1 = {}
    for _, value in shownAt do
        if var4 <= value then
            table.insert(tbl1, value)
        end
    end
    return #tbl1
end

local function setNowForTesting(func2: ((...any) -> (...any))?) -- Luacid: Inlined by compiler; 1 call site recovered
    func1 = func2 or systemNow
end

local function resetForTesting()
    var2({})
    setNowForTesting(false)
end

local tbl1 = readTracker()

if dropOlderVersions(tbl1) then
    writeTracker(tbl1)
end

return {
    record = record,
    getExposure = getExposure,
    getCount = getCount,
    now = now,
    initialize = initialize,
    setNowForTesting = setNowForTesting,
    resetForTesting = resetForTesting,
    STORAGE_KEY = "NotificationsOrchestratorGlobalTracker"
}
