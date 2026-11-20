-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:21:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}
module.__index = module

function module.new()
    return (setmetatable({ passed = true, reasons = {} }, module))
end

function module:updateReasons(bool1: boolean, tbl1)
    if bool1 then
        return
    end

    table.insert(self.reasons, table.concat(tbl1, "\n"))
    self.passed = false
end

function module:getFinalResults()
    if self.passed then
        return true
    end
    return false, self.reasons
end

return module
