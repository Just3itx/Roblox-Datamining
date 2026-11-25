-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T02:41:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local scriptParentParent = script.Parent.Parent
local HttpRequest = require(scriptParentParent.HttpRequest)
local SharedFlags = require(scriptParentParent.SharedFlags)
local Url = require(scriptParentParent.CoreScriptsCommon).Url

local scriptParent = script.Parent
local PlatformLeaderboardTypes = require(scriptParent.PlatformLeaderboardTypes)

local str1 = `{Url.APIS_URL .. "platform-leaderboards-api"}/v1/rcc/universes/{game.GameId}/leaderboard`
local LeaderboardType = PlatformLeaderboardTypes.LeaderboardType
local maxRetryCount = game:DefineFastInt("PlatformLeaderboardFetcherHttpRetryCount", 0)
local num2 = game:DefineFastInt("PlatformLeaderboardFetcherDefaultCount", 100)
local bool1 = game:DefineFastFlag("PlatformLeaderboardDisplayNameEnabled", false)

local bool2 = game:DefineFastFlag("PlatformLeaderboardBadgeMetadataEnabled", false)
local FFlagPlatformLeaderboardDebugLogging = SharedFlags.FFlagPlatformLeaderboardDebugLogging

local var1 = HttpRequest.config({ requestFunction = HttpRequest.requestFunctions.HttpRbxApi, maxRetryCount = maxRetryCount })

local function get(str2: string)
    local success, result, result2 = pcall(function()
        return var1(str2, "GET"):await()
    end)
    if not (success and result) then
        if FFlagPlatformLeaderboardDebugLogging then
            warn("[PlatformLeaderboard] Fetcher request failed")
        end
        return false, nil
    end
    if typeof(result2) ~= "table" then
        if FFlagPlatformLeaderboardDebugLogging then
            warn("[PlatformLeaderboard] Fetcher received malformed response")
        end
        return false, nil
    end
    local var2 = result2.Body or result2.responseBody
    if typeof(var2) ~= "string" then
        return true, var2
    end

    local success2, result3 = pcall(HttpService.JSONDecode, HttpService, var2)
    if success2 then
        return true, result3
    end
    if FFlagPlatformLeaderboardDebugLogging then
        warn("[PlatformLeaderboard] Fetcher: JSON decode failed:", tostring(result3))
    end
    return false, nil
end

local function formatEntry(arg1)
    if typeof(arg1) ~= "table" then
        return nil
    end

    local userId = arg1.userId
    local score = arg1.score
    if userId == nil or score == nil then
        return nil
    end

    local var2 = tonumber(userId)
    local var3 = tonumber(score)
    if var2 == nil or var3 == nil then
        return nil
    end

    local rank = arg1.rank
    local var4 = if rank == nil then nil else tonumber(rank)
    local displayName = if bool1 and typeof(arg1.displayName) == "string" then arg1.displayName else nil
    local isVerified, hasRobloxSubscription

    if bool2 then
        if typeof(arg1.isVerified) == "boolean" then
            isVerified = arg1.isVerified
        else
            isVerified = nil
        end

        if typeof(arg1.hasRobloxSubscription) == "boolean" then
            hasRobloxSubscription = arg1.hasRobloxSubscription
        else
            hasRobloxSubscription = nil
        end
    else
        isVerified = nil
        hasRobloxSubscription = nil
    end

    return {
        userId = var2,
        score = var3,
        rank = var4,
        displayName = displayName,
        isVerified = isVerified,
        hasRobloxSubscription = hasRobloxSubscription
    }
end

local function formatEntries(tbl1)
    local result = {}
    for _, value in tbl1 do
        local var2 = formatEntry(value)
        if var2 ~= nil then
            table.insert(result, var2)
        end
    end
    return result
end

local function formatConfig(config)
    if config == nil or config.leaderboardId == nil then
        return nil
    end
    local leaderboardId = config.leaderboardId
    if typeof(leaderboardId) ~= "string" then
        return nil
    end
    local unit = config.unit
    return {
        leaderboardId = leaderboardId,
        unit = if typeof(unit) ~= "string" then "" else unit
    }
end

local module = {}

function module.fetchConfig()
    local str2 = `{str1}/config`
    local bool3, var2 = get(str2)
    if not bool3 then
        return false, nil
    end
    if typeof(var2) ~= "table" then
        if FFlagPlatformLeaderboardDebugLogging then
            warn("[PlatformLeaderboard] Fetcher received malformed config response body")
        end
        return false, nil
    end

    local config = var2.config
    if config == nil or typeof(config) == "table" then
        return true, (formatConfig(config))
    end

    if FFlagPlatformLeaderboardDebugLogging then
        warn("[PlatformLeaderboard] Fetcher received malformed config payload")
    end
    return false, nil
end

local function fetchLeaderboard(_: string, arg1, num3: number?, num4: number?)
    local num5 = num4 or num2
    local var2

    if arg1 == LeaderboardType.Global then
        var2 = `{str1}/global?count={num5}`
    else
        if arg1 ~= LeaderboardType.Friends or num3 == nil then
            if FFlagPlatformLeaderboardDebugLogging then
                warn("[PlatformLeaderboard] Fetcher missing userId for friends leaderboard")
            end
            return false, nil
        end

        var2 = `{str1}/friends?userid={num3}&count={num5}`
    end
    local bool3, var3 = get(var2)
    if not bool3 then
        return false, nil
    end
    if typeof(var3) ~= "table" then
        if FFlagPlatformLeaderboardDebugLogging then
            warn("[PlatformLeaderboard] Fetcher received malformed leaderboard response body")
        end
        return false, nil
    end

    local config = var3.config
    if config ~= nil and typeof(config) ~= "table" then
        if FFlagPlatformLeaderboardDebugLogging then
            warn("[PlatformLeaderboard] Fetcher received malformed leaderboard config payload")
        end
        return false, nil
    end
    local scores = var3.scores
    if scores == nil or typeof(scores) == "table" then
        return true, {
            config = formatConfig(config),
            entries = formatEntries(scores or {})
        }
    end

    if FFlagPlatformLeaderboardDebugLogging then
        warn("[PlatformLeaderboard] Fetcher received malformed leaderboard scores payload")
    end
    return false, nil
end

function module.fetchGlobalLeaderboard(str2: string, num3: number?)
    return fetchLeaderboard(str2, LeaderboardType.Global, nil, num3)
end

function module.fetchFriendsLeaderboard(str2: string, num3: number, num4: number?)
    return fetchLeaderboard(str2, LeaderboardType.Friends, num3, num4)
end

function module.fetchUserScore(_: string, num3: number)
    local str2 = `{str1}/{num3}/score`
    local bool3, var2 = get(str2)
    if not bool3 then
        return false, nil
    elseif typeof(var2) ~= "table" then
        if FFlagPlatformLeaderboardDebugLogging then
            warn("[PlatformLeaderboard] Fetcher received malformed user score response body")
        end
        return false, nil
    else
        local userScore = var2.userScore
        if userScore ~= nil and typeof(userScore) ~= "table" then
            if FFlagPlatformLeaderboardDebugLogging then
                warn("[PlatformLeaderboard] Fetcher received malformed user score payload")
            end
            return false, nil
        elseif not userScore then
            return true, nil
        else
            return true, (formatEntry(userScore))
        end
    end
end

return module
