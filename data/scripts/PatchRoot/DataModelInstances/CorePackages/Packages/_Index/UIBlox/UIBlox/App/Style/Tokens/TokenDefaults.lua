-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:01:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local tbl1 = {
    Color3 = Color3.new(),
    Transparency = 0
}
local tbl2 = {
    Font = Enum.Font.Unknown,
    FontSize = 0,
    LineHeight = 0,
    LetterSpacing = 0
}
return {
    Global = {
        Size_0 = 0,
        Size_25 = 0,
        Size_50 = 0,
        Size_75 = 0,
        Size_100 = 0,
        Size_125 = 0,
        Size_150 = 0,
        Size_175 = 0,
        Size_200 = 0,
        Size_250 = 0,
        Size_300 = 0,
        Size_350 = 0,
        Size_400 = 0,
        Size_450 = 0,
        Size_500 = 0,
        Size_600 = 0,
        Size_700 = 0,
        Size_800 = 0,
        Size_900 = 0,
        Size_1000 = 0,
        Size_1100 = 0,
        Size_1200 = 0,
        Size_1300 = 0,
        Size_1400 = 0,
        Space_0 = 0,
        Space_25 = 0,
        Space_50 = 0,
        Space_75 = 0,
        Space_100 = 0,
        Space_125 = 0,
        Space_150 = 0,
        Space_175 = 0,
        Space_200 = 0,
        Space_250 = 0,
        Space_300 = 0,
        Space_400 = 0,
        Space_500 = 0,
        Space_600 = 0,
        Space_800 = 0,
        Space_1000 = 0,
        FontSize_25 = 0,
        FontSize_50 = 0,
        FontSize_75 = 0,
        FontSize_100 = 0,
        FontSize_200 = 0,
        FontSize_300 = 0,
        FontSize_400 = 0,
        FontSize_500 = 0,
        FontSize_600 = 0,
        FontSize_700 = 0,
        FontSize_800 = 0,
        FontSize_900 = 0,
        FontSize_1000 = 0,
        Family = { Standard = "" },
        Weight_300 = "",
        Weight_400 = "",
        Weight_600 = "",
        Weight_700 = "",
        Weight_900 = "",
        LetterSpacing = { Default = 0, Tight = 0, Loose = 0 },
        LineHeight_100 = 0,
        LineHeight_200 = 0,
        LineHeight_300 = 0,
        LineHeight_400 = 0,
        Stroke_50 = 0,
        Stroke_100 = 0,
        Stroke_150 = 0,
        Stroke_200 = 0,
        Stroke_250 = 0,
        Stroke_300 = 0,
        Stroke_400 = 0,
        Opacity_0 = 0,
        Opacity_8 = 0,
        Opacity_12 = 0,
        Opacity_16 = 0,
        Opacity_32 = 0,
        Opacity_68 = 0,
        Opacity_84 = 0,
        Opacity_88 = 0,
        Opacity_92 = 0,
        Opacity_100 = 0,
        Color = {
            Black = tbl1,
            White = tbl1,
            Green = tbl1,
            Red = tbl1,
            Blue = tbl1,
            Carbon = tbl1,
            Flint = tbl1,
            Graphite = tbl1,
            Obsidian = tbl1,
            Pumice = tbl1,
            Slate = tbl1,
            Alabaster = tbl1,
            Ash = tbl1,
            Chalk = tbl1,
            Smoke = tbl1,
            None = tbl1
        }
    },
    Semantic = {
        Typography = {
            Title = tbl2,
            Header = tbl2,
            Subheader = tbl2,
            Body = tbl2,
            CaptionHeader = tbl2,
            CaptionBody = tbl2,
            Footer = tbl2
        },
        Color = {
            Background = {
                Default = tbl1,
                Contrast = tbl1,
                Muted = tbl1,
                OnHover = tbl1,
                OnPress = tbl1
            },
            BackgroundUi = { Default = tbl1, Contrast = tbl1 },
            Ui = { Default = tbl1, Muted = tbl1, Emphasis = tbl1 },
            Text = { Default = tbl1, Muted = tbl1, Emphasis = tbl1, Link = tbl1, Inverse = tbl1 },
            Icon = { Default = tbl1, Emphasis = tbl1, OnHover = tbl1 },
            Action = {
                Primary = { Background = tbl1, Border = tbl1, Content = tbl1 },
                PrimaryBrand = { Background = tbl1, Border = tbl1, Content = tbl1 },
                Secondary = { Background = tbl1, Border = tbl1, Content = tbl1 },
                Alert = { Background = tbl1, Border = tbl1, Content = tbl1 },
                Subtle = { Background = tbl1, Border = tbl1, Content = tbl1 }
            },
            State = {
                Standard = { Default = tbl1, Hover = tbl1, Pressed = tbl1 },
                Lighten = { Default = tbl1, Hover = tbl1, Pressed = tbl1 },
                Inverse = { Default = tbl1, Hover = tbl1, Pressed = tbl1 },
                Darken = { Default = tbl1, Hover = tbl1, Pressed = tbl1 }
            },
            Focus = { Start = tbl1, End = tbl1, Gradient = tbl1 },
            Common = {
                Divider = tbl1,
                Overlay = tbl1,
                DropShadow = tbl1,
                NavigationBar = tbl1,
                Badge = tbl1,
                BadgeContent = tbl1,
                Placeholder = tbl1,
                Online = tbl1,
                Offline = tbl1,
                Alert = tbl1,
                Success = tbl1
            }
        },
        Radius = { None = 0, Small = 0, Medium = 0, Large = 0, XLarge = 0, Circle = 0 },
        Icon = {
            Size = { Small = 0, Medium = 0, Large = 0, XLarge = 0, XxLarge = 0 }
        },
        Stroke = { Input = 0, Focus = 0 },
        Offset = {
            Focus = { Standard = 0, Inset = 0 }
        },
        Opacity = {
            State = {
                Lighten = { Hover = 0, Pressed = 0 },
                Darken = { Hover = 0, Pressed = 0 }
            }
        }
    },
    Component = {
        VerticalTile = {
            Base = {
                Container = {
                    Background = tbl1,
                    BorderWidth = 0,
                    BorderColor = tbl1,
                    DropShadow = { X = 0, Y = 0, Blur = 0, Color = tbl1 },
                    BorderRadius = {
                        LeadingTop = 0,
                        TrailingTop = 0,
                        TrailingBottom = 0,
                        LeadingBottom = 0
                    }
                },
                ContentTop = {
                    Spacing = { Top = 0, Trailing = 0, Bottom = 0, Leading = 0 }
                },
                ContentBottom = {
                    Spacing = { Top = 0, Trailing = 0, Bottom = 0, Leading = 0 }
                }
            }
        },
        PlayerTileSmall = {
            Base = {
                Container = {
                    Gap = 0,
                    Spacing = { Top = 0, Trailing = 0, Bottom = 0, Leading = 0 }
                },
                Image = {
                    Size = 0,
                    BackgroundColor = tbl1,
                    BorderColor = tbl1,
                    BorderRadius = 0,
                    BorderWidth = 0
                },
                Status = { Size = 0, BackgroundColor = tbl1, BorderColor = tbl1, BorderWidth = 0 },
                Content = { Gap = 0, Typography = tbl2, ContentColor = tbl1 },
                Icon = { Size = 0 },
                Presence = { ContentColor = tbl1 }
            }
        },
        Facepile = {
            Container = { Gap = 0 },
            FaceGroup = { Gap = 0 },
            Face = {
                BackgroundColor = tbl1,
                BorderWidth = 0,
                BorderColor = tbl1,
                BorderRadius = 0,
                Width = 0,
                Height = 0
            },
            Badge = {
                BackgroundColor = tbl1,
                BorderWidth = 0,
                BorderColor = tbl1,
                BorderRadius = 0,
                Spacing = 0,
                Height = 0,
                MinWidth = 0,
                ContentColor = tbl1,
                Typography = tbl2
            },
            Label = { ContentColor = tbl1, Typography = tbl2 }
        },
        ControllerBar = {
            BackgroundColor = tbl1,
            BorderRadius = {
                LeadingTop = 0,
                TrailingTop = 0,
                TrailingBottom = 0,
                LeadingBottom = 0
            },
            Spacing = { Top = 0, Trailing = 0, Bottom = 0, Leading = 0 },
            Gap = 0
        },
        ControllerBarShortcut = {
            Container = { Gap = 0, ContentColor = tbl1 },
            Icon = { Size = 0 },
            Label = { Typography = tbl2 }
        },
        SelectionCursor = {
            BorderWidth = 0,
            Offset = 0,
            Inset = 0,
            Gradient = { Start = tbl1, End = tbl1 }
        },
        StateLayer = {
            Base = { BorderWidth = 0 },
            Standard = {
                Initialize = { Color = tbl1 },
                Default = { Color = tbl1 },
                Hover = { Color = tbl1 },
                Pressed = { Color = tbl1 },
                Selected = { Color = tbl1 },
                SelectedPressed = { Color = tbl1 },
                Disabled = { Color = tbl1 }
            },
            Lighten = {
                Initialize = { Color = tbl1 },
                Default = { Color = tbl1 },
                Hover = { Color = tbl1 },
                Pressed = { Color = tbl1 },
                Selected = { Color = tbl1 },
                SelectedPressed = { Color = tbl1 },
                Disabled = { Color = tbl1 }
            },
            Inverse = {
                Initialize = { Color = tbl1 },
                Default = { Color = tbl1 },
                Hover = { Color = tbl1 },
                Pressed = { Color = tbl1 },
                Selected = { Color = tbl1 },
                SelectedPressed = { Color = tbl1 },
                Disabled = { Color = tbl1 }
            },
            Darken = {
                Initialize = { Color = tbl1 },
                Default = { Color = tbl1 },
                Hover = { Color = tbl1 },
                Pressed = { Color = tbl1 },
                Selected = { Color = tbl1 },
                SelectedPressed = { Color = tbl1 },
                Disabled = { Color = tbl1 }
            }
        },
        MenuCell = {
            Base = {
                Container = {
                    Height = 0,
                    ContentColor = tbl1,
                    BackgroundColor = tbl1,
                    BorderColor = tbl1,
                    BorderRadius = {
                        TopLeading = 0,
                        TopTrailing = 0,
                        BottomTrailing = 0,
                        BottomLeading = 0
                    },
                    BorderWidth = 0,
                    Spacing = { Top = 0, Trailing = 0, Bottom = 0, Leading = 0 }
                },
                IconFrame = { Size = 0 },
                TextFrame = {
                    Spacing = { Top = 0, Trailing = 0, Bottom = 0, Leading = 0 }
                },
                Text = { Typography = tbl2 },
                CheckFrame = { Size = 0 }
            },
            Divider = {
                Container = { BorderWidth = 0 }
            },
            Disabled = {
                Container = { ContentColor = tbl1 }
            },
            HasRoundBottom = {
                Container = {
                    BorderRadius = { BottomTrailing = 0, BottomLeading = 0 }
                }
            },
            HasRoundTop = {
                Container = {
                    BorderRadius = { TopLeading = 0, TopTrailing = 0 }
                }
            }
        },
        BaseMenu = { BorderRadius = 0, BackgroundColor = tbl1 },
        StatGroup = { Gap = 0 },
        StatItem = {
            Container = { Gap = 0, ContentColor = tbl1 },
            Icon = { Size = 0 },
            Label = { Typography = tbl2 }
        },
        MediaTile = {
            Container = { BorderRadius = 0 },
            Icon = { Size = 0 }
        },
        StatWidget = {
            Container = { Gap = 0, ContentColor = tbl1 },
            Icon = { Size = 0 },
            DataGroup = { Gap = 0 },
            Data = { Typography = tbl2 },
            Label = { Typography = tbl2 }
        },
        RateCount = {
            Container = { Spacing = 0, Gap = 0, BorderRadius = 0, BackgroundColor = tbl1 },
            ButtonGroup = { Gap = 0 }
        },
        PlayerCount = {
            Container = { Spacing = 0, BorderRadius = 0, BackgroundColor = tbl1 }
        },
        VerticalScrollView = {
            Base = {
                Handle = { BackgroundColor = tbl1, ContentColor = tbl1, BorderRadius = 0 },
                Icon = { Size = 0 },
                Track = {
                    Opacity = 0,
                    Spacing = { Top = 0, Bottom = 0 }
                }
            },
            Compact = {
                Handle = { Width = 0 },
                Track = { Width = 0 }
            },
            Wide = {
                Handle = { Width = 0 },
                Track = { Width = 0 }
            },
            Gamepad = {
                Handle = { Width = 0 },
                Track = { Width = 0 }
            }
        },
        TextField = {
            Base = {
                Field = {
                    BorderColor = tbl1,
                    BorderRadius = 0,
                    Typography = tbl2,
                    Spacing = { Leading = 0, Trailing = 0 },
                    Gap = 0,
                    Opacity = 0
                },
                PlaceholderText = { ContentColor = tbl1 },
                FieldValue = { ContentColor = tbl1 },
                IconLeading = { ContentColor = tbl1, Size = 0 }
            },
            Error = {
                Field = { BorderColor = tbl1 }
            },
            Disabled = {
                Field = { Opacity = 0 }
            }
        },
        InputLabel = {
            Base = {
                Typography = tbl2,
                ContentColor = tbl1,
                Spacing = { Bottom = 0 },
                Opacity = 0
            },
            Disabled = { Opacity = 0 }
        },
        HelperText = {
            Base = {
                Typography = tbl2,
                ContentColor = tbl1,
                Padding = { Top = 0 },
                Opacity = 0
            },
            Error = { ContentColor = tbl1 }
        }
    }
}
