-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T15:41:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsLanding = script:FindFirstAncestor("FriendsLanding")
local FriendsLandingParent = FriendsLanding.Parent
local dependencies = require(FriendsLanding.dependencies)
local RoactRodux = require(FriendsLandingParent.RoactRodux)
local RoactAppPolicy = require(FriendsLandingParent.UniversalAppPolicy).RoactAppPolicy
local NavigateDown = require(FriendsLandingParent.NavigationRodux).Thunks.NavigateDown
local AppPage = require(FriendsLandingParent.RobloxAppEnums).AppPage

local CoreGui = dependencies.CoreGui
local Roact = dependencies.Roact
local TextService = dependencies.TextService
local UIBlox = dependencies.UIBlox
local withLocalization = dependencies.withLocalization
local Foundation = require(FriendsLandingParent.Foundation)
local Chip = Foundation.Chip
local Enums = Foundation.Enums
local View = Foundation.View
local FoundationText = Foundation.Text

local Images = UIBlox.App.ImageSet.Images
local ImpressionEvents = require(FriendsLanding.FriendsLandingAnalytics.ImpressionEvents)

local Pill = UIBlox.App.Control.Pill
local withStyle = UIBlox.Style.withStyle
local withTooltip = UIBlox.App.Dialog.TooltipV2.withTooltip
local TooltipOrientation = UIBlox.App.Dialog.Enum.TooltipOrientation
local filterStates = require(FriendsLanding.Friends.filterStates)
local PillWithAlert = require(FriendsLanding.Components.PillWithAlert)
local ChipFilterGroup = require(FriendsLanding.Components.ChipFilterGroup)

local IconSize = UIBlox.App.ImageSet.Enum.IconSize
local getIconSize = UIBlox.App.ImageSet.getIconSize

local FFlagFixScalingOnFriendsLanding = require(FriendsLanding.Flags.FFlagFixScalingOnFriendsLanding)
local FFlagConnectionManagementChips = require(FriendsLandingParent.SharedFlags).FFlagConnectionManagementChips
local FFlagSignalsNavP3Dispatch = require(FriendsLandingParent.SharedFlags).FFlagSignalsNavP3Dispatch
local NavigationCommands = if FFlagSignalsNavP3Dispatch then require(FriendsLandingParent.RobloxAppNavigation).NavigationCommands else nil
local FFlagFriendsPageUserListEnabled = require(FriendsLandingParent.SharedFlags).FFlagFriendsPageUserListEnabled

local var1 = Roact.PureComponent:extend("FilterByButton")

var1.defaultProps = {
    analytics = nil,
    layoutOrder = 1,
    onActivated = function() end,
    filter = filterStates.All,
    friendCount = 0,
    inactiveFriendCount = 0,
    isDisabled = false,
    showFriendPruningAlert = false,
    initialShowFriendPruningTooltip = false,
    onTooltipDismissal = function() end
}

function var1.init(arg1)
    arg1.state = {
        showFriendPruningTooltip = arg1.props.initialShowFriendPruningTooltip,
        hasDismissedFriendPruningTooltip = false
    }

    if FFlagConnectionManagementChips then
        arg1.state.canAccessTrustedContacts = arg1.props.canAccessTrustedContacts
    end

    function arg1.convertFilterToTranslation(arg2, arg3)
        if arg2 == filterStates.All then
            return arg3.all
        end

        if arg2 == filterStates.Online then
            return arg3.online
        end

        if arg2 == filterStates.InExperience then
            return arg3.inExperience
        end

        if arg2 == filterStates.Offline then
            return arg3.offline
        end

        if arg2 == filterStates.Inactive then
            return arg3.inactive
        end

        if FFlagConnectionManagementChips and arg2 == filterStates.Trusted then
            return arg3.trusted
        end

        return nil
    end

    function arg1.buildFilterText(arg2, arg3, arg4)
        local var2 = arg1.convertFilterToTranslation(arg2, arg3)

        if arg4 == 0 then
            return var2
        end

        return var2 .. " (" .. arg4 .. ")"
    end

    function arg1.isSelected(all): boolean
        return all ~= filterStates.All
    end

    function arg1.dismissFriendPruningTooltip()
        arg1:setState({ showFriendPruningTooltip = false, hasDismissedFriendPruningTooltip = true })

        arg1.props.onTooltipDismissal()
    end

    if FFlagConnectionManagementChips then
        function arg1.onLearnMoreClicked()
            arg1.props.navigateDown({
                name = AppPage.GenericWebPage,
                detail = "https://en.help.roblox.com/hc/articles/46158344285204",
                extraProps = { title = "" }
            })
        end
    end

    if FFlagConnectionManagementChips then
        function arg1.getTrustedFilterText(arg2)
            return if arg1.props.canAccessTrustedContacts then arg2.doMoreWithTrustedFriends else arg2.trustedFriendsUnavailable
        end
    end
end

