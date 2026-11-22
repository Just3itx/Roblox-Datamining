-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:51:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxSubscriptionPurchaseAppParent = script:FindFirstAncestor("RobloxSubscriptionPurchaseApp").Parent

local Promise = require(RobloxSubscriptionPurchaseAppParent.Promise)

local module = {}
module.__index = module

function module.new(http)
    local self = setmetatable({}, module)
    self.http = http or game:GetService("HttpService")
    return self
end

function module.get(tbl1, url: string)
    return Promise.new(function(callback, callback2)
        tbl1.http:RequestInternal({ Url = url, Method = "GET", Headers = { Accept = "application/json" } }):Start(function(_, arg1)
            if arg1.StatusCode == 200 then
                callback(tbl1.http:JSONDecode(arg1.Body))
                return
            end
            callback2({ status = arg1.StatusCode, body = arg1.Body })
        end)
    end)
end

function module.post(tbl1, url: string, tbl2)
    return Promise.new(function(callback, callback2)
        tbl1.http:RequestInternal({
            Url = url,
            Method = "POST",
            Headers = { ["Content-Type"] = "application/json", Accept = "application/json" },
            Body = tbl1.http:JSONEncode(tbl2)
        }):Start(
            function(_, arg1)
                if arg1.StatusCode == 200 then
                    callback(tbl1.http:JSONDecode(arg1.Body))
                    return
                end
                callback2({ status = arg1.StatusCode, body = arg1.Body })
            end
        )
    end)
end

return module
