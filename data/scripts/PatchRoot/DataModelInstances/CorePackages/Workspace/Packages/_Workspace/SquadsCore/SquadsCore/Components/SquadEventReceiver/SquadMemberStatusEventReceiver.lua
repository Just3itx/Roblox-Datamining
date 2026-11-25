-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T17:41:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SquadsCoreParent = script:FindFirstAncestor("SquadsCore").Parent
local GuiService = game:GetService("GuiService")

local Cryo = require(SquadsCoreParent.Cryo)
local getStandardSizeAvatarHeadShotRbxthumb = require(SquadsCoreParent.UserLib).Utils.getStandardSizeAvatarHeadShotRbxthumb
local React = require(SquadsCoreParent.React)
local RoduxSquads = require(SquadsCoreParent.RoduxSquads)
local useLocalUserId = require(SquadsCoreParent.RobloxAppHooks).useLocalUserId
local useLocalization = require(SquadsCoreParent.Localization).Hooks.useLocalization
local UserProfileStore = require(SquadsCoreParent.UserProfiles).Stores.UserProfileStore
local useSelector = require(SquadsCoreParent.RoactUtils).Hooks.RoactRodux.useSelector

local useCurrentSquadSelector = RoduxSquads.Hooks.useCurrentSquadSelector

return function()
    local var1 = useCurrentSquadSelector()
    local var2 = useLocalUserId()
    local var3 = React.useRef(nil)

    local var4 = useLocalization({
        friendJoinedYourPartyText = "Feature.Squads.Label.FriendJoinedYourParty",
        multiplePeopleJoinedYourPartyText = "Feature.Squads.Label.MultiplePeopleJoinedYourParty",
        twoFriendsJoinedYourPartyText = "Feature.Squads.Label.TwoFriendsJoinedYourParty"
    })

    local var5 = React.useCallback(function(arg1)
        return arg1.Squad.UserBlocking.isBlockedByMe
    end, {})
    local var6 = useSelector(var5)

    React.useEffect(function()
        local members = if var1 then var1.members else nil

        if var3.current and members then
            local var7 = Cryo.List.toSet(Cryo.List.map(var3.current, function(arg1): string
                return tostring(arg1.userId)
            end))

            local tbl1 = {}
            for _, member in members do
                local str1 = tostring(member.userId)

                if not var7[str1] and str1 ~= var2 and not var6[str1] then
                    table.insert(tbl1, str1)
                end
            end

            local num1 = #tbl1
            if num1 > 0 then
                if num1 > 2 then
                    GuiService:SendNotification(
                        {
                            Title = var4.multiplePeopleJoinedYourPartyText,
                            Icon = getStandardSizeAvatarHeadShotRbxthumb(tbl1[1])
                        }
                    )
                else
                    UserProfileStore.get().fetchNamesByUserIds(tbl1, function(arg1)
                        if not (#arg1.data > 0) or arg1.status ~= "success" then
                            return
                        end

                        local var8

                        if num1 == 1 then
                            var8 = var4.friendJoinedYourPartyText:gsub("{(.-)}", { combinedName = arg1.data[1].names.getCombinedName(false) })
                        else
                            var8 = var4.twoFriendsJoinedYourPartyText:gsub(
                                "{(.-)}",
                                {
                                    combinedName1 = arg1.data[1].names.getCombinedName(false),
                                    combinedName2 = arg1.data[2].names.getCombinedName(false)
                                }
                            )
                        end

                        local icon = if num1 == 1 then getStandardSizeAvatarHeadShotRbxthumb(tbl1[1]) else getStandardSizeAvatarHeadShotRbxthumb(tbl1[1])
                        GuiService:SendNotification({ Title = var8, Icon = icon })
                    end)
                end
            end
        end

        var3.current = members
    end, { var1 and var1.members })

    return nil
end
