-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T10:51:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedContentParent = script:FindFirstAncestor("SduiSharedContent").Parent

local React = require(SduiSharedContentParent.React)
local Foundation = require(SduiSharedContentParent.Foundation)
local _AppCommonLib = require(SduiSharedContentParent.AppCommonLib)
local useLocalization = require(SduiSharedContentParent.Localization).Hooks.useLocalization

local Cryo = require(SduiSharedContentParent.Cryo)

local View = Foundation.View
local Chip = Foundation.Chip
local Divider = Foundation.Divider
local usePreferences = Foundation.Hooks.usePreferences
local useTokens = Foundation.Hooks.useTokens
local ChipSize = Foundation.Enums.ChipSize
local ChipVariant = Foundation.Enums.ChipVariant
local IconName = Foundation.Enums.IconName

local useAiOverviewExpansion = require(script.Parent.useAiOverviewExpansion)

return React.memo(function(tbl1) -- name: SduiAiOverview
    local var1 = useTokens()
    local var2 = usePreferences()
    local var3 = useLocalization({ expandButtonText = "CommonUI.Controls.Action.ShowMore" })

    local var4 = React.useMemo(function()
        return {
            index = tbl1.index,
            scrollViewPositionChangedSignal = tbl1.scrollViewPositionChangedSignal,
            verticalScrollingFrameRef = tbl1.verticalScrollingFrameRef,
            startRow = tbl1.startRow or tbl1.index
        }
    end, {
        tbl1.index,
        tbl1.scrollViewPositionChangedSignal,
        tbl1.verticalScrollingFrameRef,
        tbl1.startRow
    })

    local var5 = React.useCallback(function(arg1)
        if not arg1 or typeof(arg1) ~= "table" then
            return arg1
        end

        local result = ({})
        for value, value2 in arg1 do
            local var5 = not value2.props and {} or value2.props.extraLocalProps or {}
            local cloneElement = React.cloneElement
            local tbl2 = {
                extraLocalProps = Cryo.Dictionary.join(var5, var4)
            }
            result[value] = cloneElement(value2, tbl2)
        end

        return result
    end, { var4 })

    local var6 = React.useMemo(function()
        return var5(tbl1.content)
    end, { tbl1.content, var5 })

    local var7 = React.useMemo(function()
        return var5(tbl1.footer)
    end, { tbl1.footer, var5 })

    local offset = tbl1.headerGap or var1.Gap.Small
    local offset2 = tbl1.sectionGap or var1.Gap.Large
    local hasHeader = tbl1.titleComponent ~= nil or tbl1.descriptionComponent ~= nil
    local hasExpandableBody = tbl1.content ~= nil or tbl1.footer ~= nil
    local expandButtonText = tbl1.expandButtonText or var3.expandButtonText
    local backgroundStyle = tbl1.backgroundStyle or var1.Color.Surface.Surface_0
    local size1000 = var1.Size.Size_1000

    local var9 = useAiOverviewExpansion({
        buttonHeight = size1000,
        compactHeight = tbl1.compactHeight,
        hasHeader = hasHeader,
        hasExpandableBody = hasExpandableBody,
        sectionGap = offset2,
        reducedMotion = var2.reducedMotion
    })

    local createElement = React.createElement
    local var10 = View
    local tbl2 = {
        tag = "size-full-0 auto-y",
        layout = {
            FillDirection = Enum.FillDirection.Vertical,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, offset2)
        },
        backgroundStyle = tbl1.backgroundStyle,
        LayoutOrder = tbl1.layoutOrder,
        sizeConstraint = var9.shouldReserveCompactHeight and {
            MinSize = Vector2.new(0, tbl1.compactHeight)
        } or nil,
        testId = tbl1.testId or "--sdui-ai-overview"
    }
    local tbl3 = { Header = 0, Body = 0, ToggleButton = 0 }
    local element

    if hasHeader then
        element = React.createElement(View, {
            tag = "size-full-0 auto-y",
            layout = {
                FillDirection = Enum.FillDirection.Vertical,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, offset)
            },
            LayoutOrder = 1,
            onAbsoluteSizeChanged = var9.onHeaderAbsoluteSizeChanged
        }, {
            Title = if tbl1.titleComponent then React.createElement(
                View,
                { tag = "size-full-0 auto-y", LayoutOrder = 1, testId = "--sdui-ai-overview-title" },
                {
                    Slot = tbl1.titleComponent
                }
            ) else nil,
            Description = if tbl1.descriptionComponent then React.createElement(
                View,
                {
                    tag = "size-full-0 auto-y",
                    LayoutOrder = 2,
                    testId = "--sdui-ai-overview-description"
                },
                {
                    Slot = tbl1.descriptionComponent
                }
            ) else nil
        })
    else
        element = nil
    end

    tbl3.Header = element
    local var11

    if hasExpandableBody then
        local createElement2 = React.createElement
        local var12 = View
        local tbl4 = { tag = "col size-full-0 auto-y", LayoutOrder = 2 }

        local tbl5 = { Inner = 0 }
        local createElement3 = React.createElement
        local var13 = View

        local tbl6 = {
            tag = {
                clip = var9.useCompactViewport,
                ["no-clip"] = not var9.useCompactViewport,
                ["auto-none"] = var9.useCompactViewport,
                ["auto-y"] = not var9.useCompactViewport
            },
            Size = if var9.useCompactViewport then var9.animatedViewportHeight:map(function(num1: number): UDim2
                return UDim2.new(1, 0, 0, math.ceil(num1))
            end) else UDim2.fromScale(1, 0)
        }

        local tbl7 = {
            Content = React.createElement(View, {
                tag = "size-full-0 auto-y",
                layout = {
                    FillDirection = Enum.FillDirection.Vertical,
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    Padding = UDim.new(0, offset2)
                },
                onAbsoluteSizeChanged = var9.onContentAbsoluteSizeChanged
            }, {
                Content = if var6 then React.createElement(View, {
                    tag = "size-full-0 auto-y",
                    layout = {
                        FillDirection = Enum.FillDirection.Vertical,
                        SortOrder = Enum.SortOrder.LayoutOrder,
                        Padding = UDim.new(0, offset2)
                    },
                    LayoutOrder = 3,
                    testId = "--sdui-ai-overview-content"
                }, var6) else nil,
                Footer = if var7 then React.createElement(View, {
                    tag = "size-full-0 auto-y",
                    layout = {
                        FillDirection = Enum.FillDirection.Vertical,
                        SortOrder = Enum.SortOrder.LayoutOrder,
                        Padding = UDim.new(0, offset2)
                    },
                    LayoutOrder = 4,
                    testId = "--sdui-ai-overview-footer"
                }, var7) else nil
            }),
            FadeOverlay = 0
        }
        local element2

        if var9.isCompact then
            element2 = React.createElement(View, {
                tag = "position-bottom-left anchor-bottom-left",
                backgroundStyle = backgroundStyle,
                Size = var9.animatedViewportHeight:map(function(num1: number)
                    return UDim2.new(1, 0, 0, math.ceil(num1 * 0.25))
                end),
                ZIndex = 2
            }, {
                Gradient = React.createElement("UIGradient", {
                    Rotation = 90,
                    Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 0) })
                })
            })
        else
            element2 = nil
        end

        tbl7.FadeOverlay = element2
        tbl5.Inner = createElement3(var13, tbl6, tbl7)
        var11 = createElement2(var12, tbl4, tbl5)
    else
        var11 = nil
    end

    tbl3.Body = var11
    local element2

    if var9.isCompact then
        element2 = React.createElement(View, {
            tag = "row align-y-center gap-xsmall size-full-0 auto-y",
            LayoutOrder = 3
        }, {
            LeadingLine = React.createElement(View, { tag = "grow", LayoutOrder = 1 }, { Divider = React.createElement(Divider) }),
            ChipOutline = React.createElement(View, {
                tag = "auto-xy stroke-default radius-circle",
                LayoutOrder = 2
            }, {
                Chip = React.createElement(Chip, {
                    text = expandButtonText,
                    trailing = IconName.ChevronLargeDown,
                    size = ChipSize.Large,
                    variant = ChipVariant.Utility,
                    onActivated = var9.onExpand,
                    testId = "--sdui-ai-overview-toggle"
                })
            }),
            TrailingLine = React.createElement(View, { tag = "grow", LayoutOrder = 3 }, { Divider = React.createElement(Divider) })
        })
    else
        element2 = nil
    end

    tbl3.ToggleButton = element2
    return createElement(var10, tbl2, tbl3)
end)
