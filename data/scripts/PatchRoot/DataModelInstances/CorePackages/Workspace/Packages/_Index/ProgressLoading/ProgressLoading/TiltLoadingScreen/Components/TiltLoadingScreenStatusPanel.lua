-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T12:31:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TiltLoadingScreen = script:FindFirstAncestor("TiltLoadingScreen")
local TiltLoadingScreenParent = TiltLoadingScreen.Parent
local TiltLoadingScreenParentParent = TiltLoadingScreenParent.Parent

local React = require(TiltLoadingScreenParentParent.React)
local Foundation = require(TiltLoadingScreenParentParent.Foundation)
local Localization = require(TiltLoadingScreenParentParent.Localization)
local CoreGui = game:GetService("CoreGui")
local LocalizationService = game:GetService("LocalizationService")
local RunService = game:GetService("RunService")

local Constants = require(TiltLoadingScreen.Constants)
local _Types = require(TiltLoadingScreen.Types)
local Footer = require(TiltLoadingScreenParent.Components.Footer)

local Button = Foundation.Button
local Progress = Foundation.Progress
local FoundationText = Foundation.Text
local View = Foundation.View
local Enums = Foundation.Enums

local useLocalization = Localization.Hooks.useLocalization
local FIntAutoJoinNewServerTimeMs = require(TiltLoadingScreenParentParent.SharedFlags).FIntAutoJoinNewServerTimeMs
local isPioneerLaunch = require(TiltLoadingScreenParentParent.PioneerUtils).isPioneerLaunch

local function localizeUiMessage(text: string) -- Luacid: Inlined by compiler; 1 call site recovered
    local coreScriptLocalization = CoreGui:FindFirstChild("CoreScriptLocalization")
    if not coreScriptLocalization then
        return text
    end
    local success, result = pcall(function(): string
        return coreScriptLocalization:GetTranslator(LocalizationService.RobloxLocaleId):Translate(CoreGui, text)
    end)
    return if success then result else text
end

