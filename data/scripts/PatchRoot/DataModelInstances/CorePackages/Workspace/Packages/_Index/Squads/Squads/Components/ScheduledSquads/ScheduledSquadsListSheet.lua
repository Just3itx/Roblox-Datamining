-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T22:40:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local LocalizationService = game:GetService("LocalizationService")

local Squads = script:FindFirstAncestor("Squads")
local SquadsParent = Squads.Parent

local FFlagSquadsEnableFoundationTestIds = require(Squads.Flags.FFlagSquadsEnableFoundationTestIds)

local Cryo = require(SquadsParent.Cryo)
local Foundation = require(SquadsParent.Foundation)
local React = require(SquadsParent.React)
local SquadExternalContractProvider = require(SquadsParent.SquadsCore.SquadExternalContractProvider)
local _Types = require(SquadsParent.SquadsCore.Types)
local useLocalUserId = require(SquadsParent.RobloxAppHooks).useLocalUserId
local useLocalization = require(SquadsParent.Localization).Hooks.useLocalization
local useNavigation = require(SquadsParent.Navigation).useNavigation
local useStore = require(SquadsParent.RoactUtils).Hooks.RoactRodux.useStore

local AvatarGroup = Foundation.AvatarGroup
local AvatarGroupType = Foundation.Enums.AvatarGroupType
local Button = Foundation.Button
local ButtonVariant = Foundation.Enums.ButtonVariant
local InputSize = Foundation.Enums.InputSize
local Loading = Foundation.Loading
local Sheet = Foundation.Sheet
local FoundationText = Foundation.Text
local useTokens = Foundation.Hooks.useTokens
local View = Foundation.View

local getSubscribedScheduledSquads = require(SquadsParent.SquadsCore.NetworkRequests).getSubscribedScheduledSquads
local SquadExternalContractContext = SquadExternalContractProvider.SquadExternalContractContext
local SquadPromptType = require(SquadsParent.SquadsCore.Enums).SquadPromptType
local EventNames = require(SquadsParent.SquadsCore.EventNames)
local subscribeToScheduledSquad = require(SquadsParent.SquadsCore.NetworkRequests).subscribeToScheduledSquad
local unsubscribeFromScheduledSquad = require(SquadsParent.SquadsCore.NetworkRequests).unsubscribeFromScheduledSquad
local useCurrentSquadId = require(SquadsParent.SquadsCore.Hooks).useCurrentSquadId

local ScheduledSquadActionEnum = require(Squads.Enums.ScheduledSquadActionEnum)
local ScheduledSquadActionSourceEnum = require(Squads.Enums.ScheduledSquadActionSourceEnum)

