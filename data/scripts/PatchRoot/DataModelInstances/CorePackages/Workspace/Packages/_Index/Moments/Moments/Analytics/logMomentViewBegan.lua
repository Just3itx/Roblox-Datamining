-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T03:40:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local MomentsCommon = require(MomentsParent.MomentsCommon)
local _MomentsTypes = require(MomentsParent.MomentsTypes)

local makeMomentViewBeganFields = require(script.Parent.makeMomentViewBeganFields)

local Analytics = MomentsCommon.Analytics
local EventNames = Analytics.EventNames

local function logMomentViewBegan(arg1, str1: string, str2: string?, bool1: boolean?)
    Analytics.reportMomentsViewBegan(str1)

    local momentViewBeganFields = makeMomentViewBeganFields(arg1, str1, str2, bool1)
    if momentViewBeganFields ~= nil then
        Analytics.fireAnalyticsEvent(EventNames.MomentViewBegan, momentViewBeganFields)
    end
end

return logMomentViewBegan
