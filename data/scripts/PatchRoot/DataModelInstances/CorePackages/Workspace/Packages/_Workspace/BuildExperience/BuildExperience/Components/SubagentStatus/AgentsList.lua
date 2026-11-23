-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:11:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local CreatorAgentChat = require(BuildExperienceParent.DataHydration.CreatorAgentChat)
local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)
local useLocalization = require(BuildExperienceParent.Localization).Hooks.useLocalization
local LocalizationStrings = require(BuildExperience.LocalizationStrings)

local LoadingIndicator = require(script.Parent.LoadingIndicator)

local Icon = Foundation.Icon
local ScrollView = Foundation.ScrollView
local FoundationText = Foundation.Text
local View = Foundation.View

local IconName = Foundation.Enums.IconName
local IconSize = Foundation.Enums.IconSize
local ScrollBarVisibility = Foundation.Enums.ScrollBarVisibility
local StateLayerAffordance = Foundation.Enums.StateLayerAffordance
local useScaledValue = Foundation.Hooks.useScaledValue
local useTokens = Foundation.Hooks.useTokens

local SubagentTaskCategory = CreatorAgentChat.SubagentTaskCategory
local tbl1 = {
    SubagentTaskCategory.Gameplay,
    SubagentTaskCategory.Art,
    SubagentTaskCategory.Audio,
    SubagentTaskCategory.Marketing
}

local tbl2 = {
    Art = IconName.TwoMakeupBrushes,
    Audio = IconName.FiveVerticalLinesWave,
    Gameplay = IconName.Controller,
    Marketing = IconName.Wallet
}

local function getDisplayGroups(groups)
    local tbl3 = ({})
    for _, group in groups do
        tbl3[group.name] = group
    end

    local displayGroups = {}
    for _, name in tbl1 do
        table.insert(displayGroups, tbl3[name] or { name = name, tasks = {}, isComplete = false, isLoading = false })

        tbl3[name] = nil
    end

    for _, group in groups do
        if tbl3[group.name] ~= nil then
            table.insert(displayGroups, group)
            tbl3[group.name] = nil
        end
    end

    return displayGroups
end

local function AgentTaskList(tbl3)
    local var1, var2 = React.useBinding(0)
    local var3 = var1:map(function(yOffset: number?): UDim2
        return UDim2.new(1, 0, 0, yOffset)
    end)
    local onAbsoluteCanvasSizeChanged = React.useCallback(function(arg1)
        var2(arg1.AbsoluteCanvasSize.Y)
    end, { var2 })

    return React.createElement(ScrollView, {
        LayoutOrder = tbl3.LayoutOrder,
        Size = var3,
        onAbsoluteCanvasSizeChanged = onAbsoluteCanvasSizeChanged,
        scroll = {
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
            CanvasSize = UDim2.new(1, 0, 0, 0),
            scrollBarVisibility = ScrollBarVisibility.None,
            ScrollingDirection = Enum.ScrollingDirection.Y
        },
        tag = "shrink",
        testId = tbl3.testId
    }, {
        Content = React.createElement(View, {
            onActivated = tbl3.onActivated,
            layout = {
                FillDirection = Enum.FillDirection.Vertical,
                Padding = UDim.new(0, tbl3.taskGap)
            },
            stateLayer = {
                affordance = StateLayerAffordance.None
            },
            tag = "col size-full-0 auto-y",
            testId = `{tbl3.testId}-content`
        }, tbl3.children)
    })
end

