-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T11:30:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RunService = game:GetService("RunService")

local tbl1 = ({})
local tbl2 = {
    Connect = function(_, func1: (...any) -> (...any))
        tbl1[func1] = true
        return {
            Disconnect = function()
                tbl1[func1] = nil
            end
        }
    end,
    Fire = function(_, num1: number)
        for value, _ in tbl1 do
            value(num1)
        end
    end
}

return {
    Connect = function(_, arg1)
        if _G.__OTTER_MOCK_ANIMATION_STEP_SIGNAL__ then
            return tbl2:Connect(arg1)
        end

        return RunService.RenderStepped:Connect(arg1)
    end,
    Fire = function(_, num1: number?)
        if _G.__OTTER_MOCK_ANIMATION_STEP_SIGNAL__ then
            tbl2:Fire(num1 or 1 / 60)
            return
        end
        error("Cannot manually fire real animation step signal")
    end
}
