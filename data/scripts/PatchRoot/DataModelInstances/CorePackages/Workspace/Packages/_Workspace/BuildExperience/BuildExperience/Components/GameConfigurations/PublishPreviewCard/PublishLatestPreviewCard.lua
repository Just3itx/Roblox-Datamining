-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:50:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)

local _chatTypes = require(BuildExperience.Chat.chatTypes)
local PublishExperienceTitle = require(script.Parent.PublishExperienceTitle)

local View = Foundation.View

local function PublishLatestPreviewCard(tbl1)
    local testId = tbl1.testId or "publish-latest-preview-card"

    return React.createElement(
        View,
        {
            LayoutOrder = tbl1.layoutOrder,
            tag = "col size-full-0 auto-y padding-top-xxsmall",
            testId = testId
        },
        {
            Card = React.createElement(
                View,
                {
                    LayoutOrder = 1,
                    tag = "col size-full-0 auto-y stroke-standard stroke-default radius-large clip"
                },
                {
                    Content = React.createElement(View, {
                        LayoutOrder = 1,
                        tag = "col size-full-0 auto-y padding-large"
                    }, {
                        Title = React.createElement(PublishExperienceTitle, {
                            target = tbl1.target,
                            isCreatorVerified = tbl1.isCreatorVerified,
                            layoutOrder = 1,
                            testId = `{testId}-title`
                        })
                    })
                }
            )
        }
    )
end

return PublishLatestPreviewCard
