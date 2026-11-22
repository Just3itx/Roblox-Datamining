-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:41:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TweenService = game:GetService("TweenService")

local MomentsCreationParent = script:FindFirstAncestor("MomentsCreation").Parent

local audioDuckingFastInts = require(MomentsCreationParent.MomentsCommon).Media.audioDuckingFastInts

local var1 = (setmetatable({}, { __mode = "k" }))

local function fadeVolume(instance: Instance, volume: number, bool1: boolean?)
    local var2 = var1[instance]
    if var2 ~= nil then
        var2:Cancel()
        var1[instance] = nil
    end

    local compressorParams = audioDuckingFastInts.getCompressorParams()
    local time = if bool1 then 0 elseif volume < instance.Volume then compressorParams.attack else compressorParams.release

    if time <= 0 then
        instance.Volume = volume
        return
    end

    local tween = TweenService:Create(instance, TweenInfo.new(time, Enum.EasingStyle.Linear), { Volume = volume })
    var1[instance] = tween
    tween:Play()
end

return fadeVolume
