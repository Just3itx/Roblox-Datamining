-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:41:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ReactSceneUnderstanding = script:FindFirstAncestor("ReactSceneUnderstanding")

local useEffect = require(ReactSceneUnderstanding.Parent.React).useEffect

local function useTimedLoop(num1: number, callback: (...any) -> (...any))
    useEffect(function()
        local bool1 = true

        task.spawn(function()
            while bool1 do
                task.wait(num1)

                if not bool1 then
                    break
                end

                callback()
            end
        end)

        return function()
            bool1 = false
        end
    end, { num1, callback })
end

return useTimedLoop
