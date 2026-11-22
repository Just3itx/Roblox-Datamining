-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T17:01:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local LocalizationService = game:GetService("LocalizationService")

local SocialCardsParent = script:FindFirstAncestor("SocialCards").Parent

local Cryo = require(SocialCardsParent.Cryo)
local Foundation = require(SocialCardsParent.Foundation)
local React = require(SocialCardsParent.React)
local SquadExternalContractProvider = require(SocialCardsParent.SquadsCore.SquadExternalContractProvider)
local _Types = require(SocialCardsParent.SquadsCore.Types)
local useLocalization = require(SocialCardsParent.Localization).Hooks.useLocalization
local useNavigation = require(SocialCardsParent.Navigation).useNavigation
local UserProfileStore = require(SocialCardsParent.UserProfiles).Stores.UserProfileStore

local AvatarGroup = Foundation.AvatarGroup
local AvatarGroupType = Foundation.Enums.AvatarGroupType
local InputSize = Foundation.Enums.InputSize
local useTokens = Foundation.Hooks.useTokens

local ScheduledSquadActionEnum = require(SocialCardsParent.Squads.Enums).ScheduledSquadActionEnum
local ScheduledSquadActionSourceEnum = require(SocialCardsParent.Squads.Enums).ScheduledSquadActionSourceEnum
local ScheduledSquadsMoreInfoSheet = require(SocialCardsParent.Squads.Components).ScheduledSquadsMoreInfoSheet
local SquadButtonSourceEnum = require(SocialCardsParent.Squads.Enums).SquadButtonSourceEnum
local SquadComponentAccessWrapper = require(SocialCardsParent.Squads.Components).SquadComponentAccessWrapper
local SquadJoinButton = require(SocialCardsParent.Squads.Components).SquadJoinButton

local GetScheduledSquadsStore = require(SocialCardsParent.SquadsCore.Stores).GetScheduledSquadsStore
local SquadExternalContractContext = SquadExternalContractProvider.SquadExternalContractContext
local EventNames = require(SocialCardsParent.SquadsCore.EventNames)
local useCurrentSquadId = require(SocialCardsParent.SquadsCore.Hooks).useCurrentSquadId
local useScheduledSquad = require(SocialCardsParent.SquadsCore.Hooks).useScheduledSquad

local num1 = game:DefineFastInt("ScheduledSquadJustStartedThreshold", 300)

