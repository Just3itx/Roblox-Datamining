-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T19:00:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceDetailsPrompt = script:FindFirstAncestor("InExperienceDetailsPrompt")
local InExperienceDetailsPromptParent = InExperienceDetailsPrompt.Parent
local React = require(InExperienceDetailsPromptParent.React)
local _DataHydration = require(InExperienceDetailsPromptParent.DataHydration)

local Foundation = require(InExperienceDetailsPromptParent.Foundation)
local Image = Foundation.Image
local Radius = Foundation.Enums.Radius
local Sheet = Foundation.Sheet
local Skeleton = Foundation.Skeleton
local FoundationText = Foundation.Text
local View = Foundation.View
local useTokens = Foundation.Hooks.useTokens
local useScaledValue = Foundation.Hooks.useScaledValue

local InExperienceDetailsPromptSubtitle = require(InExperienceDetailsPrompt.Features.InExperienceDetailsPromptSubtitle)
local useImageLoadingState = require(InExperienceDetailsPrompt.Hooks.useImageLoadingState)

local function InExperienceDetailsPromptHeader(tbl1)
    local var1 = useTokens()
    local xOffset = useScaledValue(200)
    local xOffset2 = useScaledValue(150)
    local var2 = useImageLoadingState(tbl1.imageUri)

    local createElement = React.createElement
    local header = Sheet.Header
    local var3 = nil
    local tbl2 = { Content = 0 }
    local createElement2 = React.createElement
    local var4 = View
    local tbl3 = {
        LayoutOrder = 1,
        tag = "row gap-small size-full-0 auto-y items-center padding-top-medium"
    }

    local tbl4 = { GameIcon = 0, TextContainer = 0 }
    local element

    if var2 then
        element = React.createElement(Image, {
            LayoutOrder = 1,
            Image = tbl1.imageUri,
            Size = UDim2.fromOffset(var1.Size.Size_1200, var1.Size.Size_1200),
            cornerRadius = UDim.new(0, var1.Radius.Medium)
        })
    else
        element = React.createElement(
            Skeleton,
            {
                LayoutOrder = 1,
                Size = UDim2.fromOffset(var1.Size.Size_1200, var1.Size.Size_1200),
                radius = Radius.Medium
            }
        )
    end

    tbl4.GameIcon = element

    tbl4.TextContainer = React.createElement(View, {
        LayoutOrder = 2,
        tag = "col gap-xxsmall fill auto-xy"
    }, {
        Title = if tbl1.name then React.createElement(
            FoundationText,
            {
                LayoutOrder = 1,
                Text = tbl1.name,
                tag = "text-heading-small content-emphasis auto-xy text-truncate-end"
            }
        ) else React.createElement(Skeleton, { LayoutOrder = 1, Size = UDim2.fromOffset(xOffset, var1.Size.Size_600) }),
        Subtitle = if tbl1.creator then React.createElement(InExperienceDetailsPromptSubtitle, { creator = tbl1.creator, layoutOrder = 2 }) else React.createElement(Skeleton, { LayoutOrder = 2, Size = UDim2.fromOffset(xOffset2, var1.Size.Size_500) })
    })
    tbl2.Content = createElement2(var4, tbl3, tbl4)
    return createElement(header, var3, tbl2)
end

return InExperienceDetailsPromptHeader
