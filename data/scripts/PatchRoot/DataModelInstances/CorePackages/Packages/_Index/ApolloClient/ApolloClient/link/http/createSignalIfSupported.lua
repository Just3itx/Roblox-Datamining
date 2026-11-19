-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T05:30:32Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local module = {}

function module.createSignalIfSupported()
    local abortController = _G.AbortController
    if typeof(abortController) == "nil" then
        return { controller = false, signal = false }
    end
    local abortController2 = abortController.new()
    return {
        controller = abortController2,
        signal = abortController2.signal
    }
end

return module
