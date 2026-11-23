-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T06:10:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(arg1): () -> string
    local function getPlatformTarget(): string
        local str1 = "unknownLua"
        local none = Enum.Platform.None

        pcall(function()
            none = arg1:GetPlatform()
        end)

        local windows = Enum.Platform.Windows
        local bool1

        if none == windows then
            bool1 = true
        else
            local osx = Enum.Platform.OSX
            bool1 = none == osx
        end
        local ios = Enum.Platform.IOS
        local bool2

        if none == ios then
            bool2 = true
        else
            local android = Enum.Platform.Android
            bool2 = none == android
        end

        if not bool2 then
            local uwp = Enum.Platform.UWP
            bool2 = none == uwp
        end
        local xBox360 = Enum.Platform.XBox360
        local engineFeature

        if none == xBox360 then
            engineFeature = true
        else
            local xBoxOne = Enum.Platform.XBoxOne
            engineFeature = none == xBoxOne
        end

        if not engineFeature then
            local ps3 = Enum.Platform.PS3

            if none == ps3 then
                engineFeature = true
            else
                local ps4 = Enum.Platform.PS4

                if none == ps4 then
                    engineFeature = true
                else
                    engineFeature = game:GetEngineFeature("PlatformEnumPS5")

                    if engineFeature then
                        local ps5 = Enum.Platform.PS5
                        engineFeature = none == ps5
                    end
                end
            end
        end

        if not engineFeature then
            local wiiU = Enum.Platform.WiiU
            engineFeature = none == wiiU
        end

        return if bool1 then "client" elseif bool2 then "mobile" elseif engineFeature then "console" else str1 .. tostring(none)
    end

    return getPlatformTarget
end
