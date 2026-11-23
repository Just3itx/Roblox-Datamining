-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:30:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local CreatorAgentChat = require(BuildExperienceParent.DataHydration.CreatorAgentChat)
local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)
local ReactRoblox = require(BuildExperienceParent.ReactRoblox)
local SignalsReact = require(BuildExperienceParent.SignalsReact)
local LocalUserIdStore = require(BuildExperienceParent.LocalUserIdStore).LocalUserIdStore
local RoactNavigation = require(BuildExperienceParent.RoactNavigation)
local SharedFlags = require(BuildExperienceParent.SharedFlags)
local useLocalization = require(BuildExperienceParent.Localization).Hooks.useLocalization
local LocalizationStrings = require(BuildExperience.LocalizationStrings)
local FFlagBuildExperienceAnalytics = SharedFlags.FFlagBuildExperienceAnalytics
local FFlagMyStatsMediaSelector = SharedFlags.FFlagMyStatsMediaSelector
local View = Foundation.View
local OverlayProvider = Foundation.OverlayProvider
local useOverlay = Foundation.Hooks.useOverlay

local BuildOverflowMenuScreens = require(script.Parent.BuildOverflowMenuScreens)
local FFlagBuildExperiencePageImpressions = require(BuildExperience.Flags.FFlagBuildExperiencePageImpressions)
local useBuildPageImpression = require(BuildExperience.Telemetry.useBuildPageImpression)
local FFlagBuildExperienceMonetizationNativeUI = require(BuildExperience.Flags.FFlagBuildExperienceMonetizationNativeUI)
local FFlagBuildExperienceModelPicker = require(BuildExperience.Flags.FFlagBuildExperienceModelPicker)
local PrivateInvitesPickerContainer = require(BuildExperience.Components.PrivateInvitesPicker.PrivateInvitesPickerContainer)

local PrivateInvitesManagementContainer = require(BuildExperience.Components.GameConfigurations.PrivateInvitesManagement.PrivateInvitesManagementContainer)
local OverflowMenuPageShell = require(script.Parent.OverflowMenuPageShell)
local BuildExperienceCompositionStyleSheet = require(BuildExperience.Components.BuildExperienceCompositionStyleSheet)
local CreatorCreditPageContainer = require(BuildExperience.Components.CreatorCreditSheet.CreatorCreditPageContainer)
local SubagentStatus = require(BuildExperience.Components.SubagentStatus)
local _createBuildOverflowMenuStore = require(BuildExperience.Stores.GetBuildOverflowMenuStore.createBuildOverflowMenuStore)
local BuildNavigationParams = require(BuildExperience.utils.BuildNavigationParams)
local useSessionSummary = require(BuildExperience.Chat.useSessionSummary)

local CreatorCreditBalanceChipContainer = require(BuildExperience.Components.CreatorCreditSheet.CreatorCreditBalanceChip.CreatorCreditBalanceChipContainer)

local tbl1 = {
    Launcher = "BuildPillMenuLauncher",
    BuildAgents = "BuildPillMenuAgents",
    BuildAgentDetails = "BuildPillMenuAgentDetails",
    BuildCreatorCredit = "BuildPillMenuCreatorCredit"
}

local function findGroup(arg1, name: string?) -- Luacid: Inlined by compiler; 1 call site recovered
    if arg1 == nil or name == nil then
        return nil
    end

    for _, group in arg1.groups do
        if group.name == name then
            return group
        end
    end

    return nil
end

