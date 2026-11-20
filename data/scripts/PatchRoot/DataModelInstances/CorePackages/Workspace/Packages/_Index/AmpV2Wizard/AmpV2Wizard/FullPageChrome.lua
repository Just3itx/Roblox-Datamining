-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T21:40:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AmpV2Wizard = script:FindFirstAncestor("AmpV2Wizard")
local AmpV2WizardParent = AmpV2Wizard.Parent

local React = require(AmpV2WizardParent.React)

local Foundation = require(AmpV2WizardParent.Foundation)
local View = Foundation.View
local FoundationText = Foundation.Text
local Divider = Foundation.Divider
local HeaderBar = Foundation.HeaderBar
local IconName = Foundation.Enums.IconName

local FFlagAmpV2WizardFullPageHeaderAlign = require(AmpV2Wizard.FFlagAmpV2WizardFullPageHeaderAlign)

local function FullPageChrome(tbl1)
    local onBack = tbl1.onBack
    local onClose = tbl1.onClose
    local title = tbl1.title

    local createElement = React.createElement
    local root = HeaderBar.Root
    local tbl2 = { LayoutOrder = 1 }
    local tbl3 = { Leading = 0, Trailing = 0 }
    local element

    if onBack == nil and (title == nil or title == "") then
        element = nil
    else
        element = React.createElement(HeaderBar.Leading, nil, {
            Actions = if onBack == nil then nil else React.createElement(
                HeaderBar.Actions,
                {
                    actions = {{
                        id = "back",
                        icon = IconName.ChevronLargeLeft,
                        onActivated = onBack
                    }}
                }
            ),
            Title = if title == nil or title == "" then nil else React.createElement(
                FoundationText,
                {
                    Text = title,
                    tag = "auto-xy text-heading-medium content-emphasis",
                    LayoutOrder = 2
                }
            )
        })
    end

    tbl3.Leading = element

    tbl3.Trailing = if onClose == nil then nil else React.createElement(HeaderBar.Trailing, nil, {
        Actions = React.createElement(HeaderBar.Actions, { actions = {{ id = "close", icon = IconName.X, onActivated = onClose }} })
    })
    local element2 = createElement(root, tbl2, tbl3)

    if not FFlagAmpV2WizardFullPageHeaderAlign then
        return React.createElement(
            View,
            {
                tag = "col align-x-center size-full bg-surface-0",
                testId = "amp-v2-wizard-full-page"
            },
            {
                Header = element2,
                HeaderDivider = React.createElement(Divider, { LayoutOrder = 2 }),
                Content = React.createElement(
                    View,
                    {
                        tag = "col fill size-full-0",
                        LayoutOrder = 3,
                        sizeConstraint = {
                            MaxSize = Vector2.new(480, math.huge)
                        }
                    },
                    tbl1.children
                )
            }
        )
    end

    return React.createElement(
        View,
        { tag = "col align-x-center size-full bg-surface-0", testId = "amp-v2-wizard-full-page" },
        {
            Column = React.createElement(View, {
                tag = "col fill size-full-0",
                testId = "amp-v2-wizard-full-page-column",
                sizeConstraint = {
                    MaxSize = Vector2.new(480, math.huge)
                }
            }, {
                Header = React.createElement(
                    View,
                    {
                        tag = "size-full-0 auto-y padding-x-small",
                        LayoutOrder = 1,
                        testId = "amp-v2-wizard-full-page-header"
                    },
                    { Bar = element2 }
                ),
                Content = React.createElement(
                    View,
                    {
                        tag = "col fill size-full-0",
                        LayoutOrder = 2,
                        testId = "amp-v2-wizard-full-page-content"
                    },
                    tbl1.children
                )
            })
        }
    )
end

return FullPageChrome
