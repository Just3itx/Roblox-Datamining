-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T17:11:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceTimedOptionsParent = script:FindFirstAncestor("AvatarExperienceTimedOptions").Parent

local Foundation = require(AvatarExperienceTimedOptionsParent.Foundation)
local React = require(AvatarExperienceTimedOptionsParent.React)
local Localization = require(AvatarExperienceTimedOptionsParent.Localization)
local Popover = Foundation.Popover
local View = Foundation.View
local FoundationText = Foundation.Text
local Enums = Foundation.Enums
local PopoverSide = Foundation.Enums.PopoverSide
local PopoverAlign = Foundation.Enums.PopoverAlign
local NumberLocalization = Localization.NumberLocalization

local WearTimeList = require(script.Parent.WearTimeList)
local _useWearTimeSelectedOptionViewModel = require(script.Parent.useWearTimeSelectedOptionViewModel)
local useWearTimePopoverFocusNavigationBindings = require(script.Parent.useWearTimePopoverFocusNavigationBindings)

local function WearTimeSelectedOptionView(arg1)
    local tokens = arg1.tokens

    local var1 = React.useCallback(function()
        arg1.setIsOpen(false)
    end, { arg1.setIsOpen })

    local ref = useWearTimePopoverFocusNavigationBindings(var1, arg1.isOpen, arg1.anchorRef)

    local createElement = React.createElement
    local str1 = "TextButton"
    local tbl1 = {
        Text = "",
        Size = UDim2.fromScale(0, 0),
        AutomaticSize = Enum.AutomaticSize.XY,
        BorderSizePixel = 0,
        BackgroundTransparency = 1,
        ref = arg1.anchorRef
    }

    tbl1[React.Event.Activated] = function()
        arg1.setIsOpen(not arg1.isOpen)
    end
    local tbl2 = {
        Layout = React.createElement(
            "UIListLayout",
            {
                FillDirection = Enum.FillDirection.Vertical,
                SortOrder = Enum.SortOrder.LayoutOrder
            }
        ),
        TopRow = React.createElement(
            View,
            { tag = "row align-y-center gap-xsmall auto-xy padding-top-xxsmall", LayoutOrder = 1 },
            {
                RobuxIcon = React.createElement(Foundation.Icon, {
                    name = Enums.IconName.Robux,
                    variant = Enums.IconVariant.Filled,
                    size = Enums.IconSize.Small,
                    style = tokens.Color.Content.Emphasis,
                    LayoutOrder = 1
                }),
                PriceLabel = React.createElement(FoundationText, {
                    tag = "auto-xy",
                    Text = NumberLocalization.localize(arg1.price, arg1.localization:GetLocale()),
                    textStyle = tokens.Color.Content.Emphasis,
                    fontStyle = {
                        Font = tokens.Typography.TitleSmall.Font,
                        FontSize = tokens.FontSize.FontSize_400
                    },
                    LayoutOrder = 2
                }),
                ChevronIcon = if arg1.disableOptionSelection then nil else React.createElement(Foundation.Icon, {
                    name = Enums.IconName.ChevronLargeDown,
                    variant = Enums.IconVariant.Regular,
                    size = Enums.IconSize.Small,
                    style = tokens.Color.Content.Emphasis,
                    LayoutOrder = 3
                })
            }
        ),
        SubLabel = arg1.subLabelText
            and React.createElement(FoundationText, {
                tag = "auto-xy padding-top-xxsmall",
                Text = arg1.subLabelText,
                textStyle = tokens.Color.Content.Muted,
                fontStyle = {
                    Font = tokens.Typography.CaptionMedium.Font,
                    FontSize = tokens.FontSize.FontSize_300
                },
                LayoutOrder = 2
            })
    }
    local triggerButton = createElement(str1, tbl1, tbl2)

    if arg1.disableOptionSelection then
        return triggerButton
    end
    return React.createElement(View, { tag = "auto-xy" }, {
        TriggerButton = triggerButton,
        Popover = React.createElement(Popover.Root, {
            isOpen = arg1.isOpen
        }, {
            Anchor = React.createElement(Popover.Anchor, { anchorRef = arg1.anchorRef }),
            Content = React.createElement(Popover.Content, {
                align = PopoverAlign.Start,
                side = PopoverSide.Top,
                hasArrow = false,
                onPressedOutside = function()
                    arg1.setIsOpen(false)
                end
            }, {
                ContentWrapper = React.createElement(
                    View,
                    {
                        Size = UDim2.new(0, tokens.Size.Size_2900 * 2, 0, 0),
                        tag = "auto-y",
                        ref = ref
                    },
                    {
                        WearTimeList = React.createElement(
                            WearTimeList,
                            {
                                options = arg1.updatedOptions,
                                selectedIndex = arg1.selectedIndex,
                                onOptionActivated = arg1.handleOptionActivated
                            }
                        )
                    }
                )
            })
        })
    })
end
return WearTimeSelectedOptionView