local tbl2 = {
    [BuildOverflowMenuScreens.Screens.BuildPublish] = {
        screen = BuildOverflowMenuScreens.BuildPublishScreen
    }
}
local tbl3 = {
    [BuildOverflowMenuScreens.Screens.BuildSettings] = {
        screen = BuildOverflowMenuScreens.BuildSettingsScreen
    }
}
local tbl4 = {
    [BuildOverflowMenuScreens.Screens.BuildAudience] = {
        screen = BuildOverflowMenuScreens.BuildAudienceScreen
    }
}
local tbl5 = {
    [BuildOverflowMenuScreens.Screens.BuildPrivateInvitesPicker] = {
        screen = BuildOverflowMenuScreens.BuildPrivateInvitesPickerScreen
    }
}
local tbl6 = {
    [BuildOverflowMenuScreens.Screens.BuildPlaytestInviteManagement] = {
        screen = BuildOverflowMenuScreens.BuildPlaytestInviteManagementScreen
    }
}
local tbl7 = {
    [BuildOverflowMenuScreens.Screens.BuildTitleDescription] = {
        screen = BuildOverflowMenuScreens.BuildTitleDescriptionScreen
    }
}
local tbl8 = {
    [BuildOverflowMenuScreens.Screens.BuildVersionTitleDescription] = {
        screen = BuildOverflowMenuScreens.BuildVersionTitleDescriptionScreen
    }
}

local tbl9 = {
    {
        BuildPillMenuLauncher = {
            screen = function(tbl9) -- name: LauncherScreen
                local navigation = tbl9.navigation
                local screenProps = tbl9.screenProps

                React.useEffect(function()
                    if screenProps.initialPage ~= nil then
                        local var1 = BuildOverflowMenuScreens.SCREEN_BY_PAGE[screenProps.initialPage]
                        if var1 == nil then
                            return
                        end
                        navigation.navigate(var1, { target = screenProps.target })
                        return
                    end
                    if screenProps.initialScreen ~= nil then
                        navigation.navigate(screenProps.initialScreen, { target = screenProps.target, dismissOnBack = true })
                    end
                end, {
                    navigation,
                    screenProps.initialPage,
                    screenProps.initialScreen,
                    screenProps.target
                })
                return nil
            end
        }
    },
    tbl2,
    tbl3,
    tbl4,
    tbl5,
    tbl6,
    tbl7,
    tbl8,
    {
        BuildPillMenuAgents = {
            screen = function(tbl9) -- name: BuildAgentsScreen
                local navigation = tbl9.navigation
                local screenProps = tbl9.screenProps
                local subagentTaskState = screenProps.subagentTaskState
                local agents = useLocalization({ agents = LocalizationStrings.SUBAGENT_STATUS_AGENTS }).agents

                local onAgentActivated = React.useCallback(function(arg1)
                    navigation.navigate("BuildPillMenuAgentDetails", { target = screenProps.target, subagentTaskGroupName = arg1.name })
                end, { navigation, screenProps.target })

                local content = React.createElement(SubagentStatus.AgentsList, {
                    groups = subagentTaskState == nil and {} or subagentTaskState.groups,
                    onAgentActivated = onAgentActivated,
                    testId = "BuildPillMenu.AgentsList"
                })

                return React.createElement(OverflowMenuPageShell, {
                    title = agents,
                    onClose = screenProps.onClose,
                    content = content,
                    scrollPerformanceIntervalName = "LuaApp_Build_Agents_Scroll",
                    testId = "BuildPillMenu.AgentsPage"
                })
            end
        }
    },
    {
        BuildPillMenuAgentDetails = {
            screen = function(tbl9) -- name: BuildAgentDetailsScreen
                local navigation = tbl9.navigation
                local screenProps = tbl9.screenProps
                local subagentTaskState = BuildNavigationParams.getSubagentTaskState(navigation) or screenProps.subagentTaskState
                local title = BuildNavigationParams.getSubagentTaskGroupName(navigation)
                local group = findGroup(subagentTaskState, title)
                local agents = useLocalization({ agents = LocalizationStrings.SUBAGENT_STATUS_AGENTS }).agents

                local onClose = React.useCallback(function()
                    navigation.goBack()
                end, { navigation })

                local content = if group ~= nil then React.createElement(SubagentStatus.AgentDetailsList, { group = group, testId = "BuildPillMenu.AgentDetailsList" }) else React.createElement(View, { tag = "size-full" })
                return React.createElement(OverflowMenuPageShell, {
                    title = title or agents,
                    onClose = onClose,
                    content = content,
                    scrollPerformanceIntervalName = "LuaApp_Build_AgentDetails_Scroll",
                    testId = "BuildPillMenu.AgentDetailsPage"
                })
            end
        }
    },
    {
        BuildPillMenuCreatorCredit = {
            screen = function(tbl9) -- name: BuildCreatorCreditScreen
                local screenProps = tbl9.screenProps
                if FFlagBuildExperiencePageImpressions then
                    useBuildPageImpression("creator-credit-ai-usage", screenProps.target)
                end
                local pageTitle = useLocalization({ pageTitle = LocalizationStrings.CREATOR_CREDIT_PAGE_TITLE }).pageTitle

                local onClose = React.useCallback(function()
                    screenProps.onClose()
                end, { screenProps.onClose })

                local content = React.createElement(CreatorCreditPageContainer, nil)

                return React.createElement(OverflowMenuPageShell, {
                    title = pageTitle,
                    onClose = onClose,
                    content = content,
                    headerTrailing = React.createElement(CreatorCreditBalanceChipContainer),
                    scrollPerformanceIntervalName = "LuaApp_Build_CreatorCredit_Scroll",
                    testId = "BuildPillMenu.CreatorCreditPage"
                })
            end
        }
    }
}

