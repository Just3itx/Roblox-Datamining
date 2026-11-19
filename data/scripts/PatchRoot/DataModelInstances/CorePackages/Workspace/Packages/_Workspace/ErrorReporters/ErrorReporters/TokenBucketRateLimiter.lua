-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T12:11:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}
module.__index = module

function module.new(tbl1)
    local self = setmetatable({}, module)

    self.maxTokens = tbl1.maxTokens
    self.refillRate = tbl1.refillRate
    self.refillIntervalSeconds = tbl1.refillIntervalSeconds
    self.currentTokens = tbl1.initialTokens or tbl1.maxTokens
    self.lastRefillTime = tick()

    if self.currentTokens > self.maxTokens then
        self.currentTokens = self.maxTokens
    end

    return self
end

function module:refill()
    local lastRefillTime = tick()
    local var1 = lastRefillTime - self.lastRefillTime

    if var1 < 0 then
        self.lastRefillTime = lastRefillTime
        return
    end

    local num1 = math.floor(var1 / self.refillIntervalSeconds)

    if num1 > 0 then
        local var2 = num1 * self.refillRate

        self.currentTokens = math.min(self.maxTokens, self.currentTokens + var2)

        self.lastRefillTime += num1 * self.refillIntervalSeconds
    end
end

function module:consume(num1: number?): boolean
    local num2 = num1 or 1

    self:refill()

    if not (num2 <= self.currentTokens) then
        return false
    end

    self.currentTokens -= num2
    return true
end

function module:getAvailableTokens()
    self:refill()
    return self.currentTokens
end

function module:getMaxTokens()
    return self.maxTokens
end

function module.hasTokensAvailable(arg1): boolean
    return arg1:getAvailableTokens() > 0
end

function module:reset()
    self.currentTokens = self.maxTokens
    self.lastRefillTime = tick()
end

function module:toString(): string
    self:refill()

    return string.format(
        "TokenBucketRateLimiter{tokens=%d/%d, refillRate=%d/%ds, nextRefillIn=%.1fs}",
        self.currentTokens,
        self.maxTokens,
        self.refillRate,
        self.refillIntervalSeconds,
        self.refillIntervalSeconds - (tick() - self.lastRefillTime) % self.refillIntervalSeconds
    )
end

return module
