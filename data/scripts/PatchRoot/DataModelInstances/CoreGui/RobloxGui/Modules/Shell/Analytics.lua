-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:40:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxGui = game:GetService("CoreGui"):FindFirstChild("RobloxGui")
local CorePackages = game:GetService("CorePackages")
local Shell = RobloxGui:FindFirstChild("Modules"):FindFirstChild("Shell")

local EventStream = require(CorePackages.Workspace.Packages.Analytics).AnalyticsReporters.EventStream

local userInteractions = require(CorePackages.Workspace.Packages.Analytics).Events.userInteractions
local pageHeartbeat = require(CorePackages.Workspace.Packages.Analytics).Events.pageHeartbeat
local contentHistory = require(Shell.XboxPrimaryNav:FindFirstChild("contentHistory"))
local XboxPrimaryNavIXPTest = require(Shell.Experiment.XboxPrimaryNavIXPTest)
local GetFIntXboxPrimaryNavABLogging = require(Shell.Flags.GetFIntXboxPrimaryNavABLogging)

local RbxAnalyticsService = nil
pcall(function()
    RbxAnalyticsService = game:GetService("RbxAnalyticsService")
end)

local EventIngestService = game:GetService("EventIngestService")
local UserInputService = game:GetService("UserInputService")

local eventStream = EventStream.new(RbxAnalyticsService)

local module = {}

local tbl1 = { TenFoot = "tenFoot", Classic = "classic" }

local function getNavigationVersion(): string -- Luacid: unused: defined but never referenced
    return if XboxPrimaryNavIXPTest.isUserEnrolled() then "tenFoot" else "classic"
end

local function setRBXEvent(eventName, additionalArgs): boolean -- Luacid: unused: defined but never referenced
    local target = nil
    local eventContext = nil
    local success, _result = pcall(function()
        if UserInputService:GetPlatform() ~= Enum.Platform.XBoxOne then
            return
        end

        target = "console"
        eventContext = "XboxOne"
        eventName = eventName or ""
        additionalArgs = additionalArgs or {}
        EventIngestService:SetRBXEvent(target, eventContext, eventName, additionalArgs)
    end)

    return success
end

local function setRBXEventStream(eventName, additionalArgs): boolean -- Luacid: unused: defined but never referenced
    local target = nil
    local eventContext = nil
    local success, _result = pcall(function()
        if UserInputService:GetPlatform() ~= Enum.Platform.XBoxOne then
            return
        end

        target = "console"
        eventContext = "XboxOne"
        eventName = eventName or ""
        additionalArgs = additionalArgs or {}
        EventIngestService:SetRBXEventStream(target, eventContext, eventName, additionalArgs)
    end)

    return success
end

local function releaseRBXEventStream(_): boolean -- Luacid: unused: defined but never referenced
    local var1 = nil
    local success, _result = pcall(function()
        if UserInputService:GetPlatform() == Enum.Platform.XBoxOne then
            var1 = "console"
            RbxAnalyticsService:ReleaseRBXEventStream(var1)
        end
    end)

    return success
end

