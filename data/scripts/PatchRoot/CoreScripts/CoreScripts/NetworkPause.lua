-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:31:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local GuiService = game:GetService("GuiService")
local CorePackages = game:GetService("CorePackages")
local TelemetryService = game:GetService("TelemetryService")

local Modules = CoreGui.RobloxGui.Modules

local LocalPlayer = Players.LocalPlayer

while not LocalPlayer do
    wait()
    LocalPlayer = Players.LocalPlayer
end

local NetworkPauseNotification = require(Modules.NetworkPauseNotification)
local Create = require(CorePackages.Workspace.Packages.AppCommonLib).Create

local num1 = game:DefineFastInt("RapidGameplayPauseIntervalMs", 1000)
local num2 = game:DefineFastInt("RapidGameplayPauseMinNotificationDurationMs", 500)
local num3 = game:DefineFastInt("GameplayPauseShowDelayMs", 300)

local config = {
    eventName = "StreamingPauseUISessionStats",
    backends = { "EventIngest" },
    throttlingPercentage = game:DefineFastInt("StreamingPauseUIAnalyticsThrottleHP", 0),
    lastUpdated = { 2026, 6, 2 },
    description = "Session stats for streaming pause UI visibility"
}

local startTime = os.clock()
local num4 = 0
local num5 = 0
local var1 = nil

local var2 = table.freeze({
    UNPAUSED = "unpaused",
    PENDING_SHOW = "pendingShow",
    PAUSED = "paused",
    RAPID_PAUSE_PENDING_DISMISS = "rapidPausePendingDismiss"
})

local bool1 = true
local UNPAUSED = var2.UNPAUSED
local huge = -math.huge
local bool2 = false
local var3 = nil
local var4 = nil

local networkPauseNotification = NetworkPauseNotification.new()

local var5 = Create("ScreenGui")({
    Name = "RobloxNetworkPauseNotification",
    OnTopOfCoreBlur = true,
    DisplayOrder = 8,
    Parent = CoreGui,
    IgnoreGuiInset = false,
    AutoLocalize = false
})

local function reportPauseSessionAnalytics()
    local num6 = num5
    if var1 ~= nil then
        num6 += (os.clock() - var1) * 1000
    end
    TelemetryService:LogEvent(config, {
        customFields = {
            sessionDurationMs = (os.clock() - startTime) * 1000,
            pauseCount = num4,
            totalPauseDurationMs = num6,
            pauseEnabled = var5.Enabled
        }
    })
end

local function setNotificationVisible(focus: boolean) -- Luacid: Inlined by compiler; 2 call sites recovered
    if focus then
        networkPauseNotification:Show()
    else
        networkPauseNotification:Hide()
    end
    RunService:SetRobloxGuiFocused(focus)

    if focus then
        if var1 == nil then
            var1 = os.clock()
            num4 += 1
        end
    elseif var1 ~= nil then
        num5 += (os.clock() - var1) * 1000
        var1 = nil
    end
end

local function cancelTimers() -- Luacid: Inlined by compiler; 1 call site recovered
    if var3 ~= nil then
        task.cancel(var3)
        var3 = nil
    end
    if var4 ~= nil then
        task.cancel(var4)
        var4 = nil
    end
end

local function isRapidRepause(): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return (os.clock() - huge) * 1000 < num1
end

local function enterStage(arg1)
    UNPAUSED = arg1
    cancelTimers()

    if arg1 == var2.UNPAUSED then
        bool2 = false
        setNotificationVisible(false)
        return
    end
    if arg1 == var2.PENDING_SHOW then
        var3 = task.delay(num3 / 1000, function()
            var3 = nil

            if UNPAUSED == var2.PENDING_SHOW and LocalPlayer.GameplayPaused and var5.Enabled then
                enterStage(var2.PAUSED)
            end
        end)

        return
    end

    if arg1 == var2.PAUSED then
        bool2 = not not isRapidRepause()
        setNotificationVisible(true)
        return
    end
    if arg1 ~= var2.RAPID_PAUSE_PENDING_DISMISS then
        return
    end
    var4 = task.delay(num2 / 1000, function()
        var4 = nil
        if UNPAUSED == var2.RAPID_PAUSE_PENDING_DISMISS and not LocalPlayer.GameplayPaused then
            enterStage(var2.UNPAUSED)
        end
    end)
end

local function onGameplayPausedChanged()
    local var6 = LocalPlayer.GameplayPaused and var5.Enabled and not bool1
    bool1 = false

    if var6 then
        if UNPAUSED == var2.RAPID_PAUSE_PENDING_DISMISS or isRapidRepause() then
            enterStage(var2.PAUSED)
            return
        end
        enterStage(var2.PENDING_SHOW)
        return
    end

    if UNPAUSED ~= var2.UNPAUSED then
        huge = os.clock()
    end
    if UNPAUSED == var2.PENDING_SHOW then
        enterStage(var2.UNPAUSED)
    elseif bool2 then
        enterStage(var2.RAPID_PAUSE_PENDING_DISMISS)
    else
        enterStage(var2.UNPAUSED)
    end
end

LocalPlayer:GetPropertyChangedSignal("GameplayPaused"):Connect(onGameplayPausedChanged)

networkPauseNotification:SetParent(var5)

GuiService.NetworkPausedEnabledChanged:Connect(function(enabled: boolean) -- name: enableNotification
    assert(type(enabled) == "boolean", "Specified argument 'enabled' must be of type boolean")
    if enabled == var5.Enabled then
        return
    end

    var5.Enabled = enabled

    if enabled then
        onGameplayPausedChanged()
        return
    end

    enterStage(var2.UNPAUSED)
end)
game.Close:Connect(reportPauseSessionAnalytics)
