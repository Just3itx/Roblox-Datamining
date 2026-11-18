-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-18T23:30:50Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local var1 = nil
local bool1 = false
local function func1() -- Luacid: Inlined by compiler; 1 call site recovered
    if not bool1 then
        local success, result = pcall(function(): AudioFocusService
            return game:GetService("AudioFocusService")
        end)
        if success and result then
            var1 = result
        end
        bool1 = true
    end
    return var1
end

return function(callback: (...any) -> (...any))
    local var2 = func1()

    if not var2 then
        return
    end

    local focusedContextId = var2:GetFocusedContextId()
    callback(focusedContextId)
    local function func2()
        local focusedContextId2 = var2:GetFocusedContextId()
        if focusedContextId ~= focusedContextId2 then
            focusedContextId = focusedContextId2
            callback(focusedContextId)
        end
    end
    var2.OnContextRegistered:Connect(func2)
    var2.OnContextUnregistered:Connect(func2)
    var2.OnDeafenVoiceAudio:Connect(func2)
    var2.OnUndeafenVoiceAudio:Connect(func2)
end
