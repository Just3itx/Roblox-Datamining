-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:41:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local Shell = game:GetService("CoreGui"):FindFirstChild("RobloxGui"):FindFirstChild("Modules"):FindFirstChild("Shell")

local Utility = require(Shell:FindFirstChild("Utility"))

local tbl1 = {
    WhiteTextColor = Color3.new(1, 1, 1),
    GreyTextColor = Color3.new(0.5, 0.5, 0.5),
    LightGreyTextColor = Color3.new(184 / 255, 184 / 255, 184 / 255),
    BlueTextColor = Color3.new(0, 116 / 255, 63 / 85),
    BlackTextColor = Color3.new(0, 0, 0),
    GreenTextColor = Color3.new(2 / 255, 61 / 85, 29 / 85),
    RedTextColor = Color3.new(72 / 85, 104 / 255, 104 / 255),
    OrangeTextColor = Color3.new(82 / 85, 8 / 15, 2 / 255),
    TextSelectedColor = Color3.new(5 / 51, 5 / 51, 5 / 51),
    LineBreakColor = Color3.new(26 / 85, 26 / 85, 26 / 85),
    PageDivideColor = Color3.new(151 / 255, 151 / 255, 151 / 255),
    BadgeOwnedColor = Color3.new(3 / 17, 32 / 85, 128 / 255),
    BadgeOverlayColor = Color3.new(13 / 255, 28 / 255, 38 / 255),
    OverlayColor = Color3.new(26 / 255, 19 / 85, 76 / 255),
    BadgeFrameColor = Color3.new(106 / 255, 8 / 17, 43 / 85),
    RobuxOverlayImageColor = Color3.new(14 / 85, 0.2, 19 / 85),
    BlueButtonColor = Color3.fromRGB(0, 162, 255),
    GreySelectionColor = Color3.new(28 / 85, 33 / 85, 109 / 255),
    GreenButtonColor = Color3.new(2 / 255, 163 / 255, 77 / 255),
    GreenSelectedButtonColor = Color3.new(21 / 85, 66 / 85, 121 / 255),
    GreyButtonColor = Color3.new(26 / 85, 28 / 85, 32 / 85),
    GreySelectedButtonColor = Color3.new(10 / 51, 181 / 255, 1),
    CharacterBackgroundColor = Color3.new(13 / 85, 23 / 85, 82 / 255),
    ForegroundGreyColor = Color3.new(58 / 255, 4 / 17, 64 / 255),
    BackgroundGreyColor = Color3.new(26 / 85, 28 / 85, 32 / 85),
    ModalBackgroundColor = Color3.new(0, 0, 0),
    AvatarBoxBackgroundColor = Color3.new(1, 1, 1),
    TabUnderlineColor = Color3.new(10 / 51, 181 / 255, 1),
    PriceLabelColor = Color3.new(241 / 255, 116 / 255, 2 / 51),
    PromoLabelColor = Color3.new(1, 0, 0),
    StatusIconEnabledColor = Color3.new(2 / 255, 61 / 85, 29 / 85),
    StatusIconDisabledColor = Color3.new(1, 0, 0),
    StatusIconUnknownColor = Color3.new(0.5, 0.5, 0.5),
    TextBoxColor = Color3.new(1, 1, 1),
    TextBoxSelectedTransparency = 0.5,
    TextBoxDefaultTransparency = 0.75,
    AvatarBoxBackgroundSelectedTransparency = 0.75,
    AvatarBoxBackgroundDeselectedTransparency = 0.875,
    AvatarBoxTextSelectedTransparency = 0,
    AvatarBoxTextDeselectedTransparency = 0.5,
    ModalBackgroundTransparency = 0.3,
    FriendStatusTextTransparency = 0.5,
    LargeHeadingSize = Enum.FontSize.Size48,
    MediumLargeHeadingSize = Enum.FontSize.Size36,
    MediumHeadingSize = Enum.FontSize.Size24,
    SmallHeadingSize = Enum.FontSize.Size18,
    ParagraphSize = Enum.FontSize.Size14,
    LargeFontSize = Enum.FontSize.Size96,
    HeaderSize = Enum.FontSize.Size60,
    MediumFontSize = Enum.FontSize.Size48,
    TitleSize = Enum.FontSize.Size42,
    ButtonSize = Enum.FontSize.Size36,
    DescriptionSize = Enum.FontSize.Size32,
    SubHeaderSize = Enum.FontSize.Size28,
    SmallTitleSize = Enum.FontSize.Size24,
    HeadingFont = Enum.Font.SourceSans,
    RegularFont = Enum.Font.SourceSans,
    LightFont = Enum.Font.SourceSansLight,
    BoldFont = Enum.Font.SourceSansBold,
    ItalicFont = Enum.Font.SourceSansItalic,
    TabItemSpacing = 30,
    DefaultPriority = 1,
    OverlayPriority = 2,
    ElevatedPriority = 3,
    ImmediatePriority = 4,
    TabDockTweenDuration = 0.35,
    AvatarPaneRefreshInterval = if Utility.GetFastVariable("XboxAvatarPaneRefreshInterval") then tonumber(Utility.GetFastVariable("XboxAvatarPaneRefreshInterval")) or 1800 else 1800,
    GameDetailsRefreshInterval = if Utility.GetFastVariable("XboxGameDetailsRefreshInterval") then tonumber(Utility.GetFastVariable("XboxGameDetailsRefreshInterval")) or 1800 else 1800,
    GameSortsUpdateInterval = if Utility.GetFastVariable("XboxGameSortsUpdateInterval") then tonumber(Utility.GetFastVariable("XboxGameSortsUpdateInterval")) or 1800 else 1800,
    TextVerticalPadding = 10,
    TextHorizontalPadding = 13,
    RoundCornerButtonImage = "rbxasset://textures/ui/Shell/Buttons/Generic9ScaleButton@720.png",
    RoundCornerButtonOutlineImage = "rbxasset://textures/ui/Shell/Buttons/Generic9ScaleButtonOutline@720.png",
    Fonts = {
        Heading = Enum.Font.SourceSans,
        Regular = Enum.Font.SourceSans,
        Light = Enum.Font.SourceSansLight,
        Bold = Enum.Font.SourceSansBold,
        Italic = Enum.Font.SourceSansItalic
    },
    Colors = {
        BlueButton = Color3.fromRGB(0, 162, 255),
        WhiteButton = Color3.fromRGB(255, 255, 255),
        GreySelectedButton = Color3.fromRGB(50, 181, 255),
        TextSelected = Color3.fromRGB(25, 25, 25),
        WhiteText = Color3.fromRGB(255, 255, 255),
        GreenText = Color3.fromRGB(2, 183, 87),
        BlueText = Color3.fromRGB(0, 116, 189),
        OrangeText = Color3.fromRGB(246, 136, 2),
        GreyText = Color3.fromRGB(127, 127, 127),
        LightGreyText = Color3.fromRGB(184, 184, 184),
        CharacterBackground = Color3.fromRGB(39, 69, 82),
        BlackText = Color3.fromRGB(0, 0, 0),
        Black = Color3.fromRGB(0, 0, 0),
        RedText = Color3.fromRGB(247, 75, 82)
    },
    TextSizes = {
        Large = 96,
        Header = 60,
        Medium = 48,
        Title = 42,
        Button = 36,
        Description = 32,
        SubHeader = 28,
        SmallTitle = 24
    },
    Images = {
        RoundCornerButton = "Buttons/Generic9ScaleButton@720.png",
        ButtonDefault = "Buttons/Button_1080.png",
        ButtonSelector = "Buttons/gr-item selector-8px corner.png",
        RightArrow = "Icons/RightIndicatorIcon@1080.png",
        EnabledStatusIcon = "Icons/EnabledStatusIcon.png",
        Shadow = "/Buttons/Generic9ScaleShadow.png",
        RobloxIcon = "Icons/RobloxIcon24.png",
        OnlineStatusIcon = "Icons/OnlineStatusIcon@1080.png",
        DefaultProfile = "Icons/DefaultProfileIcon.png"
    },
    Sounds = {
        BackgroundLoop = "RobloxMusic.ogg",
        Error = "Error.mp3",
        ButtonPress = "ButtonPress.mp3",
        MoveSelection = "MoveSelection.mp3",
        OverlayOpen = "OverlayOpen.mp3",
        PopUp = "PopUp.mp3",
        PurchaseSuccess = "PurchaseSuccess.mp3",
        ScreenChange = "ScreenChange.mp3",
        SideMenuSlideIn = "SideMenuSlideIn.mp3"
    },
    Transparency = {
        TextBoxSelected = 0.5,
        TextBoxDefault = 0.75,
        AvatarBoxBackgroundSelected = 0.75,
        AvatarBoxBackgroundDeselected = 0.875,
        AvatarBoxTextSelected = 0,
        AvatarBoxTextDeselected = 0.5,
        ModalBackground = 0.3,
        FriendStatusText = 0.5
    }
}

for k in pairs(tbl1.Images) do
    tbl1.Images[k] = table.concat({ "rbxasset://textures/ui/Shell/", tbl1.Images[k] })
end

for k in pairs(tbl1.Sounds) do
    tbl1.Sounds[k] = table.concat({ "rbxasset://sounds/ui/Shell/", tbl1.Sounds[k] })
end

return tbl1
