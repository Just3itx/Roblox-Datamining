-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T00:19:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TransientUIOverlay = script:FindFirstAncestor("TransientUIOverlay")
local TransientUIOverlayParent = TransientUIOverlay.Parent

local Signals = require(TransientUIOverlayParent.Signals)

local _Types = require(TransientUIOverlay.Types)

local function createTransientUIOverlayStore()
    local currentSnackbar, var2 = Signals.createSignal(nil)
    local currentDialog, var4 = Signals.createSignal(nil)
    local var5, var6 = Signals.createSignal(nil)
    local dialogPresentationId, var8 = Signals.createSignal(0)

    local function setTimer(thread1: thread?) -- Luacid: Inlined by compiler; 5 call sites recovered
        var6(thread1)
    end

    local function cancelTimer() -- Luacid: Inlined by compiler; 2 call sites recovered
        local var9 = var5(false)
        if var9 then
            task.cancel(var9)
            setTimer(nil)
        end
    end

    return {
        currentSnackbar = currentSnackbar,
        currentDialog = currentDialog,
        dialogPresentationId = dialogPresentationId,
        displaySnackbar = function(arg1, num1: number)
            cancelTimer()
            var2(arg1)
            setTimer((task.delay(num1, function()
                setTimer(nil)
                var2(nil)
            end)))
        end,
        displayDialog = function(arg1)
            var8(dialogPresentationId(false) + 1)
            var4(arg1)
        end,
        clearSnackbar = function()
            cancelTimer()
            var2(nil)
        end,
        clearDialog = function()
            var4(nil)
        end
    }
end
return createTransientUIOverlayStore
