-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:41:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreationParent = script:FindFirstAncestor("MomentsCreation").Parent

local audioDuckingFastInts = require(MomentsCreationParent.MomentsCommon).Media.audioDuckingFastInts

local function getTtsDuckScalar(): number
    local compressorParams = audioDuckingFastInts.getCompressorParams()

    if compressorParams.ratio <= 0 then
        return 1
    end
    local var1 = -compressorParams.threshold * (1 - 1 / compressorParams.ratio)
    return math.clamp(10 ^ ((compressorParams.makeupGain - var1) / 20), 0, 1)
end

return getTtsDuckScalar
