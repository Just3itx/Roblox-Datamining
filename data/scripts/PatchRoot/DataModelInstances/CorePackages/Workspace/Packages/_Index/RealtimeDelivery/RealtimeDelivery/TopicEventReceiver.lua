-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:01:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local RealtimeDelivery = script:FindFirstAncestor("RealtimeDelivery")
local HttpClient = require(RealtimeDelivery.Parent.HttpClient)
local UrlBase = require(RealtimeDelivery.Parent.UrlBuilder).UrlBase

local _RealtimeTypes = require(script.Parent.RealtimeTypes)
local TopicSource = require(script.Parent.TopicSource)

local var1 = table.freeze({ maxRetries = 3, firstDelaySeconds = 1 })

local function getRetryDelaySeconds(num1: number) -- Luacid: Inlined by compiler; 1 call site recovered
    return var1.firstDelaySeconds * 2 ^ (num1 - 1) * (0.5 + math.random() / 2)
end

local function cancelPendingRetry(tbl1) -- Luacid: Inlined by compiler; 5 call sites recovered
    if tbl1.retryThread then
        task.cancel(tbl1.retryThread)
        tbl1.retryThread = nil
    end
end

local module = {}
module.__index = module

local tbl1 = {
    disconnect = function() end
}

local function getTopicId(str1: string) -- Luacid: Inlined by compiler; 2 call sites recovered
    if type(str1) ~= "string" then
        return nil
    end
    local var2 = string.match(str1, "^([^%.]+)%.")
    return if var2 == nil or string.find(var2, "!", 1, true) == nil then nil else var2
end

local function decodeDetail(str1: string) -- Luacid: Inlined by compiler; 1 call site recovered
    if str1 == "" then
        return {}
    end
    local success, result = pcall(HttpService.JSONDecode, HttpService, str1)
    return if success then result else nil
end

local function requestExchange(token: string, network)
    return HttpClient.asPromise(
        HttpClient.fetch({
            method = "POST",
            url = UrlBase.APIS .. "/topic-token-exchange-service/v1/exchange",
            body = { token = token },
            analyticsKey = "RealtimeDelivery.TopicTokenExchange",
            network = network,
            decode = function<T>(arg1: T): T
                return arg1
            end
        })
    )
end

local function callObserver(str1: string, tbl2, tbl3) -- Luacid: Inlined by compiler; 1 call site recovered
    local success, result = pcall(tbl2.callback, tbl3)
    if not success then
        warn(`TopicEventReceiver: a callback for {str1} failed: {result}`)
    end
end

