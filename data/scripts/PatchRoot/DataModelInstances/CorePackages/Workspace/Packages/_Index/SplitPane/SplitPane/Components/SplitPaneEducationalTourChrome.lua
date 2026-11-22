-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T21:21:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")

local SplitPaneParent = script:FindFirstAncestor("SplitPane").Parent

local React = require(SplitPaneParent.React)
local Foundation = require(SplitPaneParent.Foundation)
local RobloxAppHooks = require(SplitPaneParent.RobloxAppHooks)
local Responsive = require(SplitPaneParent.Responsive)
local UserLib = require(SplitPaneParent.UserLib)

local View = Foundation.View
local Icon = Foundation.Icon
local Image = Foundation.Image
local Skeleton = Foundation.Skeleton
local FoundationText = Foundation.Text
local FoundationProvider = Foundation.FoundationProvider
local IconName = Foundation.Enums.IconName
local ColorMode = Foundation.Enums.ColorMode
local useTokens = Foundation.Hooks.useTokens
local usePreferences = Foundation.Hooks.usePreferences
local useDeviceType = RobloxAppHooks.useDeviceType
local useDeviceInsets = Responsive.useDeviceInsets
local usePreferredInput = Responsive.usePreferredInput
local useLocalization = require(SplitPaneParent.Localization).Hooks.useLocalization
local useSignalState = require(SplitPaneParent.SignalsReact).useSignalState
local useAppPolicy = require(SplitPaneParent.UniversalAppPolicy).useAppPolicy
local LocalUserIdStore = require(SplitPaneParent.LocalUserIdStore).LocalUserIdStore
local getStandardSizeAvatarHeadShotRbxthumb = UserLib.Utils.getStandardSizeAvatarHeadShotRbxthumb
local useAssetFetchStatus = require(SplitPaneParent.RoactUtils).Hooks.useAssetFetchStatus
local VerifiedBadge = require(SplitPaneParent.VerifiedBadges.VerifiedBadge)

local function noOp() end

local function TourProfileChip(tbl1)
    local var1 = useTokens()
    local bool1 = useAssetFetchStatus(tbl1.thumbnail) == Enum.AssetFetchStatus.Success
    local createElement = React.createElement
    local var2 = View
    local tbl2 = {
        tag = "row align-y-center gap-medium size-0-1000 auto-x padding-xsmall radius-medium",
        LayoutOrder = tbl1.layoutOrder,
        testId = "split-pane-educational-tour--profile-chip"
    }
    local tbl3 = {
        AvatarThumbnail = React.createElement(
            View,
            {
                tag = "size-1000-1000 radius-circle",
                backgroundStyle = var1.Color.Common.Shimmer,
                LayoutOrder = 1
            },
            {
                ThumbnailShimmer = if tbl1.isUserLoaded and bool1 then nil else React.createElement(Skeleton, { radius = Foundation.Enums.Radius.Circle, ZIndex = 1 }),
                Thumbnail = React.createElement(Image, { tag = "size-full radius-circle", Image = tbl1.thumbnail, ZIndex = 2 })
            }
        ),
        TextStack = 0
    }

    local createElement2 = React.createElement
    local var3 = View
    local tbl4 = { tag = "auto-xy", LayoutOrder = 2 }
    local tbl5 = {
        DisplayNameRow = React.createElement(View, {
            tag = "row align-y-center gap-small auto-xy",
            LayoutOrder = 1
        }, {
            DisplayNameShimmer = if tbl1.isUserLoaded then nil else React.createElement(
                Skeleton,
                {
                    radius = Foundation.Enums.Radius.Small,
                    Size = UDim2.fromOffset(var1.Size.Size_3000, var1.Size.Size_300)
                }
            ),
            DisplayNameText = if tbl1.isUserLoaded then React.createElement(
                FoundationText,
                {
                    tag = "auto-xy content-inverse-emphasis",
                    fontStyle = var1.Typography.TitleLarge,
                    Text = tbl1.name,
                    LayoutOrder = 1
                }
            ) else nil,
            VerifiedBadge = if tbl1.isUserLoaded and tbl1.isVerified then React.createElement(VerifiedBadge, { size = Foundation.Enums.IconSize.Large, LayoutOrder = 2 }) else nil,
            SubscriberBadge = if tbl1.isUserLoaded and tbl1.showSubscriberBadge then React.createElement(Icon, {
                name = IconName.RobloxPlus,
                size = Foundation.Enums.IconSize.Small,
                style = var1.Inverse.Content.Emphasis,
                LayoutOrder = 3
            }) else nil
        })
    }
    tbl3.TextStack = createElement2(var3, tbl4, tbl5)
    return createElement(var2, tbl2, tbl3)
