-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:40:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local CorePackages = game:GetService("CorePackages")
local IXPServiceWrapper = require(CorePackages.Workspace.Packages.IxpServiceWrapper).IXPServiceWrapper
local bool1 = game:DefineFastFlag("ClientToastNotificationsRedirect4", false)
local bool2 = game:DefineFastFlag("EnableClientToastNotificationsRedirectExperiment", false)
local str1 = game:DefineFastString("ClientToastNotificationsRedirectLayerName", "Notification.Toast")
local str2 = game:DefineFastString("ClientToastNotificationsRedirectLayerValue", "NotificationRedirect")

local bool3 = false
local var1 = nil
local var2 = nil

return function()
    if bool2 and not bool3 then
        var1, var2 = pcall(function()
            bool3 = true
            return IXPServiceWrapper:GetLayerData(str1)
        end)
    end

    return bool1 or var1 and var2 and var2[str2]
end
