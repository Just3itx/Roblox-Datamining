-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:10:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local React = require(MomentsParent.React)
local SharedFlags = require(MomentsParent.SharedFlags)
local Signals = require(MomentsParent.Signals)
local SignalsReact = require(MomentsParent.SignalsReact)
local MomentsCommon = require(MomentsParent.MomentsCommon)

local _AvatarMomentView = require(script.Parent.AvatarMomentView)
local decodeInlineMomentScene = require(script.Parent.decodeInlineMomentScene)
local FeedContext = require(Moments.Components.Feed.FeedContext)
local _FeedTypes = require(Moments.Components.Feed.FeedTypes)
local _MomentContext = require(Moments.Components.Feed.Items.Moment.MomentContext)
local MomentsHostContext = require(Moments.MomentsHostContext)
local observeGuiOnScreen = require(script.Parent.observeGuiOnScreen)
local VerticalPager = require(Moments.Components.VerticalPager)
local getAvatarSceneStage = require(script.Parent.getAvatarSceneStage)
local FFlagProfileRenderAvatarMoments = SharedFlags.FFlagProfileRenderAvatarMoments
local FFlagMomentsRecommendationContentType = require(Moments.Flags.FFlagMomentsRecommendationContentType)
local FFlagMomentsAvatarSceneStage = require(Moments.Flags.FFlagMomentsAvatarSceneStage)
local FFlagMomentsAvatarUnthrottleFramerate = require(Moments.Flags.FFlagMomentsAvatarUnthrottleFramerate)
local useAvatarMomentFramerateHold = require(script.Parent.useAvatarMomentFramerateHold)

local cFrame = CFrame.new(0, 2000, 0)

local function disposeMomentScene(arg1) -- Luacid: Inlined by compiler; 6 call sites recovered
    pcall(function()
        arg1.root.Parent = nil
    end)
    pcall(arg1.dispose)
end

local function saveCamera(camera: Camera) -- Luacid: Inlined by compiler; 1 call site recovered
    return {
        instance = camera,
        cframe = camera.CFrame,
        focus = camera.Focus,
        fieldOfView = camera.FieldOfView,
        fieldOfViewMode = camera.FieldOfViewMode,
        cameraType = camera.CameraType
    }
end

local function restoreCamera(tbl1) -- Luacid: Inlined by compiler; 1 call site recovered
    if tbl1 == nil or tbl1.instance.Parent == nil or Workspace.CurrentCamera ~= tbl1.instance then
        return
    end
    tbl1.instance.CFrame = tbl1.cframe
    tbl1.instance.Focus = tbl1.focus
    tbl1.instance.FieldOfView = tbl1.fieldOfView
    tbl1.instance.FieldOfViewMode = tbl1.fieldOfViewMode
    tbl1.instance.CameraType = tbl1.cameraType
end

