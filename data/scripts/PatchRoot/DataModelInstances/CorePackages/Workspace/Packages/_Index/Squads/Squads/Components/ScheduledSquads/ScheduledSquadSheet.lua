-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T22:40:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Squads = script:FindFirstAncestor("Squads")
local SquadsParent = Squads.Parent

local FFlagSquadsEnableFoundationTestIds = require(Squads.Flags.FFlagSquadsEnableFoundationTestIds)

local Foundation = require(SquadsParent.Foundation)
local React = require(SquadsParent.React)
local SquadExternalContractProvider = require(SquadsParent.SquadsCore.SquadExternalContractProvider)
local _Types = require(SquadsParent.SquadsCore.Types)
local useDispatch = require(SquadsParent.RoactUtils).Hooks.RoactRodux.useDispatch
local useLocalUserId = require(SquadsParent.RobloxAppHooks).useLocalUserId
local useLocalization = require(SquadsParent.Localization).Hooks.useLocalization
local useStore = require(SquadsParent.RoactUtils).Hooks.RoactRodux.useStore

local Sheet = Foundation.Sheet
local FoundationText = Foundation.Text
local View = Foundation.View

local createScheduledSquad = require(SquadsParent.SquadsCore.Thunks).createScheduledSquad
local EventNames = require(SquadsParent.SquadsCore.EventNames)
local SquadPromptResponse = require(SquadsParent.SquadsCore.Enums).SquadPromptResponse
local SquadPromptType = require(SquadsParent.SquadsCore.Enums).SquadPromptType
local SquadExternalContractContext = SquadExternalContractProvider.SquadExternalContractContext
local updateScheduledSquad = require(SquadsParent.SquadsCore.NetworkRequests).updateScheduledSquad

