-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:31:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent
local Signals = require(ExpChatParent.Signals)
local createSignal = Signals.createSignal
local FFlagExpChatDictationFadeOverride = require(ExpChat.Flags.FFlagExpChatDictationFadeOverride)

local function func1() end

return function()
    local getLastActivity, var2 = createSignal(0)
    local getLastMessageActivity, var4 = createSignal(0)
    local getIsTextBoxFocused, var6 = createSignal(false)
    local var7, var8 = createSignal(false)
    local var9, var10 = createSignal(false)
    local var11, var12 = createSignal(false)

    local function resetAllTransparency() -- Luacid: Inlined by compiler; 9 call sites recovered
        var2(os.clock())
        var4(os.clock())
    end

    local function withResetAllTransparency(callback) -- Luacid: Inlined by compiler; 8 call sites recovered
        return function()
            callback()
            resetAllTransparency()
        end
    end

    return {
        getLastActivity = getLastActivity,
        getLastMessageActivity = getLastMessageActivity,
        getIsTextBoxFocused = getIsTextBoxFocused,
        getIsFocused = Signals.createComputed(function(arg1)
            return getIsTextBoxFocused(arg1) or var7(arg1) or var9(arg1) or FFlagExpChatDictationFadeOverride and var11(arg1)
        end),
        resetAllTransparency = resetAllTransparency,
        resetTextTransparency = function()
            var4(os.clock())
        end,
        setTextboxFocus = withResetAllTransparency(function()
            var6(true)
        end),
        clearTextboxFocus = withResetAllTransparency(function()
            var6(false)
        end),
        setWindowFocusInput = withResetAllTransparency(function()
            var8(true)
        end),
        clearWindowFocusInput = withResetAllTransparency(function()
            var8(false)
        end),
        setContextMenuOpen = withResetAllTransparency(function()
            var10(true)
        end),
        clearContextMenuOpen = withResetAllTransparency(function()
            var10(false)
        end),
        setDictationActive = if FFlagExpChatDictationFadeOverride then withResetAllTransparency(function()
            var12(true)
        end) else func1,
        clearDictationActive = if FFlagExpChatDictationFadeOverride then withResetAllTransparency(function()
            var12(false)
        end) else func1
    }
end
