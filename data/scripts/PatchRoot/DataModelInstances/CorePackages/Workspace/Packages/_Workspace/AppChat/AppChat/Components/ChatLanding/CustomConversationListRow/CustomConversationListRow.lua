-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:11:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local React = require(AppChatParent.React)
local Foundation = require(AppChatParent.Foundation)

local FFlagDebugAppChatEnableDomLocators = require(AppChat.Flags.FFlagDebugAppChatEnableDomLocators)

local FFlagAppChatExtendConversationListRowDividers = require(AppChat.Flags.FFlagAppChatExtendConversationListRowDividers)
local FFlagAppChatRemoveConversationListDivider = require(AppChat.Flags.FFlagAppChatRemoveConversationListDivider)

local FFlagAppChatAlignCustomConversationListRowChevron = require(AppChat.Flags.FFlagAppChatAlignCustomConversationListRowChevron)

local useCustomConversationListRowPresentation = require(script.Parent.useCustomConversationListRowPresentation)

return React.memo(function(tbl1) -- name: CustomConversationListRow
    local var1 = useCustomConversationListRowPresentation({ entryHeight = tbl1.entryHeight, onActivated = tbl1.onActivated })

    local var2 = Foundation.Hooks.useTokens()
    local showBackground = var1.showBackground
    local uDim = UDim.new(0, var1.pagePaddingLeft)
    local uDim2 = UDim.new(0, var1.pagePaddingRight)

    local createElement = React.createElement
    local view = Foundation.View
    local tbl2 = {
        backgroundStyle = var2.Color.None,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, var1.entryHeight),
        testId = if FFlagDebugAppChatEnableDomLocators then tbl1.testId else nil
    }
    local tbl3 = { customCell = 0 }
    local createElement2 = React.createElement
    local view2 = Foundation.View
    local tbl4 = {
        Name = "customCell",
        Size = if FFlagAppChatExtendConversationListRowDividers then nil else UDim2.fromScale(1, 1),
        tag = { ["size-full"] = true, ["bg-surface-0"] = showBackground },
        backgroundStyle = if showBackground then nil else var2.Color.None,
        selection = { Selectable = true },
        onActivated = var1.onActivated,
        stateLayer = showBackground and {
            affordance = Foundation.Enums.StateLayerAffordance.Background
        } or nil
    }

    local tbl5 = { content = 0 }
    local createElement3 = React.createElement
    local view3 = Foundation.View
    local tbl6 = {
        Size = if FFlagAppChatExtendConversationListRowDividers then nil else UDim2.fromScale(1, 1),
        tag = "row align-y-center gap-small size-full",
        padding = {
            left = uDim,
            right = if FFlagAppChatExtendConversationListRowDividers then nil else uDim2
        }
    }
    local tbl7 = {
        icon = React.createElement(
            Foundation.View,
            { tag = "row align-x-center align-y-center size-1000-1000", LayoutOrder = 0 },
            {
                iconTile = React.createElement(
                    Foundation.View,
                    {
                        tag = "row align-x-center align-y-center size-900-900 radius-medium bg-surface-100"
                    },
                    {
                        icon = React.createElement(
                            Foundation.Icon,
                            {
                                name = tbl1.entryIcon,
                                size = Foundation.Enums.IconSize.Medium,
                                style = var2.Color.Content.Emphasis
                            }
                        )
                    }
                )
            }
        ),
        body = React.createElement(Foundation.View, {
            tag = "col fill size-0-full clip",
            Name = "body",
            LayoutOrder = 1
        }, {
            mainContent = React.createElement(Foundation.View, {
                tag = "row align-y-center fill gap-small size-full-0 clip",
                Name = "mainContent",
                LayoutOrder = 1,
                padding = FFlagAppChatExtendConversationListRowDividers and { right = uDim2 } or nil
            }, {
                info = React.createElement(
                    Foundation.View,
                    {
                        tag = "col align-y-center fill gap-xxsmall size-0-full clip",
                        LayoutOrder = 1
                    },
                    {
                        title = React.createElement(Foundation.Text, {
                            tag = "size-full-0 auto-y text-title-large text-align-x-left text-truncate-end content-default",
                            Name = "title",
                            Text = tbl1.titleText or "",
                            LayoutOrder = 1
                        }),
                        subtitle = React.createElement(Foundation.Text, {
                            tag = "size-full-0 auto-y text-body-small text-align-x-left text-truncate-end content-default",
                            Name = "subTitle",
                            Text = tbl1.subTitleText or "",
                            LayoutOrder = 2
                        })
                    }
                ),
                chevron = React.createElement(Foundation.View, {
                    tag = {
                        ["row align-y-center size-0-full auto-x"] = FFlagAppChatAlignCustomConversationListRowChevron,
                        ["row align-x-center align-y-center size-1200-full"] = not FFlagAppChatAlignCustomConversationListRowChevron
                    },
                    LayoutOrder = 2
                }, {
                    icon = React.createElement(Foundation.Icon, {
                        name = Foundation.Enums.IconName.ChevronLargeRight,
                        size = Foundation.Enums.IconSize.Medium,
                        style = var2.Color.Content.Emphasis
                    })
                })
            }),
            divider = if FFlagAppChatRemoveConversationListDivider then nil else React.createElement(
                Foundation.View,
                { tag = "size-full-0 auto-y", Name = "divider", LayoutOrder = 2 },
                {
                    line = React.createElement(Foundation.Divider)
                }
            )
        })
    }
    tbl5.content = createElement3(view3, tbl6, tbl7)
    tbl3.customCell = createElement2(view2, tbl4, tbl5)
    return createElement(view, tbl2, tbl3)
end)
