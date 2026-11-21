-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T19:41:04Z
-- Luau bytecode version: 14 | Luau type version: 3
return {
    Btns = { OpenGameJoinCard = "openGameJoinCard", GameJoinCardButton = "gameJoinCardButton" },
    GameJoinCardButtonAction = {
        Invalid = 0,
        JoinGame = 1,
        OpenProfileFromUserTile = 2,
        OpenProfileFromViewProfile = 3,
        ViewExperienceDetailsFromTitle = 4,
        ViewExperienceDetailsFromThumbnail = 5,
        Chat = 6,
        AgeCheckUnlock = 7,
        PlayExperience = 8,
        CreateInBuild = 9
    },
    JoinCardType = { Build = 2 },
    GameJoinCardSurface = { Desktop = "desktop", Mobile = "mobile" },
    CtaType = { Join = "Join", Play = "Play", AgeCheckUnlock = "AgeCheckUnlock" },
    AgeCheckUpsellOutcome = { Unspecified = 0, Success = 1, Cancelled = 2, Error = 3 },
    viewEDPsourceValues = { Thumbnail = "thumbnail", Title = "title" },
    viewProfileSourceValues = { UserTile = "userTile", ViewProfileButton = "viewProfileButton" }
}
