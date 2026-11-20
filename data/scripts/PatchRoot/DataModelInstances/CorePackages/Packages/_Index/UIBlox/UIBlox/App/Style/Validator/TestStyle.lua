-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:01:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local tbl1 = {
    Color = Color3.fromRGB(0, 0, 0),
    Transparency = 0
}

local SelectionCursor = {
    Color = Color3.new(0.086, 0.678, 0.847),
    Transparency = 0,
    AnimatedColor = Color3.new(1, 1, 1),
    GradientRotationSpeed = 2,
    GradientColorSequence = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0.514, 0.82, 0.992)), ColorSequenceKeypoint.new(1, Color3.new(0.086, 0.678, 0.847)) }),
    GradientTransparencySequence = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 0) })
}

local tbl3 = {
    Color = Color3.fromRGB(0, 0, 0),
    Transparency = 0,
    Image = ""
}

local tbl4 = {
    Font = Enum.Font.GothamMedium,
    RelativeSize = 1,
    RelativeMinSize = 1
}
return {
    Theme = {
        BackgroundDefault = tbl1,
        BackgroundContrast = tbl1,
        BackgroundMuted = tbl1,
        BackgroundUIDefault = tbl1,
        BackgroundUIContrast = tbl1,
        BackgroundOnHover = tbl1,
        BackgroundOnPress = tbl1,
        UIDefault = tbl1,
        UIMuted = tbl1,
        UIEmphasis = tbl1,
        ContextualPrimaryDefault = tbl1,
        ContextualPrimaryOnHover = tbl1,
        ContextualPrimaryContent = tbl1,
        SystemPrimaryDefault = tbl1,
        SystemPrimaryOnHover = tbl1,
        SystemPrimaryContent = tbl1,
        SecondaryDefault = tbl1,
        SecondaryOnHover = tbl1,
        SecondaryContent = tbl1,
        IconDefault = tbl1,
        IconEmphasis = tbl1,
        IconOnHover = tbl1,
        TextEmphasis = tbl1,
        TextDefault = tbl1,
        TextMuted = tbl1,
        TextLink = tbl1,
        Divider = tbl1,
        Overlay = tbl1,
        DropShadow = tbl1,
        NavigationBar = tbl1,
        PlaceHolder = tbl1,
        OnlineStatus = tbl1,
        OfflineStatus = tbl1,
        Success = tbl1,
        Alert = tbl1,
        Badge = tbl1,
        BadgeContent = tbl1,
        SelectionCursor = SelectionCursor,
        PlayerBackgroundDefault = tbl3,
        ItemBackgroundDefault = tbl3
    },
    Font = {
        BaseSize = 10,
        Title = tbl4,
        Header1 = tbl4,
        Header2 = tbl4,
        SubHeader1 = tbl4,
        Body = tbl4,
        CaptionHeader = tbl4,
        CaptionSubHeader = tbl4,
        CaptionBody = tbl4,
        Footer = tbl4,
        HeadingLarge = tbl4,
        HeadingSmall = tbl4,
        TitleLarge = tbl4,
        BodyLarge = tbl4,
        CaptionLarge = tbl4,
        BodySmall = tbl4,
        CaptionSmall = tbl4
    },
    Settings = { PreferredTransparency = 0.56, ReducedMotion = true }
}
