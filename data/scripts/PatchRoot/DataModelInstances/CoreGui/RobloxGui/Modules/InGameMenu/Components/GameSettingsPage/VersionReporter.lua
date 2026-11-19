-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:21:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local ContentProvider = game:GetService("ContentProvider")
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")
local HttpRbxApiService = game:GetService("HttpRbxApiService")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local RobloxReplicatedStorage = game:GetService("RobloxReplicatedStorage")
local RunService = game:GetService("RunService")
local StarterPlayer = game:GetService("StarterPlayer")

local RobloxGui = CoreGui:WaitForChild("RobloxGui")

local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local Roact = InGameMenuDependencies.Roact
local t = InGameMenuDependencies.t
local Skeleton = require(CorePackages.Packages.Foundation).Skeleton

local PlayerPermissionsModule = require(CoreGui.RobloxGui.Modules.PlayerPermissionsModule)

local scriptParentParentParent = script.Parent.Parent.Parent

local Constants = require(scriptParentParentParent.Resources.Constants)
local Divider = require(scriptParentParentParent.Components.Divider)
local ThemedTextLabel = require(scriptParentParentParent.Components.ThemedTextLabel)
local ExternalEventConnection = require(scriptParentParentParent.Utility.ExternalEventConnection)

local withLocalization = require(scriptParentParentParent.Localization.withLocalization)

local engineFeature = game:GetEngineFeature("CoreScriptVersionEnabled")

local GetFFlagNewEventIngestPlayerScriptsDimensions = require(RobloxGui.Modules.Flags.GetFFlagNewEventIngestPlayerScriptsDimensions)
local GetFFlagRemoveAssetVersionEndpoint = require(RobloxGui.Modules.Flags.GetFFlagRemoveAssetVersionEndpoint)

local var1 = Roact.PureComponent:extend("VersionReporter")
var1.validateProps = t.strictInterface({ LayoutOrder = t.integer })

local function inferPlayerScriptStatus(arg1: Instance)
    local playerScriptsLoader = arg1:FindFirstChild("PlayerScriptsLoader")
    local playerModule = arg1:FindFirstChild("PlayerModule")
    local var2

    if playerScriptsLoader == nil or playerModule == nil then
        local cameraScript = arg1:FindFirstChild("CameraScript")
        local controlScript = arg1:FindFirstChild("ControlScript")
        if cameraScript ~= nil or controlScript ~= nil then
            var2 = Constants.PlayerScriptStatusStrings.CustomOld
        else
            var2 = Constants.PlayerScriptStatusStrings.Custom
        end
    elseif not (playerModule.Archivable or playerScriptsLoader.Archivable) then
        var2 = Constants.PlayerScriptStatusStrings.Default
    else
        var2 = Constants.PlayerScriptStatusStrings.PossiblyCustom
    end

    RbxAnalyticsService:SetRBXEventStream(
        Constants.AnalyticsTargetName,
        "player_scripts_status",
        "player_scripts_status_action",
        {
            defaultPlayerScripts = var2 == Constants.PlayerScriptStatusStrings.Default,
            placeID = tostring(game.PlaceId),
            rawValue = if GetFFlagNewEventIngestPlayerScriptsDimensions() then var2 else nil,
            context = if GetFFlagNewEventIngestPlayerScriptsDimensions() then "IGMv2" else nil
        }
    )

    return var2
end

function var1.init(arg1)
    local str1 = "PlayerScript Status: Unknown"
    local starterPlayerScripts = StarterPlayer:FindFirstChild("StarterPlayerScripts")
    if starterPlayerScripts then
        str1 = inferPlayerScriptStatus(starterPlayerScripts)
    else
        arg1.playerScriptsAddedConnection = StarterPlayer.ChildAdded:Connect(function(child: Instance)
            if child.Name ~= "StarterPlayerScripts" then
                return
            end

            arg1.playerScriptsAddedConnection:Disconnect()
            arg1.playerScriptsAddedConnection = nil
            arg1:setState({ playerScriptStatus = inferPlayerScriptStatus(child) })
        end)
    end

    arg1:setState({
        baseUrl = ContentProvider.BaseUrl,
        clientVersion = RunService:GetRobloxVersion(),
        isAdmin = false,
        latestPlaceVersion = nil,
        placeVersion = game.PlaceVersion,
        serverVersion = nil,
        playerScriptStatus = str1,
        coreScriptVersion = engineFeature and RunService:GetCoreScriptVersion() or nil
    })
end

