-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:11:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)

local TodoList = require(script.Parent.TodoList)

local Sheet = Foundation.Sheet
local FoundationText = Foundation.Text
local View = Foundation.View

return React.memo(function(tbl1) -- name: TodoBottomSheet
    local testId = tbl1.testId or "subagent-status-bottom-sheet"

    return React.createElement(
        Sheet.Root,
        {
            isOpen = tbl1.isOpen,
            onClose = tbl1.onClose,
            snapPoints = { 0.5, 1 },
            defaultSnapPointIndex = 1,
            testId = testId
        },
        {
            Header = React.createElement(Sheet.Header, { hasCloseAffordance = true }, {
                TitleWrapper = React.createElement(View, {
                    LayoutOrder = 1,
                    tag = "size-full-0 auto-y padding-y-small"
                }, {
                    Title = React.createElement(FoundationText, {
                        LayoutOrder = 1,
                        Text = tbl1.title,
                        tag = "size-full-0 auto-y text-heading-small text-wrap text-align-x-left content-emphasis",
                        testId = `{testId}-title`
                    })
                })
            }),
            Content = React.createElement(
                Sheet.Content,
                nil,
                {
                    List = React.createElement(TodoList, { LayoutOrder = 1, items = tbl1.items, testId = `{testId}-list` })
                }
            )
        }
    )
end)
