-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:01:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}
module.__index = module

local function pcallOrWarn(str1: string, callback: (...any) -> (...any), ...)
    local success, result = pcall(callback, ...)
    if not success then
        warn(`TopicSource: {str1} failed: {result}`)
    end
end

local function connectIfPresent(tbl1, _notificationService, str1: string, func1: (...any) -> (...any)) -- Luacid: Inlined by compiler; 2 call sites recovered
    local success, result = pcall(function()
        return _notificationService[str1]
    end)
    if success and result then
        table.insert(tbl1, result:Connect(func1))
    end
end

local function isTokenExpiry(arg1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return type(arg1) == "table"
        and type(arg1.token) == "string"
        and type(arg1.shouldExchange) == "boolean"
        and type(arg1.isSubscribable) == "boolean"
end

local function isSubscriptionError(arg1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return type(arg1) == "table"
        and type(arg1.token) == "string"
        and type(arg1.errorCode) == "string"
        and type(arg1.shouldRetry) == "boolean"
end

function module.new(_notificationService)
    return (setmetatable({ _notificationService = _notificationService, _connections = nil }, module))
end

function module:subscribe(str1: string, str2: string?)
    local _notificationService = self._notificationService

    pcallOrWarn("SubscribeToTopic", function()
        _notificationService:SubscribeToTopic(str1, str2 or "")
    end)
end

function module:unsubscribe(str1: string)
    local _notificationService = self._notificationService
    pcallOrWarn("UnsubscribeFromTopic", function()
        _notificationService:UnsubscribeFromTopic(str1)
    end)
end

function module:startListening(tbl1)
    if self._connections then
        return
    end
    local onNotification = tbl1.onNotification
    local onConnected = tbl1.onConnected
    local onTokenExpiry = tbl1.onTokenExpiry
    local onSubscriptionError = tbl1.onSubscriptionError
    local _notificationService = self._notificationService
    local _connections = {
        _notificationService.TopicNotificationReceived:Connect(function(arg1)
            if type(arg1) == "table" and type(arg1.topicId) == "string" then
                local var1 = if type(arg1.detail) ~= "string" then "" else arg1.detail
                pcallOrWarn("onNotification", onNotification, arg1.topicId, var1)
            end
        end),
        _notificationService.RobloxConnectionChanged:Connect(function(connectionName: string, connectionState: Enum.ConnectionState)
            if connectionName == "signalR" and connectionState == Enum.ConnectionState.Connected then
                pcallOrWarn("onConnected", onConnected)
            end
        end)
    }
    self._connections = _connections
    if onTokenExpiry then
        connectIfPresent(_connections, _notificationService, "TopicTokenExpiry", function(arg1)
            local bool1 = isTokenExpiry(arg1)

            if bool1 then
                pcallOrWarn(
                    "onTokenExpiry",
                    onTokenExpiry,
                    arg1.token,
                    arg1.shouldExchange,
                    arg1.isSubscribable,
                    arg1.subscriptionActive == true
                )
            end
        end)
    end
    if not onSubscriptionError then
        return
    end

    connectIfPresent(_connections, _notificationService, "TopicSubscriptionError", function(arg1)
        local bool1 = isSubscriptionError(arg1)

        if bool1 then
            pcallOrWarn("onSubscriptionError", onSubscriptionError, arg1.token, arg1.errorCode, arg1.shouldRetry)
        end
    end)
end

function module:stopListening()
    local _connections = self._connections
    if _connections == nil then
        return
    end
    self._connections = nil
    for _, _connection in _connections do
        _connection:Disconnect()
    end
end

return module
