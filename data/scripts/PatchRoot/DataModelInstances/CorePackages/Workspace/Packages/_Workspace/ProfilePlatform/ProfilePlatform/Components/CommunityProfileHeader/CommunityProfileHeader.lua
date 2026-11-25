-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T04:41:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent
local HorizontalPageMargin = require(ProfilePlatformParent.UIBlox).App.Container.HorizontalPageMargin
local Foundation = require(ProfilePlatformParent.Foundation)
local React = require(ProfilePlatformParent.React)
local abbreviateCount = require(ProfilePlatformParent.Localization).abbreviateCount
local useLocalization = require(ProfilePlatformParent.Localization).Hooks.useLocalization

local useDispatch = require(ProfilePlatformParent.RoactUtils).Hooks.RoactRodux.useDispatch
local NavigateDown = require(ProfilePlatformParent.NavigationRodux).Thunks.NavigateDown
local AppPage = require(ProfilePlatformParent.RobloxAppEnums).AppPage
local Enums = require(ProfilePlatform.Common.Enums)

local Image = Foundation.Image
local FoundationText = Foundation.Text
local View = Foundation.View

local SocialCountsItem = require(ProfilePlatform.Components.UserProfileHeader.SocialCountsItem)
local TextKeys = require(ProfilePlatform.Common.TextKeys)

local FFlagEnablePressingCommunityOwnerInPeekView = require(ProfilePlatform.Flags.FFlagEnablePressingCommunityOwnerInPeekView)
local FFlagSignalsNavP3Dispatch = require(ProfilePlatformParent.SharedFlags).FFlagSignalsNavP3Dispatch
local NavigationCommands = if FFlagSignalsNavP3Dispatch then require(ProfilePlatformParent.RobloxAppNavigation).NavigationCommands else nil

local function CommunityProfileHeader(tbl1)
    local var1 = useDispatch()

    local var2 = useLocalization({
        byOwner = {
            TextKeys.ByOwner,
            ownerName = tbl1.ownerName
        },
        members = TextKeys.Members,
        followers = TextKeys.Followers,
        follower = TextKeys.Follower
    })

    local text = React.useMemo(function()
        if tbl1.hasSocialModules then
            return var2.members
        end

        if tbl1.membersCount == 1 then
            return var2.follower
        end

        return var2.followers
    end, { var2, tbl1.membersCount, tbl1.hasSocialModules })

    local var4 = FFlagEnablePressingCommunityOwnerInPeekView and function()
        if not tbl1.ownerUserId then
            return
        end

        local tbl2 = {
            name = AppPage.ProfilePlatform,
            detail = tbl1.ownerUserId,
            extraProps = {
                profileType = Enums.ProfileTypes.User
            }
        }
        if FFlagSignalsNavP3Dispatch then
            NavigationCommands.down(NavigationCommands.fromLegacyPage(tbl2))
            return
        end
        var1(NavigateDown(tbl2))
    end or nil

    local createElement = React.createElement
    local var5 = HorizontalPageMargin
    local tbl2 = {
        layoutOrder = tbl1.layoutOrder,
        backgroundTransparency = 1,
        size = UDim2.new(1, 0, 0, 0),
        useAutomaticSizing = true
    }
    local tbl3 = { Container = 0 }
    local createElement2 = React.createElement
    local var6 = View
    local tbl4 = { LayoutOrder = 1, tag = "col size-full-0 auto-xy gap-xsmall" }

    local tbl5 = { HeaderInformation = 0, Counts = 0 }
    local createElement3 = React.createElement
    local var7 = View
    local tbl6 = { LayoutOrder = 1, tag = "row gap-medium size-full-0 auto-xy" }

    local tbl7 = {
        CommunityThumbnail = React.createElement(
            Image,
            {
                LayoutOrder = 1,
                tag = "radius-medium self-center",
                Image = tbl1.thumbnail,
                Size = UDim2.new(0, 80, 0, 80)
            }
        ),
        Names = 0
    }
    local createElement4 = React.createElement
    local var8 = View
    local tbl8 = {
        LayoutOrder = 2,
        tag = "fill col size-full-0 auto-y align-y-center gap-small",
        Size = UDim2.new(1, 0, 0, 80)
    }
    local tbl9 = {
        CommunityName = if tbl1.name then React.createElement(
            FoundationText,
            {
                LayoutOrder = 1,
                tag = "content-emphasis auto-xy text-heading-small text-wrap text-align-x-left",
                Text = tbl1.name
            }
        ) else nil,
        OwnerName = 0
    }
    local var9

    if tbl1.ownerName then
        local createElement5 = React.createElement
        local var10 = FoundationText
        local tbl10 = {
            LayoutOrder = 2,
            tag = "content-default auto-xy text-body-medium text-wrap text-align-x-left",
            Text = var2.byOwner,
            onActivated = 0
        }

        if not FFlagEnablePressingCommunityOwnerInPeekView then
            var4 = nil
        end

        tbl10.onActivated = var4
        var9 = createElement5(var10, tbl10)
    else
        var9 = nil
    end

    tbl9.OwnerName = var9
    tbl7.Names = createElement4(var8, tbl8, tbl9)
    tbl5.HeaderInformation = createElement3(var7, tbl6, tbl7)

    tbl5.Counts = React.createElement(View, { LayoutOrder = 2, tag = "size-full-0 auto-xy" }, {
        MembersCount = React.createElement(SocialCountsItem, {
            layoutOrder = 1,
            text = text,
            count = abbreviateCount(tbl1.membersCount),
            onActivated = function() end
        })
    })
    tbl3.Container = createElement2(var6, tbl4, tbl5)
    return createElement(var5, tbl2, tbl3)
end

return CommunityProfileHeader
