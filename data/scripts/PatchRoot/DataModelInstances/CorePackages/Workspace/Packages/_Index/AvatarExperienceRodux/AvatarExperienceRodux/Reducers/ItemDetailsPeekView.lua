-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T04:20:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceRodux = script:FindFirstAncestor("AvatarExperienceRodux")
local AvatarExperienceRoduxParent = AvatarExperienceRodux.Parent

local Cryo = require(AvatarExperienceRoduxParent.Cryo)
local PeekViewState = require(AvatarExperienceRoduxParent.PeekView).PeekViewState
local AvatarExperienceCommon = require(AvatarExperienceRoduxParent.AvatarExperienceCommon)
local Rodux = require(AvatarExperienceRoduxParent.Rodux)

local SetItemDetailsPeekViewState = require(AvatarExperienceRodux.Actions.SetItemDetailsPeekViewState)
local SetItemTryOnPeekViewState = require(AvatarExperienceRodux.Actions.SetItemTryOnPeekViewState)
local SetTryOnManagerPeekViewState = require(AvatarExperienceRodux.Actions.SetTryOnManagerPeekViewState)
local SetLookDetailsPeekViewSelectedTab = require(AvatarExperienceRodux.Actions.SetLookDetailsPeekViewSelectedTab)

local CharacterHistoryStateChangeButtonActivated = AvatarExperienceCommon.State.Actions.CharacterHistoryStateChangeButtonActivated

local tbl1 = {
    viewState = PeekViewState.Closed,
    tryOnViewState = PeekViewState.Closed,
    tryOnManagerViewState = PeekViewState.Closed,
    lookDetailsSelectedTab = 2
}

local createReducer = Rodux.createReducer
local tbl2 = {}
tbl2[SetItemDetailsPeekViewState.name] = function(tbl3, tbl4)
    return Cryo.Dictionary.join(tbl3, { viewState = tbl4.viewState })
end

tbl2[SetItemTryOnPeekViewState.name] = function(tbl3, tbl4)
    return Cryo.Dictionary.join(tbl3, { tryOnViewState = tbl4.viewState })
end

tbl2[SetTryOnManagerPeekViewState.name] = function(tbl3, tbl4)
    return Cryo.Dictionary.join(tbl3, { tryOnManagerViewState = tbl4.viewState })
end

tbl2[SetLookDetailsPeekViewSelectedTab.name] = function(tbl3, tbl4)
    return Cryo.Dictionary.join(tbl3, { lookDetailsSelectedTab = tbl4.selectedTab })
end

tbl2[CharacterHistoryStateChangeButtonActivated.name] = function(tbl3, arg1)
    if not (arg1.tryOn and arg1.tryOn.OutfitTryOn) then
        return tbl3
    end

    local lookId = arg1.tryOn.OutfitTryOn.LookId
    local bool1 = not (lookId == nil) and lookId ~= Cryo.None
    local bool2 = bool1 and tbl3.tryOnManagerViewState == PeekViewState.Closed
    local bool3 = not bool1 and tbl3.tryOnManagerViewState ~= PeekViewState.Closed
    return Cryo.Dictionary.join(tbl3, {
        tryOnManagerViewState = if bool2 then PeekViewState.SuperBrief elseif bool3 then PeekViewState.Closed else tbl3.tryOnManagerViewState
    })
end

return createReducer(tbl1, tbl2)
