-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T05:30:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
game:DefineFastString("AdPlayerExitButton", "icons/navigation/close")
game:DefineFastString("AdDropdownButtonDefault", "rbxassetid://85625850440429")
game:DefineFastString("AdDropdownButtonOpen", "rbxassetid://85625850440429")

return {
    GetAdPlayerExitButton = function(): string
        return game:GetFastString("AdPlayerExitButton")
    end,
    GetAdDropdownButtonDefault = function(): string
        return game:GetFastString("AdDropdownButtonDefault")
    end,
    GetAdDropdownButtonOpen = function(): string
        return game:GetFastString("AdDropdownButtonOpen")
    end
}
