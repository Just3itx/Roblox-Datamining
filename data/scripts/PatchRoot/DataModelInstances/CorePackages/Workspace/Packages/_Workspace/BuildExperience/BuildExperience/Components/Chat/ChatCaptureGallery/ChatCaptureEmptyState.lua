-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:31:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)

local ChatCaptureToolbarIllustration = require(script.Parent.ChatCaptureToolbarIllustration)

local FoundationText = Foundation.Text
local View = Foundation.View

local function renderStep(layoutOrder: number, text: string)
    return React.createElement(View, {
        LayoutOrder = layoutOrder,
        tag = "row align-y-center gap-small size-full-0 auto-y",
        testId = `ChatCaptureEmptyState.Step.{layoutOrder}`
    }, {
        Number = React.createElement(
            View,
            {
                LayoutOrder = 1,
                tag = "row align-x-center align-y-center size-600-600 radius-circle bg-shift-200"
            },
            {
                Label = React.createElement(
                    FoundationText,
                    {
                        Text = tostring(layoutOrder),
                        tag = "auto-xy text-caption-medium content-emphasis"
                    }
                )
            }
        ),
        Text = React.createElement(
            FoundationText,
            {
                LayoutOrder = 2,
                Text = text,
                tag = "fill auto-y text-body-medium text-wrap text-align-x-left content-default"
            }
        )
    })
end

local function ChatCaptureEmptyState(tbl1)
    local tbl2 = {}
    for k, howToStep in tbl1.howToSteps do
        tbl2[`Step-{k}`] = renderStep(k, howToStep)
    end

    return React.createElement(
        View,
        {
            tag = "col gap-large size-full-0 auto-y padding-bottom-medium",
            testId = "ChatCaptureEmptyState"
        },
        {
            Header = React.createElement(View, {
                LayoutOrder = 1,
                tag = "col align-x-center gap-xsmall size-full-0 auto-y"
            }, {
                Title = React.createElement(FoundationText, {
                    LayoutOrder = 1,
                    Text = tbl1.emptyText,
                    tag = "size-full-0 auto-y text-heading-small text-wrap text-align-x-center content-emphasis"
                }),
                Description = React.createElement(FoundationText, {
                    LayoutOrder = 2,
                    Text = tbl1.descriptionText,
                    tag = "size-full-0 auto-y text-body-medium text-wrap text-align-x-center content-muted"
                })
            }),
            Illustration = React.createElement(ChatCaptureToolbarIllustration, { LayoutOrder = 2, layout = tbl1.toolbarLayout }),
            Steps = React.createElement(View, { LayoutOrder = 3, tag = "col gap-medium size-full-0 auto-y" }, tbl2)
        }
    )
end

return ChatCaptureEmptyState
