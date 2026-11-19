-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:30:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")

local Url = require(CorePackages.Workspace.Packages.CoreScriptsCommon).Url
local Promise = require(CorePackages.Packages.Promise)

local scriptParentParent = script.Parent.Parent
local resolveSourceLanguageName = require(scriptParentParent.Network.resolveSourceLanguageName)

local function requestJson(url: string)
    return Promise.new(function(callback, callback2)
        HttpService:RequestInternal({ Url = url, Method = "GET" }):Start(function(arg1, arg2)
            if not arg1 then
                callback2("Connection error")
                return
            end

            if arg2.StatusCode < 200 or arg2.StatusCode >= 400 then
                callback2("Status code: " .. tostring(arg2.StatusCode))
                return
            end
            local success, result = pcall(function()
                return HttpService:JSONDecode(arg2.Body)
            end)
            if success then
                callback(result)
                return
            end
            callback2("Failed to decode response body")
        end)
    end)
end

return function()
    local localeId = Players.LocalPlayer.LocaleId

    local var1 = if localeId then localeId:gsub("-", "_") else ""

    local url = string.format("%sv1/locales?displayValueLocale=%s", Url.LOCALE_URL, var1)

    local str2 = string.format("%sv1/source-language/games/%d", Url.GAME_INTERNATIONALIZATION_URL, game.GameId)

    return Promise.all({
        Promise.new(function(callback, callback2)
            HttpService:RequestInternal({ Url = url, Method = "GET" }):Start(function(arg1, arg2)
                if not arg1 then
                    callback2("Connection error")
                    return
                end

                if arg2.StatusCode < 200 or arg2.StatusCode >= 400 then
                    callback2("Status code: " .. tostring(arg2.StatusCode))
                    return
                end
                local success, result = pcall(function()
                    return HttpService:JSONDecode(arg2.Body)
                end)
                if success then
                    callback(result)
                    return
                end
                callback2("Failed to decode response body")
            end)
        end),
        requestJson(str2)
    }):andThen(function(arg1)
        local var2 = arg1[1]
        local var3 = arg1[2]

        local var4 = resolveSourceLanguageName(var2.data, var3.languageCode)

        if var4 == nil then
            return Promise.reject("Could not resolve source language name")
        end

        return var4
    end)
end
