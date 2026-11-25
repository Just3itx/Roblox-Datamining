-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T02:41:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent

local AppCommonLib = require(scriptParentParent.AppCommonLib)
local SharedFlags = require(scriptParentParent.SharedFlags)
local Signal = AppCommonLib.Signal

local _PlatformLeaderboardTypes = require(scriptParent.PlatformLeaderboardTypes)
local _PlatformLeaderboardFetcher = require(scriptParent.PlatformLeaderboardFetcher)

local num1 = game:DefineFastInt("PlatformLeaderboardConfigPollIntervalSeconds", 300)

local num2 = game:DefineFastInt("PlatformLeaderboardConfigPollMaxJitterSeconds", 60)
local FFlagPlatformLeaderboardDebugLogging = SharedFlags.FFlagPlatformLeaderboardDebugLogging

local module = ({})
module.__index = module

function module.new(_fetcher)
    local self = setmetatable({ _fetcher = _fetcher, _config = nil, _configChanged = Signal.new(), _pollTimer = nil }, module)

    local success, result, result2 = pcall(_fetcher.fetchConfig)
    if success and result then
        self._config = result2
    end

    local var1 = nil
    local function pollLoop()
        while self._pollTimer == var1 do
            local num3 = math.random() * num2
            task.wait(num1 + num3)
            local success2, result3, result2_2 = pcall(self._fetcher.fetchConfig)
            if success2 and result3 then
                self:updateConfig(result2_2)
            end
        end
    end

    var1 = task.defer(function()
        if pcall(pollLoop) or self._pollTimer ~= var1 then
            return
        end

        if FFlagPlatformLeaderboardDebugLogging then
            warn("[PlatformLeaderboard] ConfigService poll loop terminated unexpectedly")
        end
        self._pollTimer = nil
    end)

    self._pollTimer = var1

    return self
end

local function configsEqual(arg1, _config): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    if arg1 == _config then
        return true
    end
    if arg1 == nil or _config == nil then
        return false
    end
    return arg1.leaderboardId == _config.leaderboardId and arg1.unit == _config.unit
end

function module:updateConfig(_config)
    local _config2 = self._config

    if _config2 == _config
        or not configsEqual(nil, _config2)
            and not configsEqual(nil, _config)
            and _config2.leaderboardId == _config.leaderboardId
            and _config2.unit == _config.unit
    then
        return
    end
    local _config3 = self._config
    self._config = _config
    self._configChanged:fire(_config3, self._config)
end

function module:getConfig()
    return self._config
end

function module:hasActiveConfig(): boolean
    return self._config ~= nil
end

function module:onConfigChanged(func1: (...any) -> (...any))
    return self._configChanged:connect(func1)
end

function module:teardown()
    local _pollTimer = self._pollTimer
    self._pollTimer = nil
    if _pollTimer and not pcall(task.cancel, _pollTimer) and FFlagPlatformLeaderboardDebugLogging then
        warn("[PlatformLeaderboard] ConfigService teardown: failed to cancel poll timer")
    end
end

return module