local function AgentCard(tbl3)
    local group = tbl3.group
    local var1 = useLocalization({
        building = LocalizationStrings.SUBAGENT_STATUS_BUILDING,
        completedTasks = {
            LocalizationStrings.SUBAGENT_STATUS_COMPLETED_TASKS,
            COUNT = #group.tasks
        },
        notStarted = LocalizationStrings.SUBAGENT_STATUS_NOT_STARTED
    })
    local var2 = if #group.tasks == 0 then var1.notStarted elseif group.isComplete then var1.completedTasks else var1.building
    local name = tbl2[group.name]
    local onActivated = React.useCallback(function()
        tbl3.onAgentActivated(group)
    end, { tbl3.onAgentActivated, group })
    local tbl4 = ({})

    for layoutOrder, task in group.tasks do
        local str1 = `Task{layoutOrder}`
        local createElement = React.createElement
        local var5 = View
        local tbl5 = {
            LayoutOrder = layoutOrder,
            tag = "row align-y-center gap-small size-full-0 auto-y",
            testId = `{tbl3.testId}-card-{tbl3.index}-task-{layoutOrder}`
        }
        local tbl6 = {
            Label = React.createElement(FoundationText, {
                LayoutOrder = 1,
                Text = task.text,
                tag = "fill auto-y text-body-small text-align-x-left text-truncate-end content-emphasis"
            }),
            Status = React.createElement(
                LoadingIndicator,
                {
                    layoutOrder = 2,
                    status = task.status,
                    testId = `{tbl3.testId}-card-{tbl3.index}-task-{layoutOrder}`
                }
            )
        }
        tbl4[str1] = createElement(var5, tbl5, tbl6)
    end

    local createElement = React.createElement
    local var5 = View
    local tbl5 = {
        LayoutOrder = tbl3.index,
        onActivated = if #group.tasks > 0 then onActivated else nil,
        sizeConstraint = {
            MaxSize = Vector2.new(math.huge, tbl3.maxHeight)
        },
        tag = "col gap-large size-full-0 auto-y padding-large stroke-standard stroke-emphasis radius-large",
        testId = `{tbl3.testId}-card-{tbl3.index}-container`
    }
    local tbl6 = {
        Header = React.createElement(View, {
            LayoutOrder = 1,
            tag = "row align-y-center gap-small size-full-0 auto-y",
            testId = `{tbl3.testId}-card-{tbl3.index}`
        }, {
            Icon = if name == nil then nil else React.createElement(Icon, {
                LayoutOrder = 1,
                name = name,
                size = IconSize.Small,
                tag = "auto-xy content-emphasis",
                testId = `{tbl3.testId}-card-{tbl3.index}-category-icon`
            }),
            Title = React.createElement(FoundationText, {
                LayoutOrder = 2,
                Text = group.name,
                tag = "fill auto-y text-title-medium text-wrap text-align-x-left content-emphasis"
            }),
            Status = React.createElement(
                FoundationText,
                {
                    LayoutOrder = 3,
                    Text = var2,
                    tag = "auto-xy padding-left-large text-body-small text-align-x-right content-emphasis"
                }
            )
        }),
        Tasks = if #group.tasks > 0 then React.createElement(AgentTaskList, {
            LayoutOrder = 2,
            onActivated = onActivated,
            taskGap = tbl3.taskGap,
            testId = `{tbl3.testId}-card-{tbl3.index}-tasks`
        }, tbl4) else nil
    }
    return createElement(var5, tbl5, tbl6)
end

return React.memo(function(tbl3) -- name: AgentsList
    local var1 = useTokens()
    local maxHeight = useScaledValue(156)
    local testId = tbl3.testId or "build-agent-list"
    local tbl4 = ({})

    for index, group in getDisplayGroups(tbl3.groups) do
        local str1 = `Card{index}`
        tbl4[str1] = React.createElement(AgentCard, {
            group = group,
            index = index,
            maxHeight = maxHeight,
            onAgentActivated = tbl3.onAgentActivated,
            taskGap = var1.Gap.Small,
            testId = testId
        })
    end

    return React.createElement(
        View,
        {
            LayoutOrder = tbl3.LayoutOrder,
            tag = "col gap-medium size-full-0 auto-y padding-y-medium",
            testId = testId
        },
        tbl4
    )
end)
