-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:31:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local BuilderIcons = require(MomentsParent.BuilderIcons)
local Foundation = require(MomentsParent.Foundation)
local MomentsCommon = require(MomentsParent.MomentsCommon)
local React = require(MomentsParent.React)
local HeaderBar = require(MomentsParent.UIBlox).App.Bar.HeaderBar
local Chip = Foundation.Chip
local Coachmark = Foundation.Coachmark
local IconButton = Foundation.IconButton
local FoundationText = Foundation.Text
local View = Foundation.View

local ButtonVariant = Foundation.Enums.ButtonVariant
local ChipSize = Foundation.Enums.ChipSize
local ChipVariant = Foundation.Enums.ChipVariant
local InputSize = Foundation.Enums.InputSize

local PlusLarge = BuilderIcons.Icon.PlusLarge
local ChevronLargeLeft = BuilderIcons.Icon.ChevronLargeLeft
local CirclePerson = BuilderIcons.Icon.CirclePerson

local GradientBackdrop = MomentsCommon.Components.GradientBackdrop
local FlyoutLeftHeader = require(MomentsParent.FlyoutSidePanel).Components.FlyoutLeftHeader
local FlyoutSidePanelIXP = require(MomentsParent.SharedExperimentDefinition).FlyoutSidePanelIXP
local CreationMenuContainer = require(Moments.Components.CreationMenuContainer)
local NavigationMenu = require(Moments.Components.NavigationMenu)

local Constants = require(Moments.Constants)
local FFlagMomentsCreateAvatarPosts = require(MomentsParent.SharedFlags).FFlagMomentsCreateAvatarPosts
local FFlagMomentsFtuxTooltipCreateCopy = require(Moments.Flags.FFlagMomentsFtuxTooltipCreateCopy)
local FFlagMomentsFixFeedForDeviceSafeInsets = require(Moments.Flags.FFlagMomentsFixFeedForDeviceSafeInsets)
local shouldUseDeviceSafeInsets = require(MomentsParent.Display).shouldUseDeviceSafeInsets

local FFlagMomentsCreationFeatureGate = require(MomentsParent.SharedFlags).FFlagMomentsCreationFeatureGate

local function renderFeedTypeChips(feedTypeChips)
    local tbl1 = ({})
    for layoutOrder, feedTypeChip in feedTypeChips do
        local str1 = `Chip_{feedTypeChip.id}`
        tbl1[str1] = React.createElement(Chip, {
            LayoutOrder = layoutOrder,
            text = feedTypeChip.text,
            isChecked = feedTypeChip.isChecked,
            onActivated = feedTypeChip.onActivated,
            size = ChipSize.Medium,
            variant = ChipVariant.Standard,
            testId = `--moments-header--feed-chip--{feedTypeChip.id}`
        })
    end
    return React.createElement(
        View,
        {
            LayoutOrder = 2,
            tag = "row align-y-center gap-small auto-xy",
            testId = "--moments-header--feed-chips"
        },
        tbl1
    )
end

local function renderAction(str1: string, icon, onActivated: (...any) -> (...any), layoutOrder: number?)
    return React.createElement(IconButton, {
        LayoutOrder = layoutOrder,
        icon = icon,
        onActivated = onActivated,
        variant = ButtonVariant.Utility,
        size = InputSize.Medium,
        isCircular = true,
        Selectable = true,
        testId = `--moments-header--actions--{str1}`
    })
end

local function renderCreateAction(tbl1, layoutOrder: number)
    if tbl1.onCreateAvatarMomentPressed == nil then
        return renderAction("create", PlusLarge, tbl1.onCreateMomentButtonPressed, layoutOrder)
    end

    return React.createElement(CreationMenuContainer, {
        layoutOrder = layoutOrder,
        testId = "--moments-menu-creation",
        buttonTestId = "--moments-header--actions--create",
        buttonVariant = ButtonVariant.Utility,
        onCreateFromCaptures = tbl1.onCreateMomentButtonPressed,
        onCreateFromAvatar = tbl1.onCreateAvatarMomentPressed,
        onTriggerActivated = if tbl1.showFtuxTooltip then tbl1.onFtuxTooltipClosed else nil
    })
end

