-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T05:31:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local MomentsCommon = require(MomentsParent.MomentsCommon)
local MomentsTypes = require(MomentsParent.MomentsTypes)

local Analytics = MomentsCommon.Analytics
local MomentStatus = MomentsTypes.Enums.MomentStatus

local function reportUnavailableFeedItem(arg1, str1: string)
    if arg1.status == MomentStatus.Deleted then
        Analytics.reportMomentsFeedItemFiltered("deleted", str1)
    elseif arg1.isModerated == true then
        Analytics.reportMomentsFeedItemFiltered("moderated", str1)
    end
end

return reportUnavailableFeedItem
