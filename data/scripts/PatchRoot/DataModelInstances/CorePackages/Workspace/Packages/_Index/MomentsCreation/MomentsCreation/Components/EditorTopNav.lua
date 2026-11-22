-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:51:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreation = script:FindFirstAncestor("MomentsCreation")
local MomentsCreationParent = MomentsCreation.Parent

local BuilderIcons = require(MomentsCreationParent.BuilderIcons)
local Foundation = require(MomentsCreationParent.Foundation)
local MomentsCommon = require(MomentsCreationParent.MomentsCommon)
local React = require(MomentsCreationParent.React)

local Button = Foundation.Button
local Icon = Foundation.Icon
local View = Foundation.View

local GradientBackdrop = MomentsCommon.Components.GradientBackdrop

local useDeviceInsets = MomentsCommon.Hooks.useDeviceInsets
local useTokens = Foundation.Hooks.useTokens

local useCreationFlowStrings = require(MomentsCreation.Hooks.useCreationFlowStrings)

local function EditorTopNav(tbl1)
    local var1 = useTokens()
    local var2 = useDeviceInsets()
    local var3 = useCreationFlowStrings()
    local zIndex = tbl1.zIndex or 1

    return React.createElement(React.Fragment, nil, {
        TopScrim = React.createElement(GradientBackdrop, {
            color3 = Color3.new(0, 0, 0),
            cornerRadius = UDim.new(0, var1.Radius.Large),
            rotation = 90,
            size = UDim2.new(1, 0, 0, var2.top + var1.Size.Size_2000 + var1.Size.Size_1600),
            startingTransparency = 0.4,
            zIndex = zIndex
        }),
        Nav = React.createElement(View, {
            tag = "row flex-x-between align-y-center position-top-center anchor-top-center size-full-0 auto-y",
            padding = {
                top = UDim.new(0, var2.top + var1.Padding.Medium),
                left = UDim.new(0, var2.left + var1.Padding.Medium),
                right = UDim.new(0, var2.right + var1.Padding.Medium)
            },
            ZIndex = zIndex + 1
        }, {
            BackButton = React.createElement(View, {
                LayoutOrder = 1,
                onActivated = tbl1.onBack,
                stateLayer = {
                    affordance = Foundation.Enums.StateLayerAffordance.Background
                },
                tag = "auto-xy padding-small radius-circle",
                testId = tbl1.backTestId
            }, {
                BackIcon = React.createElement(Icon, {
                    name = BuilderIcons.Icon.ChevronLargeLeft,
                    size = Foundation.Enums.IconSize.Large,
                    style = var1.Color.Content.Emphasis
                })
            }),
            SaveButton = React.createElement(Button, {
                fillBehavior = Foundation.Enums.FillBehavior.Fit,
                LayoutOrder = 2,
                text = var3.GeneralCtaSave,
                variant = Foundation.Enums.ButtonVariant.Text,
                onActivated = tbl1.onSave,
                size = Foundation.Enums.InputSize.Medium,
                testId = tbl1.saveTestId
            })
        })
    })
end

return EditorTopNav
