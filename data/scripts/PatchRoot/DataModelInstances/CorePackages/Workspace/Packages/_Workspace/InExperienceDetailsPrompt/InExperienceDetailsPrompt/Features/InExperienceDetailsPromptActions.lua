-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T19:00:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceDetailsPromptParent = script:FindFirstAncestor("InExperienceDetailsPrompt").Parent
local React = require(InExperienceDetailsPromptParent.React)
local DataHydration = require(InExperienceDetailsPromptParent.DataHydration)
local LaunchErrorLocalizationKeys = require(InExperienceDetailsPromptParent.GameLaunch).LaunchErrorLocalizationKeys
local useLocalization = require(InExperienceDetailsPromptParent.Localization).Hooks.useLocalization
local InExperienceDetailsPromptPlayButton = require(script.Parent.InExperienceDetailsPromptPlayButton)

local Foundation = require(InExperienceDetailsPromptParent.Foundation)
local Sheet = Foundation.Sheet
local View = Foundation.View
local Button = Foundation.Button
local ButtonVariant = Foundation.Enums.ButtonVariant
local IconName = Foundation.Enums.IconName
local Skeleton = Foundation.Skeleton
local Radius = Foundation.Enums.Radius
local FoundationText = Foundation.Text
local useTokens = Foundation.Hooks.useTokens

local FFlagLuaAppIedpFixPlayButton = require(InExperienceDetailsPromptParent.SharedFlags).FFlagLuaAppIedpFixPlayButton

local function InExperienceDetailsPromptActions(tbl1)
    local var1 = useTokens()
    local playabilityError = if tbl1.playability and not tbl1.playability.isPlayable and tbl1.playability.playabilityStatus then LaunchErrorLocalizationKeys[tbl1.playability.playabilityStatus] else nil
    local var2 = useLocalization(
        {
            playButtonUnavailable = "Feature.ExperienceDetails.PlayButtonText.Unavailable",
            playabilityError = playabilityError
        }
    )
    local createElement = React.createElement
    local actions = Sheet.Actions
    local var3 = nil
    local tbl2 = { View = 0 }
    local createElement2 = React.createElement
    local var4 = View
    local tbl3 = { tag = "col gap-small size-full-0 auto-y" }
    local tbl4

    if FFlagLuaAppIedpFixPlayButton then
        tbl4 = {
            PlayButton = React.createElement(InExperienceDetailsPromptPlayButton, {
                playability = tbl1.playability,
                onJoin = tbl1.onJoin,
                rootPlaceId = tbl1.rootPlaceId,
                playabilityRetrievalStatus = tbl1.playabilityRetrievalStatus,
                playButtonUnavailableText = var2.playButtonUnavailable
            }),
            Text = if tbl1.playability and not tbl1.playability.isPlayable and var2.playabilityError then React.createElement(
                FoundationText,
                {
                    LayoutOrder = 2,
                    Text = var2.playabilityError,
                    tag = "text-body-small content-default text-truncate-split auto-xy"
                }
            ) else nil
        }
    elseif not tbl1.playability then
        tbl4 = { PlayButton = 0 }
        local element

        if tbl1.playabilityRetrievalStatus == DataHydration.DataStatus.Failed then
            element = React.createElement(Button, {
                LayoutOrder = 1,
                width = UDim.new(1, 0),
                icon = IconName.PlayLarge,
                variant = ButtonVariant.Emphasis,
                onActivated = tbl1.onJoin
            })
        else
            element = React.createElement(
                Skeleton,
                {
                    LayoutOrder = 1,
                    Size = UDim2.new(1, 0, 0, var1.Size.Size_1000),
                    radius = Radius.Medium
                }
            )
        end

        tbl4.PlayButton = element
    else
        tbl4 = { PlayButton = 0, Text = 0 }
        local createElement3 = React.createElement
        local var5 = Button
        local tbl5 = {
            LayoutOrder = 1,
            width = UDim.new(1, 0),
            text = if tbl1.playability.isPlayable then nil else var2.playButtonUnavailable,
            icon = if tbl1.playability.isPlayable then IconName.PlayLarge else IconName.CircleSlash,
            variant = if tbl1.playability.isPlayable then ButtonVariant.Emphasis else ButtonVariant.Standard,
            onActivated = tbl1.onJoin,
            isDisabled = not tbl1.playability.isPlayable
        }
        tbl4.PlayButton = createElement3(var5, tbl5)
        local element = if tbl1.playability.isPlayable or not var2.playabilityError then nil else React.createElement(
            FoundationText,
            {
                LayoutOrder = 2,
                Text = var2.playabilityError,
                tag = "text-body-small content-default text-truncate-split auto-xy"
            }
        )
        tbl4.Text = element
    end

    tbl2.View = createElement2(var4, tbl3, tbl4)
    return createElement(actions, var3, tbl2)
end

return InExperienceDetailsPromptActions
