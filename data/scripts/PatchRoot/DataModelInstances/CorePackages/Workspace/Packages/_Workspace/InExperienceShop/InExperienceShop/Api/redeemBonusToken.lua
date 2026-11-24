-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:01:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpRbxApiService = game:GetService("HttpRbxApiService")
local HttpService = game:GetService("HttpService")

local InExperienceShop = script:FindFirstAncestor("InExperienceShop")
local InExperienceShopParent = InExperienceShop.Parent

local Promise = require(InExperienceShopParent.Promise)
local Url = require(InExperienceShopParent.Http).Url
local Errors = require(script.Parent.Errors)
local ShopDebugLogger = require(InExperienceShop.Internal.ShopDebugLogger)
local FIntRedeemBonusTokenTimeoutMs = require(InExperienceShop.Flags.FIntRedeemBonusTokenTimeoutMs)

local apiUrl = Url.APIS_URL .. "payments-bonus-service/v1/redeem-bonus-token"

local function httpStatusCodeFromError(arg1): number? -- Luacid: unused: defined but never referenced
    return tonumber(string.match(tostring(arg1), "HTTP (%d%d%d)"))
end

local function redeemBonusToken(bonusJwt: string, universeId: number)
    return Promise.new(function(callback, callback2)
        task.spawn(function()
            local bool1 = false
            local function settleResolve(str1: string) -- Luacid: Inlined by compiler; 1 call site recovered
                if bool1 then
                    return
                end
                bool1 = true
                callback(str1)
            end
            local function settleReject(arg1) -- Luacid: Inlined by compiler; 5 call sites recovered
                if bool1 then
                    return
                end
                bool1 = true
                callback2(arg1)
            end

            if FIntRedeemBonusTokenTimeoutMs > 0 then
                task.delay(FIntRedeemBonusTokenTimeoutMs / 1000, function()
                    if bool1 then
                        return
                    end
                    ShopDebugLogger.logLazy(function()
                        return "redeemBonusToken: timed out after " .. FIntRedeemBonusTokenTimeoutMs .. "ms"
                    end)

                    settleReject((Errors.networkError("redeemBonusToken: timed out", FIntRedeemBonusTokenTimeoutMs)))
                end)
            end

            local input = { bonusJwt = bonusJwt, universeId = universeId }

            ShopDebugLogger.logLazy(function(): string
                return "redeemBonusToken: POST universeId=" .. universeId
            end)
            local var1 = ShopDebugLogger.startTimer()

            local success, result = pcall(function(): string
                return HttpRbxApiService:PostAsyncFullUrl(apiUrl, HttpService:JSONEncode(input))
            end)
            if not success then
                ShopDebugLogger.logElapsed("redeemBonusToken: HTTP error", var1)
                ShopDebugLogger.logLazy(function(): string
                    return "redeemBonusToken: HTTP error detail=" .. tostring(result)
                end)

                local match = string.match
                local str1 = tostring(result)

                if tonumber(match(str1, "HTTP (%d%d%d)")) == 400 then
                    settleReject((Errors.badRequestError("redeemBonusToken: HTTP 400", result)))
                    return
                end
                settleReject((Errors.networkError("redeemBonusToken: HTTP request failed", result)))
                return
            end

            ShopDebugLogger.logElapsed("redeemBonusToken: HTTP response received", var1)

            local success2, result2 = pcall(function()
                return HttpService:JSONDecode(result)
            end)
            if not success2 then
                ShopDebugLogger.logLazy(function(): string
                    return "redeemBonusToken: JSON parse error=" .. tostring(result2)
                end)

                settleReject((Errors.parseError("redeemBonusToken: response body is not valid JSON", result2)))

                return
            end

            local paymentSessionId = if typeof(result2) == "table" then result2.paymentSessionId else nil

            if typeof(paymentSessionId) ~= "string" or paymentSessionId == "" then
                ShopDebugLogger.log("redeemBonusToken: schema error, missing paymentSessionId")

                settleReject(
                    (Errors.schemaError("redeemBonusToken: malformed response, expected { paymentSessionId = string }", result2))
                )

                return
            end

            ShopDebugLogger.log("redeemBonusToken: success")
            settleResolve(paymentSessionId)
        end)
    end)
end

return redeemBonusToken
