-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T21:11:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local function getDeepLink(arg1)
    if typeof(arg1) ~= "table" or typeof(arg1.type) ~= "string" or string.lower(arg1.type) ~= "ads" then
        return nil
    end
    local universeId = arg1.universeId
    local var1 = if typeof(universeId) == "number" or typeof(universeId) == "string" then tonumber(universeId) else nil

    if var1 == nil or var1 <= 0 or var1 % 1 ~= 0 then
        return nil
    end
    return `roblox://navigation/build?universeId={var1}&type=ads`
end

return {
    NotificationType = "BuildAdsCampaign",
    EventName = "BuildAdsCampaign",
    getDeepLink = getDeepLink,
    connect = function(arg1, callback: (...any) -> (...any), callback2: (...any) -> (...any))
        return arg1:RegisterCallback(arg1.ToastEvents.UserAction, "BuildAdsCampaign", function(arg2)
            if typeof(arg2) ~= "table"
                or arg2.userActionType ~= "click"
                or typeof(arg2.visualItem) ~= "table"
                or arg2.visualItem.eventName ~= "BuildAdsCampaign"
                or typeof(arg2.visualItem.actionEventParams) ~= "string"
                or typeof(arg2.notificationData) ~= "table"
                or typeof(arg2.notificationData.id) ~= "string"
            then
                return
            end
            local success, result = pcall(HttpService.JSONDecode, HttpService, arg2.visualItem.actionEventParams)
            local deepLink = if success then getDeepLink(result) else nil

            if deepLink ~= nil then
                callback2(arg2.notificationData.id)
                callback(deepLink)
            end
        end)
    end
}
