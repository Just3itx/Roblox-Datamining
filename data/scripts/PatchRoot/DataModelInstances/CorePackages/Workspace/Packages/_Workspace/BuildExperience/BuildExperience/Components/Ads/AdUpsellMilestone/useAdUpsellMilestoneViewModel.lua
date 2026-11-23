-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:01:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local React = require(BuildExperienceParent.React)

local adUpsellVisibilityUtils = require(script.Parent.adUpsellVisibilityUtils)
local _AdUpsellMilestoneView = require(script.Parent.AdUpsellMilestoneView)
local FFlagBuildAgentAdCampaignCard = require(BuildExperience.Flags.FFlagBuildAgentAdCampaignCard)
local FFlagBuildAdUpsellPinned = require(BuildExperience.Flags.FFlagBuildAdUpsellPinned)

local function useAdUpsellMilestoneViewModel(tbl1)
    local cardRef = React.useRef(nil)
    local var2 = React.useRef(nil)

    React.useEffect(function()
        if tbl1.isImpressed then
            var2.current = tbl1.anchorId
            return
        end

        if var2.current == tbl1.anchorId then
            return
        end

        local current = cardRef.current
        if FFlagBuildAdUpsellPinned then
            if current == nil or not tbl1.isPageVisible then
                return
            end
            var2.current = tbl1.anchorId
            tbl1.onImpression(tbl1.anchorId)
            return
        end
        local current2 = tbl1.scrollingFrameRef and tbl1.scrollingFrameRef.current
        if current2 == nil or current == nil then
            return
        end

        local tbl2 = {}
        local bool1 = false
        local function disconnectListeners() -- Luacid: Inlined by compiler; 1 call site recovered
            if bool1 then
                return
            end
            bool1 = true
            for _, value in tbl2 do
                value:Disconnect()
            end
            table.clear(tbl2)
        end
        local function reportIfVisible()
            if var2.current ~= tbl1.anchorId
                and tbl1.isPageVisible
                and current:IsDescendantOf(current2)
                and adUpsellVisibilityUtils.isCardVisibleInScrollViewport(current2, current)
            then
                var2.current = tbl1.anchorId
                tbl1.onImpression(tbl1.anchorId)
                disconnectListeners()
            end
        end

        tbl2 = {
            current2:GetPropertyChangedSignal("CanvasPosition"):Connect(reportIfVisible),
            current2:GetPropertyChangedSignal("AbsolutePosition"):Connect(reportIfVisible),
            current2:GetPropertyChangedSignal("AbsoluteWindowSize"):Connect(reportIfVisible),
            current:GetPropertyChangedSignal("AbsolutePosition"):Connect(reportIfVisible),
            current:GetPropertyChangedSignal("AbsoluteSize"):Connect(reportIfVisible)
        }
        reportIfVisible()
        return disconnectListeners
    end, {
        tbl1.anchorId,
        tbl1.isImpressed,
        tbl1.isPageVisible,
        tbl1.onImpression,
        tbl1.scrollingFrameRef
    })

    return {
        order = tbl1.order,
        congratsText = tbl1.congratsText,
        freePromotionsRemaining = if FFlagBuildAgentAdCampaignCard then tbl1.freePromotionsRemaining else nil,
        cardRef = cardRef,
        isCreatePending = tbl1.isCreatePending,
        isCreateDisabled = tbl1.isCreateDisabled,
        onCreate = tbl1.onCreate,
        onDismiss = tbl1.onDismiss
    }
end

return useAdUpsellMilestoneViewModel
