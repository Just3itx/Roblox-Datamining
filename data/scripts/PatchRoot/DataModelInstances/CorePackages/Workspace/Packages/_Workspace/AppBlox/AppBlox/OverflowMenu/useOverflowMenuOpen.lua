-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T06:31:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppBlox = script:FindFirstAncestor("AppBlox")

local AppBloxParent = AppBlox.Parent
local useSignalState = require(AppBloxParent.SignalsReact).useSignalState
local getOverflowMenuSignalStore = require(AppBlox.OverflowMenu.getOverflowMenuSignalStore)

local function useOverflowMenuOpen(str1: string): boolean
    local getActiveMenuKey = getOverflowMenuSignalStore().getActiveMenuKey
    return useSignalState(getActiveMenuKey) == str1
end

return useOverflowMenuOpen
