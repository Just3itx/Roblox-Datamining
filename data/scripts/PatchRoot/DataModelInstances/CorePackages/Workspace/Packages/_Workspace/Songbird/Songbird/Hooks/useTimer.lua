-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T17:01:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Songbird = script:FindFirstAncestor("Songbird")

local Cryo = require(Songbird.Parent.Cryo)
local useEffect = require(Songbird.Parent.React).useEffect

local function useTimer(num1: number, callback: (...any) -> (...any), tbl1)
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
    end, Cryo.Dictionary.join({ num1, callback }, tbl1 or {}))
end

return useTimer
