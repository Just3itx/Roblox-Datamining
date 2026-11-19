-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:51:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local GuiService = game:GetService("GuiService")

local AbuseReportMenu = script:FindFirstAncestor("AbuseReportMenu")
local CorePackages = game:GetService("CorePackages")

local Roact = require(CorePackages.Packages.Roact)

local Constants = require(AbuseReportMenu.Components.Constants)
local ModalBaseSelectorDialog = require(AbuseReportMenu.Components.ModalBaseSelectorDialog)

local FFlagHideShortcutsOnReportDropdown = require(AbuseReportMenu.Flags.FFlagHideShortcutsOnReportDropdown)

local isInExperienceUIVREnabled = require(CorePackages.Workspace.Packages.SharedExperimentDefinition).isInExperienceUIVREnabled

local isSpatial = nil
local UIManager = nil
local PanelType = nil
if isInExperienceUIVREnabled then
    isSpatial = require(CorePackages.Workspace.Packages.AppCommonLib).isSpatial

    local vrSpatialUi = require(CorePackages.Workspace.Packages.VrSpatialUi)
    UIManager = vrSpatialUi.UIManager
    PanelType = vrSpatialUi.Constants.PanelType
end

local tbl1 = { modalSelectorHandle = nil, modalSelectorFrame = nil, modalSelectorScreenGui = nil }

return {
    mountModalSelector = function(viewportHeight, viewportWidth, cellData, onSelect, onClose, callback)
        local vector2, _vector2 = GuiService:GetGuiInset()
        if isInExperienceUIVREnabled and isSpatial() then
            local panelObject = UIManager.getInstance():getPanelObject(PanelType.MoreMenu)
            local frame = Instance.new("Frame")
            frame.BackgroundTransparency = 1
            frame.Position = UDim2.new(0, 0, 0, 0)
            frame.Size = UDim2.new(1, 0, 1, 0)
            frame.ZIndex = 10
            frame.Parent = panelObject
            tbl1.modalSelectorFrame = frame
        elseif not tbl1.modalSelectorScreenGui then
            local modalSelectorDialogGui = Instance.new("ScreenGui")
            modalSelectorDialogGui.Name = "ModalSelectorDialogGui"
            modalSelectorDialogGui.DisplayOrder = 7
            modalSelectorDialogGui.Enabled = true
            modalSelectorDialogGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
            modalSelectorDialogGui.Parent = CoreGui:FindFirstChild(Constants.AbuseReportMenuPlaceholderFrame, true)

            tbl1.modalSelectorScreenGui = modalSelectorDialogGui

            local frame = Instance.new("Frame")
            frame.BackgroundTransparency = 1
            frame.Position = UDim2.new(0, 0, 0, -vector2.Y)
            frame.Size = UDim2.new(1, 0, 1, vector2.Y)
            frame.Parent = tbl1.modalSelectorScreenGui

            tbl1.modalSelectorFrame = frame
        end

        if FFlagHideShortcutsOnReportDropdown and callback ~= nil then
            callback()
        end

        local element = Roact.createElement(ModalBaseSelectorDialog, {
            isShown = true,
            cellData = cellData,
            viewportHeight = viewportHeight,
            viewportWidth = viewportWidth,
            onSelect = onSelect,
            onClose = onClose
        })

        tbl1.modalSelectorHandle = Roact.mount(element, tbl1.modalSelectorFrame, "ModalSelectorDialog")
    end,
    unmountModalSelector = function()
        if tbl1.modalSelectorHandle ~= nil then
            Roact.unmount(tbl1.modalSelectorHandle)
            tbl1.modalSelectorHandle = nil
        end

        if isInExperienceUIVREnabled then
            if tbl1.modalSelectorFrame ~= nil then
                tbl1.modalSelectorFrame.Parent = nil
                tbl1.modalSelectorFrame = nil
            end

            if tbl1.modalSelectorScreenGui ~= nil then
                tbl1.modalSelectorScreenGui = nil
            end
        elseif tbl1.modalSelectorScreenGui ~= nil then
            tbl1.modalSelectorFrame.Parent = nil
            tbl1.modalSelectorFrame = nil
            tbl1.modalSelectorScreenGui = nil
        end
    end
}
