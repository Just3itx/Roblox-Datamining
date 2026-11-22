-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:50:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreation = script:FindFirstAncestor("MomentsCreation")

local GetFFlagMomentsTTSAudioOverlay = require(MomentsCreation.Flags.GetFFlagMomentsTTSAudioOverlay)

local function sampleVideoFrames(arg1, num1: number, callback: (...any) -> (...any), num2: number?, arg2)
    task.spawn(function()
        local success, result = pcall(function()
            local var1 = (arg2 or game:GetService("VideoService")):CreateVideoSamplerAsync(arg1)
            local num3 = num2 or 0
            local tbl1 = {}
            local var2 = if GetFFlagMomentsTTSAudioOverlay then math.max(1, math.floor(num1)) else math.floor(num1)

            for i = 0, var2 - 1 do
                table.insert(tbl1, num3 + i)
            end
            return var1:GetSamplesAtTimesAsync(tbl1)
        end)
        if success then
            callback(result)
            return
        end
        callback({})
    end)
end

return sampleVideoFrames
