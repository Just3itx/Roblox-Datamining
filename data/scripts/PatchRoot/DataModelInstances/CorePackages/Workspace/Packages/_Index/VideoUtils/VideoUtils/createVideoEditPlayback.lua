-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T04:10:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local createVideoEditMusic = require(script.Parent.createVideoEditMusic)
local getVideoEdits = require(script.Parent.getVideoEdits)

local function createVideoEditPlayback(arg1, arg2, bool1: boolean, func1: (...any) -> (...any), tbl1)
    local var1 = if tbl1 then tbl1.step else game:GetService("RunService").RenderStepped
    local var2 = if tbl1 then tbl1.createMusic else createVideoEditMusic
    local tbl2 = {}
    local var3 = nil
    local bool2 = true
    local bool3 = false
    local bool4 = false
    local bool5 = false
    local playbackRange = 0
    local num1 = 0

    local function musicPosition(): number -- Luacid: Inlined by compiler; 7 call sites recovered
        return (if arg2.music then arg2.music.startTime else 0) + math.max(0, arg1.TimePosition - playbackRange)
    end

    local function syncMusic() -- Luacid: Inlined by compiler; 5 call sites recovered
        if var3 then
            var3.setPosition((musicPosition()))
        end
    end

    local function updateMusic()
        var3 = not not (not bool2 and bool3 and arg1.Playing)
            and not bool4
            and arg2.music
            and var3 == nil
            and var2(arg2.music.assetId, musicPosition)
        syncMusic()

        if var3 then
            var3.setPlaying(not bool2 and bool3 and arg1.Playing and not bool4)
        end
    end

    local function finish() -- Luacid: Inlined by compiler; 4 call sites recovered
        if bool4 then
            return
        end
        bool4 = true
        arg1:Pause()
        updateMusic()
        local onEnded = func1().onEnded
        if onEnded then
            onEnded()
        end
    end

    local function onLooped()
        syncMusic()
        updateMusic()
        local onLooped2 = func1().onLooped
        if onLooped2 then
            onLooped2()
        end
    end

    local function onLoaded() -- Luacid: Inlined by compiler; 1 call site recovered
        if bool3 then
            return
        end
        bool3 = true
        playbackRange, num1 = getVideoEdits.getPlaybackRange(arg1.TimeLength, arg2.trim)
        arg1.TimePosition = playbackRange
        if num1 <= playbackRange then
            finish()
            return
        end

        arg1:Play()
    end

    local loaded = arg1.Loaded
    table.insert(tbl2, loaded:Connect(onLoaded))

    local played = arg1.Played

    table.insert(tbl2, played:Connect(function()
        if bool4 then
            bool4 = false
            arg1.TimePosition = playbackRange
        end

        syncMusic()
        updateMusic()
    end))

    local paused = arg1.Paused
    table.insert(tbl2, paused:Connect(updateMusic))

    local ended = arg1.Ended

    table.insert(tbl2, ended:Connect(function()
        if not bool1 or not arg2.trim or not (playbackRange < num1) or bool4 then
            finish()
            return
        end

        arg1.TimePosition = playbackRange
        syncMusic()
        updateMusic()
        local onLooped2 = func1().onLooped
        if onLooped2 then
            onLooped2()
        end

        arg1:Play()
    end))
    local didLoop = arg1.DidLoop
    table.insert(tbl2, didLoop:Connect(onLooped))
    table.insert(tbl2, var1:Connect(function()
        if not bool3 or not arg1.Playing or bool4 or not arg2.trim or not (arg1.TimePosition >= num1) then
            return
        end

        if not bool1 then
            arg1.TimePosition = num1
            finish()
            return
        end

        arg1.TimePosition = playbackRange
        syncMusic()
        updateMusic()
        local onLooped2 = func1().onLooped
        if onLooped2 then
            onLooped2()
        end
    end))

    if arg1.IsLoaded then
        onLoaded()
    end

    return {
        setMuted = function(bool6: boolean)
            bool2 = bool6

            if not bool2 and var3 then
                var3.setPosition((musicPosition()))
            end

            updateMusic()
        end,
        destroy = function()
            if bool5 then
                return
            end
            bool5 = true
            for _, value in tbl2 do
                value:Disconnect()
            end

            arg1:Pause()
            if var3 then
                var3.destroy()
            end
        end
    }
end

return createVideoEditPlayback
