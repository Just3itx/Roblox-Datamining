-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:40:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local UserGameSettings = UserSettings():GetService("UserGameSettings")
local SoundService = game:GetService("SoundService")

local Modules = game:GetService("CoreGui"):WaitForChild("RobloxGui"):WaitForChild("Modules")
local GetFFlagEnableSoundSessionTelemetry = require(Modules.Flags.GetFFlagEnableSoundSessionTelemetry)
local GetFIntSoundSessionTelemetryThrottle = require(Modules.Flags.GetFIntSoundSessionTelemetryThrottle)
local engineFeature = game:GetEngineFeature("RbxAnalyticsServiceExposePlaySessionId")

local LoggingProtocol = require(CorePackages.Workspace.Packages.LoggingProtocol)

local default = LoggingProtocol.default

local AggregatedData = require(Modules.AggregatedData)
local PlayingSounds = require(Modules.PlayingSounds)

local tbl1 = {
    eventName = "SoundSessionPlayback",
    backends = { LoggingProtocol.TelemetryBackends.EventIngest },
    throttlingPercentage = GetFIntSoundSessionTelemetryThrottle(),
    lastUpdated = { 23, 13, 6 },
    description = " Aggregated session-end event of all music playback data ",
    links = "https://roblox.atlassian.net/wiki/spaces/MUS/pages/2065826132/Scaled+Analytics+Tech+Spec"
}

local tbl2 = ({})

local aggregatedData = AggregatedData.new()
local playingSounds = PlayingSounds.new(aggregatedData)

local function logSessionEvent()
    local tbl3 = {}
    local tbl4 = {}
    local tbl5 = {}
    for k, value in pairs(aggregatedData) do
        table.insert(tbl3, k)
        table.insert(tbl4, value.loopcount)
        table.insert(tbl5, value.playtime)
    end

    local tbl6 = {
        asset_ids = table.concat(tbl3, ","),
        loop_counts = table.concat(tbl4, ","),
        playback_seconds = table.concat(tbl5, ","),
        placeid = tostring(game.PlaceId),
        sessionid = RbxAnalyticsService:GetSessionId(),
        universeid = tostring(game.GameId)
    }

    if engineFeature then
        tbl6.playsessionid = RbxAnalyticsService:GetPlaySessionId()
    end

    default:logRobloxTelemetryEvent(tbl1, nil, tbl6)
end

local function aggregateEndSessionData()
    for k, sound in pairs(playingSounds.sounds) do
        for k2, _ in pairs(sound.instances) do
            playingSounds:removeSound(k, k2)
        end
    end

    logSessionEvent()
end

local function isAudible(instance: Sound): boolean -- Luacid: Inlined by compiler; 6 call sites recovered
    local masterVolume = UserGameSettings.MasterVolume
    local var1 = if instance.SoundGroup then instance.SoundGroup.Volume else 1
    local volume = instance.Volume

    local rollOffGain = instance.RollOffGain

    return masterVolume * var1 * volume * rollOffGain > 0.01
end

local function onPlayed(instance: Sound) -- Luacid: Inlined by compiler; 2 call sites recovered
    if GetFFlagEnableSoundSessionTelemetry() and isAudible(instance) then
        playingSounds:addSound(instance.SoundId, instance:GetDebugId(10))
    end
end

local function onPaused(sound: Sound) -- Luacid: Inlined by compiler; 1 call site recovered
    if GetFFlagEnableSoundSessionTelemetry() then
        playingSounds:removeSound(sound.SoundId, sound:GetDebugId(10))
    end
end

local function onStopped(sound: Sound) -- Luacid: Inlined by compiler; 1 call site recovered
    if GetFFlagEnableSoundSessionTelemetry() then
        playingSounds:removeSound(sound.SoundId, sound:GetDebugId(10))
    end
end

local function onEnded(sound: Sound) -- Luacid: Inlined by compiler; 1 call site recovered
    if GetFFlagEnableSoundSessionTelemetry() then
        playingSounds:removeSound(sound.SoundId, sound:GetDebugId(10))
    end
end

local function onResumed(sound: Sound) -- Luacid: Inlined by compiler; 1 call site recovered
    if GetFFlagEnableSoundSessionTelemetry() and isAudible(sound) then
        playingSounds:addSound(sound.SoundId, sound:GetDebugId(10))
    end
end

local function onLooped(sound: Sound, _: number) -- Luacid: Inlined by compiler; 1 call site recovered
    if GetFFlagEnableSoundSessionTelemetry() then
        playingSounds:loopSound(sound.SoundId, sound:GetDebugId(10))
    end
end

local function unhookSoundEvents(sound: Sound)
    local var1 = tbl2[sound]
    if var1 ~= nil then
        for _, value in var1 do
            value:Disconnect()
        end
    end
    if GetFFlagEnableSoundSessionTelemetry() then
        playingSounds:removeSound(sound.SoundId, sound:GetDebugId(10))
    end
    tbl2[sound] = nil
end

local function hookupSoundEvents(sound: Sound)
    if sound.Playing and GetFFlagEnableSoundSessionTelemetry() and isAudible(sound) then
        playingSounds:addSound(sound.SoundId, sound:GetDebugId(10))
    end

    local connection = sound.Played:Connect(function()
        if sound.TimeLength ~= 0 and sound.IsLoaded then
            onPlayed(sound)
            return
        end

        local connection = nil
        connection = sound.Loaded:Connect(function()
            onPlayed(sound)
            connection:Disconnect()
        end)
    end)

    local connection2 = sound.Paused:Connect(function()
        onPaused(sound)
    end)

    local connection3 = sound.Stopped:Connect(function()
        onStopped(sound)
    end)

    local connection4 = sound.Ended:Connect(function()
        onEnded(sound)
    end)

    local connection5 = sound.Resumed:Connect(function()
        onResumed(sound)
    end)

    local connection6 = sound.DidLoop:Connect(function(_: string, _: number)
        onLooped(sound, nil)
    end)

    local connection7 = sound.AncestryChanged:Connect(function(child: Instance, _: Instance)
        if child:FindFirstAncestorOfClass("DataModel") == nil then
            unhookSoundEvents(sound)
        end
    end)

    tbl2[sound] = {
        connection,
        connection2,
        connection3,
        connection4,
        connection5,
        connection6,
        connection7
    }
end

if not GetFFlagEnableSoundSessionTelemetry() then
    return
end

if game:GetEngineFeature("AudioInstanceAddedApiEnabled") then
    SoundService.AudioInstanceAdded:Connect(function(instance: Instance)
        if instance:IsA("Sound") and not tbl2[instance] then
            hookupSoundEvents(instance)
        end
    end)
end

game.Close:Connect(function()
    aggregateEndSessionData()
end)
