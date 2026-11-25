-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:11:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent
local Cryo = require(ProfilePlatformParent.Cryo)
local React = require(ProfilePlatformParent.React)

local UserProfileHeader = require(ProfilePlatform.Components.UserProfileHeader)
local MeTabUserProfileHeader = require(ProfilePlatform.Components.UserProfileHeader.MeTabUserProfileHeader)
local About = require(ProfilePlatform.Components.About)
local ContactDescription = require(ProfilePlatform.Components.ContactDescription)
local CommunityProfileHeader = require(ProfilePlatform.Components.CommunityProfileHeader)
local CoverPhoto = require(ProfilePlatform.Components.CoverPhoto)
local CurrentlyWearing = require(ProfilePlatform.Components.CurrentlyWearing)
local Store = require(ProfilePlatform.Components.Store)
local ViewFullProfile = require(ProfilePlatform.Components.ViewFullProfile)
local Inventory = require(ProfilePlatform.Components.Inventory)
local FavoriteExperiences = require(ProfilePlatform.Components.FavoriteExperiences)
local ContactProfileHeader = require(ProfilePlatform.Components.ContactProfileHeader)
local Experiences = require(ProfilePlatform.Components.Experiences)
local ExperiencesWideCarousel = require(ProfilePlatform.Components.ExperiencesWideCarousel)
local SocialLinks = require(ProfilePlatform.Components.SocialLinks)
local CommunityLocked = require(ProfilePlatform.Components.CommunityLocked)
local Events = require(ProfilePlatform.Components.Events)
local Announcements = require(ProfilePlatform.Components.Announcements)
local GroupForumsDiscovery = require(ProfilePlatform.Components.GroupForumsDiscovery)
local ProfileCompletion = require(ProfilePlatform.Components.ProfileCompletion)
local CurrentlyPlaying = require(ProfilePlatform.Components.CurrentlyPlaying)
local CTARow = require(ProfilePlatform.Components.CTARow)
local Moments = require(ProfilePlatform.Components.Moments)

local Constants = require(ProfilePlatformParent.ProfilePlatform.Common.Constants)
local Enums = require(ProfilePlatformParent.ProfilePlatform.Common.Enums)
local getPeekViewOpenHeightByProfileType = require(ProfilePlatform.Utils.getPeekViewOpenHeightByProfileType)

local FFlagProfilePlatformEnableFavoriteExperiences = require(ProfilePlatform.Flags.FFlagProfilePlatformEnableFavoriteExperiences)
local FFlagProfilePlatformEnableStore = require(ProfilePlatformParent.SharedFlags).FFlagProfilePlatformEnableStore
local FFlagAXEnableProfileTab = require(ProfilePlatformParent.SharedFlags).FFlagAXEnableProfileTab
local FFlagProfilePlatformEnableInventory = require(ProfilePlatformParent.SharedFlags).FFlagProfilePlatformEnableInventory
local FFlagAddSocialLinksToCommunityProfile = require(ProfilePlatformParent.SharedFlags).FFlagAddSocialLinksToCommunityProfile

local FFlagAddCommunityLockedToCommunityProfile = require(ProfilePlatformParent.SharedFlags).FFlagAddCommunityLockedToCommunityProfile
local FFlagExperiencesOnProfile = require(ProfilePlatformParent.SharedFlags).FFlagExperiencesOnProfile
local FFlagEnableProfileCompletion = require(ProfilePlatformParent.SharedFlags).FFlagEnableProfileCompletion
local FFlagProfilePlatformEnableLazyLoadingComponents = require(ProfilePlatform.Flags.FFlagProfilePlatformEnableLazyLoadingComponents)
local FFlagAddEventsToCommunityProfile = require(ProfilePlatform.Flags.FFlagAddEventsToCommunityProfile)
local FFlagGroupAnnouncementsSdui = require(ProfilePlatformParent.SharedFlags).FFlagGroupAnnouncementsSdui
local FFlagGroupForumsDiscoverySdui = require(ProfilePlatformParent.SharedFlags).FFlagGroupForumsDiscoverySdui
local FFlagProfilePlatformAddCurrentlyPlaying = require(ProfilePlatform.Flags.FFlagProfilePlatformAddCurrentlyPlaying)
local FFlagAboutBeforeActionClient = require(ProfilePlatform.Flags.FFlagAboutBeforeActionClient)
local FFlagProfilePlatformEnableMoments = require(ProfilePlatform.Flags.FFlagProfilePlatformEnableMoments)

