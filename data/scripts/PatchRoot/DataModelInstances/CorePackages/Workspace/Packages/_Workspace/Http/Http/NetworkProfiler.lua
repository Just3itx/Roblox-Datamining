-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-18T23:40:59Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local var1 = tonumber(settings():GetFVariable("PercentReportingNetworkProfileAfterStartup"))

local module = {}
module.__index = module

module.aggregate = {
    queued = 0,
    nameLookup = 0,
    connect = 0,
    sslHandshake = 0,
    makeRequest = 0,
    receiveResponse = 0
}

function module.track(arg1, arg2)
    arg1.aggregate.queued = arg1.aggregate.queued + arg2.queued
    if arg2.nameLookup >= 0 then
        arg1.aggregate.nameLookup = arg1.aggregate.nameLookup + arg2.nameLookup
    end
    if arg2.connect >= 0 then
        arg1.aggregate.connect = arg1.aggregate.connect + arg2.connect
    end
    if arg2.sslHandshake >= 0 then
        arg1.aggregate.sslHandshake = arg1.aggregate.sslHandshake + arg2.sslHandshake
    end
    if arg2.makeRequest >= 0 then
        arg1.aggregate.makeRequest = arg1.aggregate.makeRequest + arg2.makeRequest
    end
    if arg2.receiveResponse >= 0 then
        arg1.aggregate.receiveResponse = arg1.aggregate.receiveResponse + arg2.receiveResponse
    end
end

function module.report(arg1, callback)
    callback("NetworkProfileDuringStartup", "Queued", arg1.aggregate.queued, var1)
    callback("NetworkProfileDuringStartup", "NameLookup", arg1.aggregate.nameLookup, var1)
    callback("NetworkProfileDuringStartup", "Connect", arg1.aggregate.connect, var1)
    callback("NetworkProfileDuringStartup", "SSLHandshake", arg1.aggregate.sslHandshake, var1)
    callback("NetworkProfileDuringStartup", "MakeRequest", arg1.aggregate.makeRequest, var1)
    callback("NetworkProfileDuringStartup", "ReceiveResponse", arg1.aggregate.receiveResponse, var1)
end

return module
