-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:11:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function createPlaybackToggleIndicatorMachine(tbl1, tbl2)
    local getPhase = "hidden"

    local var1 = nil

    local function clearTimer() -- Luacid: Inlined by compiler; 3 call sites recovered
        if var1 ~= nil then
            var1()
            var1 = nil
        end
    end

    local function onExitElapsed()
        var1 = nil
        getPhase = "hidden"
        tbl2.setMounted(false)
    end

    local function beginExit()
        var1 = nil
        getPhase = "exiting"
        tbl2.animate("exit")
        var1 = tbl2.schedule(tbl1.exitDurationMs, onExitElapsed)
    end

    local function armDwell() -- Luacid: Inlined by compiler; 1 call site recovered
        clearTimer()
        var1 = tbl2.schedule(tbl1.dwellMs, beginExit)
    end

    return {
        notifyUserToggle = function()
            if getPhase == "hidden" then
                getPhase = "shown"
                tbl2.setMounted(true)
                tbl2.animate("enter")
            elseif getPhase == "exiting" then
                getPhase = "shown"
                tbl2.animate("enter")
            end

            armDwell()
        end,
        getPhase = function()
            return getPhase
        end,
        dispose = function()
            clearTimer()
        end
    }
end
return createPlaybackToggleIndicatorMachine