local function updateHeartbeatObject(arg1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    local success, _result = pcall(function()
        RbxAnalyticsService:UpdateHeartbeatObject(arg1)
    end)

    return success
end

local function reportCounter(arg1, arg2): boolean -- Luacid: unused: defined but never referenced
    local success, _result = pcall(function()
        if UserInputService:GetPlatform() == Enum.Platform.XBoxOne then
            arg1 = arg1 or ""
            arg1 = "Xbox-" .. tostring(arg1)
            arg2 = arg2 or 1
            RbxAnalyticsService:ReportCounter(arg1, arg2)
        end
    end)

    return success
end

function module.SetRBXEvent(arg1, arg2)
    local eventName = arg1
    local additionalArgs = arg2
    local target = nil
    local eventContext = nil
    local _success, _result = pcall(function()
        if UserInputService:GetPlatform() ~= Enum.Platform.XBoxOne then
            return
        end

        target = "console"
        eventContext = "XboxOne"
        eventName = eventName or ""
        additionalArgs = additionalArgs or {}
        EventIngestService:SetRBXEvent(target, eventContext, eventName, additionalArgs)
    end)
end

function module.SetRBXEventStream(arg1, arg2)
    local eventName = arg1
    local additionalArgs = arg2
    local target = nil
    local eventContext = nil
    local _success, _result = pcall(function()
        if UserInputService:GetPlatform() ~= Enum.Platform.XBoxOne then
            return
        end

        target = "console"
        eventContext = "XboxOne"
        eventName = eventName or ""
        additionalArgs = additionalArgs or {}
        EventIngestService:SetRBXEventStream(target, eventContext, eventName, additionalArgs)
    end)
end

function module.UpdateHeartbeatObject(arg1)
    local _success = updateHeartbeatObject(arg1)
end

function module.ReportCounter(arg1, arg2)
    local var1 = arg1
    local var2 = arg2

    local _success, _result = pcall(function()
        if UserInputService:GetPlatform() == Enum.Platform.XBoxOne then
            var1 = var1 or ""
            var1 = "Xbox-" .. tostring(var1)
            var2 = var2 or 1
            RbxAnalyticsService:ReportCounter(var1, var2)
        end
    end)
end

function module.reportPageChanged()
    userInteractions(eventStream, "luaPage")
end

function module.reportPageHeartbeat(arg1, arg2)
    pageHeartbeat(eventStream, arg1, arg2)
end

function module.reportNavigation(activationType, toContent, contentType)
    local fromContent = contentHistory:getLastContentName()

    if toContent == fromContent then
        return
    end

    local eventName = "Navigation"
    local additionalArgs = {
        activationType = activationType,
        toContent = toContent,
        fromContent = fromContent,
        contentType = contentType,
        navigationVersion = if XboxPrimaryNavIXPTest.isUserEnrolled() then tbl1.TenFoot else tbl1.Classic
    }
    local target = nil
    local eventContext = nil
    local _success, _result = pcall(function()
        if UserInputService:GetPlatform() ~= Enum.Platform.XBoxOne then
            return
        end

        target = "console"
        eventContext = "XboxOne"
        eventName = eventName or ""
        additionalArgs = additionalArgs or {}
        EventIngestService:SetRBXEventStream(target, eventContext, eventName, additionalArgs)
    end)

    if GetFIntXboxPrimaryNavABLogging() > 1 then
        print(
            "[ANALYTICS] Navigation",
            "ActivationType:",
            activationType,
            "| ContentName:",
            toContent,
            "| ContentType:",
            contentType,
            "| PrevContentName:",
            fromContent,
            "| NavigationVersion:",
            if XboxPrimaryNavIXPTest.isUserEnrolled() then tbl1.TenFoot else tbl1.Classic
        )
    end
end

local function reportNavigationLoaded(toContent)
    local fromContent = contentHistory:getLastContentName()

    if toContent == fromContent then
        return
    end

    local eventName = "NavigationLoaded"
    local additionalArgs = {
        toContent = toContent,
        fromContent = fromContent,
        navigationVersion = if XboxPrimaryNavIXPTest.isUserEnrolled() then tbl1.TenFoot else tbl1.Classic
    }
    local target = nil
    local eventContext = nil
    local _success, _result = pcall(function()
        if UserInputService:GetPlatform() ~= Enum.Platform.XBoxOne then
            return
        end

        target = "console"
        eventContext = "XboxOne"
        eventName = eventName or ""
        additionalArgs = additionalArgs or {}
        EventIngestService:SetRBXEventStream(target, eventContext, eventName, additionalArgs)
    end)

    if GetFIntXboxPrimaryNavABLogging() > 1 then
        print(
            "[ANALYTICS] NavigationLoaded ContentName:",
            toContent,
            "| PrevContentName:",
            fromContent,
            "| NavigationVersion:",
            if XboxPrimaryNavIXPTest.isUserEnrolled() then tbl1.TenFoot else tbl1.Classic
        )
    end
end

function module.reportNavigationLoaded(toContent)
    if XboxPrimaryNavIXPTest.isUserEnrolled() then
        reportNavigationLoaded(toContent)
        return
    end
    spawn(function()
        reportNavigationLoaded(toContent)
    end)
end

function module.reportBackNavigation(fromContent)
    local toContent = contentHistory:getLastContentName()

    local eventName = "NavigationBack"
    local additionalArgs = {
        fromContent = fromContent,
        toContent = toContent,
        navigationVersion = if XboxPrimaryNavIXPTest.isUserEnrolled() then tbl1.TenFoot else tbl1.Classic
    }
    local target = nil
    local eventContext = nil
    local _success, _result = pcall(function()
        if UserInputService:GetPlatform() ~= Enum.Platform.XBoxOne then
            return
        end

        target = "console"
        eventContext = "XboxOne"
        eventName = eventName or ""
        additionalArgs = additionalArgs or {}
        EventIngestService:SetRBXEventStream(target, eventContext, eventName, additionalArgs)
    end)

    if GetFIntXboxPrimaryNavABLogging() > 1 then
        print(
            "[ANALYTICS] NavigationBack FromContent:",
            fromContent,
            "| ToContent:",
            toContent,
            "| NavigationVersion:",
            if XboxPrimaryNavIXPTest.isUserEnrolled() then tbl1.TenFoot else tbl1.Classic
        )
    end
end
local tbl2 = {
    WidgetId = "WidgetName",
    AppHubId = "AppHub",
    AvatarEditorScreenId = "AvatarEditorScreen",
    AvatarPaneId = "AvatarPane",
    AvatarTileId = "AvatarTile",
    BadgeOverlayId = "BadgeOverlay",
    BaseCarouselScreenId = "BaseCarouselScreen",
    BaseOverlayId = "BaseOverlay",
    BaseTileId = "BaseTile",
    ConfirmPromptId = "ConfirmPrompt",
    DisableCrossplayOverlayId = "DisableCrossplayOverlay",
    EnableCrossplayOverlayId = "EnableCrossplayOverlay",
    EngagementScreenId = "EngagementScreen",
    ErrorOverlayId = "ErrorOverlay",
    GameDetailId = "GameDetail",
    GameGenreScreenId = "GameGenreScreen",
    GamesPaneId = "GamesPane",
    GameSearchScreenId = "GameSearchScreen",
    HomePaneId = "HomePane",
    ImageOverlayId = "ImageOverlay",
    LinkAccountScreenId = "LinkAccountScreen",
    NoActionOverlayId = "NoActionOverlay",
    OutfitTileId = "OutfitTile",
    OverscanScreenId = "OverscanScreen",
    PurchasePackagePromptId = "PurchasePackagePrompt",
    ReportOverlayId = "ReportOverlay",
    RobuxBalanceOverlayId = "RobuxBalanceOverlay",
    SetAccountCredentialsScreenId = "SetAccountCredentialsScreen",
    SettingsScreenId = "SettingsScreen",
    SideBarId = "SideBar",
    SignInScreenId = "SignInScreen",
    SocialPaneId = "SocialPane",
    StorePaneId = "StorePane",
    TabDockId = "TabDock",
    UnlinkAccountOverlayId = "UnlinkAccountOverlay",
    UnlinkAccountScreenId = "UnlinkAccountScreen",
    TwoFactorScreen = "TwoFactorScreen",
    CrossDeviceLoginScreen = "CrossDeviceLoginScreen",
    StoreScreenId = "StoreScreen",
    SearchScreenId = "SearchScreen",
    PartyUiId = "PartyUi"
}

local tbl3 = {
    HomeId = "HomeTab",
    AvatarId = "AvatarTab",
    DiscoverId = "DiscoverTab",
    FriendsId = "FriendsTab",
    StoreId = "StoreTab",
    SearchId = "SearchTab",
    SettingsId = "SettingsTab"
}

function module.WidgetNames(arg1)
    return tbl2 and tbl2[arg1] or arg1
end

function module.TabNames(arg1)
    return tbl3 and tbl3[arg1] or arg1
end

return module