return function(tbl1)
    local var1 = React.useContext(SquadExternalContractContext)
    local var2 = useDispatch()
    local var3 = useLocalUserId()
    local var4 = useStore()
    local var5 = useLocalization({
        cancelText = "CommonUI.Controls.Action.Cancel",
        deleteText = "Feature.Chat.Action.Delete",
        fieldIsRequiredText = "Feature.Squads.Label.ThisFieldIsRequired",
        saveText = "Feature.Chat.Action.Save",
        scheduledPartyText = "Feature.Squads.Label.ScheduledParty",
        scheduleAPartyText = "Feature.Squads.Action.ScheduleAParty",
        startTimeText = "Feature.Squads.Label.StartTime",
        titleText = "Feature.Squads.Description.Title"
    })

    local startTime, var6 = React.useState(if tbl1.scheduledSquad and tbl1.scheduledSquad.startTime then tbl1.scheduledSquad.startTime else nil)

    local hasError, var8 = React.useState(false)
    local title, var10 = React.useState(if tbl1.scheduledSquad then tbl1.scheduledSquad.title else "")
    local var11, var12 = React.useState(false)
    if var11 then
        local _fieldIsRequiredText = var5.fieldIsRequiredText
    end

    React.useEffect(function()
        var6(if tbl1.scheduledSquad and tbl1.scheduledSquad.startTime then tbl1.scheduledSquad.startTime else nil)

        var8(false)
        var12(false)
    end, { tbl1.isOpen, tbl1.scheduledSquad and tbl1.scheduledSquad.startTime })

    local scheduledSquad = tbl1.scheduledSquad and tostring(tbl1.scheduledSquad.initiatorId) == tostring(var3)

    local dateTime = DateTime.now()
    local var13 = dateTime:ToLocalTime()

    local var14 = React.useCallback(function()
        tbl1.onClose()
        var1.setSquadPrompt(var4, { hideCancelButton = true, promptType = SquadPromptType.Error })
    end, { tbl1.onClose, var1.setSquadPrompt, var4 })

    React.useCallback(function(arg1)
        if var11 then
            var12(false)
        end

        var10(arg1)
    end, { var11, var12, var10 })

    local var15 = React.useCallback(function(num1: number, num2: number): number
        return if num1 == 2 and (num2 % 4 == 0 and num2 % 100 ~= 0 or num2 % 400 == 0) then 29 else ({
            31,
            28,
            31,
            30,
            31,
            30,
            31,
            31,
            30,
            31,
            30,
            31
        })[num1]
    end, {})

    local onChanged = React.useCallback(function(dateTime2, _)
        if dateTime2 and hasError then
            var8(false)
        end

        var6(if dateTime2 then dateTime2:ToIsoDate() else nil)
    end, { var8, var6, hasError })

    local onActivated = React.useCallback(function()
        local bool1 = false
        if not startTime then
            var8(true)
            bool1 = true
        else
            local dateTime2 = DateTime.fromIsoDate(startTime)
            if dateTime2 and dateTime2.UnixTimestampMillis < DateTime.now().UnixTimestampMillis then
                var8(true)
                bool1 = true
            end
        end

        if bool1 then
            return
        end
        if scheduledSquad and tbl1.scheduledSquad then
            updateScheduledSquad({
                scheduledGroupUpId = tbl1.scheduledSquad and tbl1.scheduledSquad.scheduledGroupUpId,
                title = title,
                startTime = startTime
            }, tbl1.onClose, var14)

            var1.fireSquadAnalytics(EventNames.SquadPromptResponded, {
                promptType = SquadPromptType.ScheduleSquad,
                scheduledSquadId = tbl1.scheduledSquad and tbl1.scheduledSquad.scheduledGroupUpId,
                squadLocation = var1.squadLocation,
                responseType = SquadPromptResponse.Update
            })
            return
        end

        tbl1.onClose()
        var2(
            createScheduledSquad(
                {
                    parentChannelId = tbl1.conversationId or "",
                    title = title,
                    startTime = startTime
                },
                var1.setSquadPrompt
            )
        )
        var1.fireSquadAnalytics(EventNames.SquadPromptResponded, {
            promptType = SquadPromptType.ScheduleSquad,
            squadLocation = var1.squadLocation,
            responseType = SquadPromptResponse.Create
        })
    end, {
        var14,
        false,
        scheduledSquad,
        tbl1.conversationId,
        tbl1.scheduledSquad,
        tbl1.onClose,
        startTime,
        var8,
        var12,
        var11,
        title,
        var1.setSquadPrompt,
        var1.fireSquadAnalytics,
        var1.squadLocation
    })

    local var18 = React.useCallback(function(): DateTime
        local day = var13.Day
        local month = if var13.Month + 6 > 12 then (var13.Month + 6) % 12 else var13.Month + 6
        local year = if var13.Month + 6 > 12 then var13.Year + 1 else var13.Year
        local day2 = var15(month, year)
        if day2 < day then
            return DateTime.fromLocalTime(year, month, day2)
        end
        return DateTime.fromLocalTime(year, month, day)
    end, { var13, var15 })

    local var7 = React.useCallback(function()
        tbl1.onClose()

        var1.fireSquadAnalytics(EventNames.SquadPromptResponded, {
            promptType = SquadPromptType.ScheduleSquad,
            scheduledSquadId = tbl1.scheduledSquad and tbl1.scheduledSquad.scheduledGroupUpId,
            squadLocation = var1.squadLocation,
            responseType = SquadPromptResponse.Cancel
        })
    end, {
        tbl1.scheduledSquad and tbl1.scheduledSquad.scheduledGroupUpId,
        var1.fireSquadAnalytics,
        tbl1.onClose,
        var1.squadLocation
    })

    local createElement = React.createElement
    local root = Sheet.Root
    local tbl2 = {
        onClose = tbl1.onClose,
        isOpen = tbl1.isOpen,
        preferCenterSheet = true,
        testId = if FFlagSquadsEnableFoundationTestIds then "--social-squad-scheduled-party-sheet" else nil
    }
    local tbl3 = {
        Header = React.createElement(Sheet.Header, {}, {
            Title = React.createElement(FoundationText, {
                LayoutOrder = 1,
                Text = var5.scheduleAPartyText,
                tag = "size-full-0 auto-y text-wrap text-heading-medium text-align-x-left",
                testId = if FFlagSquadsEnableFoundationTestIds then "--social-squad-scheduled-party-sheet--title" else nil
            })
        }),
        Content = 0,
        Action = 0
    }

    local createElement2 = React.createElement
    local content = Sheet.Content
    local tbl4 = {}
    local tbl5 = {
        TitleInput = nil,
        DateTimePicker = React.createElement(Foundation.DateTimePicker, {
            defaultDates = if scheduledSquad and tbl1.scheduledSquad then DateTime.fromIsoDate(tbl1.scheduledSquad.startTime) else nil,
            hasError = hasError,
            LayoutOrder = 2,
            isRequired = true,
            label = var5.startTimeText,
            onChanged = onChanged,
            selectableDateRange = {
                endDate = var18(),
                startDate = dateTime
            },
            variant = Foundation.Enums.DateTimePickerVariant.SingleWithTime,
            width = UDim.new(1, 0),
            testId = if FFlagSquadsEnableFoundationTestIds then "--social-squad-scheduled-party-sheet--start-time-picker" else nil
        })
    }
    tbl3.Content = createElement2(content, tbl4, tbl5)

    local createElement3 = React.createElement
    local actions = Sheet.Actions
    local tbl6 = {}
    local tbl7 = { ActionList = 0 }
    local createElement4 = React.createElement
    local var20 = View
    local tbl8 = { tag = "col auto-y gap-small size-full-0" }

    local tbl9 = {
        ConfirmButton = React.createElement(Foundation.Button, {
            LayoutOrder = 1,
            isDisabled = if scheduledSquad and tbl1.scheduledSquad and tbl1.scheduledSquad.startTime == startTime then tbl1.scheduledSquad.title == title else false,
            onActivated = onActivated,
            text = var5.saveText,
            variant = Foundation.Enums.ButtonVariant.Emphasis,
            width = UDim.new(1, 0),
            testId = if FFlagSquadsEnableFoundationTestIds then "--social-squad-scheduled-party-sheet--save-button" else nil
        }),
        CancelButton = React.createElement(Foundation.Button, {
            LayoutOrder = 2,
            onActivated = var7,
            text = var5.cancelText,
            variant = Foundation.Enums.ButtonVariant.Standard,
            width = UDim.new(1, 0),
            testId = if FFlagSquadsEnableFoundationTestIds then "--social-squad-scheduled-party-sheet--cancel-button" else nil
        })
    }
    tbl7.ActionList = createElement4(var20, tbl8, tbl9)
    tbl3.Action = createElement3(actions, tbl6, tbl7)
    return createElement(root, tbl2, tbl3)
end
