-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T11:30:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function validateMotor(arg1)
    assert(typeof(arg1) == "table")
    assert(typeof(arg1.start) == "function")
    assert(typeof(arg1.stop) == "function")
    assert(typeof(arg1.step) == "function")
    assert(typeof(arg1.setGoal) == "function")
    assert(typeof(arg1.onStep) == "function")
    assert(typeof(arg1.onComplete) == "function")
    assert(typeof(arg1.destroy) == "function")
end

return validateMotor
