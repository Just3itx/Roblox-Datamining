-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:40:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)
local useLocalization = require(BuildExperienceParent.Localization).Hooks.useLocalization
local LocalizationStrings = require(BuildExperience.LocalizationStrings)
local ChatCardPriority = require(script.Parent.ChatCardEmphasis.ChatCardPriority)
local useChatCardEmphasis = require(script.Parent.ChatCardEmphasis.useChatCardEmphasis)
local FFlagBuildExperienceChatCardEmphasis = require(BuildExperience.Flags.FFlagBuildExperienceChatCardEmphasis)

local FFlagBuildExperiencePlaytestCardPublishCta = require(BuildExperience.Flags.FFlagBuildExperiencePlaytestCardPublishCta)

local Button = Foundation.Button
local IconName = Foundation.Enums.IconName
local FoundationText = Foundation.Text
local View = Foundation.View

local ButtonVariant = Foundation.Enums.ButtonVariant
local FillBehavior = Foundation.Enums.FillBehavior
local InputSize = Foundation.Enums.InputSize

local function PlaytestCompletedCard(tbl1)
    local var1 = useLocalization({
        description = LocalizationStrings.CHAT_COMPLETED_GAME_CREATION_DESCRIPTION,
        playtest = LocalizationStrings.CHAT_PLAYTEST,
        publish = if FFlagBuildExperiencePlaytestCardPublishCta then LocalizationStrings.BUILD_MENU_PUBLISH else nil,
        title = LocalizationStrings.CHAT_COMPLETED_GAME_CREATION_TITLE
    })
    local isLoading = tbl1.isLoading == true
    local isDisabled = tbl1.isPlaytestDisabled == true
    local var2 = if FFlagBuildExperienceChatCardEmphasis then useChatCardEmphasis(if isDisabled then nil else ChatCardPriority.PlaytestCompleted) else nil
    local onPublish = tbl1.onPublish
    local element

    if FFlagBuildExperiencePlaytestCardPublishCta and onPublish ~= nil then
        local createElement = React.createElement
        local var3 = View
        local tbl2 = {
            LayoutOrder = 3,
            tag = "row gap-small size-full-0 auto-y",
            testId = "playtest-completed-card-actions"
        }

        local tbl3 = {
            Playtest = React.createElement(Button, {
                LayoutOrder = 1,
                text = var1.playtest,
                icon = IconName.PlaySmall,
                size = InputSize.Small,
                variant = if var2 == false then ButtonVariant.SoftEmphasis else ButtonVariant.Emphasis,
                fillBehavior = FillBehavior.Fill,
                isLoading = isLoading,
                isDisabled = isDisabled,
                onActivated = tbl1.onPlaytest,
                testId = "playtest-completed-card-playtest-button"
            }),
            Publish = React.createElement(Button, {
                LayoutOrder = 2,
                text = var1.publish,
                size = InputSize.Small,
                variant = ButtonVariant.Standard,
                fillBehavior = FillBehavior.Fill,
                isDisabled = tbl1.isPublishDisabled == true,
                onActivated = onPublish,
                testId = "playtest-completed-card-publish-button"
            })
        }
        element = createElement(var3, tbl2, tbl3)
    else
        element = React.createElement(Button, {
            LayoutOrder = 3,
            text = var1.playtest,
            icon = IconName.PlaySmall,
            size = InputSize.Small,
            variant = if var2 == false then ButtonVariant.SoftEmphasis else ButtonVariant.Emphasis,
            width = UDim.new(1, 0),
            isLoading = isLoading,
            isDisabled = isDisabled,
            onActivated = tbl1.onPlaytest,
            testId = "playtest-completed-card-playtest-button"
        })
    end

    return React.createElement(View, {
        LayoutOrder = tbl1.LayoutOrder,
        testId = tbl1.testId or "playtest-completed-card",
        tag = "col gap-medium size-full-0 auto-y padding-medium stroke-standard stroke-emphasis radius-medium clip"
    }, {
        Title = React.createElement(FoundationText, {
            LayoutOrder = 1,
            Text = tbl1.title or var1.title,
            tag = "size-full-0 auto-y text-title-medium text-wrap text-align-x-left content-emphasis"
        }),
        Description = React.createElement(FoundationText, {
            LayoutOrder = 2,
            Text = tbl1.description or var1.description,
            tag = "size-full-0 auto-y text-body-medium text-wrap text-align-x-left content-default"
        }),
        Actions = element
    })
end

return PlaytestCompletedCard
