-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T00:51:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TrustedContactsParent = script:FindFirstAncestor("TrustedContacts").Parent

local React = require(TrustedContactsParent.React)

local PeekView = require(TrustedContactsParent.PeekView)
local PeekView2 = PeekView.PeekView
local PeekViewState = PeekView.PeekViewState

local useDispatch = require(TrustedContactsParent.RoactUtils).Hooks.RoactRodux.useDispatch

local UIBlox = require(TrustedContactsParent.UIBlox)
local InteractiveAlert = UIBlox.App.Dialog.Alert.InteractiveAlert
local ButtonType = UIBlox.App.Button.Enum.ButtonType

local Foundation = require(TrustedContactsParent.Foundation)
local View = Foundation.View
local FoundationText = Foundation.Text
local InputLabel = Foundation.InputLabel
local InputLabelSize = Foundation.Enums.InputLabelSize

local Responsive = require(TrustedContactsParent.Responsive)
local usePreferredInput = Responsive.usePreferredInput

local useScreenSize = require(TrustedContactsParent.RobloxAppHooks).useScreenSize
local useNavigation = require(TrustedContactsParent.Navigation).useNavigation
local useLocalization = require(TrustedContactsParent.Localization).Hooks.useLocalization

local AppPage = require(TrustedContactsParent.RobloxAppEnums).AppPage
local NavigateDown = require(TrustedContactsParent.NavigationRodux).Thunks.NavigateDown
local FFlagSignalsNavP3Dispatch = require(TrustedContactsParent.SharedFlags).FFlagSignalsNavP3Dispatch
local NavigationCommands = if FFlagSignalsNavP3Dispatch then require(TrustedContactsParent.RobloxAppNavigation).NavigationCommands else nil
local useAppPolicy = require(TrustedContactsParent.UniversalAppPolicy).useAppPolicy

local Analytics = require(script.Parent.Parent.Parent.Analytics)
local useTCAnalytics = Analytics.useTCAnalytics
local EventNames = Analytics.EventNames

local bool1 = game:DefineFastFlag("FriendsRenameModalUnboldText", false)

local function FriendsRenameInfoModal()
    local var1 = usePreferredInput()
    local var2 = useDispatch()
    local screenSize = useScreenSize()
    local var4 = useNavigation()

    local fireAnalyticsEvent = useTCAnalytics().fireAnalyticsEvent

    React.useEffect(function()
        fireAnalyticsEvent(EventNames.FriendsRenameInfoModalSeen)
    end, {})

    local bool2 = var1 ~= Responsive.Input.Touch

    local var5 = useLocalization({
        gotIt = "Feature.Avatar.Action.GotIt",
        learnMore = "Feature.Chat.Action.LearnMore",
        introducingConnections = "Feature.Friends.Label.IntroducingConnections",
        renameInfoText = "Feature.Friends.Label.RenameInfoText"
    })

    local onActivated = React.useCallback(function()
        var4.pop()
    end, { var4 })

    local viewStateChanged = React.useCallback(function(arg1, _)
        if arg1 == PeekViewState.Closed or arg1 == PeekViewState.Hidden then
            var4.goBack()
        end
    end, { var4 })

    local var8 = useAppPolicy(function(arg1)
        return arg1.getWebViewSupport()
    end)

    local var3 = React.useCallback(function()
        fireAnalyticsEvent(EventNames.FriendsRenameLearnMoreClicked)
        local tbl1 = {
            name = AppPage.GenericWebPage,
            detail = "https://en.help.roblox.com/hc/en-us/articles/37725513985812",
            extraProps = { title = "" }
        }

        if FFlagSignalsNavP3Dispatch then
            NavigationCommands.down(NavigationCommands.fromLegacyPage(tbl1))
            return
        end
        var2(NavigateDown(tbl1, nil))
    end, { var2 })

    local introducingConnections = var5.introducingConnections
    local title = React.useMemo(function()
        return React.createElement(FoundationText, {
            LayoutOrder = 1,
            tag = "auto-y size-full-0 text-align-x-left text-wrap text-heading-small",
            Text = introducingConnections
        })
    end, { introducingConnections })

    local middleContent = React.useCallback(function()
        local createElement = React.createElement
        local var11 = View
        local tbl1 = {
            tag = "col size-full-0 auto-y gap-small padding-0",
            ["align-x-left"] = not bool2,
            ["align-x-center"] = bool2,
            LayoutOrder = 2
        }
        local tbl2 = {
            BodyText = React.createElement(if bool1 then FoundationText else InputLabel, {
                LayoutOrder = 1,
                tag = if bool1 then "auto-y size-full-0 text-wrap grow text-align-x-left" else "auto-y size-full-0 text-wrap grow",
                RichText = true,
                size = if bool1 then nil else InputLabelSize.Large,
                Text = var5.renameInfoText
            }),
            LearnMoreWebLink = var8
                and React.createElement(if bool1 then FoundationText else InputLabel, {
                    LayoutOrder = 2,
                    tag = if bool1 then "auto-y size-full-0 text-align-x-left" else "auto-y size-full-0",
                    RichText = true,
                    Text = `<u>{var5.learnMore}</u>`,
                    size = if bool1 then nil else InputLabelSize.Large,
                    onActivated = var3
                })
        }
        return createElement(var11, tbl1, tbl2)
    end, { var3, var5, bool2 })

    if bool2 then
        return (React.createElement(InteractiveAlert, {
            richText = true,
            screenSize = screenSize,
            title = introducingConnections,
            middleContent = middleContent,
            buttonStackInfo = {
                buttons = {{
                    buttonType = ButtonType.Secondary,
                    props = {
                        onActivated = onActivated,
                        text = var5.gotIt
                    }
                }}
            }
        }))
    end

    return (React.createElement(PeekView2, {
        briefViewContentHeight = UDim.new(0, 0),
        hasScrim = true,
        mountAsFullView = true,
        returnToFullView = true,
        showDraggerInClosedState = false,
        thumbstickScrollEnabled = true,
        viewStateChanged = viewStateChanged
    }, {
        Contents = React.createElement(
            View,
            { tag = "col size-full-0 auto-y gap-small padding-xxlarge align-x-left" },
            {
                Title = title,
                TextContent = middleContent()
            }
        )
    }))
end

return FriendsRenameInfoModal
