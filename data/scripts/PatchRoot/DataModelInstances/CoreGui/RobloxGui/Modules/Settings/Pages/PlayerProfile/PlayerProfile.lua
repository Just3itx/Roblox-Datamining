-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:11:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Players = game:GetService("Players")

local React = require(CorePackages.Packages.React)
local SignalsReact = require(CorePackages.Packages.SignalsReact)

local Foundation = require(CorePackages.Packages.Foundation)
local useTokens = Foundation.Hooks.useTokens
local IconName = Foundation.Enums.IconName
local Visibility = Foundation.Enums.Visibility
local IconButton = Foundation.IconButton
local ScrollView = Foundation.ScrollView
local FoundationText = Foundation.Text
local View = Foundation.View

local RobloxAppEnums = require(CorePackages.Workspace.Packages.RobloxAppEnums)
local useDeviceOrientation = require(CorePackages.Workspace.Packages.RobloxAppHooks).useDeviceOrientation

local Responsive = require(CorePackages.Workspace.Packages.Responsive)
local useBreakpointXOrLarger = Responsive.useBreakpointXOrLarger

local useDispatch = require(CorePackages.Workspace.Packages.RoactUtils).Hooks.RoactRodux.useDispatch

local PeopleService = require(CorePackages.Workspace.Packages.PeopleService)
local Enums = require(CorePackages.Workspace.Packages.ProfilePlatform.Enums)
local CurrentlyWearing = require(CorePackages.Workspace.Packages.ProfilePlatform.CurrentlyWearing)
local getProfilePlatform = require(CorePackages.Workspace.Packages.ProfilePlatform.getProfilePlatform)
local useDynamicSizeMargin = require(CorePackages.Workspace.Packages.ProfilePlatform.useDynamicSizeMargin)
local ProfileWrapperContext = require(CorePackages.Workspace.Packages.ProfilePlatform.ProfileWrapperContext)

local FFlagProfilePlatformGracefulVisibility = require(CorePackages.Workspace.Packages.ProfilePlatform.FFlagProfilePlatformGracefulVisibility)

local AddConnectionButton = require(script.Parent.AddConnectionButton)
local ProfileHeader = require(script.Parent.ProfileHeader)

return React.memo(function(tbl1)
    local var1 = useTokens()

    local var2 = React.useContext(ProfileWrapperContext)
    local profileId = var2.profileId
    local profileType = var2.profileType

    local var3 = React.useMemo(function()
        return PeopleService.getService("FriendStatusStore")
    end, {})

    local var4 = React.useMemo(function()
        if tbl1.userId then
            return (Players:GetPlayerByUserId(tbl1.userId))
        end

        return nil
    end, { tbl1.userId })

    local var5 = SignalsReact.useSignalState(var3.getShouldShowFriendButton(tbl1.userId, var4))

    local var6 = useDeviceOrientation()
    local var7 = useBreakpointXOrLarger(Responsive.Keys.Medium)
    local bool1 = var6 == RobloxAppEnums.DeviceOrientationMode.Portrait and not var7

    local offset, onAbsoluteSizeChanged = useDynamicSizeMargin()

    local var9, var10 = React.useState(true)
    local var11, var12 = React.useState(false)

    local var13 = useDispatch()

    React.useEffect(function()
        local components = {
            {
                component = Enums.Components.CurrentlyWearing
            },
            {
                component = Enums.Components.UserProfileHeader
            }
        }

        if FFlagProfilePlatformGracefulVisibility then
            table.insert(components, { component = Enums.Components.Friends })
        end

        var13(
            getProfilePlatform.API({
                profileId = profileId,
                profileType = profileType,
                components = components,
                includeComponentOrdering = false,
                onlyEssentialComponents = not FFlagProfilePlatformGracefulVisibility or nil
            })
        ):andThen(
            function(_)
                var10(false)
                var12(false)
            end
        ):catch(
            function(_)
                var10(false)
                var12(true)
            end
        )
    end, { profileId, profileType })

    if var9 then
        return nil
    end

    if var11 then
        return React.createElement(View, { tag = "size-full col" }, {
            BackBar = React.createElement(
                View,
                { tag = "size-full-0 auto-y row padding-xsmall", LayoutOrder = 1 },
                {
                    BackButton = React.createElement(IconButton, { icon = IconName.ChevronLargeLeft, onActivated = tbl1.closePage })
                }
            ),
            ErrorMessage = React.createElement(
                FoundationText,
                {
                    tag = "size-full-0 auto-y content-default text-title-medium",
                    Text = "Error loading profile",
                    LayoutOrder = 2
                }
            )
        })
    end

    local createElement = React.createElement
    local var14 = View
    local tbl2 = {
        tag = "size-full padding-bottom-medium",
        onAbsoluteSizeChanged = onAbsoluteSizeChanged
    }
    local tbl3 = {
        BackBar = React.createElement(
            View,
            { tag = "size-full-0 auto-y row padding-xsmall", LayoutOrder = 1 },
            {
                BackButton = React.createElement(IconButton, { icon = IconName.ChevronLargeLeft, onActivated = tbl1.closePage })
            }
        ),
        ScrollView = 0
    }

    local createElement2 = React.createElement
    local var15 = ScrollView
    local tbl4 = {
        tag = "size-full",
        scroll = {
            scrollBarVisibility = Visibility.Auto,
            ScrollingDirection = Enum.ScrollingDirection.Y,
            CanvasSize = UDim2.fromScale(1, 0),
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
            VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar
        },
        layout = {
            FillDirection = Enum.FillDirection.Vertical,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, var1.Padding.XXLarge)
        },
        padding = {
            top = UDim.new(0, 48)
        },
        LayoutOrder = 2
    }

    local tbl5 = { ProfileHeaderContainer = 0, CurrentlyWearingCarousel = 0 }
    local createElement3 = React.createElement
    local var16 = View
    local tbl6 = {
        tag = { ["size-full-0 auto-y"] = true, ["col gap-xxlarge"] = bool1 },
        LayoutOrder = 1
    }

    local tbl7 = {
        ProfileHeader = React.createElement(ProfileHeader, { profileId = profileId, layoutOrder = 1 }),
        AddConnectionButtonContainer = 0
    }
    local element

    if var5 then
        element = React.createElement(
            View,
            {
                tag = {
                    ["size-full-0 auto-y"] = bool1,
                    ["size-2500-2200 row align-y-center"] = not (bool1 or var7),
                    ["size-3000-2200 row align-y-center"] = not bool1 and var7
                },
                padding = bool1 and {
                    left = UDim.new(0, offset),
                    right = UDim.new(0, offset)
                } or nil,
                AnchorPoint = Vector2.new(1, 0),
                Position = UDim2.new(1, -offset, 0, 0),
                ZIndex = 2,
                LayoutOrder = 2
            },
            {
                AddConnectionButton = React.createElement(AddConnectionButton, { userId = tbl1.userId })
            }
        )
    else
        element = nil
    end

    tbl7.AddConnectionButtonContainer = element
    tbl5.ProfileHeaderContainer = createElement3(var16, tbl6, tbl7)

    tbl5.CurrentlyWearingCarousel = React.createElement(CurrentlyWearing, { layoutOrder = 3 })
    tbl3.ScrollView = createElement2(var15, tbl4, tbl5)
    return createElement(var14, tbl2, tbl3)
end)
