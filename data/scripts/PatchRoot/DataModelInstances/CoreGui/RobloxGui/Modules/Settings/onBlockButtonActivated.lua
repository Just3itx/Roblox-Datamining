-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:10:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local ContextActionService = game:GetService("ContextActionService")
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")
local GuiService = game:GetService("GuiService")
local RobloxGui = CoreGui:WaitForChild("RobloxGui")

local Roact = require(CorePackages.Packages.Roact)
local Promise = require(CorePackages.Packages.Promise)

local CoreScriptsRootProvider = require(CorePackages.Workspace.Packages.CoreScriptsRoactCommon).CoreScriptsRootProvider
local PlayerList = require(CorePackages.Workspace.Packages.PlayerList)

local BlockingAnalytics = require(script.Parent.Analytics.BlockingAnalytics)
local BlockingModalScreen = require(script.Parent.Components.Blocking.BlockingModalScreen)

local FFlagAddNewPlayerListMobileFocusNav = PlayerList.Flags.FFlagAddNewPlayerListMobileFocusNav

local var1 = nil

local function func1() -- Luacid: Inlined by compiler; 2 call sites recovered
    if var1 ~= nil then
        Roact.unmount(var1)
        var1 = nil
        ContextActionService:UnbindCoreAction("BlockingModalScreen")
    end
end

return function(player, arg1, source, arg2)
    return Promise.new(function(callback)
        local analytics = arg1 or BlockingAnalytics.new()
        analytics:action("SettingsHub", "blockUserButtonClick", { blockeeUserId = player.UserId, source = source })
        func1()

        local function closeModal()
            func1()
            callback()
            if FFlagAddNewPlayerListMobileFocusNav then
                if arg2 and arg2.onBlockingModalClose then
                    arg2.onBlockingModalClose()
                end
            elseif FFlagAddNewPlayerListMobileFocusNav then
                GuiService.SelectedCoreObject = nil
            end
        end

        local blockingModalScreen = Roact.createElement(BlockingModalScreen, {
            player = player,
            closeModal = closeModal,
            analytics = analytics,
            source = source,
            onBlockingSuccess = if arg2 then arg2.onBlockingSuccess or nil else nil
        })

        local element2 = Roact.createElement(CoreScriptsRootProvider, {}, { BlockingModalScreen = blockingModalScreen })

        var1 = Roact.mount(element2, RobloxGui, "BlockingContainer")
        ContextActionService:BindCoreAction("BlockingModalScreen", closeModal, false, Enum.KeyCode.ButtonB, Enum.KeyCode.Escape)
    end)
end
