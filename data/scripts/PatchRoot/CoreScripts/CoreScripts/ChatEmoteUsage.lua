-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:30:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local _CorePackages = game:GetService("CorePackages")
local Players = game:GetService("Players")
local Stats = game:GetService("Stats")
local CoreGui = game:GetService("CoreGui")

local Constants = require(CoreGui.RobloxGui.Modules.EmotesMenu.Constants)

local MaybeSendEmoteFailureAnalyticsFromPlayer = require(CoreGui.RobloxGui.Modules.EmotesMenu.Utility.MaybeSendEmoteFailureAnalyticsFromPlayer)

while Players.LocalPlayer == nil do
    wait()
end

local LocalPlayer = Players.LocalPlayer

local function reportEmoteUsed(tbl1)
    local rbxAnalyticsService = RbxAnalyticsService
    local target = "client"
    local eventContext = "chat"
    local eventName = "emoteTriggered"
    local additionalArgs = {
        pid = tostring(game.PlaceId),
        uid = tostring(LocalPlayer.UserId),
        btid = Stats:GetBrowserTrackerId(),
        assetID = if tbl1.AssetId then tostring(tbl1.AssetId) else nil,
        slotNumber = if tbl1.Slot then tostring(tbl1.Slot) else nil
    }
    rbxAnalyticsService:SetRBXEventStream(target, eventContext, eventName, additionalArgs)
end

local function reportEmoteFailed(errorType: string, tbl1)
    local rbxAnalyticsService = RbxAnalyticsService
    local target = "client"
    local eventContext = "chat"
    local eventName = "emoteTriggerFailed"
    local additionalArgs = {
        pid = tostring(game.PlaceId),
        uid = tostring(LocalPlayer.UserId),
        btid = Stats:GetBrowserTrackerId(),
        assetID = if tbl1 and tbl1.AssetId then tostring(tbl1.AssetId) else nil,
        slotNumber = if tbl1 and tbl1.Slot then tostring(tbl1.Slot) else nil,
        errorType = errorType,
        invokedByCoreGui = false
    }
    rbxAnalyticsService:SendEventDeferred(target, eventContext, eventName, additionalArgs)
end

local function getHumanoidFromPlayer(player: Player) -- Luacid: Inlined by compiler; 3 call sites recovered
    local character = player.Character
    if character then
        return character:FindFirstChildOfClass("Humanoid")
    end

    return nil
end

local function getHumanoidDescriptionFromPlayer(player: Player) -- Luacid: Inlined by compiler; 1 call site recovered
    local humanoidFromPlayer = getHumanoidFromPlayer(player)

    if humanoidFromPlayer then
        return humanoidFromPlayer:FindFirstChildOfClass("HumanoidDescription")
    end

    return nil
end

local function getEmoteFromMessage(message: string) -- Luacid: Inlined by compiler; 1 call site recovered
    if string.sub(message, 1, 3) == "/e " then
        return string.sub(message, 4):lower()
    elseif string.sub(message, 1, 7) == "/emote " then
        return string.sub(message, 8):lower()
    end

    return nil
end

local function getEquippedEmoteFromSlot(arg1, slot: number) -- Luacid: Inlined by compiler; 2 call sites recovered
    local equippedEmotes = arg1:GetEquippedEmotes()
    for _, value in ipairs(equippedEmotes) do
        if value.Slot == slot then
            return value
        end
    end

    return nil
end

local function getEmoteFromEquippedEmote(arg1, equippedEmoteFromSlot)
    local emotes = arg1:GetEmotes()
    for k, value in pairs(emotes) do
        if string.lower(equippedEmoteFromSlot.Name) ~= string.lower(k) then
            continue
        end

        return {
            Name = k,
            Slot = equippedEmoteFromSlot.Slot,
            AssetId = value[1]
        }
    end

    return nil
end

local function getEmoteFromName(arg1, str1: string)
    local emotes = arg1:GetEmotes()
    for k, value in pairs(emotes) do
        if string.lower(str1) ~= string.lower(k) then
            continue
        end

        return {
            Name = k,
            Slot = nil,
            AssetId = value[1]
        }
    end

    return nil
end

local function getEmoteUsed(arg1, str1: string) -- Luacid: unused: defined but never referenced
    local var1 = tonumber(str1)
    if not var1 then
        return (getEmoteFromName(arg1, str1))
    end

    local equippedEmoteFromSlot = getEquippedEmoteFromSlot(arg1, var1)

    if equippedEmoteFromSlot then
        return (getEmoteFromEquippedEmote(arg1, equippedEmoteFromSlot))
    end

    return nil
end

local tbl1 = {
    wave = { R6 = 128777973, R15 = 507770239 },
    point = { R6 = 128853357, R15 = 507770453 },
    dance = { R6 = 182435998, R15 = 507771019 },
    dance2 = { R6 = 182436842, R15 = 507776043 },
    dance3 = { R6 = 182436935, R15 = 507777268 },
    laugh = { R6 = 129423131, R15 = 507770818 },
    cheer = { R6 = 129423030, R15 = 507770677 }
}

local function getLegacyEmoteUsed(arg1, str1: string, tbl2) -- Luacid: unused: defined but never referenced
    return {
        Name = str1,
        Slot = nil,
        AssetId = if arg1.RigType == Enum.HumanoidRigType.R15 then tbl2.R15 else tbl2.R6
    }
end

LocalPlayer.Chatted:Connect(function(message: string, _player: Player)
    local emoteFromMessage = getEmoteFromMessage(message)

    if not emoteFromMessage then
        return
    end

    local var1 = nil

    local var2 = tbl1[emoteFromMessage]
    if var2 then
        local humanoidFromPlayer = getHumanoidFromPlayer(LocalPlayer)
        if humanoidFromPlayer then
            local bool1 = humanoidFromPlayer.RigType == Enum.HumanoidRigType.R15
            var1 = { Name = emoteFromMessage, Slot = nil, AssetId = 0 }
            local assetId = if bool1 then var2.R15 else var2.R6
            var1.AssetId = assetId
        end
    else
        local humanoidDescriptionFromPlayer = getHumanoidDescriptionFromPlayer(LocalPlayer)
        if humanoidDescriptionFromPlayer then
            local var3 = tonumber(emoteFromMessage)
            if var3 then
                local equippedEmoteFromSlot = getEquippedEmoteFromSlot(humanoidDescriptionFromPlayer, var3)

                if equippedEmoteFromSlot then
                    var1 = getEmoteFromEquippedEmote(humanoidDescriptionFromPlayer, equippedEmoteFromSlot)
                else
                    var1 = nil
                end
            else
                var1 = getEmoteFromName(humanoidDescriptionFromPlayer, emoteFromMessage)
            end
        end
    end

    if var1 then
        reportEmoteUsed(var1)
        MaybeSendEmoteFailureAnalyticsFromPlayer(LocalPlayer, function(errorType)
            reportEmoteFailed(errorType, var1)
        end)

        return
    end

    local noMatchingEmote = Constants.ErrorTypes.NoMatchingEmote
    RbxAnalyticsService:SendEventDeferred("client", "chat", "emoteTriggerFailed", {
        pid = tostring(game.PlaceId),
        uid = tostring(LocalPlayer.UserId),
        btid = Stats:GetBrowserTrackerId(),
        assetID = nil,
        slotNumber = nil,
        errorType = noMatchingEmote,
        invokedByCoreGui = false
    })
end)
