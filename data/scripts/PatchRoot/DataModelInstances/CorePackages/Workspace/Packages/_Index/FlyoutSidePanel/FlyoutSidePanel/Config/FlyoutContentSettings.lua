-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T13:40:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FlyoutSidePanel = script:FindFirstAncestor("FlyoutSidePanel")
local FlyoutSidePanelParent = FlyoutSidePanel.Parent
local Foundation = require(FlyoutSidePanelParent.Foundation)
local BuilderIcons = require(FlyoutSidePanelParent.BuilderIcons)
local UrlBuilder = require(FlyoutSidePanelParent.UrlBuilder).UrlBuilder
local AppPage = require(FlyoutSidePanelParent.RobloxAppEnums).AppPage
local FlyoutSidePanelIXP = require(FlyoutSidePanelParent.SharedExperimentDefinition).FlyoutSidePanelIXP
local Constants = require(script.Parent.Parent.Constants)
local FAVORITES_URI = Constants.FAVORITES_URI
local CONTINUE_PLAYING_URI = Constants.CONTINUE_PLAYING_URI
local SharedFlags = require(FlyoutSidePanelParent.SharedFlags)
local GetFStringPlatformEventUrl = SharedFlags.GetFStringPlatformEventUrl

local str1 = game:DefineFastString("FlyoutMomentsPlaceURI", "roblox://experiences/start?placeId=119524072047648")

local appUri = game:DefineFastString("FlyoutLearnPlaceURI", "roblox://experiences/start?placeId=92498145666402")

local FFlagCreateConnectionsHub = SharedFlags.FFlagCreateConnectionsHub
local FFlagEnableArgus = SharedFlags.FFlagEnableArgus
local FFlagEnableBlackbird = SharedFlags.FFlagEnableBlackbird
local FFlagEnableBlackbirdOnFlyoutMenu = SharedFlags.FFlagEnableBlackbirdOnFlyoutMenu
local FFlagFlyoutAddAdjustScreen = require(script.Parent.Parent.Flags.FFlagFlyoutAddAdjustScreen)
local FFlagFlyoutSidePanelTradesEntry = require(script.Parent.Parent.Flags.FFlagFlyoutSidePanelTradesEntry)
local FFlagFlyoutFilterWebViewsAndBrowserLinks = SharedFlags.FFlagFlyoutFilterWebViewsAndBrowserLinks
local FFlagEnableLuaCommunityList = SharedFlags.FFlagEnableLuaCommunityList
local FFlagFlyoutResolveItemContextOnActivation = require(FlyoutSidePanel.Flags.FFlagFlyoutResolveItemContextOnActivation)
local FFlagEnableChartsInFlyout = SharedFlags.FFlagEnableChartsInFlyout
local FFlagUserLibrary = SharedFlags.FFlagUserLibrary
local CommunityListRouting = require(FlyoutSidePanelParent.Groups).CommunityListRouting

local ItemType = {
    Favorites = "Favorites",
    ContinuePlaying = "ContinuePlaying",
    Inventory = "Inventory",
    Connections = "Connections",
    Communities = "Communities",
    Messages = "Messages",
    Settings = "Settings",
    AdjustScreen = "AdjustScreen",
    HelpAndSafety = "HelpAndSafety",
    Moments = "Moments",
    Charts = "Charts",
    UserLibrary = "UserLibrary",
    Learn = "Learn",
    CreateGames = "CreateGames",
    Premium = "Premium",
    GiftCards = "GiftCards",
    Redeem = "Redeem",
    Trades = "Trades",
    Events = "Events",
    RobuxPill = "RobuxPill",
    QuickSignin = "QuickSignin",
    ReportLogs = "ReportLogs",
    Profile = "Profile",
    Terms = "Terms",
    Privacy = "Privacy"
}

local EventNameMappings = {
    [ItemType.Premium] = "BuildersClub",
    [ItemType.Connections] = "Friends",
    [ItemType.Moments] = "RM",
    [ItemType.Communities] = "Groups",
    [ItemType.HelpAndSafety] = "SafetySupport",
    [ItemType.Events] = "TheHunt",
    [ItemType.QuickSignin] = "Login Code"
}

