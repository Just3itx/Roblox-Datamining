-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T17:11:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceTimedOptionsParent = script:FindFirstAncestor("AvatarExperienceTimedOptions").Parent

local Foundation = require(AvatarExperienceTimedOptionsParent.Foundation)
local React = require(AvatarExperienceTimedOptionsParent.React)
local Popover = Foundation.Popover
local View = Foundation.View
local FoundationText = Foundation.Text
local Enums = Foundation.Enums
local PopoverSide = Foundation.Enums.PopoverSide
local PopoverAlign = Foundation.Enums.PopoverAlign

local WearTimeList = require(script.Parent.WearTimeList)
local _useWearTimeSelectedOptionViewModel = require(script.Parent.useWearTimeSelectedOptionViewModel)
local useWearTimePopoverFocusNavigationBindings = require(script.Parent.useWearTimePopoverFocusNavigationBindings)

local function WearTimeSelectedOptionInListView(arg1)
    local tokens = arg1.tokens

    local var1 = React.useCallback(function()
        arg1.setIsOpen(false)
    end, { arg1.setIsOpen })

    local ref = useWearTimePopoverFocusNavigationBindings(var1, arg1.isOpen, arg1.anchorRef)

    local createElement = React.createElement
    local tbl1 = {
        Text = "",
        Size = UDim2.fromScale(0, 0),
        AutomaticSize = Enum.AutomaticSize.XY,
        BorderSizePixel = 0,
        Transparency = arg1.tokens.Color.Shift.Shift_200.Transparency,
        BackgroundColor3 = arg1.tokens.Color.Shift.Shift_200.Color3,
        ref = arg1.anchorRef
    }

    tbl1[React.Event.Activated] = function()
        arg1.setIsOpen(not arg1.isOpen)
    end

    local triggerButton = createElement("TextButton", tbl1, {
        UICorner = React.createElement("UICorner", { CornerRadius = UDim.new(0, tokens.Radius.Circle) }),
        Layout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, tokens.Padding.XXSmall)
        }),
        Padding = React.createElement("UIPadding", {
            PaddingLeft = UDim.new(0, tokens.Padding.Medium),
            PaddingRight = UDim.new(0, tokens.Padding.Medium),
            PaddingTop = UDim.new(0, tokens.Padding.Small),
            PaddingBottom = UDim.new(0, tokens.Padding.Small)
        }),
        TopRow = React.createElement(View, {
            tag = "row align-y-center gap-small auto-xy",
            LayoutOrder = 1
        }, {
            Duration = React.createElement(FoundationText, {
                tag = "auto-xy",
                Text = arg1.listLabelText,
                textStyle = tokens.Color.Content.Emphasis,
                fontStyle = {
                    Font = tokens.Typography.TitleSmall.Font,
                    FontSize = tokens.FontSize.FontSize_300
                },
                LayoutOrder = 2
            }),
            ChevronIcon = React.createElement(Foundation.Icon, {
                name = Enums.IconName.ChevronLargeDown,
                variant = Enums.IconVariant.Regular,
                size = Enums.IconSize.Small,
                LayoutOrder = 3
            })
        })
    })

    return React.createElement(View, { tag = "auto-xy" }, {
        TriggerButton = triggerButton,
        Popover = React.createElement(Popover.Root, {
            isOpen = arg1.isOpen
        }, {
            Anchor = React.createElement(Popover.Anchor, { anchorRef = arg1.anchorRef }),
            Content = React.createElement(Popover.Content, {
                align = PopoverAlign.Start,
                side = PopoverSide.Bottom,
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

return WearTimeSelectedOptionInListView
