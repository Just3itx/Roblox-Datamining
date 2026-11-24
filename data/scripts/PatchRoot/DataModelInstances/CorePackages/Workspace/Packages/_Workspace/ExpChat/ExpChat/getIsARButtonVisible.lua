-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T08:50:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent
local ExpChatShared = require(ExpChatParent.ExpChatShared)

local _createPresetChatStore = require(ExpChat.Stores.GetPresetChatStore.createPresetChatStore)
local isChatRegionLocked = require(ExpChat.isChatRegionLocked)
local showChatEnabledUI = require(ExpChat.showChatEnabledUI)

local FFlagExpChatTopBannerForPresetChatAccess = ExpChat.Flags.FFlagExpChatTopBannerForPresetChatAccess
local FFlagExpChatPresetChatEnabled = ExpChatShared.Flags.FFlagExpChatPresetChatEnabled

local function getIsARButtonVisible(str1: string, bool1: boolean, arg1): boolean
    return not isChatRegionLocked()
        and (if showChatEnabledUI(str1) then true elseif FFlagExpChatPresetChatEnabled and FFlagExpChatTopBannerForPresetChatAccess then bool1 and arg1 ~= "Disabled" else false)
end

return getIsARButtonVisible
