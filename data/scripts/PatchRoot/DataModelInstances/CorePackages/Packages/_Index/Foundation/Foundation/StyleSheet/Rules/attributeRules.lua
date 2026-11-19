-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T10:01:28Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent
local Dash = require(FoundationParent.Dash)
local _Tokens = require(Foundation.Providers.Style.Tokens)
local _Types = require(script.Parent.Types)
local cornerRules = require(script.Parent.cornerRules)
local shadowRules = require(script.Parent.shadowRules)
local tokenAttributePascalName = require(script.Parent.Parent.tokenAttributePascalName)

local function kebabToPascal(str1: string)
    return (str1:gsub("^%-?(.)", function(arg1)
        return arg1:upper()
    end):gsub("%-(.)", function(arg1)
        return arg1:upper()
    end))
end

local function getTextPadding(arg1, nominalScale: number): UDim -- Luacid: Inlined by compiler; 2 call sites recovered
    local var1 = arg1.TextSize / nominalScale * (arg1.LineHeight * nominalScale) - arg1.TextSize
    return UDim.new(0, var1 / 2)
end

local function DefaultSizeRules(bodyLarge, nominalScale: number)
    local uDim = getTextPadding(bodyLarge, nominalScale)
    return {{
        tag = "text-size-defaults",
        priority = -1,
        properties = {
            TextSize = "$TextSizeBodyLarge",
            LineHeight = bodyLarge.LineHeight
        },
        children = {{
            tag = "text-size-defaults",
            pseudo = "UIPadding",
            priority = -1,
            properties = {
                PaddingTop = "$TextPaddingBodyLarge",
                PaddingBottom = "$TextPaddingBodyLarge"
            },
            attributes = {{ name = "TextPaddingBodyLarge", value = uDim }}
        }},
        attributes = {{
            name = "TextSizeBodyLarge",
            value = bodyLarge.TextSize
        }}
    }}
end

local function ListLayoutSpacingRules(gaps, gutters)
    local tbl1 = {}

    for _, gap in gaps do
        local var1 = kebabToPascal(gap.name)
        local tbl2 = {
            tag = `gap-{gap.name}`,
            pseudo = "UIListLayout",
            properties = {
                Padding = `$Gap{var1}`
            },
            attributes = {{
                name = `Gap{var1}`,
                value = gap.size
            }}
        }
        table.insert(tbl1, tbl2)
    end

    local tbl2 = {}

    for _, gutter in gutters do
        local var1 = kebabToPascal(gutter.name)
        local tbl3 = {
            tag = `gutter-{gutter.name}`,
            pseudo = "UIListLayout",
            properties = {
                Padding = `$Gutter{var1}`
            },
            attributes = {{
                name = `Gutter{var1}`,
                value = gutter.size
            }}
        }
        table.insert(tbl2, tbl3)
    end

    return Dash.joinArrays(tbl1, tbl2)
end

local function CornerRules(radii) -- Luacid: Inlined by compiler; 1 call site recovered
    return cornerRules(radii, function(arg1)
        local var1 = kebabToPascal(arg1.name)
        return {
            cornerValue = `$Radius{var1}`,
            attributes = {{
                name = `Radius{var1}`,
                value = arg1.size
            }}
        }
    end)
end

