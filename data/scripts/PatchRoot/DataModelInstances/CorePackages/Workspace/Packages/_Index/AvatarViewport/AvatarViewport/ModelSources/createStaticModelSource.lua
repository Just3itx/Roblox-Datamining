-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T05:30:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _Types = require(script.Parent.Parent.Types)

local function createStaticModelSource(arg1)
    return function(_)
        local model = arg1:Clone()
        local humanoid = model:FindFirstChildOfClass("Humanoid")

        return {
            model = model,
            humanoid = humanoid,
            animator = if humanoid then humanoid:FindFirstChildOfClass("Animator") else nil
        }
    end
end

return createStaticModelSource
