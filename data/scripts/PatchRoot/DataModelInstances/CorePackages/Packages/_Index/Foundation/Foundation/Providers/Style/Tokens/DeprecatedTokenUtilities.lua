-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T06:50:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function cloneTokenValue(arg1)
    if type(arg1) ~= "table" then
        return arg1
    end

    local result = ({})
    for value, value2 in arg1 do
        result[value] = cloneTokenValue(value2)
    end
    return result
end

return {
    getDeprecatedSemanticTokens = function(arg1, num1: number)
        return (cloneTokenValue({
            Color = {
                Background = {
                    Default = arg1.Color.Surface.Surface_0,
                    Contrast = arg1.Color.Surface.Surface_100,
                    Muted = arg1.Color.Surface.Surface_200,
                    OnHover = arg1.Color.State.Hover,
                    OnPress = arg1.Color.State.Press
                },
                BackgroundUi = {
                    Default = arg1.Color.Surface.Surface_300,
                    Contrast = arg1.Color.OverMedia.OverMedia_0
                },
                Ui = {
                    Default = arg1.Color.Shift.Shift_200,
                    Muted = arg1.Color.Shift.Shift_100,
                    Emphasis = arg1.Color.Shift.Shift_400
                },
                Focus = {
                    Start = arg1.Color.Selection.Start,
                    End = arg1.Color.Selection.End,
                    Gradient = arg1.Color.Selection.Start
                },
                State = {
                    Standard = {
                        Default = arg1.Color.State.Idle,
                        Hover = arg1.Color.State.Hover,
                        Pressed = arg1.Color.State.Press
                    },
                    Inverse = {
                        Default = arg1.Inverse.State.Idle,
                        Hover = arg1.Inverse.State.Hover,
                        Pressed = arg1.Inverse.State.Press
                    },
                    Darken = {
                        Default = arg1.LightMode.State.Idle,
                        Hover = arg1.LightMode.State.Hover,
                        Pressed = arg1.LightMode.State.Press
                    },
                    Lighten = {
                        Default = arg1.DarkMode.State.Idle,
                        Hover = arg1.DarkMode.State.Hover,
                        Pressed = arg1.DarkMode.State.Press
                    }
                },
                Text = {
                    Emphasis = arg1.Color.Content.Emphasis,
                    Default = arg1.Color.Content.Default,
                    Muted = arg1.Color.Content.Muted,
                    Link = arg1.Color.Content.Link,
                    Inverse = arg1.Inverse.Content.Default
                },
                Icon = {
                    Emphasis = arg1.Color.Content.Emphasis,
                    Default = arg1.Color.Content.Default,
                    OnHover = arg1.Color.Content.Emphasis
                },
                Common = {
                    Divider = arg1.Color.Stroke.Emphasis,
                    Overlay = arg1.Color.Common.Scrim,
                    DropShadow = arg1.Color.Common.Shadow,
                    NavigationBar = arg1.Color.Common.NavigationBar,
                    Placeholder = arg1.Color.Common.Shimmer,
                    Badge = arg1.Color.System.Contrast,
                    BadgeContent = arg1.Inverse.Content.Emphasis,
                    Online = arg1.Color.System.Success,
                    Offline = arg1.Color.System.Neutral,
                    Alert = arg1.Color.System.Alert,
                    Success = arg1.Color.System.Success
                },
                Action = {
                    PrimaryBrand = {
                        Background = arg1.Color.ActionEmphasis.Background,
                        Content = arg1.Color.ActionEmphasis.Foreground,
                        Border = arg1.Color.ActionEmphasis.Border
                    },
                    Primary = {
                        Background = arg1.Color.ActionSubEmphasis.Background,
                        Content = arg1.Color.ActionSubEmphasis.Foreground,
                        Border = arg1.Color.ActionSubEmphasis.Border
                    },
                    Secondary = {
                        Background = arg1.Color.ActionSubtle.Background,
                        Content = arg1.Color.ActionSubtle.Foreground,
                        Border = arg1.Color.ActionSubtle.Border
                    },
                    Subtle = {
                        Background = arg1.Color.ActionLink.Background,
                        Content = arg1.Color.ActionLink.Foreground,
                        Border = arg1.Color.ActionLink.Border
                    },
                    Alert = {
                        Background = arg1.Color.ActionAlert.Background,
                        Content = arg1.Color.ActionAlert.Foreground,
                        Border = arg1.Color.ActionAlert.Border
                    }
                }
            },
            Icon = {
                Size = {
                    Small = arg1.Size.Size_400,
                    Medium = arg1.Size.Size_900,
                    Large = arg1.Size.Size_1200,
                    XLarge = arg1.Size.Size_2400,
                    XXLarge = num1 * 192
                }
            },
            Offset = {
                Focus = {
                    Standard = arg1.Size.Size_150,
                    Inset = arg1.Size.Size_0
                }
            },
            Opacity = {
                State = {
                    Lighten = { Hover = 0.88, Pressed = 0.8 },
                    Darken = { Hover = 0.88, Pressed = 0.8 }
                }
            },
            Radius = {
                None = arg1.Radius.None,
                Small = arg1.Radius.Small,
                Medium = arg1.Radius.Medium,
                Large = arg1.Size.Size_300,
                XLarge = arg1.Radius.Large,
                Circle = arg1.Radius.Circle
            },
            Stroke = {
                Input = arg1.Stroke.Standard,
                Focus = arg1.Stroke.Thick
            },
            Typography = {
                Title = {
                    Font = arg1.Typography.HeadingLarge.Font,
                    FontSize = arg1.Typography.HeadingLarge.FontSize,
                    LetterSpacing = arg1.Typography.HeadingLarge.LetterSpacing,
                    LineHeight = arg1.LineHeight.LineHeight_130
                },
                Header = {
                    Font = arg1.Typography.HeadingSmall.Font,
                    FontSize = arg1.Typography.HeadingSmall.FontSize,
                    LetterSpacing = arg1.Typography.HeadingSmall.LetterSpacing,
                    LineHeight = arg1.Typography.HeadingSmall.LineHeight
                },
                Subheader = {
                    Font = arg1.Typography.TitleLarge.Font,
                    FontSize = arg1.Typography.TitleLarge.FontSize,
                    LetterSpacing = arg1.Typography.TitleLarge.LetterSpacing,
                    LineHeight = arg1.Typography.TitleLarge.LineHeight
                },
                Body = {
                    Font = arg1.Typography.BodyLarge.Font,
                    FontSize = arg1.Typography.BodyLarge.FontSize,
                    LetterSpacing = arg1.Typography.BodyLarge.LetterSpacing,
                    LineHeight = arg1.Typography.BodyLarge.LineHeight
                },
                CaptionHeader = {
                    Font = arg1.Typography.CaptionLarge.Font,
                    FontSize = arg1.FontSize.FontSize_300,
                    LetterSpacing = arg1.Typography.BodyLarge.LetterSpacing,
                    LineHeight = arg1.LineHeight.LineHeight_130
                },
                CaptionBody = {
                    Font = arg1.Typography.BodySmall.Font,
                    FontSize = arg1.Typography.BodySmall.FontSize,
                    LetterSpacing = arg1.Typography.BodySmall.LetterSpacing,
                    LineHeight = arg1.LineHeight.LineHeight_130
                },
                Footer = {
                    Font = arg1.Typography.CaptionSmall.Font,
                    FontSize = arg1.Typography.CaptionSmall.FontSize,
                    LetterSpacing = arg1.Typography.BodyLarge.LetterSpacing,
                    LineHeight = arg1.Typography.CaptionSmall.LineHeight
                }
            }
        }))
    end
}