local function useAvatarMomentViewModel(tbl1)
    local var1 = FeedContext.useFeed()
    local getCurrentIndex = var1.getCurrentIndex
    assert(getCurrentIndex ~= nil, "Avatar Moments require the flag-gated feed index")
    local var2 = SignalsReact.useSignalState(getCurrentIndex)
    local var3 = React.useRef(0)
    local moment = tbl1.item.moment
    local current = MomentsCommon.Media.useMomentMediaController(moment.momentId)
    local var5 = React.useMemo(function()
        return Signals.createComputed(function(arg1)
            return not (current == nil) and current.getState(arg1).isPlaying
        end)
    end, { current })
    local var4 = SignalsReact.useSignalState(var5)
    local var7 = React.useRef(nil)
    local var8 = React.useRef(false)
    local var9 = if FFlagMomentsAvatarUnthrottleFramerate then useAvatarMomentFramerateHold(var8) else nil

    local var10 = React.useCallback(function(current3: boolean)
        local current2 = var7.current
        if current2 == nil or var8.current == current3 then
            return
        end
        var8.current = current3
        if current3 then
            current2.playhead.play()
        else
            current2.playhead.pause()
        end
        if var9 ~= nil then
            var9.refresh()
        end
    end, { var9 })
    local bool1 = var1.isPlaybackActive and var2 == tbl1.index
    local feedItemId = moment.recommendationMetadata.feedItemId
    local pageRef = if FFlagProfileRenderAvatarMoments or FFlagMomentsAvatarSceneStage then React.useRef(nil) else nil
    local viewportFrameRef = if FFlagMomentsAvatarSceneStage then React.useRef(nil) else nil
    local worldModelRef = if FFlagMomentsAvatarSceneStage then React.useRef(nil) else nil
    local var14 = if FFlagProfileRenderAvatarMoments then MomentsHostContext.useMomentsHost() else nil
    local bool2 = var14 == nil or var14.isTopShell ~= false
    if FFlagProfileRenderAvatarMoments then
        bool1 = bool2 and var2 == tbl1.index
    end
    React.useEffect(function()
        if FFlagMomentsAvatarSceneStage then
            return
        end
        if not bool1 or current == nil then
            return
        end
        local setExternalBaseReadiness = current.setExternalBaseReadiness
        assert(setExternalBaseReadiness ~= nil, "Avatar Moments require external-base readiness")
        setExternalBaseReadiness("Loading")

        local var15 = var3
        var15.current += 1
        local current2 = var3.current
        local var16 = nil
        local var17 = nil
        local var18 = nil
        local connection = nil
        local var19 = nil

        local function showScene()
            local var20 = var16
            if var20 == nil or connection ~= nil then
                return
            end
            local avatarMomentCamera = Workspace.CurrentCamera
            if avatarMomentCamera == nil then
                avatarMomentCamera = Instance.new("Camera")
                avatarMomentCamera.Name = "AvatarMomentCamera"
                avatarMomentCamera.Parent = Workspace
                Workspace.CurrentCamera = avatarMomentCamera
                var19 = avatarMomentCamera
            end

            var18 = saveCamera(avatarMomentCamera)
            var20.root.Parent = Workspace
            var20.root:PivotTo(cFrame)

            local function updateCamera() -- Luacid: Inlined by compiler; 1 call site recovered
                if Workspace.CurrentCamera ~= avatarMomentCamera then
                    return
                end
                avatarMomentCamera.CameraType = Enum.CameraType.Scriptable
                avatarMomentCamera.FieldOfViewMode = var20.camera.FieldOfViewMode
                avatarMomentCamera.FieldOfView = var20.camera.FieldOfView
                avatarMomentCamera.CFrame = cFrame * var20.camera.CFrame
                avatarMomentCamera.Focus = cFrame * var20.camera.Focus
            end

            updateCamera()
            connection = RunService.RenderStepped:Connect(updateCamera)
            if var9 ~= nil then
                var9.setShown(true)
            end
        end

        local function hideScene()
            local var20 = var16
            if var20 == nil or connection == nil then
                return
            end
            connection:Disconnect()
            connection = nil
            if var9 ~= nil then
                var9.setShown(false)
            end
            var20.root.Parent = nil
            restoreCamera(var18)
            var18 = nil
            if var19 == nil then
                return
            end

            if Workspace.CurrentCamera == var19 then
                Workspace.CurrentCamera = nil
            end
            var19:Destroy()
            var19 = nil
        end

        task.spawn(function()
            local str1 = "validate-outfit"
            local success, result = pcall(function()
                local source = tbl1.item.outfit.source
                if source.type ~= "outfit" then
                    error("Inline Avatar Moment requires an outfit annotation")
                end

                str1 = "decode-inline-scene"
                local var20 = decodeInlineMomentScene(tbl1.item.rbxmData, source.id)

                str1 = "create-moment-scene"
                return require(MomentsParent.MomentScenes).createMomentScene({ type = var20.type, args = var20.args })
            end)

            if current2 ~= var3.current then
                if success and result ~= nil then
                    disposeMomentScene(result)
                end

                return
            end

            if not success or result == nil then
                MomentsCommon.Analytics.fireAnalyticsEvent(MomentsCommon.Analytics.EventNames.AvatarMomentLoadFailed, {
                    stage = str1,
                    recommendationSource = var1.recommendationSource or "unknown",
                    momentId = moment.momentId,
                    feedItemId = feedItemId or "unknown"
                })

                setExternalBaseReadiness("Failed", `Avatar scene {str1} failed: {tostring(result)}`)
                return
            end

            local current2 = if pageRef == nil then nil else pageRef.current

            if FFlagProfileRenderAvatarMoments and current2 == nil then
                MomentsCommon.Analytics.fireAnalyticsEvent(MomentsCommon.Analytics.EventNames.AvatarMomentLoadFailed, {
                    stage = "attach-page",
                    recommendationSource = var1.recommendationSource or "unknown",
                    momentId = moment.momentId,
                    feedItemId = feedItemId or "unknown"
                })

                setExternalBaseReadiness("Failed", "Avatar scene attach-page failed: page ref was not attached")
                disposeMomentScene(result)
                return
            end

            var16 = result
            var7.current = result
            var8.current = false
            if FFlagProfileRenderAvatarMoments then
                var17 = observeGuiOnScreen(current2, function(bool3: boolean)
                    if bool3 then
                        showScene()
                        return
                    end
                    hideScene()
                end)
            else
                showScene()
            end
            setExternalBaseReadiness("Ready")
            var10(current.getState(false).isPlaying)
        end)

        return function()
            local var20 = var3
            var20.current += 1
            if var17 ~= nil then
                var17()
                var17 = nil
            end
            hideScene()
            local var21 = var16
            var16 = nil
            if var21 == nil then
                return
            end

            setExternalBaseReadiness("Loading")
            if var7.current == var21 then
                var7.current = nil
                var8.current = false
            end

            disposeMomentScene(var21)
        end
    end, {
        bool1,
        current,
        tbl1.item.rbxmData,
        tbl1.item.outfit.source,
        moment.momentId,
        feedItemId,
        var1.recommendationSource,
        var10,
        var9
    })

    if FFlagMomentsAvatarSceneStage then
        React.useEffect(function()
            local current = if pageRef == nil then nil else pageRef.current

            if current == nil then
                return nil
            end
            return getAvatarSceneStage().trackPage(current)
        end, {})

        local getIsVisible = VerticalPager.usePagerItem().getIsVisible

        local var15 = SignalsReact.useSignalState(getIsVisible)

        local var16 = React.useRef({ readiness = "Loading", failureReason = nil })

        local var17 = React.useRef(current)
        var17.current = current

        local var18 = React.useRef(var4)
        var18.current = var4

        local var19 = React.useCallback(function(readiness: string, failureReason: string?)
            var16.current = { readiness = readiness, failureReason = failureReason }
            local current = var17.current
            if current ~= nil then
                local setExternalBaseReadiness = current.setExternalBaseReadiness
                assert(setExternalBaseReadiness ~= nil, "Avatar Moments require external-base readiness")
                setExternalBaseReadiness(readiness, failureReason)
            end
        end, {})

        React.useEffect(function()
            if current ~= nil then
                local current = var16.current
                var19(current.readiness, current.failureReason)
            end
        end, { current, var19 })

        React.useEffect(function()
            if not var15 then
                return
            end

            var19("Loading")

            local var20 = var3
            var20.current += 1
            local current = var3.current
            local var21 = nil
            local var22 = nil

            task.spawn(function()
                local str1 = "validate-outfit"
                local success, result = pcall(function()
                    local source = tbl1.item.outfit.source
                    if source.type ~= "outfit" then
                        error("Inline Avatar Moment requires an outfit annotation")
                    end

                    str1 = "decode-inline-scene"
                    local var23 = decodeInlineMomentScene(tbl1.item.rbxmData, source.id)

                    str1 = "create-moment-scene"
                    return require(MomentsParent.MomentScenes).createMomentScene({ type = var23.type, args = var23.args })
                end)

                if current ~= var3.current then
                    if success and result ~= nil then
                        disposeMomentScene(result)
                    end

                    return
                end

                if not success or result == nil then
                    MomentsCommon.Analytics.fireAnalyticsEvent(MomentsCommon.Analytics.EventNames.AvatarMomentLoadFailed, {
                        stage = str1,
                        recommendationSource = var1.recommendationSource or "unknown",
                        momentId = moment.momentId,
                        feedItemId = feedItemId or "unknown"
                    })

                    var19("Failed", `Avatar scene {str1} failed: {tostring(result)}`)
                    return
                end

                local current2 = if pageRef == nil then nil else pageRef.current
                local current3 = if viewportFrameRef == nil then nil else viewportFrameRef.current
                local current4 = if worldModelRef == nil then nil else worldModelRef.current

                if current2 == nil or current3 == nil or current4 == nil then
                    MomentsCommon.Analytics.fireAnalyticsEvent(MomentsCommon.Analytics.EventNames.AvatarMomentLoadFailed, {
                        stage = "attach-page",
                        recommendationSource = var1.recommendationSource or "unknown",
                        momentId = moment.momentId,
                        feedItemId = feedItemId or "unknown"
                    })

                    var19("Failed", "Avatar scene attach-page failed: page refs were not attached")
                    disposeMomentScene(result)
                    return
                end

                var21 = result
                var7.current = result
                var8.current = false
                var22 = getAvatarSceneStage().register({ scene = result, page = current2, viewportFrame = current3, worldModel = current4 })

                if var9 ~= nil then
                    var9.trackPage(current2)
                end
                var19("Ready")
                var10(var18.current)
            end)

            return function()
                local var23 = var3
                var23.current += 1
                if var9 ~= nil then
                    var9.untrackPage()
                end
                if var22 ~= nil then
                    var22()
                    var22 = nil
                end
                local var24 = var21
                var21 = nil
                if var24 == nil then
                    return
                end

                var19("Loading")
                if var7.current == var24 then
                    var7.current = nil
                    var8.current = false
                end

                disposeMomentScene(var24)
            end
        end, {
            var15,
            tbl1.item.rbxmData,
            tbl1.item.outfit.source,
            moment.momentId,
            feedItemId,
            var1.recommendationSource,
            var19,
            var10,
            var9
        })
    end

    React.useEffect(function()
        var10(var4)
    end, { var4, var10 })

    local recommendationMetadata = moment.recommendationMetadata
    return {
        data = React.useMemo(function()
            return {
                kind = "avatar",
                momentId = moment.momentId,
                creatorId = moment.creatorId,
                creatorIsVerified = nil,
                description = moment.metadata.description,
                isModerated = moment.isModerated == true,
                commentCount = nil,
                feedItemId = recommendationMetadata.feedItemId,
                feedSessionId = recommendationMetadata.tracingId,
                contentType = if FFlagMomentsRecommendationContentType then "Avatar" else nil,
                outfit = tbl1.item.outfit
            }
        end, {
            moment,
            tbl1.item.outfit,
            recommendationMetadata.feedItemId,
            recommendationMetadata.tracingId
        }),
        moment = moment,
        pageRef = pageRef,
        viewportFrameRef = viewportFrameRef,
        worldModelRef = worldModelRef
    }
end

return useAvatarMomentViewModel
