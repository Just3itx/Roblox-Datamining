-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:41:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local HttpRbxApiService = game:GetService("HttpRbxApiService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ServerStorage = game:GetService("ServerStorage")
local TeleportService = game:GetService("TeleportService")
local CorePackages = game:GetService("CorePackages")
local RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")
local Url = require(CorePackages.Workspace.Packages.CoreScriptsCommon).Url
local Promise = require(CorePackages.Packages.Promise)
local RoCaptchaUtils = require(RobloxGui.Modules.Server.RoCaptcha.RoCaptchaUtils)
local FStringRoCaptchaUniverseIds = require(RobloxGui.Modules.Common.Flags.FStringRoCaptchaUniverseIds)
local bool1 = game:DefineFastFlag("RoCaptchaExperienceValidate", false)

local bool2 = game:DefineFastFlag("RoCaptchaExperienceKick", false) and bool1

if RunService:IsStudio() or not RoCaptchaUtils.isUniverseAllowed(FStringRoCaptchaUniverseIds, game.GameId) then
    return
end

local var1 = Url.APIS_URL .. "rocaptcha-service/v1/challenge/"
local apiUrl = Url.APIS_URL .. "challenge/v1/continue"

local tbl1 = {
    [Enum.TeleportResult.Failure] = true,
    [Enum.TeleportResult.Flooded] = true,
    [Enum.TeleportResult.IsTeleporting] = true
}

local tbl2 = {
    [Enum.TeleportResult.GameEnded] = true,
    [Enum.TeleportResult.GameFull] = true
}

local function postJson(apiUrl2: string, input)
    local input2 = HttpRbxApiService:PostAsyncFullUrl(
        apiUrl2,
        HttpService:JSONEncode(input),
        Enum.ThrottlingPriority.Default,
        Enum.HttpContentType.ApplicationJson
    )
    local var2 = HttpService:JSONDecode(input2)
    if type(var2) ~= "table" then
        error("unexpected response body")
    end
    return var2
end

local function withRetry(str1: string, callback)
    local result = nil
    for i = 1, 3 do
        local success
        success, result = pcall(callback)
        if success then
            return true, result
        end

        warn(string.format("[RoCaptcha] %s failed (attempt %d/%d): %s", str1, i, 3, tostring(result)))
        if i < 3 then
            task.wait(2 ^ (i - 1) * 0.5)
        end
    end
    return false, result
end

local function callValidate(challengeId, userId: number) -- Luacid: Inlined by compiler; 1 call site recovered
    return withRetry("validate", function()
        return (postJson(var1 .. "validate", { challengeId = challengeId, userId = userId, placeId = game.PlaceId }))
    end)
end

local function callVerify(challengeId, solvingUserId: number) -- Luacid: Inlined by compiler; 1 call site recovered
    return withRetry("verify", function()
        return (postJson(var1 .. "verify", { challengeId = challengeId, solvingUserId = solvingUserId, placeId = game.PlaceId }))
    end)
end

local function callGcsContinue(challengeId) -- Luacid: Inlined by compiler; 1 call site recovered
    return withRetry("continue", function()
        return (postJson(apiUrl, { challengeId = challengeId, challengeType = "rocaptcha", challengeMetadata = "" }))
    end)
end

local tbl3 = ({})

local function createSession(player: Player)
    local joinData = player:GetJoinData()
    local var2 = RoCaptchaUtils.parseLaunchData(joinData and joinData.LaunchData)

    if not var2 then
        return nil
    end

    return {
        challengeId = var2.challengeId,
        desiredPlaceId = var2.desiredPlaceId,
        serverInstanceId = var2.serverInstanceId,
        state = "Validating",
        teleportInitRetries = 0,
        teleportStartedAt = nil,
        retryPending = false
    }
end

local function kick(player: Player, str1: string) -- Luacid: Inlined by compiler; 3 call sites recovered
    warn("[RoCaptcha] Kicking player, reason:", str1)
    tbl3[player] = nil
    if player.Parent then
        player:Kick()
    end
end

local tbl4 = ({})

local function reject(player: Player, reason: string, detail) -- Luacid: Inlined by compiler; 3 call sites recovered
    warn("[RoCaptcha] Rejecting player, reason:", reason, detail)
    tbl3[player] = nil

    if not player.Parent then
        return
    end
    tbl4[player] = { reason = reason, detail = detail }
end

local function onPlayerAdded(player: Player)
    local session = createSession(player)
    if not session then
        if bool2 then
            reject(player, "invalid_launch_data", nil)
            return
        end

        kick(player, "invalid_launch_data")
        return
    end
    tbl3[player] = session

    local bool3, var2 = callValidate(session.challengeId, player.UserId)

    if tbl3[player] ~= session then
        return
    end

    if not bool3 then
        warn("[RoCaptcha] validate unavailable - deferring to verify")
        session.state = "Ready"
        return
    end

    if var2.valid == true then
        session.state = "Ready"
        return
    end

    if bool2 then
        reject(player, "validate_failed", var2.failureReason)
        return
    end
    local failureReason = var2.failureReason
    kick(player, "validate_failed:" .. tostring(failureReason))
end

local tbl5 = ({})

local function startValidation(player: Player) -- Luacid: Inlined by compiler; 1 call site recovered
    local var2 = tbl5[player]
    if not var2 then
        var2 = Promise.new(function(callback)
            onPlayerAdded(player)
            local var3 = tbl3[player]
            local var4 = tbl4[player]
            if var3 and var3.state == "Ready" then
                callback({ valid = true })
                return
            end

            if var4 then
                callback({ valid = false, reason = var4.reason, detail = var4.detail })
            else
                callback({ valid = false, reason = "no_session" })
            end
        end)
        tbl5[player] = var2
    end
    return var2
end

local function onPlayerJoined(player: Player)
    if not bool1 then
        onPlayerAdded(player)
        return
    end

    if tbl5[player] then
        return
    end

    tbl5[player] = Promise.new(function(callback)
        onPlayerAdded(player)
        local var2 = tbl3[player]
        local var3 = tbl4[player]
        if var2 and var2.state == "Ready" then
            callback({ valid = true })
            return
        end

        if var3 then
            callback({ valid = false, reason = var3.reason, detail = var3.detail })
        else
            callback({ valid = false, reason = "no_session" })
        end
    end)
end
Players.PlayerAdded:Connect(onPlayerJoined)
for _, player in Players:GetPlayers() do
    task.spawn(onPlayerJoined, player)
end

Players.PlayerRemoving:Connect(function(player: Player)
    tbl3[player] = nil
    tbl5[player] = nil
    tbl4[player] = nil
end)

local function teleportBack(arg1, tbl6): boolean
    tbl6.teleportStartedAt = os.clock()
    local teleportOptions = nil
    local serverInstanceId = tbl6.serverInstanceId
    if serverInstanceId then
        local teleportOptions2 = Instance.new("TeleportOptions")
        teleportOptions2.ServerInstanceId = serverInstanceId
        teleportOptions = teleportOptions2
    end
    local success, result = pcall(function()
        TeleportService:TeleportAsync(tbl6.desiredPlaceId, { arg1 }, teleportOptions)
    end)
    if not success then
        tbl6.teleportStartedAt = nil
        warn("[RoCaptcha] TeleportAsync failed:", result)
    end
    return success
end

local function isTeleporting(tbl6): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    local teleportStartedAt = tbl6.teleportStartedAt
    return not (teleportStartedAt == nil) and os.clock() - teleportStartedAt < 30
end

local function giveUpTeleport(tbl6, str1: string) -- Luacid: Inlined by compiler; 2 call sites recovered
    tbl6.teleportStartedAt = nil
    warn("[RoCaptcha] Teleport back failed, reason:", str1)
end

TeleportService.TeleportInitFailed:Connect(function(player: Instance, teleportResult: Enum.TeleportResult, errorMessage: string)
    if not player:IsA("Player") then
        return
    end

    local var2 = tbl3[player]

    if not var2 or var2.state ~= "Done" or not isTeleporting(var2) or var2.retryPending then
        return
    end

    warn("[RoCaptcha] TeleportInitFailed:", teleportResult, errorMessage)
    local bool3 = not (var2.serverInstanceId == nil) and tbl2[teleportResult] == true

    if bool3 then
        warn("[RoCaptcha] Target server unavailable - falling back to any server:", teleportResult)
        var2.serverInstanceId = nil
    end

    if not (tbl1[teleportResult] or bool3) then
        giveUpTeleport(var2, "teleport_failed:" .. tostring(teleportResult))
        return
    end

    if var2.teleportInitRetries >= 3 then
        giveUpTeleport(var2, "teleport_retries_exhausted:" .. tostring(teleportResult))
        return
    end

    var2.teleportInitRetries += 1
    var2.retryPending = true
    task.wait(2 ^ (var2.teleportInitRetries - 1) * 0.5)
    var2.retryPending = false
    if player.Parent and tbl3[player] == var2 then
        teleportBack(player, var2)
    end
end)

local roCaptchaVerify = Instance.new("BindableFunction")
roCaptchaVerify.Name = "RoCaptchaVerify"

function roCaptchaVerify.OnInvoke(arg1)
    if typeof(arg1) ~= "Instance" or not arg1:IsA("Player") then
        return { success = false, reason = "invalid_player" }
    end

    local var2 = tbl3[arg1]
    if not var2 then
        return { success = false, reason = "no_session" }
    end
    if var2.state == "Validating" then
        return { success = false, reason = "not_validated" }
    elseif var2.state == "Done" then
        return if isTeleporting(var2) then { success = false, reason = "teleport_in_progress" } elseif teleportBack(arg1, var2) then {
            success = true
        } else { success = false, reason = "teleport_error" }
    end
    if var2.state ~= "Ready" then
        return { success = false, reason = "already_in_progress" }
    end

    var2.state = "Verifying"

    local challengeId = var2.challengeId

    local bool3, var3 = callVerify(challengeId, arg1.UserId)
    if not bool3 then
        var2.state = "Ready"
        return { success = false, reason = "verify_error" }
    end
    if var3.verified ~= true then
        if bool2 then
            reject(arg1, "verify_failed", var3.failureReason)
        else
            local failureReason = var3.failureReason
            kick(arg1, "verify_failed:" .. tostring(failureReason))
        end
        return {
            success = false,
            reason = "verify_failed",
            detail = var3.failureReason
        }
    end

    if not callGcsContinue(challengeId) then
        warn("[RoCaptcha] continue failed - teleporting anyway")
    end

    var2.state = "Done"

    return if arg1.Parent then if teleportBack(arg1, var2) then { success = true } else {
        success = false,
        reason = "teleport_error"
    } else { success = true }
end

roCaptchaVerify.Parent = ServerStorage

if not bool1 then
    return
end

local roCaptchaValidate = Instance.new("BindableFunction")
roCaptchaValidate.Name = "RoCaptchaValidate"

function roCaptchaValidate.OnInvoke(arg1)
    if typeof(arg1) ~= "Instance" or not arg1:IsA("Player") then
        return { valid = false, reason = "invalid_player" }
    end

    if not arg1.Parent then
        return { valid = false, reason = "no_session" }
    end

    local var2, var3 = startValidation(arg1):await()
    return if var2 then var3 else { valid = false, reason = "no_session" }
end

roCaptchaValidate.Parent = ServerStorage
