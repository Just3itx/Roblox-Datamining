-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T12:00:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedUtilitiesParent = script:FindFirstAncestor("SduiSharedUtilities").Parent

local Cryo = require(SduiSharedUtilitiesParent.Cryo)
local _HttpClient = require(SduiSharedUtilitiesParent.HttpClient)

local maxRetryCount = game:DefineFastInt("SduiMaxRetryCount", 2)
local retryJitterMinMs = game:DefineFastInt("SduiRetryJitterMinMs", 100)
local retryJitterMaxMs = game:DefineFastInt("SduiRetryJitterMaxMs", 1000)
local retryBudgetSec = game:DefineFastInt("SduiRetryBudgetSec", 20)

local num5 = game:DefineFastInt("SduiFetchTimeoutHeadroomSec", 10)

local function getDefaultRetryOptions()
    return {
        maxRetryCount = maxRetryCount,
        retryJitterMinMs = retryJitterMinMs,
        retryJitterMaxMs = retryJitterMaxMs,
        retryBudgetSec = retryBudgetSec,
        retryOnHttpErrors = {
            [Enum.HttpError.ConnectFail] = true,
            [Enum.HttpError.DnsResolve] = true,
            [Enum.HttpError.NetFail] = true
        }
    }
end

return {
    resolve = function(tbl1)
        if tbl1 == nil then
            return (getDefaultRetryOptions())
        end
        if tbl1.mode == "none" then
            return nil
        end
        local var1 = Cryo.Dictionary.join(getDefaultRetryOptions(), tbl1.overrides)

        local retryBudgetSec2 = var1.retryBudgetSec
        var1.retryBudgetSec = if retryBudgetSec2 ~= nil then math.min(retryBudgetSec2, retryBudgetSec) else retryBudgetSec

        return var1
    end,
    getRequestDeadlineSec = function(): number
        return retryBudgetSec + num5
    end,
    getFetchTimeoutSec = function(): number
        return retryBudgetSec + num5 + 5
    end
}
