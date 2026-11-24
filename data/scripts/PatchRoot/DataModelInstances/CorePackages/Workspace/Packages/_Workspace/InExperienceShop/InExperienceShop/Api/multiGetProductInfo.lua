-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:01:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceShop = script:FindFirstAncestor("InExperienceShop")
local InExperienceShopParent = InExperienceShop.Parent

local Promise = require(InExperienceShopParent.Promise)
local getProductInfo = require(script.Parent.getProductInfo)
local ShopDebugLogger = require(InExperienceShop.Internal.ShopDebugLogger)

local function multiGetProductInfo(tbl1)
    ShopDebugLogger.logLazy(function(): string
        return "multiGetProductInfo: start batchSize=" .. #tbl1
    end)
    local var1 = ShopDebugLogger.startTimer()
    local var2 = table.create(#tbl1)
    for i, request in ipairs(tbl1) do
        var2[i] = getProductInfo(request.id, request.infoType):andThen(function(value)
            return { request = request, ok = true, value = value }
        end):catch(function(err)
            return { request = request, ok = false, err = err }
        end)
    end
    return ShopDebugLogger.tracePromise(Promise.all(var2), {
        onSuccess = function(tbl2)
            local num1 = 0
            local num2 = 0
            for _, value in ipairs(tbl2) do
                if value.ok then
                    num1 += 1
                else
                    num2 += 1
                end
            end
            ShopDebugLogger.logElapsedLazy(function()
                return "multiGetProductInfo: done succeeded=" .. num1 .. " failed=" .. num2
            end, var1)
        end
    })
end

return multiGetProductInfo
