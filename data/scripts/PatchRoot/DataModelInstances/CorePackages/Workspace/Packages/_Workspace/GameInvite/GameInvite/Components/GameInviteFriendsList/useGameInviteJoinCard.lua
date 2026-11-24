-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T14:40:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameInvite = script:FindFirstAncestor("GameInvite")
local GameInviteParent = GameInvite.Parent
local React = require(GameInviteParent.React)
local DataHydration = require(GameInviteParent.DataHydration)

local GameInviteLeaveServerConfirmation = require(script.Parent.GameInviteLeaveServerConfirmation)
local joinFriendFromExperience = require(script.Parent.joinFriendFromExperience)
local isInOtherServerOfThisExperience = require(GameInvite.utils.isInOtherServerOfThisExperience)

local tbl1 = { skipFetch = true }

local function getInExperienceGameJoinCard() -- Luacid: Inlined by compiler; 1 call site recovered
    return require(GameInviteParent.GameJoinCard).getInExperienceGameJoinCard()
end

local function useGameInviteJoinCard(str1: string, str2: string)
    local var1, var2 = React.useState(nil)

    local open = React.useCallback(function(userId: string)
        local var3 = DataHydration.Presence.PresenceStore.get().GetPresenceByUserId(userId, tbl1).data(false)
        var2({ userId = userId, isLeavingServer = isInOtherServerOfThisExperience(var3, str1, str2) })
    end, { str1, str2 })

    local close = React.useCallback(function()
        var2(nil)
    end, {})

    local cardComponent = if var1 == nil then nil elseif var1.isLeavingServer then GameInviteLeaveServerConfirmation else getInExperienceGameJoinCard()
    return {
        userId = if var1 then var1.userId else nil,
        open = open,
        close = close,
        join = joinFriendFromExperience,
        cardComponent = cardComponent
    }
end

return useGameInviteJoinCard