local function callErrorHandler(str1: string, tbl2, arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    local onError = tbl2.onError
    if onError == nil then
        return
    end
    local success, result = pcall(onError, arg1)
    if not success then
        warn(`TopicEventReceiver: an error handler for {str1} failed: {result}`)
    end
end

function module.new(arg1, tbl2)
    return (setmetatable({ _source = TopicSource.new(arg1), _topics = {}, _network = if tbl2 then tbl2.network else nil }, module))
end

function module:observeTopic(str1: string, callback: (...any) -> (...any), arg1)
    assert(type(callback) == "function", "Expected a topic callback")
    local topicId = getTopicId(str1)

    if topicId == nil then
        warn("TopicEventReceiver: ignoring a malformed topic token")
        return tbl1
    end

    if next(self._topics) == nil then
        self:_startListening()
    end
    local var2, var3 = self:_trackToken(topicId, str1)
    local tbl2 = {
        callback = callback,
        onError = if arg1 then arg1.onError else nil
    }
    table.insert(var2.observers, tbl2)
    cancelPendingRetry(var2)
    self._source:subscribe(var2.token, var3)

    return {
        disconnect = function()
            self:_removeObserver(topicId, var2, tbl2)
        end
    }
end

function module:_startListening()
    self._source:startListening({
        onNotification = function(arg1, arg2)
            self:_dispatch(arg1, arg2)
        end,
        onConnected = function()
            self:_resubscribeAll()
        end,
        onTokenExpiry = function(arg1, arg2, arg3, arg4)
            self:_onTokenExpiry(arg1, arg2, arg3, arg4)
        end,
        onSubscriptionError = function(arg1, arg2, arg3)
            self:_onSubscriptionError(arg1, arg2, arg3)
        end
    })
end

function module:_trackToken(str1: string, token: string)
    local _topic = self._topics[str1]
    if _topic == nil then
        local tbl2 = {
            token = token,
            observers = {}
        }
        self._topics[str1] = tbl2
        return tbl2, nil
    end
    if _topic.token == token then
        return _topic, nil
    end
    local token2 = _topic.token
    _topic.token = token
    _topic.previousToken = token2
    return _topic, token2
end

function module:_removeObserver(str1: string, tbl2, tbl3)
    local var2 = table.find(tbl2.observers, tbl3)
    if var2 == nil then
        return
    end
    table.remove(tbl2.observers, var2)

    if #tbl2.observers > 0 or self._topics[str1] ~= tbl2 then
        return
    end
    self._topics[str1] = nil
    self._source:unsubscribe(tbl2.token)
    if next(self._topics) == nil then
        self._source:stopListening()
    end
end

function module:_dispatch(str1: string, str2: string)
    local _topic = self._topics[str1]
    if _topic == nil then
        return
    end

    local var2 = decodeDetail(str2)

    if var2 == nil then
        warn(`TopicEventReceiver: dropped a notification for {str1} whose detail is not valid JSON`)
        return
    end
    for _, value in table.clone(_topic.observers) do
        if table.find(_topic.observers, value) then
            callObserver(str1, value, var2)
        end
    end
end

function module:_resubscribeAll()
    for _, _topic in self._topics do
        _topic.previousToken = nil
        cancelPendingRetry(_topic)
        self._source:subscribe(_topic.token)
    end
end

function module:_findCurrentTopic(token: string)
    local topicId = getTopicId(token)
    local _topic = if topicId then self._topics[topicId] else nil

    if _topic == nil or _topic.token ~= token then
        return nil, nil
    end
    return topicId, _topic
end

function module:_onTokenExpiry(str1: string, shouldExchange: boolean, bool1: boolean, bool2: boolean)
    local var2, var3 = self:_findCurrentTopic(str1)
    if var2 == nil or var3 == nil then
        return
    end

    var3.previousToken = nil
    if bool1 then
        cancelPendingRetry(var3)
        self._source:subscribe(str1)
    elseif bool2 then
        cancelPendingRetry(var3)

        if shouldExchange then
            self:_exchange(var2, var3)
        end
    else
        self:_endTopic(var2, var3, { type = "expired", shouldExchange = shouldExchange })
    end
end

function module:_exchange(str1: string, tbl2)
    local token = tbl2.token
    requestExchange(token, self._network):andThen(function(tbl3)
        local token2 = tbl3.token
        if self._topics[str1] == tbl2 and tbl2.token == token and type(token2) == "string" and token2 ~= token then
            tbl2.token = token2
            tbl2.previousToken = token
            cancelPendingRetry(tbl2)
            self._source:subscribe(token2, token)
        end
    end):catch(function(arg1)
        if type(arg1) == "table" then
            arg1 = arg1.errorMessage
        end

        warn(`TopicEventReceiver: token exchange for {str1} failed: {arg1}`)
    end)
end

function module:_onSubscriptionError(str1: string, errorCode: string, shouldRetry: boolean)
    local var2, var3 = self:_findCurrentTopic(str1)
    if var2 == nil or var3 == nil then
        return
    end

    if var3.previousToken then
        var3.token = var3.previousToken
        var3.previousToken = nil
        return
    end

    local tbl2 = { type = "error", errorCode = errorCode, shouldRetry = shouldRetry }
    if shouldRetry and self:_retrySubscribe(var2, var3) then
        return
    end
    self:_endTopic(var2, var3, tbl2)
end

function module:_retrySubscribe(str1: string, tbl2): boolean
    if tbl2.retryThread then
        return true
    end
    local retryAttempts = (tbl2.retryAttempts or 0) + 1
    if var1.maxRetries < retryAttempts then
        return false
    end
    tbl2.retryAttempts = retryAttempts
    tbl2.retryThread = task.delay(getRetryDelaySeconds(retryAttempts), function()
        tbl2.retryThread = nil

        if self._topics[str1] == tbl2 then
            self._source:subscribe(tbl2.token)
        end
    end)
    return true
end

function module:_endTopic(str1: string, tbl2, arg1)
    self._topics[str1] = nil
    if next(self._topics) == nil then
        self._source:stopListening()
    end
    for _, value in table.clone(tbl2.observers) do
        if table.find(tbl2.observers, value) then
            callErrorHandler(str1, value, arg1)
        end
    end
end

return module
