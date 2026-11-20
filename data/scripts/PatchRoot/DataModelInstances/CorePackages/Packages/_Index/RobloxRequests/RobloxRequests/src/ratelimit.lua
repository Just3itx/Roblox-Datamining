-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:31:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}
module.__index = module

local function log<T>(arg1: T): T -- Luacid: unused: defined but never referenced
    return arg1
end

if not module.ratelimit then
    module.ratelimit = {}
end

function module.get(id, rate, windowSize)
    local self = setmetatable({}, module)

    if not module.ratelimit[id] then
        module.ratelimit[id] = {}

        module.ratelimit[id].windows = {}
    end

    module.ratelimit[id].window_size = windowSize
    module.ratelimit[id].rate = rate

    self.id = id
    self.window_size = module.ratelimit[id].window_size
    self.rate = module.ratelimit[id].rate

    local _id = self.id

    return self
end

function module:window(): number
    return math.floor(tick() / self.window_size)
end

function module:progress()
    return tick() % self.window_size / self.window_size
end

function module:increment()
    local var1 = self:window()

    if not module.ratelimit[self.id].windows[var1] then
        module.ratelimit[self.id].windows[var1] = 0
    end

    module.ratelimit[self.id].windows[var1] = module.ratelimit[self.id].windows[var1] + 1

    return module.ratelimit[self.id].windows[var1]
end

function module:weighted(arg1)
    local var1 = self:progress()
    local var2 = self:window()
    local var3 = (module.ratelimit[self.id].windows[var2] or 0) + (arg1 or 0)
    local window = module.ratelimit[self.id].windows[var2 - 1] or 0

    return var3 * var1 + window * (1 - var1)
end

function module:consumption()
    return self:weighted() / self.rate
end

function module:request(): boolean
    if self:weighted(1) > self.rate then
        return false
    end
    self:increment()
    return true
end

return module
