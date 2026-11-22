-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T12:30:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProgressLoading = script:FindFirstAncestor("ProgressLoading")
local ProgressLoadingParent = ProgressLoading.Parent

local CoreGui = game:GetService("CoreGui")
local ExperienceService = game:GetService("ExperienceService")
local GuiService = game:GetService("GuiService")

local LoadingScreenTelemetry = require(ProgressLoading.LoadingScreenTelemetry)
local PlaceLauncherState = require(ProgressLoading.Enums.PlaceLauncherState)
local getLoadingScreenStore = require(ProgressLoading.Stores.getLoadingScreenStore)

local Foundation = require(ProgressLoadingParent.Foundation)
local useLocalization = require(ProgressLoadingParent.Localization).Hooks.useLocalization
local React = require(ProgressLoadingParent.React)
local _Signals = require(ProgressLoadingParent.Signals)
local SignalsReact = require(ProgressLoadingParent.SignalsReact)

local useTokens = Foundation.Hooks.useTokens
local normalizeFontFace = Foundation.Utility.normalizeFontFace

local engineFeature = game:GetEngineFeature("QueuePositionEnabled")
local FFlagEnableLuaAppsFollowUserId = require(ProgressLoadingParent.SharedFlags).FFlagEnableLuaAppsFollowUserId
local var1 = game:GetEngineFeature("ExperienceServiceFollowUserIdEnabled") and FFlagEnableLuaAppsFollowUserId

local function getStoreJoinState(arg1)
    local loadingScreenStore = getLoadingScreenStore(arg1)
    if arg1 and loadingScreenStore and loadingScreenStore.getJoinState then
        return loadingScreenStore.getJoinState(arg1)
    end
    return ""
end

local function getStoreServerStatusText(arg1)
    local loadingScreenStore = getLoadingScreenStore(arg1)
    if arg1 and loadingScreenStore and loadingScreenStore.getServerStatusText then
        return loadingScreenStore.getServerStatusText(arg1)
    end
    return ""
end

return React.memo(function(tbl1)
    local var2 = useTokens()
    local var3 = useLocalization({
        queuedDescription = "InGame.ConnectionError.Description.FriendsServerIsFullWaitingToJoin",
        dontWantToWait = "InGame.ConnectionError.Description.DontWantToWait",
        joinNewServer = "InGame.ConnectionError.Action.JoinNewServer"
    })

    local var4 = React.useRef(0)
    local var5 = React.useRef(math.huge)

    local var6 = React.useCallback(function()
        if var4.current == 0 then
            var4.current = 1
            var5.current = tick()
            return
        end
        if tick() - var5.current <= 0.5 then
            GuiService:ShowStatsBasedOnInputString("ConnectionHealth")
        end

        var4.current = 0
        var5.current = math.huge
    end, {})

    local onActivated = React.useCallback(function()
        if not tbl1.isSubjectToChinaPolicies then
            var6()
        end
    end, { tbl1.isSubjectToChinaPolicies, var6 })

    local var8 = SignalsReact.useSignalState(getStoreJoinState)
    local var9 = SignalsReact.useSignalBinding(getStoreServerStatusText)
    local var10 = React.useRef(nil)

    React.useEffect(function()
        if var8 == PlaceLauncherState.Queued then
            var10.current = os.clock()
        end
    end, { var8 })

    local var7 = React.useCallback(function()
        local var11 = if var10.current then math.floor((os.clock() - var10.current) * 1000) else nil
        LoadingScreenTelemetry.logQueuedStateButtonClick({
            buttonName = "JoinNewServer",
            joinTargetUserId = if var1 then ExperienceService:GetFollowUserId() else nil,
            placeId = tbl1.placeId,
            positionInQueue = if engineFeature then ExperienceService:GetQueuePosition() else nil,
            timeElapsedMs = var11,
            universeId = tbl1.universeId
        })
        ExperienceService:LaunchExperience({ placeId = tbl1.placeId })
    end, { tbl1.placeId, tbl1.universeId })

    local createElement = React.createElement
    local view = Foundation.View
    local tbl2 = {
        AnchorPoint = tbl1.anchorPoint,
        AutoLocalize = true,
        Position = tbl1.position,
        Size = tbl1.size,
        tag = "col align-x-center align-y-bottom gap-xxlarge"
    }
    local tbl3 = {
        ServerStatusContainer = React.createElement(Foundation.View, {
            AutoLocalize = true,
            LayoutOrder = 1,
            tag = "col align-x-center align-y-bottom gap-xsmall auto-xy",
            onActivated = onActivated,
            stateLayer = {
                affordance = Foundation.Enums.StateLayerAffordance.None
            }
        }, {
            QueuedDescriptionText = if var8 == PlaceLauncherState.Queued and var1 and ExperienceService:GetFollowUserId() > 0 then React.createElement(
                Foundation.Text,
                {
                    LayoutOrder = 1,
                    Text = var3.queuedDescription,
                    tag = "auto-xy text-title-medium content-system-contrast"
                }
            ) else nil,
            ServerStatusText = React.createElement("TextLabel", {
                AutoLocalize = true,
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundTransparency = 1,
                LayoutOrder = 2,
                Size = UDim2.new(1, 0, 0, 0),
                FontFace = normalizeFontFace(var2.Typography.TitleMedium.Font),
                TextSize = var2.Typography.TitleMedium.FontSize,
                TextWrapped = true,
                TextScaled = false,
                TextColor3 = var2.Color.System.Contrast.Color3,
                TextStrokeTransparency = 1,
                Text = var9,
                TextXAlignment = Enum.TextXAlignment.Center,
                TextYAlignment = Enum.TextYAlignment.Center,
                ZIndex = 2,
                RootLocalizationTable = CoreGui:FindFirstChild("CoreScriptLocalization")
            })
        }),
        ActionContainer = 0
    }
    local element

    if var8 == PlaceLauncherState.Queued then
        element = React.createElement(
            Foundation.View,
            { LayoutOrder = 2, tag = "col align-x-center align-y-bottom gap-xsmall auto-xy" },
            {
                ActionButtonDescriptionText = React.createElement(
                    Foundation.Text,
                    {
                        LayoutOrder = 1,
                        Text = var3.dontWantToWait,
                        tag = "auto-xy text-body-medium content-system-contrast"
                    }
                ),
                ActionButton = React.createElement(Foundation.Button, { LayoutOrder = 2, onActivated = var7, text = var3.joinNewServer })
            }
        )
    else
        element = nil
    end

    tbl3.ActionContainer = element
    return createElement(view, tbl2, tbl3)
end)
