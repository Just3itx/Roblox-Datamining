-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T18:01:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local SquadsCore = script:FindFirstAncestor("SquadsCore")
local SquadsCoreParent = SquadsCore.Parent

local UrlBuilder = require(SquadsCoreParent.UrlBuilder)
local t = require(SquadsCoreParent.t)

local Logger = require(SquadsCore.Logger)
local ScheduledSquadModel = require(SquadsCore.Models.ScheduledSquadModel)
local serializeTable = require(SquadsCore.Utils.serializeTable)
local _Types = require(SquadsCore.Types)

local UrlBuilder2 = UrlBuilder.UrlBuilder
local UrlBase = UrlBuilder.UrlBase

local var1 = t.strictInterface({ scheduledGroupUpId = t.number, title = t.string, startTime = t.string })

local Url = UrlBuilder2.new({ base = UrlBase.APIS, path = "group-up/v1/update-scheduled-group-up" })()

return function(tbl1, callback: (...any) -> (...any), callback2)
    assert(var1(tbl1))

    return HttpService:RequestInternal({
        Body = HttpService:JSONEncode({ scheduledGroupUpId = tbl1.scheduledGroupUpId, title = tbl1.title, startTime = tbl1.startTime }),
        Headers = { ["Content-Type"] = "application/json", Accept = "application/json" },
        Method = "POST",
        Url = Url
    }):Start(
        function(_, arg1)
            if arg1.StatusCode ~= 200 then
                if callback2 then
                    callback2()
                end

                Logger:error("Error updating scheduled squad: {}", arg1.StatusMessage)

                return arg1
            end

            local body = arg1.Body

            if callback then
                callback(ScheduledSquadModel.format(HttpService:JSONDecode(body)))
            end

            Logger:debug("Response: {}", serializeTable(body))
            return arg1
        end
    )
end
