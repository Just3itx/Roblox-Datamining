-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T22:40:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local LocalizationService = game:GetService("LocalizationService")

local Squads = script:FindFirstAncestor("Squads")
local SquadsParent = Squads.Parent
local FFlagSquadsUseProfileFrameThumbnail = require(Squads.Flags.FFlagSquadsUseProfileFrameThumbnail)
local FFlagSquadsEnableFoundationTestIds = require(Squads.Flags.FFlagSquadsEnableFoundationTestIds)

local Cryo = require(SquadsParent.Cryo)
local Foundation = require(SquadsParent.Foundation)
local React = require(SquadsParent.React)
local SquadExternalContractProvider = require(SquadsParent.SquadsCore.SquadExternalContractProvider)
local _Types = require(SquadsParent.SquadsCore.Types)
local useDispatch = require(SquadsParent.RoactUtils).Hooks.RoactRodux.useDispatch
local useLocalUserId = require(SquadsParent.RobloxAppHooks).useLocalUserId
local useLocalization = require(SquadsParent.Localization).Hooks.useLocalization
local useStore = require(SquadsParent.RoactUtils).Hooks.RoactRodux.useStore
local UserProfileStore = require(SquadsParent.UserProfiles).Stores.UserProfileStore

local Avatar = Foundation.Avatar
local Button = Foundation.Button
local ButtonVariant = Foundation.Enums.ButtonVariant
local Sheet = Foundation.Sheet
local FoundationText = Foundation.Text
local View = Foundation.View

local deleteScheduledSquad = require(SquadsParent.SquadsCore.Thunks).deleteScheduledSquad
local EventNames = require(SquadsParent.SquadsCore.EventNames)
local SquadExternalContractContext = SquadExternalContractProvider.SquadExternalContractContext
local SquadPromptType = require(SquadsParent.SquadsCore.Enums).SquadPromptType
local subscribeToScheduledSquad = require(SquadsParent.SquadsCore.NetworkRequests).subscribeToScheduledSquad
local unsubscribeFromScheduledSquad = require(SquadsParent.SquadsCore.NetworkRequests).unsubscribeFromScheduledSquad
local useCurrentSquadId = require(SquadsParent.SquadsCore.Hooks).useCurrentSquadId

local ScheduledSquadSheet = require(Squads.Components.ScheduledSquads.ScheduledSquadSheet)
local ScheduledSquadActionEnum = require(Squads.Enums.ScheduledSquadActionEnum)
local ScheduledSquadActionSourceEnum = require(Squads.Enums.ScheduledSquadActionSourceEnum)

