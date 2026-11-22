-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:40:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local RunService = game:GetService("RunService")

local React = require(MomentsParent.React)

local estimatePostingProgress = require(Moments.Components.PostFeedback.estimatePostingProgress)

game:DefineFastInt("MomentsPostingProgressSeconds", 100)
game:DefineFastInt("MomentsPostingProgressTargetPercent", 90)

local function getPercent(num1: number?) -- Luacid: Inlined by compiler; 3 call sites recovered
    if num1 == nil then
        return 0
    end
    local fastInt = game:GetFastInt("MomentsPostingProgressSeconds")
    local num2 = game:GetFastInt("MomentsPostingProgressTargetPercent") / 100
    return estimatePostingProgress(os.clock(), num1, fastInt, num2) * 100
end

local function usePostingProgress(num1: number?)
    local var1, var2 = React.useBinding((getPercent(num1)))

    React.useEffect(function()
        if num1 == nil then
            return nil
        end
        var2((getPercent(num1)))
        local connection = RunService.Heartbeat:Connect(function()
            var2((getPercent(num1)))
        end)
        return function()
            connection:Disconnect()
        end
    end, { num1 })

    return if num1 == nil then nil else var1
end

return usePostingProgress
