-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T19:01:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceDetailsPromptParent = script:FindFirstAncestor("InExperienceDetailsPrompt").Parent
local React = require(InExperienceDetailsPromptParent.React)
local _DataHydration = require(InExperienceDetailsPromptParent.DataHydration)
local VerifiedBadges = require(InExperienceDetailsPromptParent.VerifiedBadges)

local FoundationText = require(InExperienceDetailsPromptParent.Foundation).Text

local function InExperienceDetailsPromptSubtitle(tbl1)
    if not tbl1.creator.hasVerifiedBadge then
        return React.createElement(FoundationText, {
            Text = tbl1.creator.name,
            tag = "text-body-large content-default auto-xy text-truncate-split padding-right-xxsmall",
            LayoutOrder = tbl1.layoutOrder
        })
    end

    return React.createElement(
        VerifiedBadges.EmojiWrapper,
        {
            emoji = VerifiedBadges.emoji.verified,
            layoutOrder = tbl1.layoutOrder
        },
        {
            CreatorName = React.createElement(
                FoundationText,
                {
                    Text = tbl1.creator.name,
                    tag = "text-body-large content-default auto-xy text-truncate-split padding-right-xxsmall"
                }
            )
        }
    )
end

return InExperienceDetailsPromptSubtitle
