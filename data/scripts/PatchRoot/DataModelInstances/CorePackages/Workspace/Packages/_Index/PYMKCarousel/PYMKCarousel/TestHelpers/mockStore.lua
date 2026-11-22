-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T13:31:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PYMKCarousel = script:FindFirstAncestor("PYMKCarousel")
local Rodux = require(PYMKCarousel.dependencies).Rodux

return function(arg1, arg2)
    return Rodux.Store.new(arg2 or function<T>(arg3: T): T
        return arg3
    end, arg1 or {}, { Rodux.thunkMiddleware })
end
