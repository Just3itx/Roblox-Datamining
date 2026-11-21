-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T18:01:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameDetailParent = script:FindFirstAncestor("GameDetail").Parent
local isSubjectToDesktopPolicies = require(GameDetailParent.SharedFlags).isSubjectToDesktopPolicies
local Players = game:GetService("Players")

return function(): boolean
    return if Players.LocalPlayer then not isSubjectToDesktopPolicies() else false
end
