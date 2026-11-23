-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:11:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local CreatorAgentChat = require(BuildExperienceParent.DataHydration.CreatorAgentChat)
local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)
local useLocalization = require(BuildExperienceParent.Localization).Hooks.useLocalization
local LocalizationStrings = require(BuildExperience.LocalizationStrings)
local TodoList = require(script.Parent.TodoList)
local matchesSearchQuery = require(BuildExperience.utils.matchesSearchQuery)

local Chip = Foundation.Chip
local Menu = Foundation.Menu
local SearchInput = Foundation.SearchInput
local View = Foundation.View
local useScaledValue = Foundation.Hooks.useScaledValue
local ChipSize = Foundation.Enums.ChipSize
local ChipVariant = Foundation.Enums.ChipVariant
local IconName = Foundation.Enums.IconName
local InputSize = Foundation.Enums.InputSize
local PopoverAlign = Foundation.Enums.PopoverAlign
local PopoverSide = Foundation.Enums.PopoverSide

local SubagentTaskStatus = CreatorAgentChat.SubagentTaskStatus

local num1 = game:DefineFastInt("BuildAgentDetailsStatusMenuWidth", 172)

local function getStatusFilterText(tbl1, status) -- Luacid: unused: defined but never referenced
    for _, value in tbl1 do
        if value.status == status then
            return value.text
        end
    end
    return status or "All"
end

local function taskMatchesSearch(arg1, searchQuery: string) -- Luacid: Inlined by compiler; 2 call sites recovered
    return matchesSearchQuery(arg1.text, searchQuery) or matchesSearchQuery(arg1.description, searchQuery)
end

local function taskMatchesStatus(arg1, status): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return status == nil or arg1.status == status
end

local function shouldIncludeTask(arg1, tbl1) -- Luacid: unused: defined but never referenced
    local bool1 = taskMatchesSearch(arg1, tbl1.searchQuery)

    if bool1 then
        local status = tbl1.status

        if status == nil then
            return taskMatchesStatus(nil, nil)
        end

        bool1 = arg1.status == status
    end

    return bool1
end