function var1.didMount(arg1)
    if arg1.props.initialShowFriendPruningTooltip and arg1.props.analytics then
        arg1.props.analytics:impressionEvent(
            ImpressionEvents.FriendPruningTooltipSeen,
            {
                friendCount = tostring(arg1.props.friendCount),
                inactiveFriendCount = tostring(arg1.props.inactiveFriendCount)
            }
        )
    end
end

function var1.didUpdate(arg1)
    arg1:setState({
        showFriendPruningTooltip = arg1.props.initialShowFriendPruningTooltip and not arg1.state.hasDismissedFriendPruningTooltip
    })
end

function var1.render(arg1)
    return withStyle(function(_)
        local var2 = if FFlagFixScalingOnFriendsLanding then "icons/actions/filter_small" else Images["icons/actions/filter"]
        local tbl1 = {
            all = "Feature.Friends.Label.All",
            inactive = "Feature.Friends.Label.FewestInteractions",
            inExperience = "Feature.Friends.Label.InGame",
            tooltipHeader = "Feature.Friends.Label.ManageFriendsList",
            tooltipBody = "Feature.Friends.Label.ManageFriendsListCaption",
            online = "Common.Presence.Label.Online",
            offline = "Common.Presence.Label.Offline"
        }

        if FFlagConnectionManagementChips then
            tbl1.trusted = "Feature.Friends.TrustedConnection.Label.Trusted"
            tbl1.learnMore = "Feature.Chat.Action.LearnMore"
            tbl1.doMoreWithTrustedFriends = "Feature.Friends.Description.DoMoreWithTrustedFriends"
            tbl1.trustedFriendsUnavailable = "Feature.Friends.Description.TrustedFriendsUnavailable"
        end
        return withLocalization(tbl1)(function(arg2)
            local filter = arg1.props.filter
            local friendCount = arg1.props.friendCount
            local isDisabled = arg1.props.isDisabled
            local onActivated = arg1.props.onActivated
            local text = arg1.buildFilterText(filter, arg2, friendCount)
            local maxWidth, webViewSupported

            if FFlagConnectionManagementChips then
                maxWidth = arg1.props.maxWidth
                webViewSupported = arg1.props.webViewSupported
            else
                maxWidth = nil
                webViewSupported = nil
            end

            local tbl2 = {
                headerText = arg2.tooltipHeader,
                bodyText = arg2.tooltipBody
            }
            local tbl3 = {
                preferredOrientation = TooltipOrientation.Bottom,
                guiTarget = CoreGui,
                active = true,
                DisplayOrder = 2
            }

            local createElement = Roact.createElement
            local str1 = "Frame"
            local tbl4 = {
                AutomaticSize = Enum.AutomaticSize.Y,
                Size = UDim2.new(1, 0, 0, 36),
                LayoutOrder = arg1.props.layoutOrder,
                BackgroundTransparency = 1
            }
            local tbl5 = { Button = 0 }
            local element

            if arg1.state.showFriendPruningTooltip then
                element = withStyle(function(arg3)
                    return withTooltip(tbl2, tbl3, function(arg4)
                        local font = arg3.Font

                        local iconSize = getIconSize(IconSize.Small)
                        local baseSize = font.BaseSize
                        local var3 = font.CaptionHeader.RelativeSize * baseSize
                        local var4 = TextService:GetTextSize(text, var3, font.CaptionHeader.Font, Vector2.new(10000, 10000)).X + 24

                        local createElement2 = Roact.createElement
                        local str2 = "Frame"
                        local tbl6 = {
                            Size = UDim2.fromOffset(var4 + 4 + iconSize, 28),
                            LayoutOrder = arg1.props.layoutOrder,
                            BackgroundTransparency = 1,
                            [Roact.Change.AbsoluteSize] = arg4,
                            [Roact.Change.AbsolutePosition] = arg4
                        }
                        local tbl7 = {
                            PortalToCoreGui = 0,
                            FilterByButtonPillPossiblyWithAlert = 0
                        }
                        local createElement3 = Roact.createElement
                        local portal = Roact.Portal
                        local tbl8 = { target = CoreGui }
                        local tbl9 = { ScreenGui = 0 }
                        local createElement4 = Roact.createElement
                        local tbl10 = {
                            ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
                            DisplayOrder = 1
                        }
                        local tbl11 = {
                            DismissFriendPruningTooltipButton = Roact.createElement("TextButton", {
                                ZIndex = 0,
                                BackgroundTransparency = 1,
                                Size = UDim2.fromScale(1, 1),
                                Text = "",
                                [Roact.Event.Activated] = arg1.dismissFriendPruningTooltip,
                                [Roact.Event.TouchSwipe] = arg1.dismissFriendPruningTooltip,
                                [Roact.Event.MouseWheelForward] = arg1.dismissFriendPruningTooltip,
                                [Roact.Event.MouseWheelBackward] = arg1.dismissFriendPruningTooltip
                            })
                        }
                        tbl9.ScreenGui = createElement4("ScreenGui", tbl10, tbl11)
                        tbl7.PortalToCoreGui = createElement3(portal, tbl8, tbl9)

                        tbl7.FilterByButtonPillPossiblyWithAlert = if arg1.props.showFriendPruningAlert then Roact.createElement(
                            PillWithAlert,
                            {
                                icon = var2,
                                text = text,
                                isDisabled = isDisabled,
                                isSelected = arg1.isSelected(filter),
                                onActivated = onActivated
                            }
                        ) else Roact.createElement(
                            Pill,
                            {
                                icon = var2,
                                text = text,
                                isDisabled = isDisabled,
                                isSelected = arg1.isSelected(filter),
                                onActivated = onActivated
                            }
                        )
                        return createElement2(str2, tbl6, tbl7)
                    end)
                end)
            elseif arg1.props.showFriendPruningAlert then
                element = Roact.createElement(
                    PillWithAlert,
                    {
                        icon = var2,
                        text = text,
                        isDisabled = isDisabled,
                        isSelected = arg1.isSelected(filter),
                        onActivated = onActivated
                    }
                )
            elseif FFlagConnectionManagementChips then
                local createElement2 = Roact.createElement
                local var3 = View
                local tbl6 = {
                    tag = if FFlagFriendsPageUserListEnabled then "auto-y size-full-0 flex-between gap-large padding-top-large" else "auto-y size-full-0 flex-between gap-large padding-top-large padding-bottom-large"
                }

                local tbl7 = {
                    UISizeConstraint = if maxWidth then Roact.createElement("UISizeConstraint", { MaxSize = Vector2.new(maxWidth, math.huge) }) else nil,
                    Layout = Roact.createElement(
                        "UIListLayout",
                        {
                            FillDirection = Enum.FillDirection.Vertical,
                            SortOrder = Enum.SortOrder.LayoutOrder
                        }
                    ),
                    FilterGroup = Roact.createElement(ChipFilterGroup, { onActivated = onActivated, isDisabled = isDisabled, LayoutOrder = 1 }),
                    EducationText = 0
                }
                local element2

                if filterStates.Trusted == filter then
                    element2 = Roact.createElement(View, {
                        tag = "auto-y size-full-0",
                        LayoutOrder = 2
                    }, {
                        Layout = Roact.createElement("UIListLayout", {
                            FillDirection = Enum.FillDirection.Vertical,
                            SortOrder = Enum.SortOrder.LayoutOrder,
                            VerticalAlignment = Enum.VerticalAlignment.Top
                        }),
                        Content = Roact.createElement(FoundationText, {
                            LayoutOrder = 1,
                            tag = "auto-y size-full-0 text-caption-medium text-align-x-left text-align-y-top text-wrap",
                            Text = arg1.getTrustedFilterText(arg2)
                        }),
                        LearnMore = if webViewSupported and arg1.props.canAccessTrustedContacts then Roact.createElement(
                            View,
                            { LayoutOrder = 2, tag = "auto-y size-full-0 padding-top-xsmall" },
                            {
                                Text = Roact.createElement(FoundationText, {
                                    tag = "auto-xy text-caption-medium text-align-x-left text-align-y-top",
                                    RichText = true,
                                    Text = `<u>{arg2.learnMore}</u>`,
                                    onActivated = arg1.onLearnMoreClicked
                                })
                            }
                        ) else nil
                    })
                else
                    element2 = nil
                end

                tbl7.EducationText = element2
                element = createElement2(var3, tbl6, tbl7)
            elseif FFlagFixScalingOnFriendsLanding then
                element = Roact.createElement(Chip, {
                    leading = {
                        name = var2,
                        iconName = Enums.IconName.ThreeBarsHorizontalNarrowing,
                        position = Enums.IconPosition.Left
                    },
                    text = text,
                    isChecked = arg1.isSelected(filter),
                    onActivated = onActivated,
                    isDisabled = isDisabled
                })
            else
                element = Roact.createElement(
                    Pill,
                    {
                        icon = var2,
                        text = text,
                        isDisabled = isDisabled,
                        isSelected = arg1.isSelected(filter),
                        onActivated = onActivated
                    }
                )
            end

            tbl5.Button = element
            return createElement(str1, tbl4, tbl5)
        end)
    end)
end

if not FFlagConnectionManagementChips then
    return var1
end

local var2 = RoactRodux.connect(function(_, _)
    return {}
end, function(arg1)
    return {
        navigateDown = function(arg2)
            if FFlagSignalsNavP3Dispatch then
                return NavigationCommands.down(NavigationCommands.fromLegacyPage(arg2))
            end
            return arg1(NavigateDown(arg2))
        end
    }
end)(var1)

return RoactAppPolicy.connect(function(arg1)
    return {
        webViewSupported = arg1.getWebViewSupport()
    }
end)(var2)
