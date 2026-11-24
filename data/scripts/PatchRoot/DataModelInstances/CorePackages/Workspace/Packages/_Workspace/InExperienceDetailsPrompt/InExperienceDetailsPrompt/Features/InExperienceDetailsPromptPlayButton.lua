-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T19:00:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceDetailsPromptParent = script:FindFirstAncestor("InExperienceDetailsPrompt").Parent
local React = require(InExperienceDetailsPromptParent.React)
local DataHydration = require(InExperienceDetailsPromptParent.DataHydration)

local Foundation = require(InExperienceDetailsPromptParent.Foundation)
local Button = Foundation.Button
local ButtonVariant = Foundation.Enums.ButtonVariant
local IconName = Foundation.Enums.IconName
local Skeleton = Foundation.Skeleton
local Radius = Foundation.Enums.Radius
local useTokens = Foundation.Hooks.useTokens

local function InExperienceDetailsPromptPlayButton(tbl1)
    local var1 = useTokens()

    if not tbl1.rootPlaceId or not tbl1.playability and tbl1.playabilityRetrievalStatus ~= DataHydration.DataStatus.Failed then
        return React.createElement(
            Skeleton,
            {
                LayoutOrder = 1,
                Size = UDim2.new(1, 0, 0, var1.Size.Size_1000),
                radius = Radius.Medium
            }
        )
    end

    if not tbl1.playability then
        return React.createElement(Button, {
            LayoutOrder = 1,
            width = UDim.new(1, 0),
            icon = IconName.PlayLarge,
            variant = ButtonVariant.Emphasis,
            onActivated = tbl1.onJoin
        })
    end

    return React.createElement(Button, {
        LayoutOrder = 1,
        width = UDim.new(1, 0),
        text = if tbl1.playability.isPlayable then nil else tbl1.playButtonUnavailableText,
        icon = if tbl1.playability.isPlayable then IconName.PlayLarge else IconName.CircleSlash,
        variant = if tbl1.playability.isPlayable then ButtonVariant.Emphasis else ButtonVariant.Standard,
        onActivated = tbl1.onJoin,
        isDisabled = not tbl1.playability.isPlayable
    })
end

return InExperienceDetailsPromptPlayButton