if FFlagBuildExperienceMonetizationNativeUI then
    table.insert(
        tbl9,
        {
            [BuildOverflowMenuScreens.Screens.BuildMonetization] = {
                screen = BuildOverflowMenuScreens.BuildMonetizationScreen
            }
        }
    )
end

if FFlagBuildExperienceAnalytics then
    table.insert(
        tbl9,
        {
            [BuildOverflowMenuScreens.Screens.BuildStats] = {
                screen = BuildOverflowMenuScreens.BuildStatsScreen
            }
        }
    )
end

if FFlagMyStatsMediaSelector then
    table.insert(tbl9, {
        [BuildOverflowMenuScreens.Screens.BuildMediaSelection] = {
            screen = BuildOverflowMenuScreens.BuildMediaSelectionScreen
        }
    })
end

local appContainer = RoactNavigation.createAppContainer(
    RoactNavigation.createRobloxStackNavigator(tbl9, { initialRouteName = "BuildPillMenuLauncher" })
)

local function getOverlayScreenGui(screenGui) -- Luacid: Inlined by compiler; 1 call site recovered
    if screenGui:IsA("ScreenGui") then
        return screenGui
    end

    return screenGui:FindFirstAncestorOfClass("ScreenGui")
end

local function getInitialPage(activePage) -- Luacid: Inlined by compiler; 1 call site recovered
    return if activePage == nil or activePage.type ~= "overflow" then nil else activePage.page
end

local function getInitialScreen(tbl10) -- Luacid: unused: defined but never referenced
    if tbl10 == nil then
        return nil
    end

    if tbl10.type == "agents" then
        return "BuildPillMenuAgents"
    elseif tbl10.type == "invitePicker" then
        return BuildOverflowMenuScreens.Screens.BuildPrivateInvitesPicker
    elseif tbl10.type == "creator-credit" then
        return "BuildPillMenuCreatorCredit"
    elseif tbl10.type == "screen" then
        return tbl10.screen
    end

    return nil
end

local function getScreenTarget(activePage) -- Luacid: Inlined by compiler; 1 call site recovered
    return if activePage == nil or activePage.type ~= "screen" then nil else activePage.target
end