local function ScheduledSquadsMoreInfoSheet(tbl1)
    local var1 = useDispatch()
    local var2 = useLocalUserId()
    local var3 = React.useContext(SquadExternalContractContext)
    local squadId = useCurrentSquadId()
    local var5 = useStore()
    local var6 = var3.useGetConversationFromId(tbl1.scheduledSquad.parentChannelId)

    local dateTime = DateTime.fromIsoDate(tbl1.scheduledSquad.startTime)
    local var7 = dateTime and dateTime.UnixTimestamp < DateTime.now().UnixTimestamp

    local var8, var9 = React.useState(false)
    local var10, var11 = React.useState(tbl1.scheduledSquad.subscribers)

    local var12 = React.useMemo(function()
        return Cryo.List.map(var10, function(arg1): string
            return tostring(arg1.userId)
        end)
    end, { var10 })

    React.useEffect(function()
        var11(tbl1.scheduledSquad.subscribers)
    end, { tbl1.scheduledSquad.subscribers })

    local bool1 = tostring(tbl1.scheduledSquad.initiatorId) == tostring(var2)
    local var13 = React.useMemo(function(): boolean
        return bool1 or Cryo.List.findWhere(var12, function(arg1): boolean
            return arg1 == tostring(var2)
        end) ~= nil
    end, { bool1, var2, var12 })

    local var14, var15 = React.useState({})
    local var16, var17 = React.useState(true)

    local onClose = React.useCallback(function()
        var9(false)
        if tbl1.onClose then
            tbl1.onClose()
        end
    end, { tbl1.onClose })

    local var19 = React.useCallback(function()
        onClose()
        var3.setSquadPrompt(var5, { hideCancelButton = true, promptType = SquadPromptType.Error })
    end, { onClose, var3.setSquadPrompt, var5 })

    local useEffect = React.useEffect
    local function func1()
        var17(true)
        UserProfileStore.get().fetchNamesByUserIds(Cryo.List.join(var12, var6 and var6.participants or {}), function(arg1)
            if arg1.status ~= "success" then
                if arg1.status == "failed" then
                    var17(false)
                    onClose()
                    var19()
                end
                return
            end

            local tbl2 = {}
            for _, value in arg1.data do
                tbl2[value.userId] = value.names.getCombinedName(false)
            end
            var15(tbl2)
            var17(false)
        end)
    end

    local setSquadPrompt = var3.setSquadPrompt
    local participants = if var6 then var6.participants or nil else nil
    useEffect(func1, { onClose, var19, var17, var12, setSquadPrompt, var5, participants })

    local var20 = useLocalization
    local tbl2 = {
        deleteText = "Feature.Squads.Action.Delete",
        dontJoinText = "Feature.Squads.Action.DontJoin",
        editText = "Feature.Squads.Action.Edit",
        goingText = "Feature.Squads.Description.Going",
        joinText = "Feature.Squads.Action.Join",
        notGoingText = "Feature.Squads.Description.NotGoing",
        partyText = "Feature.Squads.Label.Party",
        usersPartyText = 0,
        willYouJoinScheduledPartyText = 0
    }

    local usersPartyText = { [1] = nil, "Feature.Squads.Label.UsersParty" }

    local initiatorId = tbl1.scheduledSquad.initiatorId
    usersPartyText.displayName = var14[tostring(initiatorId)]
    tbl2.usersPartyText = usersPartyText

    local willYouJoinScheduledPartyText = {
        [1] = nil,
        "Feature.Squads.Label.WillYouJoinScheduledParty"
    }
    local initiatorId2 = tbl1.scheduledSquad.initiatorId
    willYouJoinScheduledPartyText.displayName = var14[tostring(initiatorId2)]
    tbl2.willYouJoinScheduledPartyText = willYouJoinScheduledPartyText
    local var21 = var20(tbl2)

    local var22 = React.useMemo(function()
        local result = {}

        for _, value in var10 do
            local str1 = `--social-squad-scheduled-party-info-sheet--going-user-{value.userId}`

            local createElement = React.createElement
            local var22 = View
            local tbl5 = {
                tag = "size-full-0 auto-y row align-x-left align-y-center gap-small",
                testId = if FFlagSquadsEnableFoundationTestIds then str1 else nil
            }
            local tbl6 = {
                Avatar = React.createElement(Avatar, {
                    LayoutOrder = 1,
                    userId = value.userId,
                    includeProfileFrame = FFlagSquadsUseProfileFrameThumbnail,
                    testId = if FFlagSquadsEnableFoundationTestIds then `{str1}--avatar` else nil
                }),
                DisplayName = React.createElement(FoundationText, {
                    LayoutOrder = 2,
                    Text = var14[tostring(value.userId)],
                    tag = "auto-xy fill text-truncate-end text-title-medium text-align-x-left",
                    testId = if FFlagSquadsEnableFoundationTestIds then `{str1}--name` else nil
                })
            }
            table.insert(result, createElement(var22, tbl5, tbl6))
        end

        return result
    end, { var14, var10 })

    local var23 = React.useMemo(function()
        local result = {}

        if var6 and var6.participants then
            local var23 = Cryo.List.toSet(var12)

            for _, userId in var6.participants do
                if var23[tostring(userId)] then
                    continue
                end

                local str1 = `--social-squad-scheduled-party-info-sheet--not-going-user-{userId}`

                local createElement = React.createElement
                local var24 = View
                local tbl5 = {
                    tag = "size-full-0 auto-y row align-x-left align-y-center gap-small padding-y-small",
                    testId = if FFlagSquadsEnableFoundationTestIds then str1 else nil
                }
                local tbl6 = {
                    Avatar = React.createElement(Avatar, {
                        LayoutOrder = 1,
                        userId = userId,
                        includeProfileFrame = FFlagSquadsUseProfileFrameThumbnail,
                        testId = if FFlagSquadsEnableFoundationTestIds then `{str1}--avatar` else nil
                    }),
                    DisplayName = React.createElement(FoundationText, {
                        LayoutOrder = 2,
                        Text = var14[tostring(userId)],
                        tag = "auto-xy fill text-truncate-end text-title-medium text-align-x-left",
                        testId = if FFlagSquadsEnableFoundationTestIds then `{str1}--name` else nil
                    })
                }
                table.insert(result, createElement(var24, tbl5, tbl6))
            end
        end

        return result
    end, { var14, var12, var6 and var6.participants })

    local onActivated = React.useCallback(function()
        onClose()
        var1(deleteScheduledSquad(tbl1.scheduledSquad.scheduledGroupUpId, var3.setSquadPrompt))

        var3.fireSquadAnalytics(EventNames.ScheduledSquadAction, {
            actionType = ScheduledSquadActionEnum.Delete,
            conversationId = tbl1.scheduledSquad.parentChannelId,
            scheduledSquadId = tbl1.scheduledSquad.scheduledGroupUpId,
            source = ScheduledSquadActionSourceEnum.ScheduledSquadsMoreInfoSheet,
            squadId = squadId,
            squadLocation = var3.squadLocation
        })
    end, {
        squadId,
        onClose,
        tbl1.scheduledSquad.parentChannelId,
        tbl1.scheduledSquad.scheduledGroupUpId,
        var3.fireSquadAnalytics,
        var3.setSquadPrompt,
        var3.squadLocation,
        var5
    })

    local function func2()
        var11(Cryo.List.filter(var10, function(arg1): boolean
            return tostring(arg1.userId) ~= tostring(var2)
        end))
    end

    local function func3()
        var11(Cryo.List.join(var10, {{ userId = tostring(var2) }}))
    end

    local var4 = React.useCallback(function()
        if var13 then
            unsubscribeFromScheduledSquad({ scheduledGroupUpId = tbl1.scheduledSquad.scheduledGroupUpId }, func2, var19)
        else
            subscribeToScheduledSquad({ scheduledGroupUpId = tbl1.scheduledSquad.scheduledGroupUpId }, func3, var19)
        end

        onClose()
        var3.fireSquadAnalytics(EventNames.ScheduledSquadAction, {
            actionType = if var13 then ScheduledSquadActionEnum.Unsubscribe else ScheduledSquadActionEnum.Subscribe,
            conversationId = tbl1.scheduledSquad.parentChannelId,
            scheduledSquadId = tbl1.scheduledSquad.scheduledGroupUpId,
            source = ScheduledSquadActionSourceEnum.ScheduledSquadsMoreInfoSheet,
            squadId = squadId,
            squadLocation = var3.squadLocation
        })
    end, {
        var13,
        var3.squadLocation,
        squadId,
        tbl1.scheduledSquad,
        var3.fireSquadAnalytics,
        onClose,
        var19,
        func2,
        func3,
        squadId
    })

    local var18 = React.useCallback(function()
        var9(true)

        var3.fireSquadAnalytics(EventNames.ScheduledSquadAction, {
            actionType = ScheduledSquadActionEnum.Edit,
            conversationId = tbl1.scheduledSquad.parentChannelId,
            scheduledSquadId = tbl1.scheduledSquad.scheduledGroupUpId,
            source = ScheduledSquadActionSourceEnum.ScheduledSquadsMoreInfoSheet,
            squadId = squadId,
            squadLocation = var3.squadLocation
        })
    end, {
        squadId,
        tbl1.scheduledSquad,
        var3.fireSquadAnalytics,
        var3.squadLocation
    })

    if var8 then
        return React.createElement(
            ScheduledSquadSheet,
            {
                isOpen = tbl1.isOpen,
                onClose = onClose,
                scheduledSquad = tbl1.scheduledSquad,
                snapPoints = { 0.4, 0.7 }
            }
        )
    end

    local createElement = React.createElement
    local root = Sheet.Root
    local tbl5 = {
        onClose = onClose,
        isOpen = tbl1.isOpen,
        preferCenterSheet = true,
        snapPoints = { 0.4, 0.7 },
        testId = if FFlagSquadsEnableFoundationTestIds then "--social-squad-scheduled-party-info-sheet" else nil
    }
    local tbl6 = { Header = 0, Content = 0, Actions = 0 }
    local createElement2 = React.createElement
    local header = Sheet.Header
    local tbl7 = {}
    local tbl8 = { View = 0 }
    local createElement3 = React.createElement
    local var27 = View
    local tbl9 = { tag = "size-full-0 auto-y col" }

    local tbl10 = {
        ScheduledSquadTitle = React.createElement(FoundationText, {
            LayoutOrder = 1,
            Text = if not var7 and var13 then var21.usersPartyText elseif var7 or var13 then var21.partyText else var21.willYouJoinScheduledPartyText,
            tag = "size-full-0 auto-y text-heading-medium text-align-x-left text-truncate-end",
            testId = if FFlagSquadsEnableFoundationTestIds then "--social-squad-scheduled-party-info-sheet--title" else nil
        }),
        DateTime = React.createElement(FoundationText, {
            LayoutOrder = 2,
            Text = if dateTime then dateTime:FormatLocalTime("LLL", LocalizationService.RobloxLocaleId) else "",
            tag = "size-full-0 auto-y text-body-medium text-align-x-left",
            testId = if FFlagSquadsEnableFoundationTestIds then "--social-squad-scheduled-party-info-sheet--date-time" else nil
        })
    }
    tbl8.View = createElement3(var27, tbl9, tbl10)
    tbl6.Header = createElement2(header, tbl7, tbl8)

    local createElement4 = React.createElement
    local content = Sheet.Content
    local tbl11 = {}
    local tbl12 = {
        Loading = if var16 then React.createElement(
            Foundation.Loading,
            {
                testId = if FFlagSquadsEnableFoundationTestIds then "--social-squad-scheduled-party-info-sheet--loading" else nil
            }
        ) else nil,
        View = 0
    }
    local element

    if var16 then
        element = nil
    else
        element = React.createElement(View, {
            tag = "size-full-0 auto-y col gap-small padding-y-small"
        }, {
            SubscribedUsersText = React.createElement(FoundationText, {
                LayoutOrder = 1,
                Text = `{var21.goingText}`,
                tag = "size-full-0 auto-y content-emphasis text-align-x-left",
                testId = if FFlagSquadsEnableFoundationTestIds then "--social-squad-scheduled-party-info-sheet--going-label" else nil
            }),
            SubscribedUsers = React.createElement(View, { LayoutOrder = 2, tag = "size-full-0 auto-y col gap-small" }, unpack(var22)),
            NotSubscribedUsersText = React.createElement(FoundationText, {
                LayoutOrder = 3,
                Text = `{var21.notGoingText}`,
                tag = "size-full-0 auto-y content-emphasis text-align-x-left",
                testId = if FFlagSquadsEnableFoundationTestIds then "--social-squad-scheduled-party-info-sheet--not-going-label" else nil
            }),
            NotSubscribedUsers = React.createElement(View, { LayoutOrder = 4, tag = "size-full-0 auto-y col gap-small" }, unpack(var23))
        })
    end

    tbl12.View = element
    tbl6.Content = createElement4(content, tbl11, tbl12)
    local element2

    if var7 then
        element2 = nil
    else
        element2 = React.createElement(Sheet.Actions, {}, {
            React.createElement(View, { tag = "size-full-0 auto-y col gap-small" }, {
                JoinButton = if bool1 or var13 then nil else React.createElement(Button, {
                    LayoutOrder = 1,
                    onActivated = var4,
                    text = var21.joinText,
                    variant = ButtonVariant.Emphasis,
                    width = UDim.new(1, 0),
                    testId = if FFlagSquadsEnableFoundationTestIds then "--social-squad-scheduled-party-info-sheet--join-button" else nil
                }),
                DontJoinButton = if bool1 or not var13 then nil else React.createElement(Button, {
                    LayoutOrder = 2,
                    onActivated = var4,
                    text = var21.dontJoinText,
                    variant = ButtonVariant.Standard,
                    width = UDim.new(1, 0),
                    testId = if FFlagSquadsEnableFoundationTestIds then "--social-squad-scheduled-party-info-sheet--dont-join-button" else nil
                }),
                EditButton = if bool1 then React.createElement(Button, {
                    LayoutOrder = 3,
                    onActivated = var18,
                    text = var21.editText,
                    variant = ButtonVariant.Standard,
                    width = UDim.new(1, 0),
                    testId = if FFlagSquadsEnableFoundationTestIds then "--social-squad-scheduled-party-info-sheet--edit-button" else nil
                }) else nil,
                DeleteButton = if bool1 then React.createElement(Button, {
                    LayoutOrder = 4,
                    onActivated = onActivated,
                    text = var21.deleteText,
                    variant = ButtonVariant.Alert,
                    width = UDim.new(1, 0),
                    testId = if FFlagSquadsEnableFoundationTestIds then "--social-squad-scheduled-party-info-sheet--delete-button" else nil
                }) else nil
            })
        })
    end

    tbl6.Actions = element2
    return (createElement(root, tbl5, tbl6))
end

return ScheduledSquadsMoreInfoSheet
