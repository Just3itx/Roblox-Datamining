-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:00:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreation = script:FindFirstAncestor("MomentsCreation")
local MomentsCreationParent = MomentsCreation.Parent

local BuilderIcons = require(MomentsCreationParent.BuilderIcons)
local Foundation = require(MomentsCreationParent.Foundation)
local React = require(MomentsCreationParent.React)

local IconButton = Foundation.IconButton
local FoundationText = Foundation.Text
local View = Foundation.View

local useTokens = Foundation.Hooks.useTokens

local Constants = require(MomentsCreation.Constants)
local _CreationFlowTypes = require(MomentsCreation.Types.CreationFlowTypes)
local useTextFontRowState = require(MomentsCreation.Components.TextOverlay.useTextFontRowState)
local FFlagMomentsTextOverlayColorPickerIcon = require(MomentsCreation.Flags.FFlagMomentsTextOverlayColorPickerIcon)

local tbl1 = {
    {
        font = Enum.Font.BuilderSansMedium,
        label = "Builder"
    },
    {
        font = Enum.Font.SourceSans,
        label = "Source Sans"
    },
    {
        font = Enum.Font.LuckiestGuy,
        label = "Luckiest Guy"
    },
    {
        font = Enum.Font.Bangers,
        label = "Bangers"
    },
    {
        font = Enum.Font.PermanentMarker,
        label = "Permanent Marker"
    },
    {
        font = Enum.Font.Creepster,
        label = "Creepster"
    },
    {
        font = Enum.Font.Arcade,
        label = "Arcade"
    },
    {
        font = Enum.Font.SciFi,
        label = "Sci-Fi"
    },
    {
        font = Enum.Font.IndieFlower,
        label = "Indie Flower"
    },
    {
        font = Enum.Font.GrenzeGotisch,
        label = "Grenze Gotisch"
    },
    {
        font = Enum.Font.SpecialElite,
        label = "Special Elite"
    }
}

local tbl2 = {
    Color3 = Color3.fromRGB(32, 34, 39),
    Transparency = 0
}
local function TextFontRow(tbl3)
    local var1 = useTokens()
    local var2 = useTextFontRowState(tbl3.controller)

    local tbl4 = ({})
    for layoutOrder, value2 in tbl1 do
        local bool1 = var2.font == value2.font
        local var3 = "Chip" .. layoutOrder
        local createElement = React.createElement
        local var4 = View
        local tbl5 = {
            LayoutOrder = layoutOrder,
            tag = "row align-x-center align-y-center size-0-800 auto-x radius-circle clip",
            padding = {
                left = UDim.new(0, var1.Padding.Medium),
                right = UDim.new(0, var1.Padding.Medium),
                top = if FFlagMomentsTextOverlayColorPickerIcon and value2.font == Enum.Font.LuckiestGuy then UDim.new(0, var1.Size.Size_100) else nil
            },
            backgroundStyle = if bool1 then var1.Inverse.Surface.Surface_0 else var1.Color.ActionStandard.Background,
            onActivated = 0
        }

        function tbl5.onActivated()
            var2.onChipActivated(value2.font, layoutOrder)
        end
        local tbl6 = {
            Label = React.createElement(FoundationText, {
                Text = value2.label,
                tag = "shrink auto-x text-label-medium text-truncate-end",
                fontStyle = {
                    Font = value2.font
                },
                textStyle = if bool1 then tbl2 else var1.Color.ActionStandard.Foreground
            })
        }
        tbl4[var3] = createElement(var4, tbl5, tbl6)
    end

    return React.createElement(
        View,
        {
            LayoutOrder = tbl3.LayoutOrder,
            Size = UDim2.new(1, 0, 0, Constants.TextOverlay.PickerRowHeight)
        },
        {
            Scroll = React.createElement(
                Foundation.ScrollView,
                {
                    Size = UDim2.new(1, 0, 1, 0),
                    scrollingFrameRef = var2.scrollingFrameRef,
                    onCanvasPositionChanged = var2.onScrollViewportChanged,
                    onAbsoluteCanvasSizeChanged = var2.onScrollViewportChanged,
                    onAbsoluteWindowSizeChanged = var2.onScrollViewportChanged,
                    scroll = {
                        scrollBarVisibility = Foundation.Enums.Visibility.None,
                        ScrollingDirection = Enum.ScrollingDirection.X,
                        AutomaticCanvasSize = Enum.AutomaticSize.X
                    }
                },
                {
                    Row = React.createElement(View, { tag = "row align-y-center gap-medium size-0-full auto-x padding-x-large" }, tbl4)
                }
            ),
            LeftChevron = if var2.showLeftChevron then React.createElement(
                View,
                { ZIndex = 2, tag = "position-center-left anchor-center-left auto-xy" },
                {
                    Icon = React.createElement(IconButton, {
                        icon = BuilderIcons.Icon.ChevronSmallLeft,
                        onActivated = var2.onLeftChevronActivated,
                        size = Foundation.Enums.InputSize.Medium
                    })
                }
            ) else nil,
            RightChevron = if var2.showRightChevron then React.createElement(
                View,
                { ZIndex = 2, tag = "position-center-right anchor-center-right auto-xy" },
                {
                    Icon = React.createElement(IconButton, {
                        icon = BuilderIcons.Icon.ChevronSmallRight,
                        onActivated = var2.onRightChevronActivated,
                        size = Foundation.Enums.InputSize.Medium
                    })
                }
            ) else nil
        }
    )
end

return TextFontRow