return function(tbl1)
    local userId = useLocalUserId()
    local var2 = useNavigation()
    local var3 = useTokens()
    local var4 = useStore()
    local var5 = React.useContext(SquadExternalContractContext)
    local squadId = useCurrentSquadId()

    local var7 = useLocalization({
        editText = "Feature.Squads.Action.Edit",
        goingText = "Feature.Squads.Description.Going",
        interestedText = "Feature.Squads.Description.Interested",
        noScheduledSquadsText = "Feature.Squads.Description.YouHaveNoScheduledParties",
        scheduledPartyText = "Feature.Squads.Label.ScheduledParty",
        upcomingPartiesText = "Feature.Squads.Label.UpcomingParties"
    })

    local var8, var9 = React.useState(true)
    local var10, var11 = React.useState({})

    local onClose = React.useCallback(function()
        if tbl1.onClose then
            tbl1.onClose()
        end
    end, { tbl1.onClose })

    React.useEffect(function()
        if not tbl1.isOpen then
            return
        end

        getSubscribedScheduledSquads(function(arg1)
            var9(false)
            var11(arg1.scheduledGroupUps)
        end, function()
            var5.setSquadPrompt(var4, { hideCancelButton = true, promptType = SquadPromptType.Error })

            onClose()
        end)
    end, {
        getSubscribedScheduledSquads,
        tbl1.isOpen,
        onClose,
        var9,
        var11,
        var5.setSquadPrompt,
        var4
    })

    local var13 = React.useCallback(function()
        var5.setSquadPrompt(var4, { hideCancelButton = true, promptType = SquadPromptType.Error })
    end, { var5.setSquadPrompt, var4 })

    local var14 = React.useMemo(function()
        local result = {}

        for value, additionalInfo in var10 do
            local bool1 = tostring(additionalInfo.initiatorId) == tostring(userId)

            local avatars = Cryo.List.map(additionalInfo.subscribers, function(arg1)
                return arg1.userId
            end)

            local bool2 = bool1 or Cryo.List.findWhere(avatars, function(arg1): boolean
                return tostring(arg1) == tostring(userId)
            end) ~= nil

            local dateTime = DateTime.fromIsoDate(additionalInfo.startTime)
            local str1 = `--social-squad-scheduled-parties-list-sheet--item-{additionalInfo.scheduledGroupUpId}`

            local createElement = React.createElement
            local var15 = View
            local tbl2 = {
                LayoutOrder = #result + 1,
                onActivated = 0,
                tag = "size-full-0 auto-y col gap-xsmall radius-large padding-y-small padding-x-medium",
                testId = 0
            }

            function tbl2.onActivated()
                onClose()
                var2.navigate("ChatConversation", { conversationId = additionalInfo.parentChannelId })

                var5.fireSquadAnalytics(EventNames.ScheduledSquadAction, {
                    actionType = ScheduledSquadActionEnum.NavigateToAssociatedChat,
                    conversationId = additionalInfo.parentChannelId,
                    scheduledSquadId = additionalInfo.scheduledGroupUpId,
                    source = ScheduledSquadActionSourceEnum.SubscribedScheduledSquadsListSheet,
                    squadId = squadId,
                    squadLocation = var5.squadLocation
                })
            end

            tbl2.testId = if FFlagSquadsEnableFoundationTestIds then str1 else nil
            local tbl3 = {
                TitleText = React.createElement(FoundationText, {
                    LayoutOrder = 1,
                    tag = "size-full-0 auto-y text-title-large text-align-x-left text-truncate-end",
                    Text = var7.scheduledPartyText,
                    testId = if FFlagSquadsEnableFoundationTestIds then `{str1}--title` else nil
                }),
                DateTimeText = React.createElement(FoundationText, {
                    LayoutOrder = 2,
                    tag = "size-full-0 auto-y text-body-medium text-align-x-left text-truncate-end",
                    Text = if dateTime then dateTime:FormatLocalTime("LLL", LocalizationService.RobloxLocaleId) else "",
                    testId = if FFlagSquadsEnableFoundationTestIds then `{str1}--date-time` else nil
                }),
                SubscribedContainer = 0,
                ActionButton = 0
            }
            local createElement2 = React.createElement
            local var16 = View
            local tbl4 = {
                LayoutOrder = 3,
                tag = "size-full-0 auto-y row gap-small padding-y-xsmall align-y-center align-x-left"
            }

            local tbl5 = {
                AvatarGroup = React.createElement(AvatarGroup, {
                    avatars = avatars,
                    backplateStyle = {
                        Color3 = var3.Color.Shift.Shift_200.Color3,
                        Transparency = var3.Color.Shift.Shift_200.Transparency
                    },
                    LayoutOrder = 1,
                    max = 3,
                    type = AvatarGroupType.Stacked,
                    size = InputSize.XSmall,
                    testId = if FFlagSquadsEnableFoundationTestIds then `{str1}--avatar-group` else nil
                }),
                NumberSubscribed = React.createElement(FoundationText, {
                    LayoutOrder = 2,
                    tag = "size-full-0 auto-y text-caption-medium text-align-x-left",
                    Text = `{var7.goingText}`,
                    testId = if FFlagSquadsEnableFoundationTestIds then `{str1}--going-label` else nil
                })
            }
            tbl3.SubscribedContainer = createElement2(var16, tbl4, tbl5)

            local createElement3 = React.createElement
            local var17 = Button
            local tbl6 = {
                LayoutOrder = 4,
                testId = if FFlagSquadsEnableFoundationTestIds then `{str1}--action-button` else nil,
                onActivated = 0,
                text = 0,
                variant = 0,
                width = 0
            }

            function tbl6.onActivated()
                if bool1 then
                    onClose()
                    var5.setSquadPrompt(var4, {
                        additionalInfo = additionalInfo,
                        conversationId = additionalInfo.parentChannelId,
                        promptType = SquadPromptType.ScheduleSquad
                    })
                elseif bool2 then
                    unsubscribeFromScheduledSquad({
                        scheduledGroupUpId = additionalInfo.scheduledGroupUpId
                    }, function()
                        local var18 = Cryo.Dictionary.join(additionalInfo, {
                            subscribers = Cryo.List.filter(additionalInfo.subscribers, function(arg1): boolean
                                return tostring(arg1.userId) ~= tostring(userId)
                            end)
                        })

                        var11(Cryo.List.replaceIndex(var10, value, var18))
                    end, var13)
                else
                    subscribeToScheduledSquad({
                        scheduledGroupUpId = additionalInfo.scheduledGroupUpId
                    }, function()
                        local var18 = Cryo.Dictionary.join(
                            additionalInfo,
                            {
                                subscribers = Cryo.List.join(additionalInfo.subscribers, {{ userId = userId }})
                            }
                        )

                        var11(Cryo.List.replaceIndex(var10, value, var18))
                    end, var13)
                end

                var5.fireSquadAnalytics(EventNames.ScheduledSquadAction, {
                    actionType = if bool1 then ScheduledSquadActionEnum.Edit elseif bool2 then ScheduledSquadActionEnum.Unsubscribe else ScheduledSquadActionEnum.Subscribe,
                    conversationId = additionalInfo.parentChannelId,
                    scheduledSquadId = additionalInfo.scheduledGroupUpId,
                    source = ScheduledSquadActionSourceEnum.SubscribedScheduledSquadsListSheet,
                    squadId = squadId,
                    squadLocation = var5.squadLocation
                })
            end
            tbl6.text = if bool1 then var7.editText else var7.interestedText
            tbl6.variant = if bool1 or bool2 then ButtonVariant.Standard else ButtonVariant.Emphasis

            tbl6.width = UDim.new(1, 0)
            tbl3.ActionButton = createElement3(var17, tbl6)
            table.insert(result, createElement(var15, tbl2, tbl3))
        end

        return result
    end, { var10, onClose, var13 })

    local createElement = React.createElement
    local root = Sheet.Root
    local tbl2 = {
        onClose = onClose,
        isOpen = tbl1.isOpen,
        preferCenterSheet = true,
        snapPoints = { 0.4, 0.7 },
        testId = if FFlagSquadsEnableFoundationTestIds then "--social-squad-scheduled-parties-list-sheet" else nil
    }
    local tbl3 = {
        Header = React.createElement(Sheet.Header, {}, {
            Title = React.createElement(FoundationText, {
                LayoutOrder = 1,
                Text = var7.upcomingPartiesText,
                tag = "size-full-0 auto-y text-wrap text-heading-medium text-align-x-left",
                testId = if FFlagSquadsEnableFoundationTestIds then "--social-squad-scheduled-parties-list-sheet--title" else nil
            })
        }),
        Content = React.createElement(Sheet.Content, {}, {
            Loading = if var8 then React.createElement(
                Loading,
                {
                    testId = if FFlagSquadsEnableFoundationTestIds then "--social-squad-scheduled-parties-list-sheet--loading" else nil
                }
            ) else nil,
            ScheduledSquadsList = if var8 or not (#Cryo.Dictionary.keys(var10) > 0) then nil else React.createElement(View, { tag = "auto-y size-full-0 col gap-xsmall" }, unpack(var14)),
            NoUpcomingScheduledSquads = if var8 or #Cryo.Dictionary.keys(var10) ~= 0 then nil else React.createElement(
                FoundationText,
                {
                    Text = var7.noScheduledSquadsText,
                    tag = "size-full-0 auto-y text-label-medium text-align-x-left",
                    testId = if FFlagSquadsEnableFoundationTestIds then "--social-squad-scheduled-parties-list-sheet--empty-label" else nil
                }
            )
        })
    }
    return createElement(root, tbl2, tbl3)
end
