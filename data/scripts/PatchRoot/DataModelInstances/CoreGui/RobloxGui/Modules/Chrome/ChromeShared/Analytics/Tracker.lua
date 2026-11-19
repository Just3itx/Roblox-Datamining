-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:30:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}
module.__index = module

function module.new()
    return (setmetatable({ trackers = {} }, module))
end

function module.toggle(tbl1, str1: string)
    tbl1[str1] = not tbl1[str1]
    return tbl1[str1]
end

function module:set(str1: string, arg1)
    self.trackers[str1] = arg1
end

function module:get(str1: string)
    return self.trackers[str1]
end

function module:reset(str1: string)
    self.trackers[str1] = nil
end

function module:startTime(str1: string)
    self.trackers[str1] = DateTime.now().UnixTimestampMillis
end

function module:finishTime(str1: string): number
    if not self.trackers[str1] then
        return 0
    end

    local var1 = DateTime.now().UnixTimestampMillis - self.trackers[str1]
    self.trackers[str1] = 0
    return var1
end

return module
