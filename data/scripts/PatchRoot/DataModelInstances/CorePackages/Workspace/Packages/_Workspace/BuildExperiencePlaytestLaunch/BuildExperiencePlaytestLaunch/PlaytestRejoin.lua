-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T22:04:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperiencePlaytestLaunchParent = script:FindFirstAncestor("BuildExperiencePlaytestLaunch").Parent

local HttpService = game:GetService("HttpService")
local MemStorageService = game:GetService("MemStorageService")
local MessageBusService = game:GetService("MessageBusService")

local Logger = require(BuildExperiencePlaytestLaunchParent.Loggers).Logger
local launchExperience = require(script.Parent.launchExperience)

local num1 = game:DefineFastInt("BuildExperiencePlaytestRejoinDelayMs", 250)

local num2 = game:DefineFastInt("BuildExperiencePlaytestRejoinExpiryMs", 60000)

local messageId = MessageBusService:GetMessageId("Game", "onGameLeave")

local function now(): number -- Luacid: Inlined by compiler; 2 call sites recovered
    return DateTime.now().UnixTimestampMillis
end

local function takeIntent()
    local item = MemStorageService:GetItem("BuildExperiencePlaytestRejoin")
    if item == nil or item == "" then
        return nil
    end
    MemStorageService:SetItem("BuildExperiencePlaytestRejoin", "")
    local success, result = pcall(HttpService.JSONDecode, HttpService, item)
    if not success
        or type(result) ~= "table"
        or type(result.placeId) ~= "number"
        or type(result.source) ~= "string"
        or type(result.createdAt) ~= "number"
    then
        return nil
    end

    local var1 = now() - result.createdAt
    if not (var1 < 0 or num2 < var1) then
        return result
    end

    Logger:warning("PlaytestRejoin: dropped a Playtest request that expired after {} ms", var1)
    return nil
end

local module = {}

function module.request(placeId: number, source: string, isTeamTest: boolean?, isEarlyTesting: boolean?)
    local input = {
        placeId = placeId,
        source = source,
        isTeamTest = isTeamTest,
        isEarlyTesting = isEarlyTesting,
        createdAt = now()
    }
    MemStorageService:SetItem("BuildExperiencePlaytestRejoin", HttpService:JSONEncode(input))
end

function module.resume(num3: number?): boolean
    local var1 = takeIntent()
    if var1 == nil then
        return false
    end

    local num4 = num3 or num1
    if num4 > 0 then
        task.delay(num4 / 1000, function()
            launchExperience(var1.placeId, var1.source, var1.isTeamTest, nil, var1.isEarlyTesting)
        end)
    else
        launchExperience(var1.placeId, var1.source, var1.isTeamTest, nil, var1.isEarlyTesting)
    end
    return true
end

function module.listen()
    module.resume()
    local var1 = MessageBusService:Subscribe(messageId, function()
        module.resume()
    end, false, false)
    return function()
        var1:Disconnect()
    end
end

return module