local ItemTextKey = {
    [ItemType.Favorites] = "Feature.Catalog.Label.Favorites",
    [ItemType.ContinuePlaying] = "Feature.FlyoutSidePanel.Action.ContinuePlaying",
    [ItemType.Inventory] = "CommonUI.Features.Label.Inventory",
    [ItemType.Connections] = "CommonUI.Features.Label.Friends",
    [ItemType.Communities] = "CommonUI.Features.Label.Groups",
    [ItemType.Messages] = "CommonUI.Features.Label.Messages",
    [ItemType.Settings] = "CommonUI.Features.Label.Settings",
    [ItemType.AdjustScreen] = "CommonUI.Features.Label.AdjustScreen",
    [ItemType.HelpAndSafety] = "CommonUI.Features.Label.HelpAndSafety",
    [ItemType.Moments] = "CommonUI.Features.Label.RM",
    [ItemType.Charts] = "CommonUI.Features.Label.Charts",
    [ItemType.UserLibrary] = "Feature.UserLibrary.Label.MyLibrary",
    [ItemType.Learn] = "CommonUI.Features.Label.Learn",
    [ItemType.CreateGames] = "CommonUI.Features.Label.CreateGames",
    [ItemType.Premium] = "CommonUI.Features.Label.Premium",
    [ItemType.GiftCards] = "CommonUI.Features.Label.GiftCards",
    [ItemType.Redeem] = "CommonUI.Features.Label.Redeem",
    [ItemType.Trades] = "CommonUI.Features.Label.Trades",
    [ItemType.Events] = "CommonUI.Features.Label.TheHunt",
    [ItemType.Terms] = "CommonUI.Features.Label.Terms",
    [ItemType.Privacy] = "CommonUI.Features.Label.Privacy"
}

local DestinationType = {
    WebView = "WebView",
    WebLink = "WebLink",
    AppPage = "AppPage",
    GameSortDeeplink = "GameSortDeeplink",
    PlaceLaunch = "PlaceLaunch"
}

local function getCommunitiesContext()
    if CommunityListRouting.getShouldUseLuaCommunityList() then
        return {
            appPage = AppPage.Groups,
            destinationType = DestinationType.AppPage
        }
    end

    return {
        url = UrlBuilder.static.groups(),
        destinationType = DestinationType.WebView
    }
end

local function getResolvedItemContext(tbl5) -- Luacid: Inlined by compiler; 3 call sites recovered
    if FFlagFlyoutResolveItemContextOnActivation and tbl5.getContext then
        return (tbl5.getContext())
    end

    return tbl5.context
end

local function getDestinationType(tbl5) -- Luacid: Inlined by compiler; 2 call sites recovered
    local resolvedItemContext = getResolvedItemContext(tbl5)
    return if resolvedItemContext then resolvedItemContext.destinationType else nil
end

local function itemRequiresWebView(tbl5, bool1: boolean?): boolean
    local destinationType = getDestinationType(tbl5)
    return destinationType == DestinationType.WebView or destinationType == DestinationType.WebLink and not bool1
end

local function itemIsGameSortDeeplink(tbl5): boolean
    return getDestinationType(tbl5) == DestinationType.GameSortDeeplink
end

local var1 = FFlagEnableLuaCommunityList and FFlagFlyoutResolveItemContextOnActivation

local ItemInfo = {}
local tbl6 = {
    itemType = ItemType.Favorites,
    textKey = ItemTextKey[ItemType.Favorites],
    icon = BuilderIcons.Icon.Bookmark,
    context = {
        appUri = FAVORITES_URI,
        destinationType = DestinationType.GameSortDeeplink
    }
}
ItemInfo[ItemType.Favorites] = tbl6

local tbl7 = {
    itemType = ItemType.ContinuePlaying,
    textKey = ItemTextKey[ItemType.ContinuePlaying],
    icon = BuilderIcons.Icon.ClockSpinReverse,
    context = {
        appUri = CONTINUE_PLAYING_URI,
        destinationType = DestinationType.GameSortDeeplink
    }
}
ItemInfo[ItemType.ContinuePlaying] = tbl7

local tbl8 = {
    itemType = ItemType.Inventory,
    textKey = ItemTextKey[ItemType.Inventory],
    icon = BuilderIcons.Icon.Backpack,
    context = {
        urlGenerator = function(userId)
            return userId and UrlBuilder.user.inventory({ userId = userId }) or nil
        end,
        destinationType = DestinationType.WebView
    }
}

ItemInfo[ItemType.Inventory] = tbl8

