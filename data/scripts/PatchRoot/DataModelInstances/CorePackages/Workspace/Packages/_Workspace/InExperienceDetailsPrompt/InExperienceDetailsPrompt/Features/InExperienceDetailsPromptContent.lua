-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T19:00:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceDetailsPromptParent = script:FindFirstAncestor("InExperienceDetailsPrompt").Parent
local React = require(InExperienceDetailsPromptParent.React)
local _DataHydration = require(InExperienceDetailsPromptParent.DataHydration)

local Foundation = require(InExperienceDetailsPromptParent.Foundation)
local Badge = Foundation.Badge
local Chip = Foundation.Chip
local Enums = Foundation.Enums
local BadgeVariant = Enums.BadgeVariant
local ScrollView = Foundation.ScrollView
local Visibility = Foundation.Enums.Visibility
local useTokens = Foundation.Hooks.useTokens

local bool1 = game:DefineFastFlag("LuaAppIedpSwitchChipToBadge", false)

local function InExperienceDetailsPromptContent(tbl1)
    local var1 = useTokens()

    local createElement = React.createElement
    local var2 = ScrollView
    local tbl2 = {
        tag = "size-full-0 auto-y",
        ClipsDescendants = false,
        layout = {
            FillDirection = Enum.FillDirection.Horizontal,
            Padding = UDim.new(0, var1.Gap.Small)
        },
        scroll = {
            AutomaticCanvasSize = Enum.AutomaticSize.X,
            AutomaticSize = Enum.AutomaticSize.Y,
            ScrollingDirection = Enum.ScrollingDirection.X,
            scrollBarVisibility = Visibility.None
        }
    }
    local tbl3 = { AgeRecommendation = 0, Rating = 0 }
    local element

    if tbl1.ageRecommendation and tbl1.ageRecommendation.displayNameWithHeaderShort then
        if bool1 then
            element = React.createElement(
                Badge,
                {
                    text = tbl1.ageRecommendation.displayNameWithHeaderShort,
                    LayoutOrder = 1,
                    variant = BadgeVariant.Neutral
                }
            )
        else
            element = React.createElement(Chip, {
                text = tbl1.ageRecommendation.displayNameWithHeaderShort,
                LayoutOrder = 1,
                onActivated = function() end,
                Selectable = false
            })
        end
    else
        element = nil
    end

    tbl3.AgeRecommendation = element
    local element2

    if tbl1.rating then
        if bool1 then
            element2 = React.createElement(Badge, {
                text = tbl1.rating,
                LayoutOrder = 2,
                variant = BadgeVariant.Neutral,
                icon = {
                    name = Enums.IconName.ThumbUp,
                    variant = Enums.IconVariant.Filled,
                    position = Enums.IconPosition.Left
                }
            })
        else
            element2 = React.createElement(Chip, {
                text = tbl1.rating,
                LayoutOrder = 2,
                leading = {
                    iconName = Enums.IconName.ThumbUp,
                    iconVariant = Enums.IconVariant.Filled
                },
                onActivated = function() end,
                Selectable = false
            })
        end
    else
        element2 = nil
    end

    tbl3.Rating = element2
    return createElement(var2, tbl2, tbl3)
end

return InExperienceDetailsPromptContent