local function orderWithAboutBeforeActions(tbl1)
    if not FFlagAboutBeforeActionClient then
        return tbl1
    end
    local var1 = nil
    local var2 = nil
    local var3 = nil
    for i, value in ipairs(tbl1) do
        if value == Enums.Components.About then
            var1 = i
        elseif value == Enums.Components.Actions then
            var2 = i
        elseif FFlagProfilePlatformAddCurrentlyPlaying and value == Enums.Components.CurrentlyPlaying then
            var3 = i
        end
    end

    if var1 == nil or var2 == nil or var1 < var2 then
        return tbl1
    end
    local var4 = Cryo.List.join({}, tbl1)
    if not (FFlagProfilePlatformAddCurrentlyPlaying and var3) then
        local var5 = var4[var2]
        local var6 = var4[var1]
        var4[var1] = var5
        var4[var2] = var6

        return var4
    end

    local var5 = var4[var1]
    local var6 = var4[var3]
    local var7 = var4[var2]
    var4[var3] = var5
    var4[var2] = var6
    var4[var1] = var7
    return var4
end

local function moveMomentsToTop(tbl1)
    local var1 = nil
    for i, value in ipairs(tbl1) do
        if value == Enums.Components.Moments then
            var1 = i
            break
        end
    end

    if var1 == nil then
        return tbl1
    end
    local var2 = Cryo.List.join({}, tbl1)
    table.remove(var2, var1)
    local num1 = 1
    for i, value in ipairs(var2) do
        if value == Enums.Components.CurrentlyWearing then
            num1 = i
            break
        end
    end

    table.insert(var2, num1, Enums.Components.Moments)
    return var2
end

local tbl1 = {
    [Enums.Components.UserProfileHeader] = UserProfileHeader,
    [Enums.Components.CurrentlyWearing] = CurrentlyWearing,
    [Enums.Components.Actions] = CTARow
}
local Experiences2 = Enums.Components.Experiences

if not FFlagExperiencesOnProfile then
    ExperiencesWideCarousel = Experiences
end

tbl1[Experiences2] = ExperiencesWideCarousel
tbl1[Enums.Components.ViewFullProfile] = ViewFullProfile
tbl1[Enums.Components.About] = About.About
local FavoriteExperiences2 = Enums.Components.FavoriteExperiences

if not FFlagProfilePlatformEnableFavoriteExperiences then
    FavoriteExperiences = nil
end

tbl1[FavoriteExperiences2] = FavoriteExperiences

local Inventory2 = Enums.Components.Inventory

if not FFlagProfilePlatformEnableInventory then
    Inventory = nil
end

tbl1[Inventory2] = Inventory
local Store2 = Enums.Components.Store
tbl1[Store2] = if FFlagProfilePlatformEnableStore then Store else nil
local ProfileCompletion2 = Enums.Components.ProfileCompletion

if not FFlagEnableProfileCompletion then
    ProfileCompletion = nil
end

tbl1[ProfileCompletion2] = ProfileCompletion
local CurrentlyPlaying2 = Enums.Components.CurrentlyPlaying

if not FFlagProfilePlatformAddCurrentlyPlaying then
    CurrentlyPlaying = nil
end

tbl1[CurrentlyPlaying2] = CurrentlyPlaying
local Moments2 = Enums.Components.Moments

if not FFlagProfilePlatformEnableMoments then
    Moments = nil
end

tbl1[Moments2] = Moments

