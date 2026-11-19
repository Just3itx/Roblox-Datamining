-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:11:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}
local num1 = game:DefineFastInt("WaitForChildOfClassTimeout", 0)

if num1 > 0 then
    function module.waitForChildOfClass(arg1, arg2)
        local var1 = arg1:FindFirstChildOfClass(arg2)
        local var2 = tick() + num1
        while not var1 and tick() < var2 do
            task.wait()
            var1 = arg1:FindFirstChildOfClass(arg2)
        end
        return var1
    end
else
    function module.waitForChildOfClass(arg1, className)
        local child = arg1:FindFirstChildOfClass(className)
        while not child or child.ClassName ~= className do
            child = arg1.ChildAdded:Wait()
        end
        return child
    end
end

function module.waitForChildWhichIsA(arg1, arg2)
    local child = arg1:FindFirstChildWhichIsA(arg2)
    while not (child and child:IsA(arg2)) do
        child = arg1.ChildAdded:Wait()
    end
    return child
end

return module
