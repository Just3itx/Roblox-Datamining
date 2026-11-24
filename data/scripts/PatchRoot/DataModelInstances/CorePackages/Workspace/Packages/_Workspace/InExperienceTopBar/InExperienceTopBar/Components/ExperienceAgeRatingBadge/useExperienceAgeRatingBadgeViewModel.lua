-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T22:10:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceTopBarParent = script:FindFirstAncestor("InExperienceTopBar").Parent

local DataHydration = require(InExperienceTopBarParent.DataHydration)
local React = require(InExperienceTopBarParent.React)
local Signals = require(InExperienceTopBarParent.Signals)
local SignalsReact = require(InExperienceTopBarParent.SignalsReact)
local _ExperienceAgeRatingBadgeView = require(script.Parent.ExperienceAgeRatingBadgeView)
local DataStatus = DataHydration.DataStatus

local function useExperienceAgeRatingBadgeViewModel(tbl1)
    local universeId = tbl1.universeId

    local var1 = React.useMemo(function()
        return Signals.createComputed(function(arg1)
            local var1 = DataHydration.Game.getAgeRecommendationStore(arg1).getAndFetchAgeRecommendation(universeId)
            local var2 = var1.status(arg1)
            if var2 == DataStatus.Failed then
                return "12+"
            end

            if var2 == DataStatus.NotReady then
                return nil
            end
            local var3 = var1.data(arg1)
            return var3 and var3.minimumAgeDisplay or "12+"
        end)
    end, { universeId })
    local text = SignalsReact.useSignalState(var1)

    if text == nil then
        return nil
    end

    return {
        text = text,
        layoutOrder = tbl1.layoutOrder,
        onAbsoluteSizeChanged = tbl1.onAbsoluteSizeChanged,
        onAbsolutePositionChanged = tbl1.onAbsolutePositionChanged
    }
end

return useExperienceAgeRatingBadgeViewModel