return React.memo(function(arg1) -- name: TiltLoadingScreenStatusPanel
    local var1 = useLocalization({
        antiAddictionText = "Authentication.Login.WeChat.AntiAddictionText",
        dontWantToWait = "InGame.ConnectionError.Description.DontWantToWait",
        friendsServerIsFullJoiningNewServer = "InGame.ConnectionError.Description.FriendsServerIsFullJoiningNewServer",
        friendsServerIsFullWaitingToJoin = "InGame.ConnectionError.Description.FriendsServerIsFullWaitingToJoin",
        joinNewServer = "InGame.ConnectionError.Action.JoinNewServer",
        joinTheLine = "InGame.ConnectionError.Action.JoinTheLine",
        statusGameEnded = "InGame.ConnectionError.PlacelaunchGameEnded",
        statusHttpError = "InGame.ConnectionError.PlacelaunchHttpError",
        statusJoining = "InGame.ConnectionError.Joining",
        statusQueued = {
            "InGame.ConnectionError.Queue",
            POSITION = tostring(arg1.queuePosition or "")
        },
        wantToJoinYourFriend = "InGame.ConnectionError.Description.WantToJoinYourFriend"
    })

    local var2 = React.useRef(-math.huge)
    local value, var4 = React.useBinding(0)
    local var5, var6 = React.useState(false)
    local var7 = React.useRef(nil)
    local var8 = React.useRef(nil)

    local var9 = React.useCallback(function()
        var6(false)
        if var7.current then
            var7.current:Disconnect()
            var7.current = nil
        end
    end, {})

    local var10 = React.useCallback(function()
        if var7.current then
            return
        end

        var6(true)
        local startTime = os.clock()
        local var10 = FIntAutoJoinNewServerTimeMs / 1000

        var7.current = RunService.Heartbeat:Connect(function()
            local num1 = math.clamp((os.clock() - startTime) / var10 * 100, 0, 100)
            var4(num1)
            if num1 >= 100 then
                var9()
                arg1.onAutoJoinNewServer()
            end
        end)
    end, { arg1.onAutoJoinNewServer, var9 })

    React.useEffect(function()
        if arg1.status == Constants.QUEUED_STATE then
            var8.current = os.clock()
        end
    end, { arg1.status })

    React.useEffect(function()
        if arg1.status == Constants.QUEUED_STATE and arg1.queueTreatment == Constants.AUTO_JOIN_TREATMENT and arg1.followUserId > 0 then
            var10()
        else
            var9()
        end

        return var9
    end, {
        arg1.status,
        arg1.queueTreatment,
        arg1.followUserId,
        var10,
        var9
    })
    local onActivated = React.useCallback(function()
        if arg1.isSubjectToChinaPolicies then
            return
        end
        local current = os.clock()
        if current - var2.current <= Constants.DOUBLE_TAP_WINDOW_SECONDS then
            arg1.onShowConnectionHealth()
            var2.current = -math.huge
            return
        end
        var2.current = current
    end, { arg1.isSubjectToChinaPolicies, arg1.onShowConnectionHealth })

    local var3 = React.useCallback(function()
        var9()
        local onJoinTheLine = arg1.onJoinTheLine
        local var12 = if var8.current then math.floor((os.clock() - var8.current) * 1000) else nil
        onJoinTheLine(var12)
    end, { arg1.onJoinTheLine, var9 })

    local var11 = React.useCallback(function()
        local onJoinNewServer = arg1.onJoinNewServer
        local var13 = if var8.current then math.floor((os.clock() - var8.current) * 1000) else nil
        onJoinNewServer(var13)
    end, { arg1.onJoinNewServer })

    local bool1 = arg1.status == Constants.QUEUED_STATE and arg1.queueTreatment == Constants.JOIN_NEW_SERVER_TREATMENT
    local var14 = not (arg1.status ~= Constants.QUEUED_STATE or arg1.queueTreatment ~= Constants.AUTO_JOIN_TREATMENT)
        and arg1.followUserId > 0
        and var5
    local var15 = if arg1.status == Constants.QUEUED_STATE and arg1.followUserId > 0 and arg1.queueTreatment ~= nil then if var5 then var1.friendsServerIsFullJoiningNewServer else var1.friendsServerIsFullWaitingToJoin else nil
    local var16 = ({
        Joining = var1.statusJoining,
        GameEnded = var1.statusGameEnded,
        HttpError = var1.statusHttpError
    })[arg1.status]
    local var17 = if arg1.status == Constants.QUEUED_STATE and arg1.queuePosition ~= nil then var1.statusQueued else var16 or localizeUiMessage(arg1.statusText)
    local createElement = React.createElement
    local var18 = View
    local tbl1 = {
        LayoutOrder = arg1.LayoutOrder,
        tag = "col align-x-center align-y-bottom gap-large size-full-0 auto-y padding-x-xlarge padding-bottom-xlarge",
        testId = "tilt-loading-screen-status-panel"
    }

    local tbl2 = {
        Status = React.createElement(View, {
            LayoutOrder = 1,
            tag = {
                ["col align-x-center gap-small size-full-0 auto-y"] = true,
                ["padding-bottom-small"] = isPioneerLaunch()
            },
            onActivated = onActivated,
            stateLayer = {
                affordance = Enums.StateLayerAffordance.None
            },
            testId = "tilt-loading-screen-status"
        }, {
            Policy = if arg1.isSubjectToChinaPolicies then React.createElement(FoundationText, {
                LayoutOrder = 1,
                Text = var1.antiAddictionText,
                tag = "size-full-0 auto-y text-title-medium text-wrap text-align-x-center content-system-contrast"
            }) else nil,
            QueueDescription = if var15 then React.createElement(FoundationText, {
                LayoutOrder = 2,
                Text = var15,
                tag = "auto-xy text-title-medium content-system-contrast",
                testId = "tilt-loading-screen-queue-description"
            }) else nil,
            StatusText = if var17 == "" then nil else React.createElement(FoundationText, {
                LayoutOrder = 3,
                Text = var17,
                tag = "size-full-0 auto-y text-body-small text-wrap text-align-x-center content-system-contrast"
            })
        }),
        Countdown = if var5 then React.createElement(
            View,
            { LayoutOrder = 2, tag = "col align-x-center size-full-0 auto-y" },
            {
                ProgressBar = React.createElement(
                    Progress,
                    {
                        shape = Enums.ProgressShape.Bar,
                        value = value,
                        testId = "tilt-loading-screen-auto-join-progress"
                    }
                )
            }
        ) else nil,
        JoinNewServerAction = 0,
        JoinTheLineAction = 0,
        RobloxWordmark = 0
    }
    local element

    if bool1 then
        element = React.createElement(View, {
            LayoutOrder = 3,
            tag = "col align-x-center gap-xsmall auto-xy"
        }, {
            Description = React.createElement(
                FoundationText,
                {
                    LayoutOrder = 1,
                    Text = var1.dontWantToWait,
                    tag = "auto-xy text-body-medium content-system-contrast"
                }
            ),
            Button = React.createElement(
                Button,
                {
                    LayoutOrder = 2,
                    onActivated = var11,
                    text = var1.joinNewServer,
                    testId = "tilt-loading-screen-join-new-server"
                }
            )
        })
    else
        element = nil
    end

    tbl2.JoinNewServerAction = element
    local element2

    if var14 then
        element2 = React.createElement(View, {
            LayoutOrder = 4,
            tag = "col align-x-center gap-xsmall auto-xy"
        }, {
            Description = React.createElement(
                FoundationText,
                {
                    LayoutOrder = 1,
                    Text = var1.wantToJoinYourFriend,
                    tag = "auto-xy text-body-medium content-system-contrast"
                }
            ),
            Button = React.createElement(
                Button,
                {
                    LayoutOrder = 2,
                    onActivated = var3,
                    text = var1.joinTheLine,
                    testId = "tilt-loading-screen-join-the-line"
                }
            )
        })
    else
        element2 = nil
    end

    tbl2.JoinTheLineAction = element2

    tbl2.RobloxWordmark = if isPioneerLaunch() then React.createElement(Footer, {
        LayoutOrder = 5,
        textTestId = "tilt-loading-screen-pre-logo-text",
        wordmarkTestId = "tilt-loading-screen-roblox-wordmark"
    }) else nil
    return createElement(var18, tbl1, tbl2)
end)
