-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:51:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local PaymentPlatform = require(scriptParentParent.Enums.PaymentPlatform)
local FFlagEnablePioneerPaymentsPlatform = require(scriptParentParent.Flags.FFlagEnablePioneerPaymentsPlatform)
local getIsPioneerBuild = require(scriptParentParent.Utils.getIsPioneerBuild)

return function(platform, arg1, arg2)
    if platform == Enum.Platform.XBoxOne then
        return PaymentPlatform.Xbox
    end

    if platform == Enum.Platform.IOS then
        if arg1 then
            return PaymentPlatform.Midas
        end

        return PaymentPlatform.Apple
    end

    if platform == Enum.Platform.Windows or platform == Enum.Platform.OSX or platform == Enum.Platform.Linux then
        if FFlagEnablePioneerPaymentsPlatform and getIsPioneerBuild() then
            return PaymentPlatform.Pioneer
        end

        return PaymentPlatform.Web
    end

    if platform ~= Enum.Platform.Android then
        if platform == Enum.Platform.UWP then
            return PaymentPlatform.UWP
        end

        return PaymentPlatform.None
    end

    if arg1 then
        return PaymentPlatform.Midas
    end

    if arg2 then
        return PaymentPlatform.Amazon
    end

    return PaymentPlatform.Google
end
