-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T14:40:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameInviteParent = script:FindFirstAncestor("GameInvite").Parent

local ExperienceService = require(GameInviteParent.ExperienceService)
local isSubjectToDesktopPolicies = require(GameInviteParent.SharedFlags).isSubjectToDesktopPolicies

local ExperienceService2 = ExperienceService.ExperienceService
local GameParams = ExperienceService.GameParams

local function joinFriendFromExperience(tbl1)
    local var1 = if tbl1.placeId ~= "" then tbl1.placeId else tbl1.rootPlaceId
    local params = GameParams.fromParams(
        {
            userId = tbl1.userId,
            placeId = if var1 == "" then nil else tonumber(var1),
            referralPage = "GameInviteFriendsList"
        }
    )

    if not isSubjectToDesktopPolicies() then
        game:Shutdown()
    end
    ExperienceService2:LaunchExperience(params, "GameInviteFriendsListFromInExp", nil)
end

return joinFriendFromExperience
