-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:41:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ReactSceneUnderstanding = script:FindFirstAncestor("ReactSceneUnderstanding")

local React = require(ReactSceneUnderstanding.Parent.React)
local ReactUtils = require(ReactSceneUnderstanding.Parent.ReactUtils)
local SceneAnalysisContext = require(ReactSceneUnderstanding.SceneAnalysisContext)
local enums = require(ReactSceneUnderstanding.enums)
local useCameraState = require(ReactSceneUnderstanding.useCameraState)
local sortByAudibleVolume = require(ReactSceneUnderstanding.audio.sortByAudibleVolume)
local useAudioSources = require(ReactSceneUnderstanding.audio.useAudioSources)
local useTimedLoop = require(ReactSceneUnderstanding.useTimedLoop)

local useCallback = React.useCallback
local useEffect = React.useEffect
local usePrevious = ReactUtils.usePrevious

local function useAudibleSounds()
    local var1 = SceneAnalysisContext.use()
    local var2 = useAudioSources()
    local var3 = useCameraState()
    local var4 = usePrevious(var3)

    local var5 = useCallback(function()
        var1.setAudibleSounds(sortByAudibleVolume(var2))
    end, { var2, var1.setAudibleSounds })

    useTimedLoop(1, function()
        var5()
    end)

    useEffect(function()
        if #var1.audibleSounds == 0 and #var2 > 0 then
            var5()
        end
    end, { #var1.audibleSounds, #var2, var5 })

    useEffect(function()
        if var3 ~= var4 and var3 == enums.CameraState.Idle then
            var5()
        end
    end, { var3, var4, var5 })

    return var1.audibleSounds
end

return useAudibleSounds
