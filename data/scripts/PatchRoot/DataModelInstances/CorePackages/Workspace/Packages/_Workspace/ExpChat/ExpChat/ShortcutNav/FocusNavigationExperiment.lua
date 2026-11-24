-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:20:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChatParent = script:FindFirstAncestor("ExpChat").Parent
local IXPServiceWrapper = require(ExpChatParent.IxpServiceWrapper).IXPServiceWrapper

local isTabNavEnabled = game:DefineFastFlag("ExpChatFocusNavigation", false)
local isExposureLoggingEnabled = game:DefineFastFlag("ExpChatFocusNavigationIxpEnabled", false)
local isBackupExposureLoggingEnabled = game:DefineFastFlag("ExpChatFocusNavigationBackupIxpEnabled", false)

local str1 = game:DefineFastString("ExpChatFocusNavigationIxpLayer", "ExperienceChat.FocusNavigation")

return {
    isTabNavEnabled = isTabNavEnabled,
    isExposureLoggingEnabled = isExposureLoggingEnabled,
    isBackupExposureLoggingEnabled = isBackupExposureLoggingEnabled,
    logExposure = function()
        IXPServiceWrapper:LogFlagLinkedUserLayerExposure(str1)
    end
}
