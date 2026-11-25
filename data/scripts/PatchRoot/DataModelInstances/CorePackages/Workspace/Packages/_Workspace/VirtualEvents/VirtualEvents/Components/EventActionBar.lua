-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:01:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VirtualEvents = script:FindFirstAncestor("VirtualEvents")

local React = require(VirtualEvents.Parent.React)
local Foundation = require(VirtualEvents.Parent.Foundation)
local UIBlox = require(VirtualEvents.Parent.UIBlox)
local GamePlayButton = require(VirtualEvents.Parent.GamePlayButton)
local RoactNetworking = require(VirtualEvents.Parent.RoactServiceTags).RoactNetworking
local useRoactService = require(VirtualEvents.Parent.RobloxAppHooks).useRoactService
local _VirtualEventsState = require(VirtualEvents.Parent.VirtualEventsState)
local useExperienceSubtitle = require(VirtualEvents.Hooks.useExperienceSubtitle)

local View = Foundation.View
local Button = Foundation.Button
local ButtonSize = Foundation.Enums.ButtonSize
local ButtonVariant = Foundation.Enums.ButtonVariant
local FillBehavior = Foundation.Enums.FillBehavior
local FoundationText = Foundation.Text
local useTokens = Foundation.Hooks.useTokens

local Images = UIBlox.App.ImageSet.Images
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel

local usePlayButtonState = GamePlayButton.usePlayButtonState
local PlayButtonStates = GamePlayButton.PlayButtonStates

local function EventActionBar(tbl1)
    local var1 = useTokens()
    local var2 = if tbl1.universeId then useExperienceSubtitle(tbl1.universeId) else nil
    local var3 = useRoactService(RoactNetworking)
    local var4 = usePlayButtonState(var3, tbl1.universeId or "")
    local bool1 = var4.playButtonState == PlayButtonStates.Playable or var4.playButtonState == PlayButtonStates.PlayableWithParty

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y
    }
    local tbl3 = {
        Layout = React.createElement(
            "UIListLayout",
            {
                FillDirection = Enum.FillDirection.Vertical,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 16)
            }
        ),
        UpperContainer = 0,
        LowerContianer = 0
    }

    local createElement2 = React.createElement
    local str2 = "Frame"
    local tbl4 = {
        Size = UDim2.new(1, 0, 0, 40),
        BackgroundTransparency = 1,
        LayoutOrder = 1
    }

    local tbl5 = {
        Layout = React.createElement(
            "UIListLayout",
            {
                FillDirection = Enum.FillDirection.Horizontal,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 12)
            }
        ),
        ExperienceThumbnail = React.createElement(
            "ImageButton",
            {
                Active = true,
                Size = UDim2.fromOffset(40, 40),
                BorderSizePixel = 0,
                Image = ("rbxthumb://type=GameIcon&id=%s&w=150&h=150"):format(tbl1.universeId),
                [React.Event.Activated] = tbl1.onExperienceTileActivated
            },
            {
                UICorner = React.createElement("UICorner", { CornerRadius = UDim.new(0, 8) })
            }
        ),
        EventInfo = 0
    }

    local createElement3 = React.createElement
    local str3 = "Frame"
    local tbl6 = {
        Size = UDim2.new(1, -52, 1, 0),
        BackgroundTransparency = 1,
        LayoutOrder = 2
    }

    local tbl7 = {
        Layout = React.createElement(
            "UIListLayout",
            {
                SortOrder = Enum.SortOrder.LayoutOrder,
                FillDirection = Enum.FillDirection.Vertical
            }
        ),
        ExperienceName = React.createElement(FoundationText, {
            LayoutOrder = 1,
            Size = UDim2.fromScale(1, if var2 then 0.5 else 1),
            Text = tbl1.experienceName,
            textStyle = var1.Color.Content.Emphasis,
            fontStyle = var1.Typography.TitleLarge,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextTruncate = Enum.TextTruncate.SplitWord,
            TextWrapped = false
        }),
        ExperienceSubtitle = 0
    }
    local element

    if var2 then
        element = React.createElement(FoundationText, {
            LayoutOrder = 2,
            Size = UDim2.fromScale(1, 0.5),
            Text = var2,
            textStyle = var1.Color.Content.Default,
            fontStyle = var1.Typography.BodyLarge,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextTruncate = Enum.TextTruncate.None,
            TextWrapped = false
        })
    else
        element = nil
    end

    tbl7.ExperienceSubtitle = element
    tbl5.EventInfo = createElement3(str3, tbl6, tbl7)
    tbl3.UpperContainer = createElement2(str2, tbl4, tbl5)
    local var5

    if tbl1.ctaProps.button then
        local createElement4 = React.createElement
        local var6 = View
        local tbl8 = {
            LayoutOrder = 2,
            size = UDim2.new(1, 0, 0, 40),
            tag = { ["row gap-small wrap auto-y size-full-0"] = true, ["fill-x"] = true }
        }
        local tbl9 = {
            CTAButton = React.createElement(Button, {
                text = tbl1.ctaProps.button.text,
                variant = ButtonVariant[tbl1.ctaProps.button.variant],
                onActivated = not bool1 and function() end or tbl1.ctaProps.button.onActivated,
                fillBehavior = FillBehavior.Fill,
                size = ButtonSize.Medium,
                isDisabled = not bool1
            }),
            ShareButtonWrapper = 0
        }
        local element2

        if tbl1.ctaProps.icon then
            element2 = React.createElement("Frame", {
                Size = UDim2.fromOffset(40, 40),
                BackgroundTransparency = 1
            }, {
                ShareButton = React.createElement(Button, {
                    variant = ButtonVariant.Standard,
                    onActivated = not bool1 and function() end or tbl1.ctaProps.icon.onActivated,
                    fillBehavior = FillBehavior.Fill,
                    size = ButtonSize.Medium,
                    isDisabled = not bool1
                }),
                ShareIcon = React.createElement(ImageSetLabel, {
                    ZIndex = 2,
                    Size = UDim2.fromOffset(32, 32),
                    Image = Images[tbl1.ctaProps.icon.icon],
                    BackgroundTransparency = 1,
                    Position = UDim2.fromOffset(4, 4)
                })
            })
        else
            element2 = nil
        end

        tbl9.ShareButtonWrapper = element2
        var5 = createElement4(var6, tbl8, tbl9)
    else
        var5 = nil
    end

    tbl3.LowerContianer = var5
    return createElement(str1, tbl2, tbl3)
end

return EventActionBar
