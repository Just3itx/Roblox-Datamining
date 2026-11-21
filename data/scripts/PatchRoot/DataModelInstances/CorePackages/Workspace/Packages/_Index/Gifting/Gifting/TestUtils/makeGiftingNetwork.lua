-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T23:31:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local GiftingParent = script:FindFirstAncestor("Gifting").Parent

local HttpClient = require(GiftingParent.HttpClient)

local function makeGiftingNetwork(tbl1)
    local tbl2 = tbl1 or {}
    local getLastRequest = nil
    local getRequestCount = 0

    return {
        network = HttpClient.createMockNetwork({
            fallback = function(arg1)
                getLastRequest = arg1
                getRequestCount += 1

                if tbl2.statusCode == nil then
                    return tbl2.responseBody or {}
                end

                return {
                    statusCode = tbl2.statusCode,
                    responseBody = HttpService:JSONEncode(tbl2.responseBody or {})
                }
            end
        }),
        getLastRequest = function()
            return getLastRequest
        end,
        getLastBody = function()
            local var2 = getLastRequest
            if var2 == nil or var2.body == nil then
                return nil
            end
            return HttpService:JSONDecode(var2.body)
        end,
        getRequestCount = function()
            return getRequestCount
        end
    }
end

return makeGiftingNetwork