local Connections = ItemType.Connections
ItemInfo[Connections] = {
    itemType = ItemType.Connections,
    textKey = ItemTextKey[ItemType.Connections],
    icon = BuilderIcons.Icon.TwoPeople,
    context = {
        appPage = if FFlagCreateConnectionsHub then AppPage.CoHubMyConnections else AppPage.ViewFriends,
        destinationType = DestinationType.AppPage
    }
}
local Communities = ItemType.Communities
local tbl9 = {
    itemType = ItemType.Communities,
    textKey = ItemTextKey[ItemType.Communities],
    icon = BuilderIcons.Icon.ThreePeople,
    context = not var1 and {
        url = UrlBuilder.static.groups(),
        destinationType = DestinationType.WebView
    } or nil,
    getContext = 0
}

if not var1 then
    getCommunitiesContext = nil
end

tbl9.getContext = getCommunitiesContext
ItemInfo[Communities] = tbl9

ItemInfo[ItemType.Messages] = {
    itemType = ItemType.Messages,
    textKey = ItemTextKey[ItemType.Messages],
    icon = BuilderIcons.Icon.Envelope,
    context = {
        url = UrlBuilder.static.messages(),
        destinationType = DestinationType.WebView
    }
}
ItemInfo[ItemType.Settings] = {
    itemType = ItemType.Settings,
    textKey = ItemTextKey[ItemType.Settings],
    icon = BuilderIcons.Icon.Gear,
    context = {
        appPage = AppPage.Settings,
        destinationType = DestinationType.AppPage
    }
}
ItemInfo[ItemType.AdjustScreen] = FFlagFlyoutAddAdjustScreen
    and {
        itemType = ItemType.AdjustScreen,
        textKey = ItemTextKey[ItemType.AdjustScreen],
        icon = BuilderIcons.Icon.SquareDualArrowsToCorner,
        context = {
            appPage = AppPage.AdjustScreen,
            destinationType = DestinationType.AppPage
        }
    }
    or nil

ItemInfo[ItemType.HelpAndSafety] = {
    itemType = ItemType.HelpAndSafety,
    textKey = ItemTextKey[ItemType.HelpAndSafety],
    icon = BuilderIcons.Icon.ShieldLock,
    context = {
        appPage = AppPage.SafetySupport,
        destinationType = DestinationType.AppPage
    }
}
local tbl10 = {
    itemType = ItemType.Moments,
    textKey = ItemTextKey[ItemType.Moments],
    icon = BuilderIcons.Icon.Moments,
    context = FFlagEnableArgus and {
        appPage = AppPage.Moments,
        destinationType = DestinationType.AppPage
    }
        or {
            appUri = str1,
            destinationType = DestinationType.PlaceLaunch
        }
}
ItemInfo[ItemType.Moments] = tbl10

local Charts = ItemType.Charts
ItemInfo[Charts] = {
    itemType = ItemType.Charts,
    textKey = ItemTextKey[ItemType.Charts],
    icon = BuilderIcons.Icon.ChartThreeVerticalBars,
    context = {
        appPage = if FFlagEnableChartsInFlyout and FlyoutSidePanelIXP.isChartsInFlyoutEnabled() then AppPage.Games else nil,
        destinationType = DestinationType.AppPage
    }
}
local UserLibrary = ItemType.UserLibrary
ItemInfo[UserLibrary] = {
    itemType = ItemType.UserLibrary,
    textKey = ItemTextKey[ItemType.UserLibrary],
    icon = BuilderIcons.Icon.Bookmark,
    context = {
        appPage = if FFlagUserLibrary then AppPage.UserLibrary else nil,
        destinationType = DestinationType.AppPage
    }
}
ItemInfo[ItemType.Learn] = {
    itemType = ItemType.Learn,
    textKey = ItemTextKey[ItemType.Learn],
    icon = BuilderIcons.Icon.PersonGraduate,
    context = {
        appUri = appUri,
        destinationType = DestinationType.PlaceLaunch
    }
}
local CreateGames = ItemType.CreateGames

ItemInfo[CreateGames] = {
    itemType = ItemType.CreateGames,
    textKey = ItemTextKey[ItemType.CreateGames],
    icon = BuilderIcons.Icon.Studio,
    context = {
        urlGenerator = function(arg1)
            return arg1({ utm_content = "side_panel" })
        end,
        destinationType = if FFlagFlyoutFilterWebViewsAndBrowserLinks then DestinationType.WebLink else DestinationType.WebView
    }
}

