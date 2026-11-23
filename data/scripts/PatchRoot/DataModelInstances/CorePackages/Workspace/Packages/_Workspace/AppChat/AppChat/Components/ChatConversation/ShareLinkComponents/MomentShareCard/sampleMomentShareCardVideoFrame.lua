-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:41:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VideoService = game:GetService("VideoService")

local Full = Enum.VideoSampleSize.Full

local function sampleMomentShareCardVideoFrame(arg1, arg2)
    local var1 = arg2 or VideoService
    local var2 = nil
    local success, result = pcall(function()
        var2 = var1:CreateVideoSamplerAsync(arg1, { Size = Full })

        return var2:GetSamplesAtTimesAsync({ 0 })
    end)
    if var2 ~= nil then
        pcall(function()
            var2:Destroy()
        end)
    end

    if not success then
        return nil
    end
    local var3 = result[1]
    return if var3 == nil then nil else var3.Image
end

return sampleMomentShareCardVideoFrame
