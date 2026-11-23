-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:31:09Z
-- Luau bytecode version: 14 | Luau type version: 3
game:DefineFastString("UnfilteredMessageLightHexColor", "335FFF")
game:DefineFastString("UnfilteredMessagePressedLightHexColor", "0031E5")
game:DefineFastString("UnfilteredMessageDarkHexColor", "335FFF")
game:DefineFastString("UnfilteredMessagePressedDarkHexColor", "0031E5")
game:DefineFastInt("UnfilteredMessageTransparencyHundredths", 0)

return {
    UnfilteredMessageLightColor3 = Color3.fromHex(game:GetFastString("UnfilteredMessageLightHexColor")),
    UnfilteredMessagePressedLightColor3 = Color3.fromHex(game:GetFastString("UnfilteredMessagePressedLightHexColor")),
    UnfilteredMessageDarkColor3 = Color3.fromHex(game:GetFastString("UnfilteredMessageDarkHexColor")),
    UnfilteredMessagePressedDarkColor3 = Color3.fromHex(game:GetFastString("UnfilteredMessagePressedDarkHexColor")),
    UnfilteredMessageTransparency = game:GetFastInt("UnfilteredMessageTransparencyHundredths") / 100
}
