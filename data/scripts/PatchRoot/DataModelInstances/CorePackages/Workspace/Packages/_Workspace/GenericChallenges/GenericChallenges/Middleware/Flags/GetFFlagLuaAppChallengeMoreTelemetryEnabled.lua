-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T16:31:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
game:DefineFastFlag("EnableNativeToWebviewMiddleware", false)

return function(): boolean
    return game:GetFastFlag("EnableNativeToWebviewMiddleware")
end
