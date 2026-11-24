-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T10:01:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local MemStorageService = game:GetService("MemStorageService")

local scriptParent = script.Parent
local getGameLaunchPlaceId = require(scriptParent.getGameLaunchPlaceId)
local parseNotificationTypes = require(scriptParent.parseNotificationTypes)

local module = {}
module.__index = module

local function toJoinIntent(arg1): {chatTarget: number, createdAt: number, notificationId: number, notificationType: any, placeId: number, source: any, version: number}?
    if type(arg1) ~= "table" then
        return nil
    end

    if arg1.version ~= 1
        or type(arg1.source) ~= "string"
        or type(arg1.notificationType) ~= "string"
        or type(arg1.placeId) ~= "number"
        or type(arg1.createdAt) ~= "number"
    then
        return nil
    end
    local notificationId = arg1.notificationId
    local chatTarget = arg1.chatTarget
    local tbl1 = {
        version = 1,
        source = arg1.source,
        notificationType = arg1.notificationType,
        notificationId = 0,
        chatTarget = 0,
        placeId = 0,
        createdAt = 0
    }

    if type(notificationId) ~= "string" then
        notificationId = nil
    end

    tbl1.notificationId = notificationId
    if type(chatTarget) ~= "string" then
        chatTarget = nil
    end

    tbl1.chatTarget = chatTarget
    tbl1.placeId = arg1.placeId
    tbl1.createdAt = arg1.createdAt
    return tbl1
end

function module.new(tbl1)
    return (setmetatable(
        {
            notificationTypes = parseNotificationTypes(tbl1.notificationTypes),
            now = tbl1.now or os.time,
            cachedRead = nil
        },
        module
    ))
end

function module:handleDeeplinkTap(tbl1)
    local notificationType = tbl1.notificationType
    if notificationType == nil then
        return
    end
    local var1 = self.notificationTypes[notificationType]
    if var1 == nil then
        return
    end
    local placeId = getGameLaunchPlaceId(tbl1.url)
    if placeId == nil then
        return
    end
    local input = {
        version = 1,
        source = tbl1.source,
        notificationType = notificationType,
        notificationId = tbl1.notificationId,
        chatTarget = var1.chatTarget,
        placeId = placeId,
        createdAt = self.now()
    }
    MemStorageService:SetItem("ExpChatJoinIntent", HttpService:JSONEncode(input))
end

function module:read(placeId: number)
    local cachedRead = self.cachedRead
    if cachedRead then
        return cachedRead
    end

    local item = MemStorageService:GetItem("ExpChatJoinIntent")
    local var1

    if item == "" then
        var1 = { result = "none" }
    else
        MemStorageService:SetItem("ExpChatJoinIntent", "")
        local success, result = pcall(HttpService.JSONDecode, HttpService, item)
        local intent = if success then toJoinIntent(result) else nil
        var1 = intent == nil and { result = "invalid" }
            or self.now() - intent.createdAt > 300 and { result = "expired", intent = intent }
            or intent.placeId == placeId and { result = "accepted", intent = intent }
            or { result = "placeMismatch", intent = intent }
    end

    self.cachedRead = var1
    return var1
end

function module:getIntent()
    local cachedRead = self.cachedRead
    return if cachedRead and cachedRead.result == "accepted" then cachedRead.intent else nil
end

return module
