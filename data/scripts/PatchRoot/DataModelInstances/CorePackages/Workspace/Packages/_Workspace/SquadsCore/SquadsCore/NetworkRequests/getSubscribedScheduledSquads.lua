-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T18:01:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local SquadsCore = script:FindFirstAncestor("SquadsCore")
local SquadsCoreParent = SquadsCore.Parent

local UrlBuilder = require(SquadsCoreParent.UrlBuilder)

local Logger = require(SquadsCore.Logger)
local serializeTable = require(SquadsCore.Utils.serializeTable)
local _Types = require(SquadsCore.Types)

local UrlBuilder2 = UrlBuilder.UrlBuilder
local UrlBase = UrlBuilder.UrlBase

local Url = UrlBuilder2.new({ base = UrlBase.APIS, path = "group-up/v1/get-subscribed-scheduled-group-ups" })()

return function(callback: ((...any) -> (...any))?, callback2: ((...any) -> (...any))?)
    return HttpService:RequestInternal(
        {
            Headers = { ["Content-Type"] = "application/json", Accept = "application/json" },
            Method = "GET",
            Url = Url
        }
    ):Start(
        function(_, arg1)
            if arg1.StatusCode ~= 200 then
                if callback2 then
                    callback2()
                end

                Logger:error("Error getting subscribed scheduled squads: {}", arg1.StatusMessage)

                return arg1
            end

            local body = arg1.Body

            if callback then
                callback(HttpService:JSONDecode(body))
            end

            Logger:debug("Response: {}", serializeTable(body))
            return arg1
        end
    )
end
