-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T15:41:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsLanding = script:FindFirstAncestor("FriendsLanding")
local dependencies = require(FriendsLanding.dependencies)

local UIBlox = dependencies.UIBlox
local Roact = dependencies.Roact
local memoize = dependencies.memoize
local TextService = dependencies.TextService
local withLocalization = dependencies.withLocalization

local PartialPageModal = UIBlox.App.Dialog.Modal.PartialPageModal
local SmallRadioButtonGroup = UIBlox.App.Cell.Small.SelectionGroup.SmallRadioButtonGroup
local ButtonType = UIBlox.App.Button.Enum.ButtonType
local withStyle = UIBlox.Style.withStyle

local compose = dependencies.SocialLibraries.RoduxTools.compose

local FriendsLandingAnalytics = require(FriendsLanding.FriendsLandingAnalytics)
local ButtonClickEvents = require(FriendsLanding.FriendsLandingAnalytics.ButtonClickEvents)

local FriendsLandingContext = require(FriendsLanding.FriendsLandingContext)
local makeFilterButtons = require(FriendsLanding.Friends.makeFilterButtons)
local filterStates = require(FriendsLanding.Friends.filterStates)

local navigationParamKeys = require(script.navigationParamKeys)

local InputHandlers = dependencies.InputHandlers
local FocusNavigationUtils = dependencies.FocusNavigationUtils
local FocusNavigableSurfaceWrapper = FocusNavigationUtils.FocusNavigableSurfaceWrapper
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum
local FocusNavigationEventNameEnum = FocusNavigationUtils.FocusNavigationEventNameEnum

local var1 = Roact.PureComponent:extend("FriendsLandingFilter")

var1.defaultProps = { analytics = nil, navigation = nil }

function var1.init(arg1)
    arg1.state = {
        selectedValue = arg1.props.filter
    }

    function arg1.onClose()
        arg1.props.navigation.goBack()
    end

    arg1.focusEventHandlers = {
        [FocusNavigationEventNameEnum.NavigateBack] = {
            handler = InputHandlers.onRelease(function(arg2)
                arg1.onClose()
                arg2:cancel()
            end)
        }
    }

    arg1.onApply = memoize(function(callback)
        return function()
            arg1.props.analytics:buttonClick(ButtonClickEvents.FriendFilterApply, { filter = arg1.state.selectedValue })

            callback(arg1.state.selectedValue)
            arg1.onClose()
            if arg1.state.selectedValue == filterStates.Inactive then
                arg1.onFewestInteractionsSelection()()
            end
        end
    end)

    function arg1.setSelectedValue(selectedValue)
        arg1:setState({ selectedValue = selectedValue })
    end

    function arg1.onCurrentSelected(selectedValue): boolean
        return selectedValue == arg1.state.selectedValue
    end

    function arg1.getAlertPlacement(id, arg2, num1: number, arg3): UDim2
        local num2 = 0
        local str1 = ""

        for i, value in ipairs(arg2) do
            if value.id == id then
                str1 = value.text
                num2 = i
                break
            end
        end

        assert(num2 ~= 0, "getAlertPlacement expects alertFilterId to have an entry in filterButtons")

        local var2 = arg3.Header2.RelativeSize * arg3.BaseSize

        local xOffset = 24 + TextService:GetTextSize(str1, var2, arg3.Header2.Font, Vector2.new(10000, 10000)).X + 12

        local yOffset = (num2 - 1) * 57 + math.floor(28 - num1 / 2)

        return UDim2.fromOffset(xOffset, yOffset)
    end

    function arg1.showInactiveFilterOption()
        if arg1.props.navigation.getParam then
            return (arg1.props.navigation.getParam(navigationParamKeys.ShowInactiveFilterOption))
        end

        return nil
    end

    function arg1.onFewestInteractionsSelection()
        if arg1.props.navigation.getParam then
            return (arg1.props.navigation.getParam(navigationParamKeys.OnFewestInteractionsSelection))
        end

        return nil
    end
end

function var1.render(arg1)
    return withStyle(function(_)
        return withLocalization({
            apply = "CommonUI.Messages.Action.Apply",
            all = "Feature.Friends.Label.All",
            inactive = "Feature.Friends.Label.FewestInteractions",
            inExperience = "Feature.Friends.Label.InGame",
            online = "Common.Presence.Label.Online",
            offline = "Common.Presence.Label.Offline",
            filterBy = "Feature.Friends.Heading.FilterBy",
            upsellNew = "Feature.Catalog.Label.New"
        })(
            function(arg2)
                local items = makeFilterButtons(arg2, arg1.showInactiveFilterOption())
                local modal = Roact.createElement(PartialPageModal, {
                    title = arg2.filterBy,
                    screenSize = arg1.props.screenSize,
                    onCloseClicked = arg1.onClose,
                    marginSize = 0,
                    buttonStackProps = {
                        buttons = {{
                            buttonType = ButtonType.PrimarySystem,
                            props = {
                                isDisabled = arg1.onCurrentSelected(arg1.props.filter),
                                onActivated = arg1.onApply(arg1.props.setFilterKeys),
                                text = arg2.apply
                            }
                        }}
                    }
                }, {
                    ButtonContainer = Roact.createElement(
                        "Frame",
                        {
                            Size = UDim2.new(1, 0, 0, #items * 58 + 20),
                            BackgroundTransparency = 1
                        },
                        {
                            RadioButtons = Roact.createElement(
                                SmallRadioButtonGroup,
                                {
                                    onActivated = arg1.setSelectedValue,
                                    selectedValue = arg1.state.selectedValue,
                                    items = items
                                }
                            )
                        }
                    )
                })
                return (Roact.createElement(FocusNavigableSurfaceWrapper, {
                    surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.PopUp,
                    isIsolated = true,
                    customEventHandlers = arg1.focusEventHandlers
                }, { Modal = modal }))
            end
        )
    end)
end
return compose(FriendsLandingAnalytics.connect(function(analytics)
    return { analytics = analytics }
end), FriendsLandingContext.connect(function(arg1, _)
    return {
        filter = arg1.filter,
        screenSize = arg1.screenSize,
        setFilterKeys = arg1.setFilterKeys
    }
end))(var1)
