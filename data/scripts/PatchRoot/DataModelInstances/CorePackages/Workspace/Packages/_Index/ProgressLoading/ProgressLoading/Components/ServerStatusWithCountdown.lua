-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T12:30:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProgressLoading = script:FindFirstAncestor("ProgressLoading")
local ProgressLoadingParent = ProgressLoading.Parent

local CoreGui = game:GetService("CoreGui")
local ExperienceService = game:GetService("ExperienceService")
local GuiService = game:GetService("GuiService")
local RunService = game:GetService("RunService")

local LoadingScreenTelemetry = require(ProgressLoading.LoadingScreenTelemetry)
local PlaceLauncherState = require(ProgressLoading.Enums.PlaceLauncherState)
local getLoadingScreenStore = require(ProgressLoading.Stores.getLoadingScreenStore)

local Foundation = require(ProgressLoadingParent.Foundation)
local useLocalization = require(ProgressLoadingParent.Localization).Hooks.useLocalization
local React = require(ProgressLoadingParent.React)
local _Signals = require(ProgressLoadingParent.Signals)
local SignalsReact = require(ProgressLoadingParent.SignalsReact)

local engineFeature = game:GetEngineFeature("QueuePositionEnabled")
local SharedFlags = require(ProgressLoadingParent.SharedFlags)
local FIntAutoJoinNewServerTimeMs = SharedFlags.FIntAutoJoinNewServerTimeMs
local FFlagEnableLuaAppsFollowUserId = SharedFlags.FFlagEnableLuaAppsFollowUserId
local var1 = game:GetEngineFeature("ExperienceServiceFollowUserIdEnabled") and FFlagEnableLuaAppsFollowUserId

local useTokens = Foundation.Hooks.useTokens
local normalizeFontFace = Foundation.Utility.normalizeFontFace

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
        friendsServerIsFullJoiningNewServer = "InGame.ConnectionError.Description.FriendsServerIsFullJoiningNewServer",
        friendsServerIsFullWaitingToJoin = "InGame.ConnectionError.Description.FriendsServerIsFullWaitingToJoin",
        joinTheLine = "InGame.ConnectionError.Action.JoinTheLine",
        wantToJoinYourFriend = "InGame.ConnectionError.Description.WantToJoinYourFriend"
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

    local value, var11 = React.useBinding(0)
    local var12 = React.useRef(nil)
    local var13, var14 = React.useState(false)

    local var15 = React.useRef(nil)

    local var16 = React.useCallback(function()
        var14(false)
        if var15.current then
            var15.current:Disconnect()
            var15.current = nil
        end
    end, {})

    local var17 = React.useCallback(function()
        if var15.current then
            return
        end

        var14(true)

        local startTime = os.clock()
        local var17 = FIntAutoJoinNewServerTimeMs / 1000

        var15.current = RunService.Heartbeat:Connect(function()
            local num1 = math.clamp((os.clock() - startTime) / var17 * 100, 0, 100)
            var11(num1)
            if not (num1 >= 100) then
                return
            end

            ExperienceService:LaunchExperience({ placeId = tbl1.placeId })
            if var15.current then
                var15.current:Disconnect()
                var15.current = nil
            end
        end)
    end, { tbl1.placeId })

    React.useEffect(function()
        if var8 == PlaceLauncherState.Queued then
            var12.current = os.clock()
        end
    end, { var8 })

    React.useEffect(function()
        if var8 == PlaceLauncherState.Queued and var1 and ExperienceService:GetFollowUserId() > 0 then
            var17()
        else
            var16()
        end

        return function()
            var16()
        end
    end, { var8, var17, var16 })

    local var7 = React.useCallback(function()
        var16()
        local var18 = if var12.current then math.floor((os.clock() - var12.current) * 1000) else nil
        LoadingScreenTelemetry.logQueuedStateButtonClick({
            buttonName = "JoinTheLine",
            joinTargetUserId = if var1 then ExperienceService:GetFollowUserId() else nil,
            placeId = tbl1.placeId,
            positionInQueue = if engineFeature then ExperienceService:GetQueuePosition() else nil,
            timeElapsedMs = var18,
            universeId = tbl1.universeId
        })
    end, { tbl1.placeId, tbl1.universeId, var16 })

    local createElement = React.createElement
    local view = Foundation.View
    local tbl2 = {
        AnchorPoint = tbl1.anchorPoint,
        AutoLocalize = true,
        Position = tbl1.position,
        Size = tbl1.size,
        tag = "col align-x-center align-y-bottom gap-xxlarge"
    }
    local tbl3 = { ServerStatusContainer = 0, ProgressBarContainer = 0, ActionContainer = 0 }
    local createElement2 = React.createElement
    local view2 = Foundation.View
    local tbl4 = {
        AutoLocalize = true,
        LayoutOrder = 1,
        tag = "col align-x-center align-y-bottom gap-xsmall auto-xy",
        onActivated = onActivated,
        stateLayer = {
            affordance = Foundation.Enums.StateLayerAffordance.None
        }
    }
    local tbl5 = {
        QueuedDescriptionText = if var8 == PlaceLauncherState.Queued and var1 and ExperienceService:GetFollowUserId() > 0 then React.createElement(
            Foundation.Text,
            {
                LayoutOrder = 1,
                Text = if var13 then var3.friendsServerIsFullJoiningNewServer else var3.friendsServerIsFullWaitingToJoin,
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
    }
    tbl3.ServerStatusContainer = createElement2(view2, tbl4, tbl5)

    tbl3.ProgressBarContainer = if var13 then React.createElement(Foundation.View, {
        LayoutOrder = 2,
        sizeConstraint = {
            MaxSize = Vector2.new(277, math.huge)
        },
        tag = "col align-x-center align-y-bottom gap-xsmall size-full-0 auto-y"
    }, {
        ProgressBar = React.createElement(Foundation.Progress, { shape = Foundation.Enums.ProgressShape.Bar, value = value })
    }) else nil
    local element2

    if var8 == PlaceLauncherState.Queued and var13 and var1 and ExperienceService:GetFollowUserId() > 0 then
        element2 = React.createElement(
            Foundation.View,
            { LayoutOrder = 3, tag = "col align-x-center align-y-bottom gap-xsmall auto-xy" },
            {
                ActionButtonDescriptionText = React.createElement(
                    Foundation.Text,
                    {
                        LayoutOrder = 1,
                        Text = var3.wantToJoinYourFriend,
                        tag = "auto-xy text-body-medium content-system-contrast"
                    }
                ),
                ActionButton = React.createElement(Foundation.Button, { LayoutOrder = 2, onActivated = var7, text = var3.joinTheLine })
            }
        )
    else
        element2 = nil
    end

    tbl3.ActionContainer = element2
    return createElement(view, tbl2, tbl3)
end)