return function(arg1)
    local var1 = useTokens()
    local var2 = useNavigation()
    local var3 = React.useContext(SquadExternalContractContext)
    local squadId = useCurrentSquadId()

    local bool1 = arg1.startTime == nil
    local isOpen, var6 = React.useState(false)
    local var7, var8 = React.useState(true)
    local var9, var10 = React.useState(true)
    local displayName, var12 = React.useState("")
    local scheduledSquad = useScheduledSquad(arg1.scheduledGroupUpId)

    local var14 = React.useMemo(function()
        if arg1.startTime then
            return DateTime.fromIsoDate(arg1.startTime)
        end

        return nil
    end, { arg1.startTime })
    local var15 = React.useMemo(function()
        return var14 and var14.UnixTimestamp < DateTime.now().UnixTimestamp
    end, { var14 })
    local var16 = React.useMemo(function()
        local bool2 = var14
        return bool2
            and var14.UnixTimestamp <= DateTime.now().UnixTimestamp
            and DateTime.now().UnixTimestamp - var14.UnixTimestamp < num1
    end, { var14 })

    local avatars = React.useMemo(function()
        return Cryo.List.map((scheduledSquad or arg1).subscribers, function(arg2)
            return arg2.userId
        end)
    end, { scheduledSquad, arg1 })

    React.useEffect(function()
        if not (bool1 or var15) then
            GetScheduledSquadsStore(false).fetchAndCacheScheduledSquadStatus(arg1.scheduledGroupUpId, function()
                var10(false)
            end)

            return
        end

        var10(false)
    end, { bool1, var15, arg1.scheduledGroupUpId })

    React.useEffect(function()
        if bool1 or var15 then
            var8(false)
            return
        end
        local fetchNamesByUserIds = UserProfileStore.get().fetchNamesByUserIds
        local tbl1 = { tostring(if scheduledSquad then scheduledSquad.initiatorId else arg1.initiatorId) }

        fetchNamesByUserIds(tbl1, function(arg2)
            local status = arg2.status
            local data = arg2.data
            if status == "success" then
                var12(data[1].names.getDisplayName(false))
                var8(false)
            elseif status == "failed" then
                var8(false)
            end
        end)
    end, {
        arg1 and arg1.initiatorId,
        bool1,
        var15,
        scheduledSquad and scheduledSquad.initiatorId
    })

    local var18 = useLocalization({
        deletedScheduledPartyText = "Feature.Squads.Label.DeletedScheduledParty",
        goingText = "Feature.Squads.Description.Going",
        partyText = "Feature.Squads.Label.Party",
        scheduledPartyText = "Feature.Squads.Label.ScheduledParty",
        usersPartyText = { "Feature.Squads.Label.UsersParty", displayName = displayName }
    })

    local var19 = if var14 then var14:FormatLocalTime("llll", LocalizationService.RobloxLocaleId) else ""

    local onActivated = React.useCallback(function()
        var6(true)

        var3.fireSquadAnalytics(EventNames.ScheduledSquadAction, {
            actionType = ScheduledSquadActionEnum.SeeMoreDetails,
            conversationId = arg1.parentChannelId,
            scheduledSquadId = if scheduledSquad then scheduledSquad.scheduledGroupUpId else arg1.scheduledGroupUpId,
            source = ScheduledSquadActionSourceEnum.ScheduledSquadCard,
            squadId = squadId,
            squadLocation = var3.squadLocation
        })
    end, {
        squadId,
        arg1 and arg1.scheduledGroupUpId,
        arg1.parentChannelId,
        scheduledSquad and scheduledSquad.scheduledGroupUpId,
        var6,
        var3.fireSquadAnalytics,
        var3.squadLocation
    })

    local onClose = React.useCallback(function()
        var6(false)
    end, { var6 })

    local var4 = React.useCallback(function()
        var2.navigate(
            "SquadLobby",
            {
                conversationId = arg1.parentChannelId,
                extraParams = {
                    scheduledGroupUpId = tostring(arg1.scheduledGroupUpId)
                }
            }
        )
    end, { var2.navigate, arg1.parentChannelId, arg1.scheduledGroupUpId })

    if var7 or var9 then
        return React.createElement(Foundation.View, { tag = "size-full-800" }, {
            Skeleton = React.createElement(
                Foundation.Skeleton,
                {
                    Size = UDim2.new(0, 280, 0, var1.Size.Size_2500),
                    radius = Foundation.Enums.Radius.Large
                }
            )
        })
    end
    local createElement = React.createElement
    local view = Foundation.View
    local tbl1 = {
        onActivated = onActivated,
        Size = UDim2.new(0, 280, 0, 0),
        tag = "auto-y bg-shift-200 radius-large col padding-y-medium padding-x-large align-x-center gap-medium flex-fill"
    }
    local tbl2 = { TextContainer = 0, Interested = 0, JoinButton = 0, Sheet = 0 }
    local createElement2 = React.createElement
    local view2 = Foundation.View
    local tbl3 = { LayoutOrder = 1, tag = "auto-y size-full-0 col gap-xsmall" }

    local tbl4 = {
        Title = React.createElement(Foundation.Text, {
            LayoutOrder = 1,
            tag = "auto-y size-full-0 text-title-large text-align-x-left content-emphasis text-wrap",
            Text = if bool1 then var18.deletedScheduledPartyText elseif var15 then var18.partyText else var18.usersPartyText
        }),
        Date = if bool1 then nil else React.createElement(Foundation.Text, {
            LayoutOrder = 2,
            tag = "auto-y size-full-0 text-body-medium text-align-x-left content-default text-wrap",
            Text = var19
        })
    }
    tbl2.TextContainer = createElement2(view2, tbl3, tbl4)
    local element

    if bool1 then
        element = nil
    else
        element = React.createElement(
            Foundation.View,
            {
                LayoutOrder = 2,
                tag = "row size-full-0 auto-y gap-small align-x-left align-y-center"
            },
            {
                AvatarGroup = React.createElement(AvatarGroup, {
                    avatars = avatars,
                    backplateStyle = {
                        Color3 = var1.Color.Shift.Shift_200.Color3,
                        Transparency = var1.Color.Shift.Shift_200.Transparency
                    },
                    LayoutOrder = 1,
                    max = 4,
                    size = InputSize.XSmall,
                    type = AvatarGroupType.Stacked
                }),
                InterestedCount = React.createElement(
                    Foundation.Text,
                    {
                        LayoutOrder = 2,
                        tag = "auto-xy text-body-medium content-default",
                        Text = `{var18.goingText}`
                    }
                )
            }
        )
    end

    tbl2.Interested = element

    tbl2.JoinButton = if var16 then React.createElement(
        SquadComponentAccessWrapper,
        {
            parentChannelId = arg1.parentChannelId
        },
        { React.createElement(SquadJoinButton, {
                conversationId = arg1.parentChannelId,
                isFullWidth = true,
                isInCard = true,
                layoutOrder = 3,
                onActivated = var4,
                shouldAnimate = false,
                squadButtonSource = SquadButtonSourceEnum.ScheduledSquadCard,
                squadLocation = var3.squadLocation
            }) }
    ) else nil

    tbl2.Sheet = if bool1 then nil else React.createElement(
        ScheduledSquadsMoreInfoSheet,
        {
            isOpen = isOpen,
            onClose = onClose,
            scheduledSquad = scheduledSquad or arg1
        }
    )
    return createElement(view, tbl1, tbl2)
end
