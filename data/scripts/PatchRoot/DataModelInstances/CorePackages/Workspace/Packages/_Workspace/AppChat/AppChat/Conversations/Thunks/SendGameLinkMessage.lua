-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:00:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local FFlagLuaAppDefaultHttpRetry = require(AppChatParent.SharedFlags).FFlagLuaAppDefaultHttpRetry
local Http = require(AppChatParent.Http)
local HttpRequest = require(AppChatParent.HttpRequest)
local Promise = require(AppChatParent.Promise)
local _LuauPolyfill = require(AppChatParent.LuauPolyfill)

local SendTextMessage = require(script.Parent.SendTextMessage)
local var1 = require(AppChat.Logger):new(script.Name)

local Url = Http.Url

local var2 = HttpRequest.config({
    requestFunction = function(str1: string, str2: string, arg1)
        return HttpRequest.requestFunctions.HttpRbxApi(str1, str2, arg1)
    end,
    maxRetryCount = if FFlagLuaAppDefaultHttpRetry then game:DefineFastInt("SendGameLinkMessageHttpRetryCount", 4) else nil
})

local function fetchRootPlaceId(num1: number) -- Luacid: Inlined by compiler; 1 call site recovered
    local str1 = `{Url.GAME_URL}v1/games?universeIds={num1}`
    return var2(str1, "GET"):andThen(function(arg1)
        local data = arg1 and arg1.responseBody and arg1.responseBody.data
        local var3 = data and data[1]
        return var3 and var3.rootPlaceId or nil
    end)
end

return function(str1: string, num1: number)
    return function(arg1)
        return fetchRootPlaceId(num1):andThen(function(num2: number?)
            if not num2 then
                return Promise.reject(`no root place id for universe {num1}`)
            end

            local str2 = `{Url.BASE_URL}games/{num2}`
            return arg1:dispatch(SendTextMessage(str1, str2, nil))
        end):catch(function(arg2)
            var1:warning(`SendGameLinkMessage failed for universe {num1}: {tostring(arg2)}`)
            return Promise.reject(arg2)
        end)
    end
end