ItemInfo[ItemType.Premium] = {
    itemType = ItemType.Premium,
    textKey = ItemTextKey[ItemType.Premium],
    icon = BuilderIcons.Icon.Premium,
    context = {
        appPage = AppPage.BuildersClub,
        destinationType = DestinationType.WebView
    }
}
local GiftCards = ItemType.GiftCards

ItemInfo[GiftCards] = {
    itemType = ItemType.GiftCards,
    textKey = ItemTextKey[ItemType.GiftCards],
    icon = BuilderIcons.Icon.GiftCard,
    context = {
        urlGenerator = function(arg1)
            return UrlBuilder.static.giftCards(arg1)
        end,
        destinationType = if FFlagFlyoutFilterWebViewsAndBrowserLinks then DestinationType.WebLink else DestinationType.WebView
    }
}

ItemInfo[ItemType.Redeem] = {
    itemType = ItemType.Redeem,
    textKey = ItemTextKey[ItemType.Redeem],
    icon = BuilderIcons.Icon.Wallet,
    context = {
        url = UrlBuilder.static.redeem(),
        destinationType = DestinationType.WebView
    }
}
ItemInfo[ItemType.Trades] = FFlagFlyoutSidePanelTradesEntry
    and {
        itemType = ItemType.Trades,
        textKey = ItemTextKey[ItemType.Trades],
        icon = BuilderIcons.Icon.HandTwoArrowsHorizontal,
        context = {
            url = UrlBuilder.static.trades(),
            destinationType = DestinationType.WebView
        }
    }
    or nil

local Events = ItemType.Events
ItemInfo[Events] = {
    itemType = ItemType.Events,
    textKey = ItemTextKey[ItemType.Events],
    icon = BuilderIcons.Icon.CalendarStar,
    context = {
        url = if GetFStringPlatformEventUrl() ~= "" then UrlBuilder.fromString(GetFStringPlatformEventUrl())() else UrlBuilder.static.help(),
        destinationType = DestinationType.WebView
    }
}
local Terms = ItemType.Terms

ItemInfo[Terms] = {
    itemType = ItemType.Terms,
    textKey = ItemTextKey[ItemType.Terms],
    context = {
        urlGenerator = function(_, arg1)
            local termsOfUseLink = if arg1 then arg1.getTermsOfUseLink() else nil

            if termsOfUseLink == nil or termsOfUseLink == "" then
                termsOfUseLink = UrlBuilder.static.about.terms({ useGameQQUrls = true })
            end
            return termsOfUseLink
        end,
        destinationType = if FFlagFlyoutFilterWebViewsAndBrowserLinks then DestinationType.WebLink else DestinationType.WebView
    }
}

local Privacy = ItemType.Privacy

ItemInfo[Privacy] = {
    itemType = ItemType.Privacy,
    textKey = ItemTextKey[ItemType.Privacy],
    context = {
        urlGenerator = function(_, arg1)
            local privacyPolicyLink = if arg1 then arg1.getPrivacyPolicyLink() else nil

            if privacyPolicyLink == nil or privacyPolicyLink == "" then
                privacyPolicyLink = UrlBuilder.static.about.privacy({ useGameQQUrls = true })
            end
            return privacyPolicyLink
        end,
        destinationType = if FFlagFlyoutFilterWebViewsAndBrowserLinks then DestinationType.WebLink else DestinationType.WebView
    }
}

if FFlagEnableBlackbird and FFlagEnableBlackbirdOnFlyoutMenu then
    ItemType.Blackbird = "Blackbird"
    EventNameMappings[ItemType.Blackbird] = "Blackbird"

    ItemTextKey[ItemType.Blackbird] = "CommonUI.Features.Label.X"
    ItemInfo[ItemType.Blackbird] = {
        itemType = ItemType.Blackbird,
        textKey = ItemTextKey[ItemType.Blackbird],
        icon = Foundation.Enums.IconName.RobloxPlus,
        context = {
            appPage = AppPage.Blackbird,
            destinationType = DestinationType.WebView
        }
    }
end

return {
    ItemType = ItemType,
    ItemTextKey = ItemTextKey,
    ItemInfo = ItemInfo,
    EventNameMappings = EventNameMappings,
    MomentsExperienceUri = str1,
    DestinationType = DestinationType,
    itemRequiresWebView = itemRequiresWebView,
    itemIsGameSortDeeplink = itemIsGameSortDeeplink
}
