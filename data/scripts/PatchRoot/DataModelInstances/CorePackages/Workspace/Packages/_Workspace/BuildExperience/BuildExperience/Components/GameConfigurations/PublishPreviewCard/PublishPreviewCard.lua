-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:50:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)

local _chatTypes = require(BuildExperience.Chat.chatTypes)
local PublishExperienceTitle = require(script.Parent.PublishExperienceTitle)

local Image = Foundation.Image
local View = Foundation.View

local useTokens = Foundation.Hooks.useTokens

local x = game:DefineFastInt("BuildPublishPreviewCardMaxWidth", 560)
local numberSequence = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 1),
    NumberSequenceKeypoint.new(0.499, 1),
    NumberSequenceKeypoint.new(0.5, 0),
    NumberSequenceKeypoint.new(1, 0)
})

local function getMediaUrl(target) -- Luacid: Inlined by compiler; 1 call site recovered
    if target.placeId ~= nil then
        return `rbxthumb://type=GameThumbnail&id={target.placeId}&w=768&h=432`
    end

    return target.gameIcon or `rbxthumb://type=GameIcon&id={target.universeId}&w=150&h=150`
end

local function PublishPreviewCard(tbl1)
    local var1 = useTokens()
    local testId = tbl1.testId or "publish-preview-card"
    local target = tbl1.target
    local image = getMediaUrl(target)
    return React.createElement(
        View,
        {
            LayoutOrder = tbl1.layoutOrder,
            tag = "col align-x-center size-full-0 auto-y padding-y-xsmall",
            testId = testId
        },
        {
            Card = React.createElement(View, {
                sizeConstraint = {
                    MaxSize = Vector2.new(x, math.huge)
                },
                tag = "col size-full-0 auto-y stroke-standard stroke-default radius-large clip bg-surface-100",
                testId = `{testId}-card`
            }, {
                Media = React.createElement(
                    View,
                    {
                        LayoutOrder = 1,
                        ClipsDescendants = true,
                        tag = "size-full-full auto-y aspect-16-9 bg-surface-200"
                    },
                    {
                        RoundedCornerImage = React.createElement(Image, {
                            Image = image,
                            ScaleType = Enum.ScaleType.Fit,
                            ZIndex = 1,
                            cornerRadius = UDim.new(0, var1.Radius.Medium),
                            tag = "size-full",
                            testId = `{testId}-media`
                        }),
                        SquareCornerImage = React.createElement(
                            Image,
                            {
                                Image = image,
                                ScaleType = Enum.ScaleType.Fit,
                                ZIndex = 2,
                                tag = "size-full",
                                testId = `{testId}-media-bottom`
                            },
                            {
                                BottomHalfMask = React.createElement("UIGradient", { Rotation = 90, Transparency = numberSequence })
                            }
                        )
                    }
                ),
                Content = React.createElement(View, {
                    LayoutOrder = 2,
                    tag = "col size-full-0 auto-y padding-large"
                }, {
                    Title = React.createElement(
                        PublishExperienceTitle,
                        {
                            target = target,
                            isCreatorVerified = tbl1.isCreatorVerified,
                            layoutOrder = 1,
                            testId = `{testId}-title`
                        }
                    )
                })
            })
        }
    )
end

return PublishPreviewCard