function var1.render(arg1)
    local bool1 = arg1.state.serverVersion ~= nil
    local bool2 = arg1.state.latestPlaceVersion ~= nil
    local bool3 = not arg1.state.baseUrl:find("www.roblox.com")

    local var2 = bool3 or arg1.state.isAdmin

    return withLocalization({
        clientVersion = {
            "CoreScripts.InGameMenu.GameSettings.ClientVersion",
            CLIENT_VERSION = arg1.state.clientVersion
        },
        serverVersion = {
            "CoreScripts.InGameMenu.GameSettings.ServerVersion",
            SERVER_VERSION = arg1.state.serverVersion
        },
        placeVersion = {
            if bool2 then "CoreScripts.InGameMenu.GameSettings.PlaceVersionWithLatest" else "CoreScripts.InGameMenu.GameSettings.PlaceVersion",
            PLACE_VERSION = arg1.state.placeVersion,
            LATEST_PLACE_VERSION = arg1.state.latestPlaceVersion
        },
        coreScriptVersion = engineFeature
            and {
                "CoreScripts.InGameMenu.GameSettings.ClientCoreScriptVersion",
                CLIENT_CORESCRIPT_VERSION = arg1.state.coreScriptVersion
            }
            or nil
    })(
        function(arg2)
            local clientVersion = arg2.clientVersion

            local success, result = pcall(function(): string
                return RunService.ClientGitHash
            end)

            if success then
                clientVersion = string.format("%s (%.6s)", clientVersion, result)
            end

            return Roact.createElement(
                "Frame",
                {
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 0, 80),
                    LayoutOrder = arg1.props.LayoutOrder
                },
                {
                    Padding = Roact.createElement(
                        "UIPadding",
                        {
                            PaddingTop = UDim.new(0, 14),
                            PaddingLeft = UDim.new(0, 24),
                            PaddingBottom = UDim.new(0, 14)
                        }
                    ),
                    Layout = Roact.createElement("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 10) }),
                    ClientVersion = Roact.createElement(
                        ThemedTextLabel,
                        {
                            themeKey = "TextDefault",
                            fontKey = "Footer",
                            Text = clientVersion,
                            LayoutOrder = 1,
                            Size = UDim2.new(1, -24, 0, 14)
                        }
                    ),
                    ServerVersion = Roact.createElement(
                        ThemedTextLabel,
                        {
                            themeKey = "TextDefault",
                            fontKey = "Footer",
                            Text = bool1 and arg2.serverVersion or "",
                            LayoutOrder = 2,
                            Size = UDim2.new(1, -24, 0, 14)
                        },
                        { not bool1 and Roact.createElement(Skeleton, { Size = UDim2.new(1, 0, 1, 0) }) }
                    ),
                    PlaceVersion = Roact.createElement(ThemedTextLabel, {
                        themeKey = "TextDefault",
                        fontKey = "Footer",
                        Text = arg2.placeVersion,
                        LayoutOrder = 3,
                        Size = UDim2.new(1, -24, 0, 14)
                    }),
                    Divider = (bool3 or var2) and Roact.createElement(Divider, { Size = UDim2.new(1, 0, 0, 1), LayoutOrder = 4 }),
                    PlayerScriptStatus = var2
                        and Roact.createElement(ThemedTextLabel, {
                            themeKey = "TextDefault",
                            fontKey = "Footer",
                            Text = arg1.state.playerScriptStatus,
                            LayoutOrder = 5,
                            Size = UDim2.new(1, -24, 0, 14)
                        }),
                    Environment = bool3
                        and Roact.createElement(ThemedTextLabel, {
                            themeKey = "TextDefault",
                            fontKey = "Footer",
                            Text = ("Base URL: %s"):format(arg1.state.baseUrl),
                            LayoutOrder = 6,
                            Size = UDim2.new(1, -24, 0, 14)
                        }),
                    Divider2 = engineFeature and Roact.createElement(Divider, { Size = UDim2.new(1, 0, 0, 1), LayoutOrder = 7 }),
                    CoreScriptVersion = engineFeature
                        and Roact.createElement(ThemedTextLabel, {
                            themeKey = "TextDefault",
                            fontKey = "Footer",
                            Text = arg2.coreScriptVersion,
                            LayoutOrder = 8,
                            Size = UDim2.new(1, -24, 0, 14)
                        }),
                    VersionWatcher = Roact.createElement(ExternalEventConnection, {
                        event = game:GetPropertyChangedSignal("PlaceVersion"),
                        callback = function()
                            arg1:setState({ placeVersion = game.PlaceVersion })
                        end
                    })
                }
            )
        end
    )
end

function var1.didMount(arg1)
    arg1.mounted = true

    coroutine.wrap(function()
        local serverVersion = RobloxReplicatedStorage:WaitForChild("GetServerVersion", math.huge):InvokeServer()

        if arg1.mounted then
            arg1:setState({ serverVersion = serverVersion })
        end
    end)()

    if not GetFFlagRemoveAssetVersionEndpoint() then
        coroutine.wrap(function()
            pcall(function()
                local async = HttpRbxApiService:GetAsync(string.format("assets/%d/versions", game.PlaceId))
                local versionNumber = HttpService:JSONDecode(async)[1].VersionNumber

                if arg1.mounted then
                    arg1:setState({ latestPlaceVersion = versionNumber })
                end
            end)
        end)()
    end

    coroutine.wrap(function()
        local isAdmin = PlayerPermissionsModule.IsPlayerAdminAsync(Players.LocalPlayer)

        if arg1.mounted then
            arg1:setState({ isAdmin = isAdmin })
        end
    end)()
end

function var1.willUnmount(arg1)
    arg1.mounted = false
    if arg1.playerScriptsAddedConnection then
        arg1.playerScriptsAddedConnection:Disconnect()
    end
end

return var1
