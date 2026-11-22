-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T02:41:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local dependencies = require(scriptParentParent.dependencies)
local Promise = dependencies.Promise
local UrlBuilder = dependencies.UrlBuilder
local UrlBase = dependencies.UrlBase
local Fetch = dependencies.Fetch
local fetch = Fetch.fetch
local Response = Fetch.Response
local UserSetting = require(scriptParentParent.Enums.UserSetting)

local FFlagLuaAppSduiUpdateUserSettingsAction = require(scriptParentParentParent.SharedFlags).FFlagLuaAppSduiUpdateUserSettingsAction

local urlBuilder = UrlBuilder.new({ base = UrlBase.APIS, path = "user-settings-api/v1/user-settings" })

local urlBuilder2 = UrlBuilder.new({ base = UrlBase.APIS, path = "user-settings-api/v2/user-settings" })

return {
    updateUserSetting = function(str1: string, arg1, rbxAuditData: string)
        local var1 = urlBuilder()
        return Promise.new(function(callback, callback2)
            local success, result = pcall(function()
                return fetch(var1, {
                    method = "POST",
                    body = HttpService:JSONEncode({ [str1] = arg1 }),
                    headers = {
                        ["Content-Type"] = "application/json",
                        Accept = "application/json",
                        ["rbx-audit-data"] = rbxAuditData
                    }
                }):catch(
                    function(_)
                        return Response.error()
                    end
                ):expect()
            end)

            if not success then
                callback2("Failed to make request: " .. tostring(result))
                return
            end

            if not result.ok then
                callback2(string.format("Got update user setting HTTP Response: %d - %s", result.status, result.statusText))
            else
                callback()
            end
        end)
    end,
    updateUserSettings = FFlagLuaAppSduiUpdateUserSettingsAction and function(input, rbxAuditData: string?) -- name: updateUserSettings
        for value, _ in input do
            if not UserSetting[value] then
                return Promise.reject(`Invalid setting name: {value}`)
            end
        end

        local var1 = urlBuilder()
        return Promise.new(function(callback, callback2)
            local success, result = pcall(function()
                return fetch(var1, {
                    method = "POST",
                    body = HttpService:JSONEncode(input),
                    headers = {
                        ["Content-Type"] = "application/json",
                        Accept = "application/json",
                        ["rbx-audit-data"] = rbxAuditData
                    }
                }):catch(
                    function(_)
                        return Response.error()
                    end
                ):expect()
            end)
            if not (success and result) then
                callback2(`Failed to make request: {result}`)
                return
            end

            if not result.ok then
                callback2(`Got update user setting HTTP Response: {result.status} - {result.statusText}`)
            else
                callback(result)
            end
        end)
    end or nil,
    updateUserSettingV2 = function(str1: string, arg1, rbxAuditData: string)
        if not UserSetting[str1] then
            local tbl1 = {
                message = `Invalid setting name: {str1}`
            }
            return Promise.reject(tbl1)
        end

        local var1 = urlBuilder2()
        return Promise.new(function(callback, callback2)
            local success, result = pcall(function()
                return fetch(var1, {
                    method = "POST",
                    body = HttpService:JSONEncode({ [str1] = arg1 }),
                    headers = {
                        ["Content-Type"] = "application/json",
                        Accept = "application/json",
                        ["rbx-audit-data"] = rbxAuditData
                    }
                }):catch(
                    function()
                        return Response.error()
                    end
                ):expect()
            end)
            if not (success and result) then
                callback2({ message = `Failed to make request: {result}` })
                return
            end

            if not result.ok then
                callback2({
                    statusCode = result.status,
                    message = `Got update user setting HTTP Response: {result.status} - {result.statusText}`
                })
            else
                callback()
            end
        end)
    end
}
