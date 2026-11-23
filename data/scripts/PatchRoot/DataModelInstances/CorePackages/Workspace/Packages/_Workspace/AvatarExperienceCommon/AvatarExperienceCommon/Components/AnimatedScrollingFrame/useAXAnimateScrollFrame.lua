-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:11:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserGameSettings = UserSettings():GetService("UserGameSettings")

local AvatarExperienceCommonParent = script:FindFirstAncestor("AvatarExperienceCommon").Parent
local useAnimateScrollViewToSelection = require(AvatarExperienceCommonParent.AppBlox).useAnimateScrollViewToSelection
local num1 = game:DefineFastInt("AXAnimatedScrollingFrameScrollTimeMs", 200)

local num2 = if num1 > 0 then num1 / 1000 else 0.2

local function useAXAnimateScrollFrame(tbl1, num3: number?)
    return useAnimateScrollViewToSelection(tbl1, if UserGameSettings.ReducedMotion then 0 else num3 or num2)
end

return useAXAnimateScrollFrame
