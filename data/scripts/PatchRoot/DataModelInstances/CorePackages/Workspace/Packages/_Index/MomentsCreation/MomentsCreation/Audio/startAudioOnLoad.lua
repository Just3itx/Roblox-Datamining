-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:50:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function startAudioOnLoad(arg1, func1: (...any) -> (...any))
    local function startIfLoaded() -- Luacid: Inlined by compiler; 1 call site recovered
        if not arg1.IsReady then
            return
        end

        arg1.TimePosition = arg1.PlaybackRegion.Min
        if not func1() then
            return
        end

        arg1.PlaybackSpeed = 1
        if not arg1.IsPlaying then
            arg1:Play()
        end
    end

    local connection = arg1:GetPropertyChangedSignal("IsReady"):Connect(startIfLoaded)
    startIfLoaded()
    return connection
end

return startAudioOnLoad
