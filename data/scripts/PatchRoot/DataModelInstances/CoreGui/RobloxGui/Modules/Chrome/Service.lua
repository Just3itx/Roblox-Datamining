-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:00:29Z
-- Luau bytecode version: 14 | Luau type version: 3
local CorePackages = game:GetService("CorePackages")
local Chrome = script:FindFirstAncestor("Chrome")

assert(
    require(CorePackages.Workspace.Packages.Chrome).Enabled(),
    "Chrome.Service should not be initialized when Chrome is not enabled"
)
return (require(Chrome.ChromeShared.Service))
