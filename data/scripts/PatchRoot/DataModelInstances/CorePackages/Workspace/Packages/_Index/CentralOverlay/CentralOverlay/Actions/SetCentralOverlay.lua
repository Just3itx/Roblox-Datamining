-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T06:21:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CentralOverlayParent = script:FindFirstAncestor("CentralOverlay").Parent
return require(CentralOverlayParent.Rodux).makeActionCreator(script.Name, function(overlayType, arg1, configs)
    return { overlayType = overlayType, arguments = arg1, configs = configs }
end)
