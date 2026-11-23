-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:31:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent
local React = require(BuildExperienceParent.React)
local Foundation = require(BuildExperienceParent.Foundation)

local function AnswersCardView(tbl1)
    local tbl2 = ({})
    for layoutOrder, row in tbl1.rows do
        local tbl3 = ({})
        for k, answer in row.answers do
            local str1 = `Answer{k}`
            local createElement = React.createElement
            local view = Foundation.View
            local tbl4 = { LayoutOrder = k, tag = "col gap-xsmall size-full-0 auto-y" }

            local tbl5 = {
                Title = React.createElement(Foundation.Text, {
                    LayoutOrder = 1,
                    Text = answer.title,
                    tag = "size-full-0 auto-y text-body-medium text-wrap text-align-x-left content-emphasis"
                }),
                Description = if answer.description == nil then nil else React.createElement(Foundation.Text, {
                    LayoutOrder = 2,
                    Text = answer.description,
                    tag = "size-full-0 auto-y text-body-medium text-wrap text-align-x-left content-default"
                })
            }
            tbl3[str1] = createElement(view, tbl4, tbl5)
        end

        local str1 = `Answer{layoutOrder}`
        local createElement = React.createElement
        local view = Foundation.View

        local tbl4 = {
            Divider = React.createElement(Foundation.Divider, { LayoutOrder = 1 }),
            Content = 0
        }
        local createElement2 = React.createElement
        local view2 = Foundation.View

        local tbl5 = {
            Question = React.createElement(Foundation.Text, {
                LayoutOrder = 1,
                Text = row.question,
                tag = "size-full-0 auto-y text-body-medium text-wrap text-align-x-left content-muted"
            }),
            Answers = React.createElement(Foundation.View, { LayoutOrder = 2, tag = "col gap-small size-full-0 auto-y" }, tbl3)
        }
        tbl4.Content = createElement2(view2, { LayoutOrder = 2, tag = "col gap-xsmall size-full-0 auto-y padding-large" }, tbl5)
        tbl2[str1] = createElement(view, { LayoutOrder = layoutOrder, tag = "col size-full-0 auto-y" }, tbl4)
    end

    return React.createElement(Foundation.View, {
        LayoutOrder = tbl1.LayoutOrder,
        Size = tbl1.Size,
        tag = "stroke-standard stroke-default radius-large",
        testId = "AnswersCard"
    }, {
        Content = React.createElement(
            Foundation.View,
            {
                onAbsoluteSizeChanged = tbl1.onContentSizeChanged,
                tag = "col size-full-0 auto-y",
                testId = "AnswersCard.Content"
            },
            {
                Header = React.createElement(Foundation.Text, {
                    LayoutOrder = 1,
                    Text = tbl1.headerText,
                    tag = "size-full-0 auto-y padding-large text-title-small text-align-x-left content-emphasis"
                }),
                Answers = React.createElement(Foundation.View, { LayoutOrder = 2, tag = "col size-full-0 auto-y" }, tbl2)
            }
        )
    })
end

return AnswersCardView
