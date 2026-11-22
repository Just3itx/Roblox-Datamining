-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:40:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local var1 = nil

local function playDragToDeleteHaptic()
    pcall(function()
        if var1 == nil then
            local hapticEffect = Instance.new("HapticEffect")
            hapticEffect.Type = Enum.HapticEffectType.UIClick
            hapticEffect.Position = Vector3.new(0, 0, 0)
            hapticEffect.Radius = 100
            hapticEffect.Parent = workspace
            var1 = hapticEffect
        end
        var1:Play()
    end)
end

return playDragToDeleteHaptic
