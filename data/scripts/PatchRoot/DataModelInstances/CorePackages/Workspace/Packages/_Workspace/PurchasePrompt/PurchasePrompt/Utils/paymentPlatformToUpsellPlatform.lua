-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T08:01:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local PaymentPlatform = require(scriptParentParent.Enums.PaymentPlatform)

return function(arg1): string
    if arg1 == PaymentPlatform.Web then
        return "Web"
    end

    if arg1 == PaymentPlatform.Apple then
        return "AppleAppStore"
    end

    if arg1 == PaymentPlatform.Google then
        return "GooglePlayStore"
    end

    if arg1 == PaymentPlatform.Amazon then
        return "AmazonStore"
    end

    if arg1 == PaymentPlatform.UWP then
        return "WindowsStore"
    end

    if arg1 == PaymentPlatform.Xbox then
        return "XboxStore"
    end

    if arg1 == PaymentPlatform.Maquettes then
        return "MaquettesStore"
    end

    if arg1 == PaymentPlatform.Palisades then
        return "PalisadesStore"
    end

    if arg1 == PaymentPlatform.Microsoft then
        return "MicrosoftStore"
    end

    if arg1 == PaymentPlatform.MilkyWay then
        return "MilkyWayStore"
    end

    if arg1 == PaymentPlatform.Pioneer then
        return "PioneerStore"
    end

    return "None"
end
