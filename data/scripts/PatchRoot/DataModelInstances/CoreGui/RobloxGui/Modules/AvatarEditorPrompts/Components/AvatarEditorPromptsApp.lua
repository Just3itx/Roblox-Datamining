-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:11:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local CoreGui = game:GetService("CoreGui")
local GuiService = game:GetService("GuiService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)
local RoactGamepad = require(CorePackages.Packages.RoactGamepad)
local t = require(CorePackages.Packages.t)
local ExternalEventConnection = require(CorePackages.Workspace.Packages.RoactUtils).ExternalEventConnection

local Connection = require(script.Parent.Connection)

local Prompts = script.Parent.Prompts
local AllowInventoryReadAccessPrompt = require(Prompts.AllowInventoryReadAccessPrompt)
local SaveAvatarPrompt = require(Prompts.SaveAvatarPrompt)
local SaveAvatarTimeoutPrompt = require(Prompts.SaveAvatarTimeoutPrompt)
local CreateOutfitPrompt = require(Prompts.CreateOutfitPrompt)
local EnterOutfitNamePrompt = require(Prompts.EnterOutfitNamePrompt)
local SetFavoritePrompt = require(Prompts.SetFavoritePrompt)
local DeleteOutfitPrompt = require(Prompts.DeleteOutfitPrompt)
local RenameOutfitPrompt = require(Prompts.RenameOutfitPrompt)
local UpdateOutfitPrompt = require(Prompts.UpdateOutfitPrompt)

local LocalPlayer = Players.LocalPlayer

local scriptParentParent = script.Parent.Parent

local PromptType = require(scriptParentParent.PromptType)

local ScreenSizeUpdated = require(scriptParentParent.Actions.ScreenSizeUpdated)

local tbl1 = {
    [Enum.UserInputType.Gamepad1] = true,
    [Enum.UserInputType.Gamepad2] = true,
    [Enum.UserInputType.Gamepad3] = true,
    [Enum.UserInputType.Gamepad4] = true,
    [Enum.UserInputType.Gamepad5] = true,
    [Enum.UserInputType.Gamepad6] = true,
    [Enum.UserInputType.Gamepad7] = true,
    [Enum.UserInputType.Gamepad8] = true
}

local tbl2 = {
    [PromptType.AllowInventoryReadAccess] = AllowInventoryReadAccessPrompt,
    [PromptType.SaveAvatar] = SaveAvatarPrompt,
    [PromptType.CreateOutfit] = CreateOutfitPrompt,
    [PromptType.EnterOutfitName] = EnterOutfitNamePrompt,
    [PromptType.SetFavorite] = SetFavoritePrompt,
    [PromptType.DeleteOutfit] = DeleteOutfitPrompt,
    [PromptType.RenameOutfit] = RenameOutfitPrompt,
    [PromptType.UpdateOutfit] = UpdateOutfitPrompt,
    [PromptType.SaveAvatarTimeout] = SaveAvatarTimeoutPrompt
}

local var1 = Roact.PureComponent:extend("AvatarEditorPromptsApp")

var1.validateProps = t.strictInterface({ promptType = t.optional(t.userdata), screenSizeUpdated = t.callback })

function var1.init(arg1)
    arg1:setState({ isGamepad = tbl1[UserInputService:GetLastInputType()] or false })

    function arg1.absoluteSizeChanged(arg2)
        arg1.props.screenSizeUpdated(arg2.AbsoluteSize)
    end

    arg1.focusController = RoactGamepad.createFocusController()

    arg1.selectedCoreGuiObject = nil
    arg1.selectedGuiObject = nil
end

function var1.render(arg1)
    local element = nil
    if arg1.props.promptType then
        local var2 = tbl2[arg1.props.promptType]
        if var2 then
            element = Roact.createElement(var2)
        else
            error("Unexpected prompt type!")
        end
    end

    if element == nil then
        return nil
    end

    local createElement = Roact.createElement
    local tbl3 = {
        IgnoreGuiInset = true,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        AutoLocalize = false,
        DisplayOrder = -1,
        [Roact.Change.AbsoluteSize] = arg1.absoluteSizeChanged
    }

    return (createElement("ScreenGui", tbl3, {
        Connection = Roact.createElement(Connection),
        LastInputTypeConnection = Roact.createElement(ExternalEventConnection, {
            event = UserInputService.LastInputTypeChanged,
            callback = function(arg2)
                arg1:setState({ isGamepad = tbl1[arg2] or false })
            end
        }) or nil,
        PromptFrame = Roact.createElement(
            RoactGamepad.Focusable.Frame,
            {
                focusController = arg1.focusController,
                BackgroundTransparency = 1,
                Size = UDim2.fromScale(1, 1)
            },
            { Prompt = element }
        )
            or nil
    }))
end

function var1.revertSelectedGuiObject(arg1)
    local var2 = LocalPlayer and LocalPlayer:FindFirstChildWhichIsA("PlayerGui")

    if arg1.selectedCoreGuiObject and arg1.selectedCoreGuiObject:IsDescendantOf(CoreGui) then
        GuiService.SelectedCoreObject = arg1.selectedCoreGuiObject
    elseif arg1.selectedGuiObject and arg1.selectedGuiObject:IsDescendantOf(var2) then
        GuiService.SelectedObject = arg1.selectedGuiObject
        GuiService.SelectedCoreObject = nil
    else
        GuiService.SelectedCoreObject = nil
    end

    arg1.selectedCoreGuiObject = nil
    arg1.selectedGuiObject = nil
end

function var1.didUpdate(arg1, arg2, arg3)
    local var2 = arg1.state.isGamepad and arg1.props.promptType ~= nil
    if var2 == (arg3.isGamepad and arg2.promptType ~= nil) then
        return
    end

    if var2 then
        arg1.selectedCoreGuiObject = GuiService.SelectedCoreObject
        arg1.selectedGuiObject = GuiService.SelectedObject
        GuiService.SelectedObject = nil
        arg1.focusController.captureFocus()
        return
    end
    arg1.focusController.releaseFocus()
    if arg1.state.isGamepad then
        arg1:revertSelectedGuiObject()
    end
end

function var1.willUnmount(arg1)
    if arg1.state.isGamepad then
        arg1:revertSelectedGuiObject()
    end
end

return RoactRodux.connect(function(arg1) -- name: mapStateToProps
    return {
        promptType = arg1.promptInfo.promptType
    }
end, function(arg1) -- name: mapDispatchToProps
    return {
        screenSizeUpdated = function(arg2)
            return arg1(ScreenSizeUpdated(arg2))
        end
    }
end)(var1)