end

local var1 = React.forwardRef(function(tbl1, ref)
    local var1 = useTokens()
    local var2 = if tbl1.usesOverMediaStyle then var1.Color.ActionOverMedia else var1.Color.ActionUtility
    return React.createElement(View, {
        ref = ref,
        tag = "row align-x-center align-y-center",
        Size = UDim2.fromOffset(var1.Size.Size_1000, var1.Size.Size_1000),
        cornerRadius = UDim.new(0, if tbl1.isCircular then var1.Radius.Circle else var1.Radius.Medium),
        backgroundStyle = var2.Background,
        stroke = var2.Border ~= nil and {
            Color = var2.Border.Color3,
            Transparency = var2.Border.Transparency
        } or nil,
        testId = tbl1.testId,
        LayoutOrder = tbl1.LayoutOrder
    }, {
        Icon = React.createElement(Icon, { name = tbl1.icon, size = var1.Size.Size_600, style = var2.Foreground, LayoutOrder = 1 })
    })
end)

local var2 = React.forwardRef(function(tbl1, ref)
    local var2 = useTokens()
    local actionOverMedia = var2.Color.ActionOverMedia
    return React.createElement(View, {
        ref = ref,
        tag = "row align-x-center align-y-center gap-small padding-medium clip",
        AutomaticSize = Enum.AutomaticSize.X,
        Size = UDim2.fromOffset(0, var2.Size.Size_1000),
        cornerRadius = UDim.new(0, var2.Radius.Medium),
        backgroundStyle = actionOverMedia.Background,
        stroke = actionOverMedia.Border ~= nil
            and {
                Color = actionOverMedia.Border.Color3,
                Transparency = actionOverMedia.Border.Transparency
            }
            or nil,
        testId = tbl1.testId,
        LayoutOrder = tbl1.LayoutOrder
    }, {
        Label = React.createElement(FoundationText, {
            tag = "shrink size-0-full auto-x text-label-medium text-truncate-end",
            Text = tbl1.text,
            textStyle = actionOverMedia.Foreground,
            LayoutOrder = 1
        })
    })
end)

local function getHasRobloxSubscription(player: Player) -- Luacid: Inlined by compiler; 1 call site recovered
    if player == nil then
        return false
    end

    local success, result = pcall(function(): boolean
        return player.HasRobloxSubscription == true
    end)
    return success and result
end

