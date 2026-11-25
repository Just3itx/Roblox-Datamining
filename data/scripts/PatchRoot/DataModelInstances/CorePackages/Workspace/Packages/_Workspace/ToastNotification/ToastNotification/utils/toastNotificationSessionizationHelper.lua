-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T19:40:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SessionService = game:GetService("SessionService")
local scriptParentParent = script.Parent.Parent
local constants = require(scriptParentParent.constants)
local type = require(scriptParentParent.type)

return function(str1: string)
    if str1 == type.ToastNotificationActionsEnum.Display then
        SessionService:SetSession(
            constants.ToastStructuralIdentifier.Level1,
            constants.ToastStructuralIdentifier.ToastNotification,
            constants.ToastStructuralIdentifier.ToastNotification
        )
    elseif str1 == type.ToastNotificationActionsEnum.Dismissed or str1 == type.ToastNotificationActionsEnum.Ignored then
        SessionService:RemoveSession(constants.ToastStructuralIdentifier.ToastNotification)
    end
end
