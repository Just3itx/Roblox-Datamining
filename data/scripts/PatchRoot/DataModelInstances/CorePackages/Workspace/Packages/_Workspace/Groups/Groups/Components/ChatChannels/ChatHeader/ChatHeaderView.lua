-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T17:40:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GroupsParent = script:FindFirstAncestor("Groups").Parent

local React = require(GroupsParent.React)
local Foundation = require(GroupsParent.Foundation)

local View = Foundation.View
local FoundationText = Foundation.Text
local Image = Foundation.Image
local Button = Foundation.Button
local IconButton = Foundation.IconButton
local Menu = Foundation.Menu
local ButtonVariant = Foundation.Enums.ButtonVariant
local InputSize = Foundation.Enums.InputSize

local function ChatHeaderView(tbl1)
    local createElement = React.createElement
    local var1 = View
    local tbl2 = {
        tag = "row align-y-center gap-small size-full-0 auto-y",
        LayoutOrder = tbl1.LayoutOrder,
        testId = tbl1.testId
    }
    local tbl3 = {
        HeaderSlot = React.createElement(View, { tag = "row fill size-0-0 auto-y", LayoutOrder = 1 }, {
            Header = React.createElement(View, {
                tag = "row align-y-center shrink gap-medium size-0-0 auto-xy padding-small radius-medium",
                onActivated = tbl1.onClick,
                testId = `{tbl1.testId}--header`
            }, {
                Icon = React.createElement(Image, {
                    Image = tbl1.icon,
                    ScaleType = Enum.ScaleType.Crop,
                    tag = {
                        ["size-1000-1000"] = true,
                        ["radius-circle"] = tbl1.isUserIcon,
                        ["radius-medium"] = not tbl1.isUserIcon
                    },
                    LayoutOrder = 1,
                    testId = `{tbl1.testId}--icon`
                }),
                Details = React.createElement(View, {
                    tag = "col flex-x-fill shrink size-0-0 auto-xy",
                    LayoutOrder = 2
                }, {
                    Title = React.createElement(FoundationText, {
                        Text = tbl1.title,
                        tag = "auto-xy text-title-medium text-no-wrap text-align-x-left text-truncate-end content-default",
                        LayoutOrder = 1
                    }),
                    Subtitle = React.createElement(FoundationText, {
                        Text = tbl1.subtitle,
                        tag = "auto-xy text-body-medium text-no-wrap text-align-x-left text-truncate-end content-muted",
                        LayoutOrder = 2
                    })
                })
            })
        }),
        CTA = if tbl1.ctaButton then React.createElement(Button, {
            text = tbl1.ctaButton.title,
            onActivated = tbl1.ctaButton.action,
            variant = tbl1.ctaButton.type,
            size = InputSize.Small,
            LayoutOrder = 2,
            testId = `{tbl1.testId}--cta`
        }) else nil,
        Overflow = 0
    }
    local element

    if #tbl1.menuItems > 0 then
        element = React.createElement(Menu, {
            items = tbl1.menuItems,
            isOpen = tbl1.isMenuOpen,
            onPressedOutside = tbl1.onCloseMenu,
            side = Foundation.Enums.PopoverSide.Bottom,
            align = Foundation.Enums.PopoverAlign.End,
            selectionGroup = {
                SelectionBehaviorUp = Enum.SelectionBehavior.Stop,
                SelectionBehaviorDown = Enum.SelectionBehavior.Stop,
                SelectionBehaviorLeft = Enum.SelectionBehavior.Stop,
                SelectionBehaviorRight = Enum.SelectionBehavior.Stop
            },
            ref = tbl1.menuRef,
            LayoutOrder = 3,
            testId = `{tbl1.testId}--menu`
        }, {
            Trigger = React.createElement(IconButton, {
                icon = Foundation.Enums.IconName.ThreeDotsHorizontal,
                variant = ButtonVariant.Utility,
                size = InputSize.Small,
                onActivated = tbl1.onToggleMenu,
                testId = `{tbl1.testId}--overflow`
            })
        })
    else
        element = nil
    end

    tbl3.Overflow = element
    return createElement(var1, tbl2, tbl3)
end

return ChatHeaderView
