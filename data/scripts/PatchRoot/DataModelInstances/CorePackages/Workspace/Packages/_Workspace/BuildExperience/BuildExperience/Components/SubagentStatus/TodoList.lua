-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:11:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local CreatorAgentChat = require(BuildExperienceParent.DataHydration.CreatorAgentChat)
local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)

local LoadingIndicator = require(script.Parent.LoadingIndicator)

local List = Foundation.List
local View = Foundation.View

local InputSize = Foundation.Enums.InputSize

local SubagentTaskStatus = CreatorAgentChat.SubagentTaskStatus

local function createTrailingIndicator(tbl1, str1: string)
    if tbl1.status == nil or tbl1.status == SubagentTaskStatus.Pending then
        return nil
    end

    return React.createElement(View, { tag = "auto-xy" }, {
        Indicator = React.createElement(LoadingIndicator, { status = tbl1.status, testId = `{str1}-loading-indicator` })
    })
end

return React.memo(function(tbl1) -- name: TodoList
    local testId = tbl1.testId or "subagent-status-list"
    local tbl2 = ({})

    for layoutOrder, item in tbl1.items do
        local var1 = item.testId or `{testId}-item-{layoutOrder}`

        local str1 = `Item{layoutOrder}`
        tbl2[str1] = React.createElement(List.Item, {
            LayoutOrder = layoutOrder,
            description = item.description,
            testId = var1,
            title = item.title,
            trailing = createTrailingIndicator(item, var1)
        })
    end

    return React.createElement(List.Root, {
        LayoutOrder = tbl1.layoutOrder,
        hasDivider = false,
        isContained = { isContained = false, hasMargin = false },
        size = InputSize.Medium,
        testId = testId
    }, tbl2)
end)
