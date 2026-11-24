-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T21:31:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceSideSheet = script:FindFirstAncestor("InExperienceSideSheet")

local ContentProvider = game:GetService("ContentProvider")
local HttpService = game:GetService("HttpService")

local toEconomyCurrencyUrl = require(InExperienceSideSheet.Utils.toEconomyCurrencyUrl)
local extractRobuxBalance = require(InExperienceSideSheet.Utils.extractRobuxBalance)

local function fetchRobuxBalance(callback: (...any) -> (...any))
    HttpService:RequestInternal({ Url = toEconomyCurrencyUrl(ContentProvider.BaseUrl), Method = "GET" }):Start(function(bool1: boolean, tbl1)
        if not bool1 then
            return
        end

        local success, result = pcall(HttpService.JSONDecode, HttpService, tbl1.Body)
        if not success then
            return
        end

        local var1 = extractRobuxBalance(result)
        if var1 ~= nil then
            callback(var1)
        end
    end)
end

return fetchRobuxBalance