local function MomentsHeaderView(tbl1)
    local var1 = nil
    local var2 = nil
    local var3 = nil

    if tbl1.variant == "back" then
        var1 = function()
            return renderAction("back", ChevronLargeLeft, tbl1.onBack, 1)
        end
        if tbl1.showInteractiveButtons and tbl1.showNavigationMenu then
            local tbl2 = {}
            if tbl1.showCreateButton then
                local element

                if FFlagMomentsCreateAvatarPosts then
                    element = renderCreateAction(tbl1, 1)
                else
                    local icon = PlusLarge
                    local onCreateMomentButtonPressed = tbl1.onCreateMomentButtonPressed
                    element = React.createElement(IconButton, {
                        LayoutOrder = 1,
                        icon = icon,
                        onActivated = onCreateMomentButtonPressed,
                        variant = ButtonVariant.Utility,
                        size = InputSize.Medium,
                        isCircular = true,
                        Selectable = true,
                        testId = "--moments-header--actions--create"
                    })
                end

                tbl2.CreateMomentButton = element
            end
            tbl2.NavigationMenu = React.createElement(NavigationMenu, {
                layoutOrder = 2,
                buttonTestId = "--moments-header--actions--more",
                buttonVariant = ButtonVariant.Utility,
                onNavigateToTrending = tbl1.onNavigateToTrending,
                onNavigateToMyMoments = tbl1.onNavigateToMyMoments
            })

            var2 = function()
                return React.createElement(View, { tag = "row align-y-center gap-xsmall auto-xy" }, tbl2)
            end
        elseif tbl1.showInteractiveButtons and tbl1.showCreateButton then
            var2 = function()
                if FFlagMomentsCreateAvatarPosts then
                    return (renderCreateAction(tbl1, 1))
                end

                local icon = PlusLarge
                local onCreateMomentButtonPressed = tbl1.onCreateMomentButtonPressed
                return (React.createElement(IconButton, {
                    LayoutOrder = 1,
                    icon = icon,
                    onActivated = onCreateMomentButtonPressed,
                    variant = ButtonVariant.Utility,
                    size = InputSize.Medium,
                    isCircular = true,
                    Selectable = true,
                    testId = "--moments-header--actions--create"
                }))
            end
        end
    elseif tbl1.variant == "base" then
        if tbl1.feedTypeChips ~= nil then
            var3 = renderFeedTypeChips(tbl1.feedTypeChips)
        end
        local isFlyoutEntrypointEnabled = FlyoutSidePanelIXP.isFlyoutSidePanelEnabled()
        local var5 = tbl1.showInteractiveButtons and tbl1.showHamburger and isFlyoutEntrypointEnabled

        var1 = function()
            if var5 then
                return React.createElement(FlyoutLeftHeader, {
                    titleText = tbl1.title,
                    isRobloxLogoEnabled = false,
                    isFlyoutEntrypointEnabled = isFlyoutEntrypointEnabled,
                    isAlternateEntryPointEnabled = FlyoutSidePanelIXP.isAlternateEntryPointEnabled()
                })
            end

            return React.createElement(View, { tag = "row align-x-left align-y-center auto-xy" }, {
                Title = React.createElement(
                    FoundationText,
                    {
                        Text = tbl1.title,
                        textStyle = tbl1.titleTextStyle,
                        tag = "auto-xy text-heading-large"
                    }
                )
            })
        end

        if tbl1.showInteractiveButtons then
            local element = nil
            if tbl1.showCreateButton or not FFlagMomentsCreationFeatureGate then
                local element2

                if FFlagMomentsCreateAvatarPosts then
                    element2 = renderCreateAction(tbl1, 1)
                else
                    local icon = PlusLarge
                    local onCreateMomentButtonPressed = tbl1.onCreateMomentButtonPressed
                    element2 = React.createElement(IconButton, {
                        LayoutOrder = 1,
                        icon = icon,
                        onActivated = onCreateMomentButtonPressed,
                        variant = ButtonVariant.Utility,
                        size = InputSize.Medium,
                        isCircular = true,
                        Selectable = true,
                        testId = "--moments-header--actions--create"
                    })
                end

                if FFlagMomentsCreateAvatarPosts or tbl1.showFtuxTooltip then
                    local tbl2 = {
                        LayoutOrder = 1,
                        isOpen = tbl1.showFtuxTooltip,
                        onClose = tbl1.onFtuxTooltipClosed,
                        side = Foundation.Enums.PopoverSide.Bottom,
                        title = if FFlagMomentsFtuxTooltipCreateCopy then tbl1.ftuxTooltipTitle else "Share Your First Moment",
                        text = if FFlagMomentsFtuxTooltipCreateCopy then tbl1.ftuxTooltipText else "Tap + to share a moment from your captures",
                        align = Foundation.Enums.PopoverAlign.End
                    }
                    element = React.createElement(Coachmark, tbl2, element2)
                else
                    element = React.createElement(View, { LayoutOrder = 1, tag = "auto-xy" }, { Action = element2 })
                end
            end

            var2 = function()
                local createElement = React.createElement
                local var6 = View
                local tbl2 = { tag = "row align-y-center gap-xsmall auto-xy" }

                local tbl3 = {
                    CreateMomentButton = element,
                    MyMomentsButton = 0,
                    NavigationMenu = 0
                }
                local element2

                if tbl1.showMyMomentsButton then
                    local icon = CirclePerson
                    local onNavigateToMyMoments = tbl1.onNavigateToMyMoments
                    element2 = React.createElement(IconButton, {
                        LayoutOrder = 2,
                        icon = icon,
                        onActivated = onNavigateToMyMoments,
                        variant = ButtonVariant.Utility,
                        size = InputSize.Medium,
                        isCircular = true,
                        Selectable = true,
                        testId = "--moments-header--actions--my-moments"
                    })
                else
                    element2 = nil
                end

                tbl3.MyMomentsButton = element2

                tbl3.NavigationMenu = if tbl1.showMyMomentsButton then nil else React.createElement(NavigationMenu, {
                    layoutOrder = 2,
                    buttonTestId = "--moments-header--actions--more",
                    buttonVariant = ButtonVariant.Utility,
                    onNavigateToTrending = tbl1.onNavigateToTrending,
                    onNavigateToMyMoments = tbl1.onNavigateToMyMoments
                })
                return createElement(var6, tbl2, tbl3)
            end
        end
    elseif tbl1.variant == "close" then
        var2 = function()
            return renderAction("close", "icons/navigation/close_small", tbl1.onClose, 1)
        end
    end

    local tbl2 = {
        HeaderContent = React.createElement(
            View,
            { tag = "size-full-0 auto-y", testId = "--moments-header-content", ZIndex = 2 },
            {
                SafeAreaContent = React.createElement(View, {
                    padding = tbl1.headerPadding,
                    tag = {
                        ["size-full-0 auto-y"] = true,
                        col = var3 ~= nil
                    },
                    testId = "--moments-header-safe-area"
                }, {
                    FeedTypeChips = var3,
                    HeaderBarContainer = React.createElement(View, {
                        LayoutOrder = 1,
                        tag = "size-full-0 auto-y",
                        Size = UDim2.new(1, 0, 0, tbl1.headerHeight),
                        testId = "--moments-header"
                    }, {
                        HeaderBar = React.createElement(HeaderBar, {
                            barHeight = tbl1.headerHeight,
                            isTitleCentered = false,
                            isOnMedia = false,
                            backgroundTransparency = 1,
                            paddingLeft = UDim.new(0, 0),
                            paddingRight = UDim.new(0, 0),
                            renderLeft = var1,
                            renderRight = var2,
                            zIndex = 2
                        })
                    })
                })
            }
        )
    }
    if tbl1.showTopScrim then
        tbl2.GradientScrim = React.createElement(GradientBackdrop, {
            color3 = Color3.new(0, 0, 0),
            startingTransparency = 0.4,
            endingTransparency = 1,
            rotation = 90,
            position = if FFlagMomentsFixFeedForDeviceSafeInsets and shouldUseDeviceSafeInsets then UDim2.fromOffset(0, tbl1.scrimTopOffset or 0) else UDim2.fromScale(0, 0),
            size = UDim2.new(1, 0, 0, tbl1.scrimHeight),
            zIndex = 1
        })
    end

    return React.createElement(View, {
        LayoutOrder = tbl1.layoutOrder,
        tag = "size-full-0",
        testId = "--moments-header-root",
        ZIndex = Constants.DisplayOrder.FeedTopBar
    }, tbl2)
end

return MomentsHeaderView
