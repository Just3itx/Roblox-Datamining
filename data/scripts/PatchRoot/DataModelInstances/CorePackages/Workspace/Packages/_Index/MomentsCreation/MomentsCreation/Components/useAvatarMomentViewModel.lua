-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:01:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreation = script:FindFirstAncestor("MomentsCreation")
local MomentsCreationParent = MomentsCreation.Parent

local React = require(MomentsCreationParent.React)

local _AvatarMomentView = require(script.Parent.AvatarMomentView)
local Constants = require(MomentsCreation.Constants)
local useCreationMusicSync = require(MomentsCreation.Hooks.useCreationMusicSync)
local _CreationFlowTypes = require(MomentsCreation.Types.CreationFlowTypes)

local function disposeMomentScene(arg1) -- Luacid: Inlined by compiler; 3 call sites recovered
    pcall(function()
        arg1.root.Parent = nil
    end)
    pcall(arg1.dispose)
end

local function useAvatarMomentViewModel(tbl1)
    local preview = tbl1.preview
    local viewportFrameRef = React.useRef(nil)
    local var2 = React.useRef(nil)
    local var3 = React.useRef(nil)
    local var4 = React.useRef(0)

    local var5 = useCreationMusicSync(preview, Constants.ScreenshotMusicDuration, tbl1.ttsAudio)
    local music = var5.music
    local elapsed = var5.audio.timeline.elapsed

    React.useEffect(function()
        preview.bindEngine(nil)
        preview.setDuration(Constants.ScreenshotMusicDuration)
        preview.setTimeLength(Constants.ScreenshotMusicDuration)
        preview.setPosition(0)
        preview.setReadiness("Loading")

        local var6 = var4
        var6.current += 1
        local current = var4.current
        task.spawn(function()
            local success, result = pcall(function()
                return require(MomentsCreationParent.MomentScenes).createMomentScene(tbl1.avatarMoment.SceneSpec)
            end)
            if current ~= var4.current then
                if success and result ~= nil then
                    disposeMomentScene(result)
                end

                return
            end

            if not success or result == nil then
                warn(`Failed to build Avatar Moment scene: {result}`)
                preview.setReadiness("Failed")
                return
            end

            local current2 = viewportFrameRef.current
            local current3 = var2.current
            if current2 == nil or current3 == nil then
                disposeMomentScene(result)
                return
            end

            var3.current = result
            result.root.Parent = current3
            current2.CurrentCamera = result.camera
            result.playhead.play()
            preview.setReadiness("Ready")
        end)

        return function()
            local var7 = var4
            var7.current += 1
            local current2 = var3.current
            var3.current = nil
            if current2 ~= nil then
                disposeMomentScene(current2)
            end
        end
    end, { preview, tbl1.avatarMoment })

    React.useEffect(function()
        local setPosition = preview.setPosition
        local var6 = if music == nil then 0 else math.clamp(elapsed, 0, Constants.ScreenshotMusicDuration)
        setPosition(var6)
    end, { preview, music, elapsed })

    return {
        viewportFrameRef = viewportFrameRef,
        worldModelRef = React.useCallback(function(current)
            if current == nil and var3.current ~= nil then
                pcall(function()
                    var3.current.root.Parent = nil
                end)
            end
            var2.current = current
        end, {}),
        onAbsoluteSizeChanged = React.useCallback(function(arg1)
            if tbl1.onAbsoluteSizeChanged ~= nil then
                tbl1.onAbsoluteSizeChanged(arg1)
            end
            if tbl1.onResolutionChanged ~= nil then
                tbl1.onResolutionChanged(arg1.AbsoluteSize)
            end
        end, { tbl1.onAbsoluteSizeChanged, tbl1.onResolutionChanged }),
        children = tbl1.children
    }
end

return useAvatarMomentViewModel
