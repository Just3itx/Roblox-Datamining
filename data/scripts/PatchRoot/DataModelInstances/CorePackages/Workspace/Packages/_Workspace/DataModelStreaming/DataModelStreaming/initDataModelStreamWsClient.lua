-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T05:41:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
game:DefineFastFlag("LuaAppEnableCompactDataModelPayload", false)
game:DefineFastFlag("LuaAppEnableWebViewStateTrackerInDataModelStreaming", false)

local bool1 = game:DefineFastFlag("LuaAppDisableDataModelStreamingInStudio", false)

local RunService = game:GetService("RunService")

local scriptParentParent = script.Parent.Parent
local SharedFlags = require(scriptParentParent.SharedFlags)

local FFlagLuaAppEnableInExperienceDataModelStreamStarter = SharedFlags.FFlagLuaAppEnableInExperienceDataModelStreamStarter
local FFlagEnableWebViewStateTracker = SharedFlags.FFlagEnableWebViewStateTracker
local var1 = require(scriptParentParent.Loggers).Logger:new("DataModelStreaming")
local HttpService = game:GetService("HttpService")
local getDataModelStreamAllowedHosts = require(script.Parent.getDataModelStreamAllowedHosts)
local getDataModelRoot = require(script.Parent.getDataModelRoot)
local compactDataModelPayload = require(script.Parent.compactDataModelPayload)
local WebViewStateTracker = require(scriptParentParent.WebViewUtils).WebViewStateTracker

local dataModelStreamAllowedHosts = getDataModelStreamAllowedHosts()
local num1 = 0
local var2 = nil

local WebSocketService = nil
local success, _result = pcall(function()
    WebSocketService = game:GetService("WebSocketService")
end)
if not success then
    return function(_: string?)
        var1:error("WebSocketService is not available...")
    end
end

local function splitIntoChunks(arg1, num2: number): {string}
    local result = {}
    for i = 1, #arg1, num2 do
        table.insert(result, string.sub(arg1, i, i + num2 - 1))
    end
    return result
end

local function streamDataModel(arg1, arg2, properties)
    local success2, result = pcall(function()
        if WebViewStateTracker
            and FFlagEnableWebViewStateTracker
            and game:GetFastFlag("LuaAppEnableWebViewStateTrackerInDataModelStreaming")
            and WebViewStateTracker.isOpen()
        then
            return HttpService:JSONEncode({ type = "webview", webViewMetadata = WebViewStateTracker.getWebViewMetadata() })
        elseif game:GetFastFlag("LuaAppEnableCompactDataModelPayload") then
            return HttpService:JSONEncode(compactDataModelPayload(getDataModelRoot(properties)))
        end
        return HttpService:JSONEncode(getDataModelRoot(properties))
    end)

    if not success2 then
        var1:error(`Error encoding data model: {result}`)
        return
    end

    var1:info(`Streaming data model, total size: {#result}`)

    local tbl1 = splitIntoChunks(result, 262144)
    local num2 = #tbl1
    for i, value in ipairs(tbl1) do
        arg1:Send(`DM_STREAM_CHUNK:{arg2}:{num2}:{i}:{value}`)
    end
end

local function getHostToTry() -- Luacid: Inlined by compiler; 1 call site recovered
    if var2 then
        return var2
    end
    num1 += 1
    return if num1 > #dataModelStreamAllowedHosts then nil else dataModelStreamAllowedHosts[num1]
end

local function startDataModelStreamWsClient(str1: string?)
    local hostToTry = getHostToTry()

    if not hostToTry then
        return
    end

    local var3 = hostToTry
    if str1 then
        var3 ..= "/?source=" .. str1
    end

    local success2, result = pcall(function()
        return WebSocketService:CreateClient(var3)
    end)
    if not (success2 and result) then
        var1:error("Failed to create WebSocket client")
        return
    end
    local var4 = result

    var4.Closed:Connect(function()
        startDataModelStreamWsClient(str1)
    end)

    var4.MessageReceived:Connect(function(input)
        var2 = hostToTry

        if input:match("%x%x%x%x%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%x%x%x%x%x%x%x%x") then
            print("[" .. "DataModelStreaming" .. "] uuid[" .. input .. "]")
        end

        local success3, result2 = pcall(function()
            return HttpService:JSONDecode(input)
        end)

        if not success3 or result2.type ~= "data_model" then
            return
        end

        local str2 = HttpService:GenerateGUID(false)
        if result2.request_id then
            str2 = result2.request_id
        end
        streamDataModel(var4, str2, result2.properties)
    end)
end

local function initDataModelStreamWsClientWithVPNGate(str1: string?)
    local success2, result = pcall(function()
        return WebSocketService:CreateClient("ws://10.110.101.222:5052")
    end)
    if not (success2 and result) then
        return
    end

    result.MessageReceived:Connect(function(_)
        pcall(function()
            result:Close()
        end)
        startDataModelStreamWsClient(str1)
    end)
end

local function initDataModelStreamWsClient(str1: string?)
    str1 = FFlagLuaAppEnableInExperienceDataModelStreamStarter and (str1 or "ua") or nil

    if bool1 and RunService:IsStudio() then
        return
    end
    initDataModelStreamWsClientWithVPNGate(str1)
end

return initDataModelStreamWsClient
