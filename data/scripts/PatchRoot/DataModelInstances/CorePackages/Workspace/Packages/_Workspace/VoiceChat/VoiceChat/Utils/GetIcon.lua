-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:31:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
function getIconSrc(str1: string, str2: string): string
    return "rbxasset://textures/ui/VoiceChat/" .. (str2 and str2 .. "/" or "") .. str1 .. ".png"
end

return function(str1: string, str2: string, num1: number?)
    if str1 ~= "Unmuted" then
        return getIconSrc(str1, str2)
    end

    local num2 = math.floor(0.5 + 5 * (num1 or math.random())) * 20
    return num1 and getIconSrc("Unmuted" .. tostring(num2), str2) or getIconSrc("Blank", str2)
end
