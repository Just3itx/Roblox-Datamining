-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:40:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}
module.__index = module

function module.new(isEnabled, enableVoice, getPropertyChangedSignal, getClientFeaturesAsync)
    return (setmetatable({
        IsEnabled = isEnabled,
        EnableVoice = enableVoice,
        GetPropertyChangedSignal = getPropertyChangedSignal,
        GetClientFeaturesAsync = getClientFeaturesAsync
    }, module))
end

return module
