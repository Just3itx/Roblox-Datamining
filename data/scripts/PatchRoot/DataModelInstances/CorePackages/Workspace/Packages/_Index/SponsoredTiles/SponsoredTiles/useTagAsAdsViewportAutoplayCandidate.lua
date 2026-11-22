-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T22:00:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CollectionService = game:GetService("CollectionService")

local SponsoredTilesParent = script:FindFirstAncestor("SponsoredTiles").Parent

local React = require(SponsoredTilesParent.React)
local VideoEndReason = require(SponsoredTilesParent.VideoUtils).AnalyticsEnums.VideoEndReason

local AdsViewportAutoplayCandidateTag = require(script.Parent.AdsViewportAutoplayCandidateTag)

local function useTagAsAdsViewportAutoplayCandidate(tbl1, arg1)
    React.useEffect(function()
        if not arg1 then
            return
        end

        local current = tbl1.current
        if not current then
            return
        end

        CollectionService:AddTag(current, AdsViewportAutoplayCandidateTag)
        arg1:onAdsCandidateRegistered(current)

        return function()
            CollectionService:RemoveTag(current, AdsViewportAutoplayCandidateTag)
            arg1:resetIfActiveInstance(current, VideoEndReason.Unmounted)
        end
    end, { arg1, tbl1 })
end

return useTagAsAdsViewportAutoplayCandidate
