-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T17:11:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceTimedOptionsParent = script:FindFirstAncestor("AvatarExperienceTimedOptions").Parent

local React = require(AvatarExperienceTimedOptionsParent.React)
local useLocalization = require(AvatarExperienceTimedOptionsParent.Localization).Hooks.useLocalization
local Foundation = require(AvatarExperienceTimedOptionsParent.Foundation)
local useTokens = Foundation.Hooks.useTokens
local FoundationText = Foundation.Text
local View = Foundation.View
local Enums = Foundation.Enums

local _AvatarExperienceCommon = require(AvatarExperienceTimedOptionsParent.AvatarExperienceCommon)
local WearTimeOptionButton = require(script.Parent.WearTimeOptionButton)

local AXTooltip = require(AvatarExperienceTimedOptionsParent.AvatarExperienceUIKit).AXTooltipComponents.AXTooltip

local function WearTimeOptionsCarousel(tbl1)
    local var1 = useTokens()

    local var2 = useLocalization({
        wearTimeOptions = "Feature.Durables.ItemDetails.WearTimeOptions.Title",
        tooltipText = "Feature.Durables.FTUX.Tooltip"
    })

    local isOpen, var4 = React.useState(false)
    React.useEffect(function()
        local var5 = task.delay(5, function()
            var4(false)
        end)

        return function()
            task.cancel(var5)
        end
    end, {})

    local var5, var6 = React.useState(function()
        for k, option in tbl1.options do
            if option.selected then
                return k
            end
        end
        return 1
    end)

    local var7 = React.useMemo(function()
        local result = ({})
        for layoutOrder, option in tbl1.options do
            local createElement = React.createElement
            local var7 = WearTimeOptionButton
            local tbl2 = {
                option = {
                    days = option.days,
                    price = option.price,
                    selected = layoutOrder == var5
                },
                onActivated = 0,
                LayoutOrder = 0
            }
            function tbl2.onActivated()
                var6(layoutOrder)

                if tbl1.onOptionActivated then
                    tbl1.onOptionActivated(layoutOrder)
                end
            end
            tbl2.LayoutOrder = layoutOrder
            result[layoutOrder] = createElement(var7, tbl2)
        end

        return result
    end, { tbl1.options, var5, tbl1.onOptionActivated })

    local element = React.createElement(
        View,
        { tag = "row gap-medium align-y-center auto-xy" },
        {
            Options = React.createElement(React.Fragment, nil, var7)
        }
    )
    local element2

    if tbl1.useWrapping then
        element2 = React.createElement(
            View,
            {
                tag = "row wrap gap-medium align-y-center size-full-0 auto-y",
                LayoutOrder = 2,
                wrap = true
            },
            var7
        )
    else
        element2 = React.createElement(
            View,
            {
                tag = "size-full-0",
                Size = UDim2.new(1, 0, 0, var1.Size.Size_1200),
                LayoutOrder = 2
            },
            {
                ScrollingFrame = React.createElement("ScrollingFrame", {
                    Size = UDim2.new(1, 0, 1, 0),
                    CanvasSize = UDim2.new(0, 0, 0, var1.Size.Size_1200),
                    AutomaticCanvasSize = Enum.AutomaticSize.X,
                    ScrollBarThickness = 0,
                    ScrollingDirection = Enum.ScrollingDirection.X,
                    BorderSizePixel = 0,
                    BackgroundTransparency = 1,
                    ClipsDescendants = false,
                    ElasticBehavior = Enum.ElasticBehavior.Always,
                    Selectable = false
                }, element)
            }
        )
    end

    return React.createElement(View, {
        LayoutOrder = tbl1.LayoutOrder,
        tag = "size-full-0 auto-y col gap-medium"
    }, {
        Heading = React.createElement(View, {
            tag = "auto-xy row gap-xxsmall align-y-center",
            LayoutOrder = 1
        }, {
            HeadingText = React.createElement(FoundationText, {
                Text = var2.wearTimeOptions,
                textStyle = var1.Color.Content.Emphasis,
                fontStyle = {
                    Font = var1.Typography.TitleLarge.Font,
                    FontSize = var1.FontSize.FontSize_500
                },
                AutomaticSize = Enum.AutomaticSize.XY,
                LayoutOrder = 1
            }),
            InfoIconContainer = React.createElement(View, { tag = "auto-xy", LayoutOrder = 2 }, {
                InfoIcon = React.createElement(Foundation.IconButton, {
                    icon = Enums.IconName.CircleI,
                    size = Enums.IconSize.Small,
                    onActivated = function()
                        var4(true)
                    end
                }),
                Tooltip = React.createElement(AXTooltip, {
                    isOpen = isOpen,
                    popoverSide = "Top",
                    tooltipText = var2.tooltipText,
                    maxWidth = var1.Size.Size_1200 * 3,
                    onTooltipActivated = function()
                        var4(false)
                    end
                })
            })
        }),
        CarouselContainer = element2
    })
end

return WearTimeOptionsCarousel
