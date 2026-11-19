-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:40:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")
local UserInputService = game:GetService("UserInputService")

local FocusUtils = require(CorePackages.Workspace.Packages.Chrome).FocusUtils

local InputType = require(CorePackages.Workspace.Packages.InputType)
local getInputGroup = InputType.getInputGroup
local var1 = require(CorePackages.Workspace.Packages.ExpChat).Stores.GetFocusNavigationStore(false)

local ChatSelector = require(RobloxGui.Modules.ChatSelector)

local function isUsingGamepad(): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return getInputGroup(UserInputService:GetLastInputType()) == InputType.InputTypeConstants.Gamepad
end

return function(_)
    if ChatSelector:GetVisibility() and isUsingGamepad() then
        FocusUtils.FocusOffChrome(function()
            var1.focusChatInputBar()
        end)
    end
end
