-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:21:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local React = require(BuildExperienceParent.React)

local function useScrollEndReached(num1: number, num2: number, callback: (...any) -> (...any))
    React.useEffect(function()
        local current = num1.current
        if current == nil then
            return
        end

        local function checkDistanceToEnd() -- Luacid: Inlined by compiler; 1 call site recovered
            local absoluteWindowSizeY = current.AbsoluteWindowSize.Y
            if current.AbsoluteCanvasSize.Y - absoluteWindowSizeY - current.CanvasPosition.Y <= absoluteWindowSizeY * num2 then
                callback()
            end
        end
        local tbl1 = {}
        for _, value in { "CanvasPosition", "AbsoluteCanvasSize", "AbsoluteWindowSize" } do
            local var1 = current:GetPropertyChangedSignal(value)
            table.insert(tbl1, var1:Connect(checkDistanceToEnd))
        end

        checkDistanceToEnd()

        return function()
            for _, value in tbl1 do
                value:Disconnect()
            end
        end
    end, { num1, num2, callback })
end

return useScrollEndReached
