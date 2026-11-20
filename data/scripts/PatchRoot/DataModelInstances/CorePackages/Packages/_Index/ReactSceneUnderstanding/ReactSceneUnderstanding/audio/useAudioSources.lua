-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:41:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ReactSceneUnderstanding = script:FindFirstAncestor("ReactSceneUnderstanding")

local SoundService = game:GetService("SoundService")

local Cryo = require(ReactSceneUnderstanding.Parent.Cryo)
local React = require(ReactSceneUnderstanding.Parent.React)
local useTimedLoop = require(ReactSceneUnderstanding.useTimedLoop)

local useState = React.useState

local function getAllAudioSources()
    local success, result = pcall(function()
        return SoundService:GetAudioInstances()
    end)

    if success then
        return Cryo.List.filter(result, function(arg1)
            return arg1:IsA("Sound") or arg1:IsA("AudioPlayer")
        end)
    end
    return {}
end

local function useAudioSources()
    local var1, var2 = useState(getAllAudioSources)

    useTimedLoop(1, function()
        var2(getAllAudioSources())
    end)

    return var1
end

return useAudioSources
