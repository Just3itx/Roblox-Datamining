-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:50:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

task.spawn(function()
    require(CorePackages.Workspace.Packages.InExperienceOffers.prefetchOffersOnGameJoin)()
end)

return true
