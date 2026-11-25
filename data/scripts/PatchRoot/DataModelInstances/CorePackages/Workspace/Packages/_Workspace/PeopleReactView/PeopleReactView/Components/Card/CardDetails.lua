-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T01:21:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local GuiService = game:GetService("GuiService")

local PeopleReactView = script:FindFirstAncestor("PeopleReactView")
local PeopleReactViewParent = PeopleReactView.Parent

local React = require(PeopleReactViewParent.React)
local SignalsReact = require(PeopleReactViewParent.SignalsReact)

local formatUsername = require(PeopleReactViewParent.UserProfiles).Formatters.formatUsername

local Foundation = require(PeopleReactViewParent.Foundation)
local ButtonVariant = Foundation.Enums.ButtonVariant
local ControlState = Foundation.Enums.ControlState
local IconName = Foundation.Enums.IconName
local IconVariant = Foundation.Enums.IconVariant
local InputSize = Foundation.Enums.InputSize
local StateLayerAffordance = Foundation.Enums.StateLayerAffordance
local IconButton = Foundation.IconButton
local FoundationText = Foundation.Text
local View = Foundation.View

local ConnectButton = require(PeopleReactView.Components.Card.ConnectButton)

local PersonButtonConfigs = require(PeopleReactView.Configs.PersonButtonConfigs)
local useGetPeopleService = require(PeopleReactView.Hooks.useGetPeopleService)
local useInExperienceCombinedName = require(PeopleReactView.Hooks.useInExperienceCombinedName)
local useIsComponentInputEnded = require(PeopleReactView.Hooks.useIsComponentInputEnded)

local engineFeature = game:GetEngineFeature("RbxAnalyticsServiceExposePlaySessionId")

local SharedFlags = require(PeopleReactViewParent.SharedFlags)
local FFlagAddIEMProfilePage = SharedFlags.FFlagAddIEMProfilePage
local FFlagSideSheetOpenPeoplePage = SharedFlags.FFlagSideSheetOpenPeoplePage

return React.memo(function(tbl1) -- name: CardDetails
    local ref = React.useRef(nil)
    local var2 = if FFlagAddIEMProfilePage then useGetPeopleService("PeopleAnalyticsManager") else nil
    local var3 = if FFlagAddIEMProfilePage then useGetPeopleService("SettingsHubService") else nil
    local var4 = useInExperienceCombinedName(tbl1.person.UserId, tbl1.person.DisplayName)

    local var5 = useIsComponentInputEnded(ref)

    local var6, var7 = React.useState(false)

    local onStateChanged = React.useCallback(function(arg1)
        var7(arg1 == ControlState.Hover or arg1 == ControlState.Pressed)
    end, {})

    local var9 = nil
    local var10, var11, var12

    if FFlagSideSheetOpenPeoplePage then
        var10 = nil
        var11 = nil
        var12 = nil
    else
        local var13 = useGetPeopleService("FriendStatusStore")
        local var14 = useGetPeopleService("Constants")

        local var15 = PersonButtonConfigs(tbl1.person.UserId)

        var9 = React.useMemo(function()
            return var15[var14.PERSON_BUTTONS.ADD_FRIEND]
        end, { var15 })

        local var16 = SignalsReact.useSignalState(var13.getFriendStatus(tbl1.person.UserId))

        local var17 = SignalsReact.useSignalState(var13.getIsFriendButtonGrayedOut(tbl1.person.UserId))

        var10 = React.useMemo(function()
            if var16 then
                return {
                    name = IconName.PersonCheck,
                    variant = IconVariant.Filled
                }
            end

            if var17 then
                return {
                    name = IconName.Clock,
                    variant = IconVariant.Filled
                }
            end

            return {
                name = IconName.PersonPlus,
                variant = IconVariant.Regular
            }
        end, { var16, var17 })

        var11 = SignalsReact.useSignalState(var13.getIsFriendButtonDisabled(tbl1.person.UserId))

        var12 = React.useCallback(function()
            var9.onActivated(var14.ANALYTICS.ENTRY_POINT.PEOPLE_CARD)
        end, { var9.onActivated })
    end

    local var13 = if FFlagAddIEMProfilePage then React.useCallback(function()
        local var13 = var3.hubRef()
        if not var13 then
            return
        end

        var13:SwitchToReactPage(var13.PlayerProfilePage, {
            userId = tbl1.person.UserId,
            inspectAvatar = function()
                local playSessionId = if engineFeature then RbxAnalyticsService:GetPlaySessionId() else nil
                var2:trackInspectButton(game.GameId, playSessionId, "player_profile")

                GuiService:InspectPlayerFromUserIdWithCtx(tbl1.person.UserId, "playerProfile")
                var13:SetVisibility(false)
            end,
            closePage = function()
                var13:CloseReactPage()
            end
        })
    end, {}) else nil

    local element

    if FFlagSideSheetOpenPeoplePage then
        if tbl1.isCompactCardLayout then
            element = nil
        else
            element = React.createElement(ConnectButton, { person = tbl1.person, layoutOrder = 2, onStateChanged = onStateChanged })
        end
    else
        local createElement = React.createElement
        local var14 = View
        local tbl2 = {
            AutomaticSize = Enum.AutomaticSize.XY,
            LayoutOrder = 2,
            stateLayer = {
                affordance = StateLayerAffordance.None
            },
            onStateChanged = onStateChanged
        }
        local tbl3 = {
            ConnectButton = React.createElement(IconButton, {
                icon = var10,
                variant = if var11 then ButtonVariant.Utility else ButtonVariant.Standard,
                size = InputSize.Medium,
                isDisabled = var11,
                Visible = var9.shouldShow(),
                onActivated = var12
            })
        }
        element = createElement(var14, tbl2, tbl3)
    end

    local createElement = React.createElement
    local var14 = View
    local tbl2 = {
        tag = "row size-full-1400 align-y-center padding-x-small radius-medium",
        LayoutOrder = tbl1.layoutOrder,
        stateLayer = {
            affordance = if var6 or var5 then StateLayerAffordance.None else StateLayerAffordance.Background
        },
        onActivated = 0,
        ref = 0
    }

    if not FFlagAddIEMProfilePage then
        var13 = nil
    end

    tbl2.onActivated = var13
    tbl2.ref = ref
    return createElement(var14, tbl2, {
        NameContainer = React.createElement(View, { tag = "col fill auto-y", LayoutOrder = 1 }, {
            Name = React.createElement(FoundationText, {
                tag = "size-full-0 auto-y content-emphasis text-title-medium text-align-x-left text-truncate-end padding-right-small",
                Text = var4,
                LayoutOrder = 1
            }),
            Handle = React.createElement(FoundationText, {
                tag = "size-full-0 auto-y content-default text-body-medium text-align-x-left text-truncate-end padding-right-small",
                Text = formatUsername(tbl1.person.Name),
                LayoutOrder = 2
            })
        }),
        ConnectButtonBackground = element
    })
end)
