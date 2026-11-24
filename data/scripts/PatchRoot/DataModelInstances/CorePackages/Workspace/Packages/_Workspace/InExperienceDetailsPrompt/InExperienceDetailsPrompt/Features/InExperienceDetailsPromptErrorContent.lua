-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T19:00:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceDetailsPromptParent = script:FindFirstAncestor("InExperienceDetailsPrompt").Parent
local React = require(InExperienceDetailsPromptParent.React)
local Foundation = require(InExperienceDetailsPromptParent.Foundation)
local View = Foundation.View
local Icon = Foundation.Icon
local Enums = Foundation.Enums
local FoundationText = Foundation.Text
local useTokens = Foundation.Hooks.useTokens
local useLocalization = require(InExperienceDetailsPromptParent.Localization).Hooks.useLocalization

local EnumGameDetailErrorTypes = require(InExperienceDetailsPromptParent.DiscoveryTypes).EnumGameDetailErrorTypes

local function getErrorDisplayMessage(experienceUnavailable: string, tbl1) -- Luacid: Inlined by compiler; 1 call site recovered
    return if experienceUnavailable == EnumGameDetailErrorTypes.ExperienceUnavailable then tbl1.experienceUnavailable else tbl1.noInternet
end

local function InExperienceDetailsPromptErrorContent(tbl1)
    local var1 = useTokens()

    local var2 = useLocalization({
        experienceUnavailable = "Feature.GamePage.QuickLaunch.LaunchError.TemporarilyUnavailable",
        noInternet = "Feature.EmptyStatePage.Message.NoInternet"
    })

    local errorDisplayMessage = getErrorDisplayMessage(tbl1.errorType, var2)

    return React.createElement(
        View,
        {
            tag = "col size-full-0 auto-y items-center gap-medium padding-bottom-large padding-top-large"
        },
        {
            Icon = React.createElement(Icon, { name = Enums.IconName.TriangleExclamation, size = var1.Size.Size_1700, layoutOrder = 1 }),
            Message = React.createElement(
                FoundationText,
                {
                    Text = errorDisplayMessage,
                    tag = "text-body-large size-full-0 auto-y text-center text-wrap",
                    layoutOrder = 2
                }
            )
        }
    )
end

return InExperienceDetailsPromptErrorContent
