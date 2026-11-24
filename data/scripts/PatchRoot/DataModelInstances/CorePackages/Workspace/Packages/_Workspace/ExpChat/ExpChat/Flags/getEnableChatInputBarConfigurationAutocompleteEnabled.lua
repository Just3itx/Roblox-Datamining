-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T08:41:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(): boolean
    return game:GetEngineFeature("EnableChatInputBarConfigurationAutocompleteEnabled")
        and not game:GetService("UserInputService").TouchEnabled
end
