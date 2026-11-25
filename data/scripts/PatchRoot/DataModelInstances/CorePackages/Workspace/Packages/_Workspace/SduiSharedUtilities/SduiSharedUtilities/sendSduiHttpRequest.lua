-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T12:01:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedUtilities = script:FindFirstAncestor("SduiSharedUtilities")
local SduiSharedUtilitiesParent = SduiSharedUtilities.Parent

local HttpClient = require(SduiSharedUtilitiesParent.HttpClient)
local Promise = require(SduiSharedUtilitiesParent.Promise)
local buildSduiRequestHeaders = require(SduiSharedUtilities.buildSduiRequestHeaders)
local FFlagSduiMrRouterHeaders = require(SduiSharedUtilities.Flags.FFlagSduiMrRouterHeaders)

local function deadlineRejection(deadlineSec: number) -- Luacid: Inlined by compiler; 2 call sites recovered
    return {
        stats = {},
        statusMessage = `SDUI request exceeded its {deadlineSec}s deadline`
    }
end

local function sendSduiHttpRequest(tbl1)
    local var1 = tbl1.network or HttpClient.createRequestInternalNetwork({ transportFailuresAsResponses = true })
    if tbl1.retry then
        var1 = HttpClient.withRetry(var1, tbl1.retry)
    end

    local deadlineSec = tbl1.deadlineSec
    local bool1 = false
    local delivery = tbl1.delivery
    local onMessage = if delivery.mode == "streaming" then delivery.onMessage else nil

    local func1 = if onMessage == nil or deadlineSec == nil then onMessage else function(str1: string)
        bool1 = true
        onMessage(str1)
    end

    local request = HttpClient.createRequest({
        networkImpl = var1,
        method = tbl1.method,
        url = tbl1.url,
        body = tbl1.body,
        headers = not FFlagSduiMrRouterHeaders and {
            Accept = tbl1.accept
        } or buildSduiRequestHeaders(tbl1.accept, nil),
        encode = HttpClient.encodeRaw(tbl1.contentType or "application/json"),
        decode = function(arg1)
            if arg1.statusCode >= 400
                or arg1.httpError ~= nil and arg1.httpError ~= Enum.HttpError.OK
                or arg1.wasTransportFailure == true
            then
                return nil, `Http request not successful StatusCode {arg1.statusCode} HttpError {arg1.httpError}`, arg1.statusCode
            end
            return arg1, nil, nil
        end,
        analyticsKey = tbl1.analyticsKey,
        onMessage = func1,
        priority = tbl1.priority
    })

    local var2 = HttpClient.asPromise(request):catch(function(arg1)
        return Promise.reject(arg1.response or { stats = {}, statusMessage = arg1.errorMessage })
    end)

    if deadlineSec == nil then
        return var2
    end

    if delivery.mode ~= "streaming" then
        return var2:timeout(deadlineSec, (deadlineRejection(deadlineSec)))
    end

    local var3 = Promise.delay(deadlineSec):andThen(function()
        if bool1 then
            return var2
        end

        return (Promise.reject((deadlineRejection(deadlineSec))))
    end)

    return Promise.race({ var3, var2 })
end

return sendSduiHttpRequest
