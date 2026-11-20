-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:01:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RunService = game:GetService("RunService")

local checkApplyDefaultClothing = require(script.Parent.checkApplyDefaultClothing)

local function pumpScheduler() -- Luacid: Inlined by compiler; 1 call site recovered
    if RunService:IsRunning() then
        task.wait()
        return
    end
    wait(0)
end

local function applyDefaultClothing(arg1, num1: number?)
    local var1 = if num1 == nil then 8 else num1
    local bool1 = false
    local bool2 = false
    local var2 = nil
    task.spawn(function()
        bool2, var2 = pcall(checkApplyDefaultClothing, arg1)
        bool1 = true
    end)

    local startTime = os.clock()

    while not bool1 and os.clock() - startTime < var1 do
        pumpScheduler()
    end

    if not bool1 then
        warn("applyDefaultClothing: timed out")
        return arg1
    end
    if bool2 then
        return if typeof(var2) == "Instance" and var2:IsA("HumanoidDescription") then var2 else arg1
    end

    warn(`applyDefaultClothing: {var2}`)
    return arg1
end

return applyDefaultClothing