local tbl2 = {
    [Enums.Components.CoverPhoto] = CoverPhoto,
    [Enums.Components.CommunityProfileHeader] = CommunityProfileHeader,
    [Enums.Components.About] = About.About,
    [Enums.Components.Actions] = CTARow,
    [Enums.Components.Experiences] = Experiences,
    [Enums.Components.Store] = Store
}
local SocialLinks2 = Enums.Components.SocialLinks

if not FFlagAddSocialLinksToCommunityProfile then
    SocialLinks = nil
end

tbl2[SocialLinks2] = SocialLinks
tbl2[Enums.Components.ViewFullProfile] = ViewFullProfile
local CommunityLocked2 = Enums.Components.CommunityLocked

if not FFlagAddCommunityLockedToCommunityProfile then
    CommunityLocked = nil
end

tbl2[CommunityLocked2] = CommunityLocked
local Events2 = Enums.Components.Events

if not FFlagAddEventsToCommunityProfile then
    Events = nil
end

tbl2[Events2] = Events
local Announcements2 = Enums.Components.Announcements

if not FFlagGroupAnnouncementsSdui then
    Announcements = nil
end

tbl2[Announcements2] = Announcements
local GroupForumsDiscovery2 = Enums.Components.GroupForumsDiscovery

if not FFlagGroupForumsDiscoverySdui then
    GroupForumsDiscovery = nil
end

tbl2[GroupForumsDiscovery2] = GroupForumsDiscovery

local tbl3 = {
    [Enums.Components.ContactProfileHeader] = ContactProfileHeader,
    [Enums.Components.ContactDescription] = ContactDescription,
    [Enums.Components.Actions] = CTARow
}
local var1

if FFlagAXEnableProfileTab then
    local join = Cryo.Dictionary.join

    local tbl4 = {
        [Enums.Components.UserProfileHeader] = MeTabUserProfileHeader,
        [Enums.Components.Actions] = Cryo.None
    }
    var1 = join(tbl1, tbl4)
else
    var1 = nil
end

return function(arg1, arg2, arg3, momentsFeed: string?, bool1: boolean?)
    local var2 = arg2 or {}
    local tbl4 = {
        Layout = React.createElement("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            FillDirection = Enum.FillDirection.Vertical,
            Padding = UDim.new(0, Constants.PAGE_PADDING)
        })
    }

    if Cryo.isEmpty(var2) then
        tbl4.loadingView = React.createElement(
            "Frame",
            {
                Size = UDim2.new(1, 0, 0, getPeekViewOpenHeightByProfileType(arg3)),
                BackgroundTransparency = 1,
                BorderSizePixel = 0
            }
        )

        return tbl4
    end

    local tbl5 = {}
    if arg3 == Enums.ProfileTypes.User then
        if FFlagAXEnableProfileTab and bool1 then
            tbl5 = var1
        else
            tbl5 = tbl1
        end
    elseif arg3 == Enums.ProfileTypes.Community then
        tbl5 = tbl2
    elseif arg3 == Enums.ProfileTypes.Contact then
        tbl5 = tbl3
    end

    if FFlagAboutBeforeActionClient and arg3 == Enums.ProfileTypes.User then
        var2 = orderWithAboutBeforeActions(var2)
    end

    if FFlagProfilePlatformEnableMoments and arg3 == Enums.ProfileTypes.User and momentsFeed == Enums.Sources.MomentsFeed then
        var2 = moveMomentsToTop(var2)
    end

    for layoutOrder, value2 in var2 do
        local var3 = tbl5[value2]

        if FFlagProfilePlatformEnableLazyLoadingComponents then
            if var3 ~= nil and arg1[value2] ~= nil then
                tbl4[value2] = React.createElement(var3, { layoutOrder = layoutOrder })
            end
        elseif var3 ~= nil then
            tbl4[value2] = React.createElement(var3, { layoutOrder = layoutOrder })
        end
    end

    return tbl4
end