return React.memo(function(tbl10) -- name: BuildPillMenuPageHost
    local privateInvitesPageTitle = useLocalization({ privateInvitesPageTitle = LocalizationStrings.PRIVATE_INVITES_PAGE_TITLE }).privateInvitesPageTitle
    local screenGui = useOverlay()
    local gui, ref = React.useState(nil)
    local initialPage = getInitialPage(tbl10.activePage)
    local activePage = tbl10.activePage
    local var3

    if activePage == nil then
        var3 = nil
    elseif activePage.type == "agents" then
        var3 = tbl1.BuildAgents
    elseif activePage.type == "invitePicker" then
        var3 = BuildOverflowMenuScreens.Screens.BuildPrivateInvitesPicker
    elseif activePage.type == "creator-credit" then
        var3 = tbl1.BuildCreatorCredit
    elseif activePage.type == "screen" then
        var3 = activePage.screen
    else
        var3 = nil
    end

    local target = getScreenTarget(tbl10.activePage)
    local var4 = if FFlagBuildExperienceModelPicker then SignalsReact.useSignalState(LocalUserIdStore.getCurrentUserId) else nil

    local var5 = React.useMemo(function()
        return CreatorAgentChat.getCreatorAgentChatStore().getSessionForProject(
            tbl10.target.universeId,
            tbl10.target.placeId,
            tbl10.target.sessionId
        )
    end, {
        tbl10.target.universeId,
        tbl10.target.placeId,
        tbl10.target.sessionId,
        var4
    })

    local subagentTaskState = useSessionSummary(var5).subagentTaskState
    local overlayScreenGui = if screenGui == nil then nil else getOverlayScreenGui(screenGui)
    local var6 = if overlayScreenGui == nil or overlayScreenGui.Parent == nil then screenGui else overlayScreenGui.Parent
    local displayOrder = if overlayScreenGui == nil then 0 else overlayScreenGui.DisplayOrder

    React.useEffect(function()
        if tbl10.activePage == nil then
            ref(nil)
        end
    end, { tbl10.activePage })

    if tbl10.activePage == nil or screenGui == nil then
        return nil
    end

    local element

    if tbl10.activePage.type == "invitePicker" then
        element = React.createElement(
            PrivateInvitesPickerContainer,
            {
                universeId = tbl10.target.universeId,
                onClose = tbl10.onClose,
                onInvitesSent = tbl10.onInvitesSent or tbl10.onClose
            }
        )
    elseif tbl10.activePage.type == "playtestManagement" then
        element = React.createElement(
            View,
            {
                ZIndex = 10,
                tag = "size-full bg-surface-0",
                testId = "build-pill-menu-playtest-management"
            },
            {
                Content = React.createElement(View, { tag = "size-full margin-top-large" }, {
                    Management = React.createElement(OverflowMenuPageShell, {
                        title = privateInvitesPageTitle,
                        testId = "BuildPillMenu.playtestInviteManagement.Page",
                        onClose = tbl10.onClose,
                        content = React.createElement(
                            PrivateInvitesManagementContainer,
                            {
                                universeId = tbl10.target.universeId,
                                onOpenInvitePicker = tbl10.onOpenInvitePicker or tbl10.onClose
                            }
                        )
                    })
                })
            }
        )
    else
        element = React.createElement(
            View,
            { ZIndex = 10, tag = "size-full bg-surface-0", testId = "build-pill-menu-page-view" },
            {
                Content = React.createElement(View, { tag = "size-full margin-top-large" }, {
                    Navigator = React.createElement(appContainer, {
                        screenProps = {
                            initialPage = initialPage,
                            initialScreen = var3,
                            target = target or tbl10.target,
                            subagentTaskState = subagentTaskState,
                            onClose = tbl10.onClose,
                            onOpenChat = tbl10.onOpenChat,
                            showPreviewButton = false,
                            isPillMenu = true
                        }
                    })
                })
            }
        )
    end

    local createPortal = ReactRoblox.createPortal
    local createElement = React.createElement
    local str1 = "ScreenGui"
    local tbl11 = {
        ClipToDeviceSafeArea = false,
        DisplayOrder = displayOrder,
        IgnoreGuiInset = true,
        Name = "BuildExperiencePillMenuPage",
        ref = ref,
        ScreenInsets = Enum.ScreenInsets.None,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    }
    local tbl12 = {
        CompositionStyleSheet = React.createElement(BuildExperienceCompositionStyleSheet),
        Page = 0
    }

    if gui ~= nil then
        element = React.createElement(OverlayProvider, { gui = gui }, { Page = element })
    elseif FFlagBuildExperiencePageImpressions or tbl10.activePage.type == "invitePicker" then
        element = nil
    end

    tbl12.Page = element
    return createPortal(createElement(str1, tbl11, tbl12), var6)
end)