return React.memo(function(tbl1) -- name: AgentDetailsList
    local var1, onChanged = React.useState("")
    local status, var4 = React.useState(nil)
    local isOpen, var6 = React.useState(false)
    local offset = useScaledValue(num1)
    local var7 = useLocalization({
        all = LocalizationStrings.SUBAGENT_STATUS_ALL,
        deleted = LocalizationStrings.SUBAGENT_STATUS_DELETED,
        done = LocalizationStrings.SUBAGENT_STATUS_DONE,
        error = LocalizationStrings.SUBAGENT_STATUS_ERROR,
        inProgress = LocalizationStrings.SUBAGENT_STATUS_IN_PROGRESS,
        pending = LocalizationStrings.SUBAGENT_STATUS_PENDING,
        searchTasks = LocalizationStrings.SUBAGENT_STATUS_SEARCH_TASKS,
        version = LocalizationStrings.SUBAGENT_STATUS_VERSION
    })
    local searchTasks = var7.searchTasks
    local _version = var7.version
    local tbl2 = {
        {
            id = "All",
            status = nil,
            text = var7.all
        },
        {
            id = SubagentTaskStatus.InProgress,
            status = SubagentTaskStatus.InProgress,
            text = var7.inProgress
        },
        {
            id = SubagentTaskStatus.Done,
            status = SubagentTaskStatus.Done,
            text = var7.done
        },
        {
            id = SubagentTaskStatus.Pending,
            status = SubagentTaskStatus.Pending,
            text = var7.pending
        },
        {
            id = SubagentTaskStatus.Error,
            status = SubagentTaskStatus.Error,
            text = var7.error
        },
        {
            id = SubagentTaskStatus.Deleted,
            status = SubagentTaskStatus.Deleted,
            text = var7.deleted
        }
    }

    local tbl3 = { searchQuery = var1, status = status }

    local items = {}
    for k, task in tbl1.group.tasks do
        if not (taskMatchesSearch(task, tbl3.searchQuery) and taskMatchesStatus(task, tbl3.status)) then
            continue
        end

        table.insert(items, {
            title = task.text,
            description = task.description,
            status = task.status,
            testId = `{tbl1.testId or "build-agent-details-list"}-item-{k}`
        })
    end

    local function buildStatusMenuItems()
        local statusMenuItems = {}
        for _, value in tbl2 do
            table.insert(
                statusMenuItems,
                {
                    id = value.id,
                    text = value.text,
                    isChecked = status == value.status,
                    isDisabled = false
                }
            )
        end
        return statusMenuItems
    end

    local statusMenuItems = buildStatusMenuItems()

    local onActivated = React.useCallback(function()
        var6(function(arg1): boolean
            return not arg1
        end)
    end, {})

    local onPressedOutside = React.useCallback(function()
        var6(false)
    end, {})

    local var2 = React.useCallback(function(arg1)
        local var10 = var4

        if arg1 == "All" then
            arg1 = nil
        end

        var10(arg1)
        var6(false)
    end, {})

    local createElement = React.createElement
    local var11 = View
    local tbl5 = {
        LayoutOrder = tbl1.LayoutOrder,
        tag = "col gap-xxlarge size-full-0 auto-y padding-y-small",
        testId = tbl1.testId or "build-agent-details-list"
    }
    local tbl6 = { Filters = 0, List = 0 }
    local createElement2 = React.createElement
    local var12 = View
    local tbl7 = { LayoutOrder = 1, tag = "col gap-small size-full-0 auto-y" }

    local tbl8 = {
        Search = React.createElement(SearchInput, {
            LayoutOrder = 1,
            text = var1,
            placeholder = searchTasks,
            onChanged = onChanged,
            width = UDim.new(1, 0),
            testId = `{tbl1.testId or "build-agent-details-list"}-search-input`
        }),
        Chips = 0
    }
    local createElement3 = React.createElement
    local var13 = View
    local tbl9 = { LayoutOrder = 2, tag = "row align-y-center gap-small size-full-0 auto-y" }

    local tbl10 = { VersionChip = nil, StatusMenu = 0 }

    local createElement4 = React.createElement
    local var14 = Menu
    local tbl11 = {
        LayoutOrder = 2,
        align = PopoverAlign.Start,
        isOpen = isOpen,
        items = statusMenuItems,
        onActivated = var2,
        onPressedOutside = onPressedOutside,
        side = PopoverSide.Bottom,
        size = InputSize.Medium,
        width = UDim.new(0, offset)
    }
    local tbl12 = { StatusChip = 0 }
    local createElement5 = React.createElement
    local var15 = Chip
    local tbl13 = {
        LayoutOrder = 1,
        text = 0,
        trailing = 0,
        variant = 0,
        size = 0,
        onActivated = 0,
        testId = 0
    }
    local bool1 = false
    local text

    for _, value in tbl2 do
        if value.status == status then
            text = value.text
            bool1 = true
            break
        end
    end

    if not bool1 then
        text = status or "All"
    end

    tbl13.text = text
    tbl13.trailing = IconName.ChevronLargeDown
    tbl13.variant = ChipVariant.Standard
    tbl13.size = ChipSize.Medium
    tbl13.onActivated = onActivated
    tbl13.testId = `{tbl1.testId or "build-agent-details-list"}-status-filter-chip`
    tbl12.StatusChip = createElement5(var15, tbl13)
    tbl10.StatusMenu = createElement4(var14, tbl11, tbl12)
    tbl8.Chips = createElement3(var13, tbl9, tbl10)
    tbl6.Filters = createElement2(var12, tbl7, tbl8)

    tbl6.List = React.createElement(TodoList, { layoutOrder = 2, items = items })
    return createElement(var11, tbl5, tbl6)
end)
