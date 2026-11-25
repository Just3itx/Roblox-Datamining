-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T15:31:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialContextToasts = script:FindFirstAncestor("SocialContextToasts")
local SocialContextToastsParent = SocialContextToasts.Parent
local Rodux = require(SocialContextToastsParent.Rodux)
local _ToastRoot = require(SocialContextToasts.ToastRoot)

return Rodux.makeActionCreator(script.Name, function(toastContent)
    return { toastContent = toastContent }
end)