local function ShadowRules(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    return shadowRules(arg1)
end

local function SizeRules(sizes)
    local result = {}

    for _, value in sizes do
        local var1 = kebabToPascal(value.name)
        local tbl1 = {
            tag = `size-{value.name}`,
            properties = {
                Size = `$Size{var1}`
            },
            attributes = {{
                name = `Size{var1}`,
                value = UDim2.new(value.size, value.size)
            }}
        }
        table.insert(result, tbl1)

        for _, value2 in sizes do
            local var2 = kebabToPascal(value2.name)
            local tbl2 = {
                tag = `size-{value.name}-{value2.name}`,
                properties = {
                    Size = `$Size{var1}_{var2}`
                },
                attributes = {{
                    name = `Size{var1}_{var2}`,
                    value = UDim2.new(value.size, value2.size)
                }}
            }
            table.insert(result, tbl2)
        end
    end

    return result
end

local function TypographyRules(typography, nominalScale: number, bool1: boolean?)
    local result = {}

    for value, value2 in typography do
        local var1 = kebabToPascal(value)
        local uDim = getTextPadding(value2, nominalScale)
        local tbl1 = {
            tag = `text-{value}`,
            properties = {
                Font = if bool1 then nil else `$Font{var1}`,
                FontFace = if bool1 then `$Font{var1}` else nil,
                TextSize = `$TextSize{var1}`,
                LineHeight = value2.LineHeight
            },
            attributes = {
                {
                    name = `Font{var1}`,
                    value = value2.Font
                },
                {
                    name = `TextSize{var1}`,
                    value = value2.TextSize
                }
            },
            children = 0
        }

        local tbl2 = {
            tag = `text-{value}`,
            pseudo = "UIPadding",
            priority = 0,
            properties = {
                PaddingTop = `$TextPadding{var1}`,
                PaddingBottom = `$TextPadding{var1}`
            },
            attributes = {{
                name = `TextPadding{var1}`,
                value = uDim
            }}
        }
        tbl1.children = { tbl2 }
        table.insert(result, tbl1)
    end

    return result
end

local function PaddingRules(paddings, margins)
    local result = {}

    local tbl1 = {
        x = { "PaddingLeft", "PaddingRight" },
        y = { "PaddingTop", "PaddingBottom" },
        top = { "PaddingTop" },
        bottom = { "PaddingBottom" },
        left = { "PaddingLeft" },
        right = { "PaddingRight" }
    }

    for _, padding in paddings do
        local var1 = kebabToPascal(padding.name)
        local tbl2 = {
            tag = `padding-{padding.name}`,
            pseudo = "UIPadding",
            properties = {
                PaddingTop = `$Padding{var1}`,
                PaddingBottom = `$Padding{var1}`,
                PaddingLeft = `$Padding{var1}`,
                PaddingRight = `$Padding{var1}`
            },
            attributes = {{
                name = `Padding{var1}`,
                value = padding.size
            }}
        }
        table.insert(result, tbl2)
    end

    for _, margin in margins do
        local var1 = kebabToPascal(margin.name)
        local tbl2 = {
            tag = `margin-{margin.name}`,
            pseudo = "UIPadding",
            properties = {
                PaddingTop = `$Margin{var1}`,
                PaddingBottom = `$Margin{var1}`,
                PaddingLeft = `$Margin{var1}`,
                PaddingRight = `$Margin{var1}`
            },
            attributes = {{
                name = `Margin{var1}`,
                value = margin.size
            }}
        }
        table.insert(result, tbl2)
    end

    for value, value2 in tbl1 do
        for _, padding in paddings do
            local var1 = kebabToPascal(padding.name)
            local properties = ({})
            for _, value3 in value2 do
                properties[value3] = `$Padding{var1}`
            end
            local tbl3 = {
                tag = `padding-{value}-{padding.name}`,
                pseudo = "UIPadding",
                properties = properties,
                attributes = {{
                    name = `Padding{var1}`,
                    value = padding.size
                }}
            }
            table.insert(result, tbl3)
        end

        for _, margin in margins do
            local var1 = kebabToPascal(margin.name)
            local properties = ({})
            for _, value3 in value2 do
                properties[value3] = `$Margin{var1}`
            end
            local tbl3 = {
                tag = `margin-{value}-{margin.name}`,
                pseudo = "UIPadding",
                properties = properties,
                attributes = {{
                    name = `Margin{var1}`,
                    value = margin.size
                }}
            }
            table.insert(result, tbl3)
        end
    end

    return result
end

local tbl1 = {
    Content = { "content" },
    Stroke = { "stroke" },
    Shift = { "bg" },
    Surface = { "bg" },
    OverMedia = { "bg" },
    System = { "bg", "content", "stroke" },
    Extended = {},
    Common = {},
    Selection = {},
    State = {},
    None = {}
}

local function GuiObjectDefaultRules()
    return {{
        tag = "gui-object-defaults",
        priority = -1,
        properties = { BackgroundTransparency = 1 }
    }}
end

local function DefaultFontRules(arg1, bool1: boolean?)
    return {{
        tag = "text-defaults",
        priority = -1,
        properties = {
            Font = if bool1 then nil else "$FontBodyLarge",
            FontFace = if bool1 then "$FontBodyLarge" else nil
        },
        attributes = {{
            name = "FontBodyLarge",
            value = arg1.Typography.BodyLarge.Font
        }}
    }}
end

local function DefaultColorRules(arg1)
    return {{
        tag = "text-color-defaults",
        priority = -1,
        properties = {
            TextColor3 = "$ColorContentDefaultColor3",
            TextTransparency = "$ColorContentDefaultTransparency"
        },
        attributes = {
            {
                name = "ColorContentDefaultColor3",
                value = arg1.Color.Content.Default.Color3
            },
            {
                name = "ColorContentDefaultTransparency",
                value = arg1.Color.Content.Default.Transparency
            }
        }
    }}
end

local function BackgroundRules(colors, variants)
    local result = {}

    for k, color in colors do
        if not table.find(tbl1[k], "bg") then
            continue
        end

        for value, value2 in color do
            local var1 = tokenAttributePascalName(k, value)
            local tbl2 = {
                tag = `bg-{value}`,
                properties = {
                    BackgroundColor3 = `$Color{k}{var1}Color3`,
                    BackgroundTransparency = `$Color{k}{var1}Transparency`
                },
                attributes = {
                    {
                        name = `Color{k}{var1}Color3`,
                        value = value2.Color3
                    },
                    {
                        name = `Color{k}{var1}Transparency`,
                        value = value2.Transparency
                    }
                }
            }
            table.insert(result, tbl2)
        end
    end

    for k, variant in variants do
        local var1 = kebabToPascal(k)
        local tbl2 = {
            tag = `bg-{k}`,
            properties = {
                BackgroundColor3 = `$Color{var1}BackgroundColor3`,
                BackgroundTransparency = `$Color{var1}BackgroundTransparency`
            },
            attributes = {
                {
                    name = `Color{var1}BackgroundColor3`,
                    value = variant.Background.Color3
                },
                {
                    name = `Color{var1}BackgroundTransparency`,
                    value = variant.Background.Transparency
                }
            }
        }
        table.insert(result, tbl2)
    end

    return result
end

local function StrokeSizeRules(strokes)
    local result = {}

    for _, value in strokes do
        if value.name == "none" then
            continue
        end

        local var1 = kebabToPascal(value.name)
        local tbl2 = {
            tag = `stroke-{value.name}`,
            pseudo = "UIStroke",
            properties = {
                Thickness = `$StrokeThickness{var1}`
            },
            attributes = {{
                name = `StrokeThickness{var1}`,
                value = value.size
            }}
        }
        table.insert(result, tbl2)
    end

    return result
end

local function StrokeRules(colors, variants)
    local result = {}

    for k, color in colors do
        if not table.find(tbl1[k], "stroke") then
            continue
        end

        for value, value2 in color do
            local var1 = tokenAttributePascalName(k, value)
            local tbl2 = {
                tag = `stroke-{value}`,
                pseudo = "UIStroke",
                properties = {
                    Color = `$Color{k}{var1}Color3`,
                    Transparency = `$Color{k}{var1}Transparency`
                },
                attributes = {
                    {
                        name = `Color{k}{var1}Color3`,
                        value = value2.Color3
                    },
                    {
                        name = `Color{k}{var1}Transparency`,
                        value = value2.Transparency
                    }
                }
            }
            table.insert(result, tbl2)
        end
    end

    for k, variant in variants do
        local var1 = kebabToPascal(k)
        local tbl2 = {
            tag = `stroke-{k}`,
            pseudo = "UIStroke",
            properties = {
                Color = `$Color{var1}BorderColor3`,
                Transparency = `$Color{var1}BorderTransparency`
            },
            attributes = {
                {
                    name = `Color{var1}BorderColor3`,
                    value = variant.Border.Color3
                },
                {
                    name = `Color{var1}BorderTransparency`,
                    value = variant.Border.Transparency
                }
            }
        }
        table.insert(result, tbl2)
    end

    for value, borderStrokePosition in {
        center = Enum.BorderStrokePosition.Center,
        inner = Enum.BorderStrokePosition.Inner,
        outer = Enum.BorderStrokePosition.Outer
    } do
        table.insert(result, {
            tag = `stroke-position-{value}`,
            pseudo = "UIStroke",
            properties = { BorderStrokePosition = borderStrokePosition }
        })
    end

    return result
end

local function ContentRules(colors, variants)
    local result = {}

    for k, color in colors do
        if not table.find(tbl1[k], "content") then
            continue
        end

        for value, value2 in color do
            local var1 = tokenAttributePascalName(k, value)
            local tbl2 = {
                tag = `content-{value}`,
                properties = {
                    ImageColor3 = `$Color{k}{var1}Color3`,
                    ImageTransparency = `$Color{k}{var1}Transparency`,
                    TextColor3 = `$Color{k}{var1}Color3`,
                    TextTransparency = `$Color{k}{var1}Transparency`
                },
                attributes = {
                    {
                        name = `Color{k}{var1}Color3`,
                        value = value2.Color3
                    },
                    {
                        name = `Color{k}{var1}Transparency`,
                        value = value2.Transparency
                    }
                }
            }
            table.insert(result, tbl2)
        end
    end

    for k, variant in variants do
        local var1 = kebabToPascal(k)
        local tbl2 = {
            tag = `content-{k}`,
            properties = {
                ImageColor3 = `$Color{var1}ForegroundColor3`,
                ImageTransparency = `$Color{var1}ForegroundTransparency`,
                TextColor3 = `$Color{var1}ForegroundColor3`,
                TextTransparency = `$Color{var1}ForegroundTransparency`
            },
            attributes = {
                {
                    name = `Color{var1}ForegroundColor3`,
                    value = variant.Foreground.Color3
                },
                {
                    name = `Color{var1}ForegroundTransparency`,
                    value = variant.Foreground.Transparency
                }
            }
        }
        table.insert(result, tbl2)
    end

    return result
end

local function DeprecatedColorRules(colors)
    local result = {}

    for value, value2 in colors.System do
        local var1 = value:sub(8)
        local var2 = tokenAttributePascalName("System", value)

        local tbl2 = {
            tag = `bg-{var1}`,
            properties = {
                BackgroundColor3 = `$ColorSystem{var2}Color3`,
                BackgroundTransparency = `$ColorSystem{var2}Transparency`
            },
            attributes = {
                {
                    name = `ColorSystem{var2}Color3`,
                    value = value2.Color3
                },
                {
                    name = `ColorSystem{var2}Transparency`,
                    value = value2.Transparency
                }
            },
            deprecatedFor = `bg-{value}`
        }
        table.insert(result, tbl2)

        if var1 == "emphasis" then
            continue
        end

        local tbl3 = {
            tag = `content-{var1}`,
            properties = {
                ImageColor3 = `$ColorSystem{var2}Color3`,
                ImageTransparency = `$ColorSystem{var2}Transparency`,
                TextColor3 = `$ColorSystem{var2}Color3`,
                TextTransparency = `$ColorSystem{var2}Transparency`
            },
            attributes = {
                {
                    name = `ColorSystem{var2}Color3`,
                    value = value2.Color3
                },
                {
                    name = `ColorSystem{var2}Transparency`,
                    value = value2.Transparency
                }
            },
            deprecatedFor = `content-{value}`
        }
        table.insert(result, tbl3)

        local tbl4 = {
            tag = `stroke-{var1}`,
            pseudo = "UIStroke",
            properties = {
                Color = `$ColorSystem{var2}Color3`,
                Transparency = `$ColorSystem{var2}Transparency`
            },
            attributes = {
                {
                    name = `ColorSystem{var2}Color3`,
                    value = value2.Color3
                },
                {
                    name = `ColorSystem{var2}Transparency`,
                    value = value2.Transparency
                }
            },
            deprecatedFor = `stroke-{value}`
        }
        table.insert(result, tbl4)
    end

    return result
end

local function EngineDefaultBypassRules()
    return {
        {
            tag = "x-default-transparency",
            properties = { BackgroundTransparency = 0 }
        },
        {
            tag = "x-default-text-size",
            properties = { TextSize = 8 }
        }
    }
end

local function ListLayoutRules()
    local tbl2 = {
        {
            tag = "row",
            pseudo = "UIListLayout",
            properties = {
                FillDirection = Enum.FillDirection.Horizontal,
                SortOrder = Enum.SortOrder.LayoutOrder
            }
        },
        {
            tag = "col",
            pseudo = "UIListLayout",
            properties = {
                FillDirection = Enum.FillDirection.Vertical,
                SortOrder = Enum.SortOrder.LayoutOrder
            }
        }
    }

    local tbl3 = {
        {
            tag = "align-x-left",
            pseudo = "UIListLayout",
            properties = {
                HorizontalAlignment = Enum.HorizontalAlignment.Left
            }
        },
        {
            tag = "align-x-center",
            pseudo = "UIListLayout",
            properties = {
                HorizontalAlignment = Enum.HorizontalAlignment.Center
            }
        },
        {
            tag = "align-x-right",
            pseudo = "UIListLayout",
            properties = {
                HorizontalAlignment = Enum.HorizontalAlignment.Right
            }
        },
        {
            tag = "align-y-top",
            pseudo = "UIListLayout",
            properties = {
                VerticalAlignment = Enum.VerticalAlignment.Top
            }
        },
        {
            tag = "align-y-center",
            pseudo = "UIListLayout",
            properties = {
                VerticalAlignment = Enum.VerticalAlignment.Center
            }
        },
        {
            tag = "align-y-bottom",
            pseudo = "UIListLayout",
            properties = {
                VerticalAlignment = Enum.VerticalAlignment.Bottom
            }
        }
    }

    local tbl4 = {
        {
            tag = "wrap",
            pseudo = "UIListLayout",
            properties = { Wraps = true }
        },
        {
            tag = "no-wrap",
            pseudo = "UIListLayout",
            properties = { Wraps = false }
        }
    }

    local tbl5 = {}

    for value, value2 in {
        none = Enum.UIFlexAlignment.None,
        fill = Enum.UIFlexAlignment.Fill,
        around = Enum.UIFlexAlignment.SpaceAround,
        between = Enum.UIFlexAlignment.SpaceBetween,
        evenly = Enum.UIFlexAlignment.SpaceEvenly
    } do
        table.insert(tbl5, {
            tag = `flex-{value}`,
            pseudo = "UIListLayout",
            properties = { HorizontalFlex = value2, VerticalFlex = value2 }
        })

        table.insert(
            tbl5,
            {
                tag = `flex-x-{value}`,
                pseudo = "UIListLayout",
                properties = { HorizontalFlex = value2 }
            }
        )

        table.insert(
            tbl5,
            {
                tag = `flex-y-{value}`,
                pseudo = "UIListLayout",
                properties = { VerticalFlex = value2 }
            }
        )
    end

    local tbl6 = {}

    for value, itemLineAlignment in {
        auto = Enum.ItemLineAlignment.Automatic,
        start = Enum.ItemLineAlignment.Start,
        center = Enum.ItemLineAlignment.Center,
        ["end"] = Enum.ItemLineAlignment.End,
        stretch = Enum.ItemLineAlignment.Stretch
    } do
        table.insert(
            tbl6,
            {
                tag = `items-{value}`,
                pseudo = "UIListLayout",
                properties = { ItemLineAlignment = itemLineAlignment }
            }
        )
    end

    return Dash.joinArrays(tbl2, tbl3, tbl4, tbl5, tbl6)
end

local function FlexItemRules()
    local tbl2 = {
        {
            tag = "grow",
            pseudo = "UIFlexItem",
            properties = {
                FlexMode = Enum.UIFlexMode.Grow
            }
        },
        {
            tag = "shrink",
            pseudo = "UIFlexItem",
            properties = {
                FlexMode = Enum.UIFlexMode.Shrink
            }
        },
        {
            tag = "fill",
            pseudo = "UIFlexItem",
            properties = {
                FlexMode = Enum.UIFlexMode.Fill
            }
        },
        {
            tag = "no-flex",
            pseudo = "UIFlexItem",
            properties = {
                FlexMode = Enum.UIFlexMode.None
            }
        }
    }

    local tbl3 = {}
    local tbl4 = {}

    for value in {
        1,
        2,
        3,
        4,
        5
    } do
        table.insert(tbl3, {
            tag = `grow-{value}`,
            pseudo = "UIFlexItem",
            properties = {
                FlexMode = Enum.UIFlexMode.Custom,
                GrowRatio = value
            }
        })
        table.insert(tbl4, {
            tag = `shrink-{value}`,
            pseudo = "UIFlexItem",
            properties = {
                FlexMode = Enum.UIFlexMode.Custom,
                ShrinkRatio = value
            }
        })
    end

    local tbl5 = {}

    for value, itemLineAlignment in {
        auto = Enum.ItemLineAlignment.Automatic,
        start = Enum.ItemLineAlignment.Start,
        center = Enum.ItemLineAlignment.Center,
        ["end"] = Enum.ItemLineAlignment.End,
        stretch = Enum.ItemLineAlignment.Stretch
    } do
        table.insert(
            tbl5,
            {
                tag = `self-{value}`,
                pseudo = "UIFlexItem",
                properties = { ItemLineAlignment = itemLineAlignment }
            }
        )
    end

    return Dash.joinArrays(tbl2, tbl3, tbl4, tbl5)
end

local function TextRules()
    local result = {}

    for value, textXAlignment in {
        left = Enum.TextXAlignment.Left,
        center = Enum.TextXAlignment.Center,
        right = Enum.TextXAlignment.Right
    } do
        table.insert(result, { tag = `text-align-x-{value}`, properties = { TextXAlignment = textXAlignment } })
    end

    for value, textYAlignment in {
        top = Enum.TextYAlignment.Top,
        center = Enum.TextYAlignment.Center,
        bottom = Enum.TextYAlignment.Bottom
    } do
        table.insert(result, { tag = `text-align-y-{value}`, properties = { TextYAlignment = textYAlignment } })
    end

    for value, textTruncate in {
        none = Enum.TextTruncate.None,
        ["end"] = Enum.TextTruncate.AtEnd,
        split = Enum.TextTruncate.SplitWord
    } do
        table.insert(result, { tag = `text-truncate-{value}`, properties = { TextTruncate = textTruncate } })
    end

    table.insert(result, { tag = "text-wrap", properties = { TextWrapped = true } })

    table.insert(result, { tag = "text-no-wrap", properties = { TextWrapped = false } })

    return result
end

local function AutomaticSizeRules()
    local result = {}

    for value, automaticSize in {
        none = Enum.AutomaticSize.None,
        x = Enum.AutomaticSize.X,
        y = Enum.AutomaticSize.Y,
        xy = Enum.AutomaticSize.XY
    } do
        table.insert(result, { tag = `auto-{value}`, properties = { AutomaticSize = automaticSize } })
    end

    return result
end

local function PositionRules()
    local result = {}

    local tbl2 = { top = 0, center = 0.5, bottom = 1 }

    for value, value2 in { left = 0, center = 0.5, right = 1 } do
        for value3, value4 in tbl2 do
            table.insert(
                result,
                {
                    tag = `position-{value3}-{value}`,
                    properties = {
                        Position = UDim2.fromScale(value2, value4)
                    }
                }
            )
        end
    end

    return result
end

local function AnchorPointRules()
    local result = {}

    local tbl2 = { top = 0, center = 0.5, bottom = 1 }

    for value, value2 in { left = 0, center = 0.5, right = 1 } do
        for value3, value4 in tbl2 do
            table.insert(
                result,
                {
                    tag = `anchor-{value3}-{value}`,
                    properties = {
                        AnchorPoint = Vector2.new(value2, value4)
                    }
                }
            )
        end
    end

    return result
end

local function ClipsDescendantRules()
    return {
        {
            tag = "clip",
            properties = { ClipsDescendants = true }
        },
        {
            tag = "no-clip",
            properties = { ClipsDescendants = false }
        }
    }
end

local function roundDecimals(num1: number, num2: number): number -- Luacid: unused: defined but never referenced
    local num3 = 10 ^ num2
    return math.round(num1 * num3) / num3
end

local function AspectRatioRules()
    local result = {}

    for _, value in {
        { 1, 1 },
        { 5, 4 },
        { 4, 3 },
        { 3, 2 },
        { 16, 9 },
        { 2, 1 }
    } do
        table.insert(result, {
            tag = `aspect-{value[1]}-{value[2]}`,
            pseudo = "UIAspectRatioConstraint",
            properties = {
                AspectRatio = math.round(value[1] / value[2] * 1000) / 1000
            }
        })

        if value[1] == value[2] then
            continue
        end

        table.insert(result, {
            tag = `aspect-{value[2]}-{value[1]}`,
            pseudo = "UIAspectRatioConstraint",
            properties = {
                AspectRatio = math.round(value[2] / value[1] * 1000) / 1000
            }
        })
    end

    return result
end

return {
    rulesGenerator = function(arg1, arg2, bool1: boolean?)
        local colors = arg2.colors
        local variants = arg2.variants
        local gaps = arg2.gaps
        local gutters = arg2.gutters
        local radii = arg2.radii
        local sizes = arg2.sizes
        local strokes = arg2.strokes
        local typography = arg2.typography
        local paddings = arg2.paddings
        local margins = arg2.margins
        return Dash.joinArrays(
            GuiObjectDefaultRules(),
            EngineDefaultBypassRules(),
            FlexItemRules(),
            TextRules(),
            AutomaticSizeRules(),
            PositionRules(),
            AnchorPointRules(),
            ClipsDescendantRules(),
            (AspectRatioRules())
        ), Dash.joinArrays(
            ListLayoutRules(),
            ListLayoutSpacingRules(gaps, gutters),
            CornerRules(radii),
            ShadowRules(arg1),
            SizeRules(sizes),
            StrokeSizeRules(strokes),
            (PaddingRules(paddings, margins))
        ), Dash.joinArrays(
            DefaultColorRules(arg1),
            DeprecatedColorRules(colors),
            BackgroundRules(colors, variants),
            StrokeRules(colors, variants),
            (ContentRules(colors, variants))
        ), (Dash.joinArrays(
            DefaultFontRules(arg1, bool1),
            DefaultSizeRules(typography["body-large"], arg1.Config.Text.NominalScale),
            (TypographyRules(typography, arg1.Config.Text.NominalScale, bool1))
        ))
    end
}