local function TourOwnedSupportPaneChrome(tbl1)
    local var3 = useTokens()
    local device = useDeviceType()
    local preferences = usePreferences()
    local var6 = useDeviceInsets()
    local bool1 = usePreferredInput() == Responsive.Input.Directional
    local var7 = useLocalization({ editAvatarButtonText = "Feature.SplitPane.EditAvatarButtonText" })

    local var8 = useSignalState(LocalUserIdStore.getCurrentUserId)
    local localPlayer = Players.LocalPlayer
    local isUserLoaded = not (localPlayer == nil) and var8 ~= ""
    local showSubscriberBadge = getHasRobloxSubscription(localPlayer)

    local var9 = useAppPolicy(function(arg1)
        return arg1.getShowDisplayName()
    end)

    local function scopedStyle(colorMode) -- Luacid: Inlined by compiler; 4 call sites recovered
        return { colorMode = colorMode, device = device, preferences = preferences }
    end

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        Name = "TourOwnedSupportPaneChrome",
        Position = UDim2.fromOffset(tbl1.supportPaneRect.Min.X, tbl1.supportPaneRect.Min.Y),
        Size = UDim2.fromOffset(
            tbl1.supportPaneRect.Max.X - tbl1.supportPaneRect.Min.X,
            tbl1.supportPaneRect.Max.Y - tbl1.supportPaneRect.Min.Y
        ),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ZIndex = 2
    }

    local tbl3 = {
        InputSink = React.createElement("TextButton", {
            Name = "InputSink",
            Size = UDim2.fromScale(1, 1),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            AutoButtonColor = false,
            Active = true,
            Selectable = false,
            Text = "",
            ZIndex = 2,
            [React.Event.Activated] = noOp
        }),
        Vignette = React.createElement("Frame", {
            Name = "Vignette",
            Position = UDim2.fromOffset(0, -var6.top),
            Size = UDim2.new(1, var6.right, 1, var6.top + var6.bottom),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ZIndex = 3
        }, {
            TopScrim = React.createElement("Frame", {
                Size = UDim2.new(1, 0, 0, 158),
                BackgroundColor3 = Color3.fromRGB(0, 0, 0),
                BackgroundTransparency = 0.1,
                BorderSizePixel = 0
            }, {
                Gradient = React.createElement("UIGradient", {
                    Rotation = 90,
                    Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1) })
                })
            }),
            BottomScrim = React.createElement("Frame", {
                Position = UDim2.new(0, 0, 1, 0),
                AnchorPoint = Vector2.new(0, 1),
                Size = UDim2.new(1, 0, 0, 158),
                BackgroundColor3 = Color3.fromRGB(0, 0, 0),
                BackgroundTransparency = 0.3,
                BorderSizePixel = 0
            }, {
                Gradient = React.createElement("UIGradient", {
                    Rotation = 90,
                    Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 0) })
                })
            })
        }),
        Content = 0
    }

    local createElement2 = React.createElement
    local var10 = View
    local tbl4 = { tag = "size-full-full margin-x-medium padding-y-small", ZIndex = 4 }

    local tbl5 = {
        BottomPaneTooltipAnchor = React.createElement("Frame", {
            ref = tbl1.onBottomPaneTooltipAnchorInstanceChanged,
            Position = UDim2.new(0, 0, 1, var3.Padding.Small),
            AnchorPoint = Vector2.new(0, 1),
            Size = UDim2.new(1, 0, 0, 1),
            BackgroundTransparency = 1,
            BorderSizePixel = 0
        }),
        GamepadStepTwoTooltipAnchor = if bool1 then React.createElement("Frame", {
            Name = "GamepadStepTwoTooltipAnchor",
            ref = tbl1.onGamepadStepTwoTooltipAnchorInstanceChanged,
            Position = UDim2.new(0.5, 0, 1, -16),
            AnchorPoint = Vector2.new(0.5, 0),
            Size = UDim2.fromOffset(1, 1),
            BackgroundTransparency = 1,
            BorderSizePixel = 0
        }) else nil,
        GamepadFinalTooltipAnchor = if bool1 then React.createElement("Frame", {
            Name = "GamepadFinalTooltipAnchor",
            ref = tbl1.onGamepadFinalTooltipAnchorInstanceChanged,
            Position = UDim2.new(0.5, 0, 150 / 217, 0),
            AnchorPoint = Vector2.new(0.5, 0),
            Size = UDim2.fromOffset(1, 1),
            BackgroundTransparency = 1,
            BorderSizePixel = 0
        }) else nil,
        OverMediaScope = 0,
        MiddleAreaScope = 0,
        BottomAreaScope = 0
    }

    local createElement3 = React.createElement
    local var11 = View
    local tbl6 = {
        Size = UDim2.fromScale(1, 1)
    }
    local tbl7 = { OverMediaProvider = 0 }
    local createElement4 = React.createElement
    local var12 = FoundationProvider
    local tbl8 = scopedStyle(ColorMode.Light)
    local tbl9 = { TopArea = 0 }
    local createElement5 = React.createElement
    local var13 = View
    local tbl10 = {
        tag = "row align-y-center anchor-top-center size-full-1200",
        Position = UDim2.new(0.5, 0, 0, tbl1.topInset),
        padding = not bool1 and {
            right = UDim.new(0, -var3.Padding.Small)
        } or nil
    }

    local tbl11 = {
        ProfileChip = React.createElement(TourProfileChip, {
            isUserLoaded = isUserLoaded,
            thumbnail = if isUserLoaded then getStandardSizeAvatarHeadShotRbxthumb(var8) else nil,
            name = if localPlayer then if var9 then localPlayer.DisplayName else localPlayer.Name else nil,
            isVerified = if localPlayer then localPlayer.HasVerifiedBadge else nil,
            showSubscriberBadge = showSubscriberBadge,
            layoutOrder = 1
        }),
        Spacer = React.createElement(View, { tag = "grow auto-y", LayoutOrder = 2 }),
        CollapseButton = 0,
        TopEditAvatarButton = 0
    }
    local element

    if bool1 then
        element = nil
    else
        element = React.createElement(View, {
            AutomaticSize = Enum.AutomaticSize.XY,
            LayoutOrder = 3
        }, {
            DarkScope = React.createElement(FoundationProvider, scopedStyle(ColorMode.Dark), {
                CollapseButton = React.createElement(var1, {
                    ref = tbl1.onTopRightControlInstanceChanged,
                    testId = "split-pane-educational-tour--collapse",
                    icon = IconName.RectangleRightPaneChevronRight,
                    LayoutOrder = 3
                })
            })
        })
    end

    tbl11.CollapseButton = element

    tbl11.TopEditAvatarButton = if bool1 then React.createElement(var2, {
        ref = tbl1.onTopRightControlInstanceChanged,
        testId = "split-pane-educational-tour--top-edit-avatar",
        text = var7.editAvatarButtonText,
        LayoutOrder = 3
    }) else nil
    tbl9.TopArea = createElement5(var13, tbl10, tbl11)
    tbl7.OverMediaProvider = createElement4(var12, tbl8, tbl9)
    tbl5.OverMediaScope = createElement3(var11, tbl6, tbl7)
    local element2

    if bool1 then
        element2 = nil
    else
        element2 = React.createElement(View, {
            Size = UDim2.fromScale(1, 1)
        }, {
            LightScope = React.createElement(FoundationProvider, scopedStyle(ColorMode.Light), {
                MiddleArea = React.createElement(View, {
                    tag = "row position-center-center anchor-center-center size-full-1000"
                }, {
                    Spacer = React.createElement(View, { tag = "grow auto-y", LayoutOrder = 1 }),
                    RightChevron = React.createElement(var1, {
                        testId = "split-pane-educational-tour--next-avatar",
                        icon = IconName.ChevronLargeRight,
                        isCircular = true,
                        usesOverMediaStyle = true,
                        LayoutOrder = 3
                    })
                })
            })
        })
    end

    tbl5.MiddleAreaScope = element2
    local element3

    if bool1 then
        element3 = nil
    else
        element3 = React.createElement(View, {
            Size = UDim2.fromScale(1, 1)
        }, {
            LightScope = React.createElement(FoundationProvider, scopedStyle(ColorMode.Light), {
                BottomArea = React.createElement(
                    View,
                    {
                        tag = "row align-x-center position-bottom-center anchor-bottom-center size-full-1200 padding-bottom-small"
                    },
                    {
                        EditAvatarButton = React.createElement(var2, { testId = "split-pane-educational-tour--edit-avatar", text = var7.editAvatarButtonText })
                    }
                )
            })
        })
    end

    tbl5.BottomAreaScope = element3
    tbl3.Content = createElement2(var10, tbl4, tbl5)
    return createElement(str1, tbl2, tbl3)
end

return TourOwnedSupportPaneChrome
