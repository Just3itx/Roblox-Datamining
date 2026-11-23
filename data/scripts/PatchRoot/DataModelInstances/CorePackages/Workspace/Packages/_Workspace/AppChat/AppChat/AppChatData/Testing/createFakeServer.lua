-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:01:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local _Http = require(AppChatParent.Http)
local Promise = require(AppChatParent.Promise)

local _createHttpPort = require(AppChat.AppChatData.Ports.createHttpPort)

local function decodeBody(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    local postBody = if arg1 == nil then nil else arg1.postBody

    if type(postBody) ~= "string" then
        return postBody
    end
    local success, result = pcall(function()
        return HttpService:JSONDecode(postBody)
    end)
    return if success then result else postBody
end

local function createFakeServer()
    local tbl1 = ({})
    local tbl2 = {}

    return {
        request = function(endpoint, url: string, method: string, arg1)
            local tbl3 = {
                endpoint = endpoint,
                url = url,
                method = method,
                body = decodeBody(arg1)
            }
            table.insert(tbl2, tbl3)

            local var1 = tbl1[endpoint]
            if var1 == nil then
                return Promise.reject(`AppChatData.Testing: no response scripted for {endpoint}`)
            end
            if type(var1) == "function" then
                var1 = var1(tbl3)
            end

            local status = var1.status or 200
            local tbl4 = {
                responseBody = var1.body,
                responseCode = status,
                StatusCode = status
            }
            if status >= 200 and status < 300 then
                return Promise.resolve(tbl4)
            end

            if var1.body ~= nil then
                tbl4.Body = HttpService:JSONEncode(var1.body)
            end
            return Promise.reject(tbl4)
        end,
        respond = function(arg1, arg2)
            tbl1[arg1] = arg2
        end,
        getCalls = function(endpoint)
            if endpoint == nil then
                return table.clone(tbl2)
            end
            local calls = {}
            for _, value in tbl2 do
                if value.endpoint == endpoint then
                    table.insert(calls, value)
                end
            end
            return calls
        end
    }
end

return createFakeServer
