-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:21:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local CorePackages = game:GetService("CorePackages")
local RobloxGui = CoreGui:WaitForChild("RobloxGui")
local default = require(CorePackages.Workspace.Packages.LoggingProtocol).default

local RbxAnalyticsService = game:GetService("RbxAnalyticsService")

local FaceAnimatorService = game:GetService("FaceAnimatorService")

local GetFIntFacialAnimationStreamingHeartbeatStatsIntervalSec = require(RobloxGui.Modules.Flags.GetFIntFacialAnimationStreamingHeartbeatStatsIntervalSec)

local engineFeature = game:GetEngineFeature("RbxAnalyticsServiceExposePlaySessionId")

local AvatarChatHeartbeatStats = require(script.Parent.RobloxTelemetryConfigs.AvatarChatHeartbeatStats)

local module = {}

local bool1 = false

local tbl1 = { None = 0, AudioOnly = 1, VideoOnly = 2, AudioVideo = 3 }

local None = tbl1.None
local tbl2 = ({})
local var1 = nil

local tbl3 = ({})

local function updateTrackingTimes() -- Luacid: Inlined by compiler; 5 call sites recovered
    local now = os.clock()

    if var1 then
        local var2 = now - var1
        local tbl4 = tbl2
        local num1 = None
        tbl4[num1] += var2
    end
    var1 = now
end

local function reportHeartbeat()
    local tbl4 = {
        pid = tostring(game.PlaceId),
        sessionid = RbxAnalyticsService:GetSessionId(),
        userid = tostring(Players.LocalPlayer.UserId),
        universeid = tostring(game.GameId)
    }

    if engineFeature then
        tbl4.playSessionId = RbxAnalyticsService:GetPlaySessionId()
    end

    tbl4.trackingMode = None
    updateTrackingTimes()

    for value, value2 in tbl2 do
        tbl4[tostring(value)] = value2
        tbl2[value] = 0
    end

    default:logRobloxTelemetryEvent(AvatarChatHeartbeatStats, nil, tbl4)
end

local function startHeartbeat() -- Luacid: Inlined by compiler; 1 call site recovered
    local fIntFacialAnimationStreamingHeartbeatStatsIntervalSec = GetFIntFacialAnimationStreamingHeartbeatStatsIntervalSec()
    if not (fIntFacialAnimationStreamingHeartbeatStatsIntervalSec > 0) or bool1 then
        return
    end

    bool1 = true
    task.spawn(function()
        while bool1 do
            reportHeartbeat()
            task.wait(fIntFacialAnimationStreamingHeartbeatStatsIntervalSec)
        end
        bool1 = false
    end)
end

local function updateTrackingMode() -- Luacid: Inlined by compiler; 3 call sites recovered
    updateTrackingTimes()

    if FaceAnimatorService.VideoAnimationEnabled and FaceAnimatorService.AudioAnimationEnabled then
        None = tbl1.AudioVideo
    elseif FaceAnimatorService.VideoAnimationEnabled then
        None = tbl1.VideoOnly
    elseif FaceAnimatorService.AudioAnimationEnabled then
        None = tbl1.AudioOnly
    else
        None = tbl1.None
    end
end

function module.Initialize()
    if GetFIntFacialAnimationStreamingHeartbeatStatsIntervalSec() <= 0 then
        return
    end

    for _, value in tbl1 do
        tbl2[value] = 0
    end

    tbl3.videoAnimationEnabled = FaceAnimatorService:GetPropertyChangedSignal("VideoAnimationEnabled"):Connect(function()
        updateTrackingMode()
    end)

    tbl3.audioAnimationEnabled = FaceAnimatorService:GetPropertyChangedSignal("AudioAnimationEnabled"):Connect(function()
        updateTrackingMode()
    end)

    updateTrackingMode()
    startHeartbeat()
end

function module.Cleanup()
    if GetFIntFacialAnimationStreamingHeartbeatStatsIntervalSec() <= 0 then
        return
    end

    for _, value in pairs(tbl3) do
        if value then
            value:Disconnect()
        end
    end

    table.clear(tbl3)

    bool1 = false
end

return module
