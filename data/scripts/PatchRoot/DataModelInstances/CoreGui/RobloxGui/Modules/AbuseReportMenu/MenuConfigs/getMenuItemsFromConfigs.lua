-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:51:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AbuseReportMenu = script:FindFirstAncestor("AbuseReportMenu")
local CorePackages = game:GetService("CorePackages")
local Foundation = require(CorePackages.Packages.Foundation)
local React = require(CorePackages.Packages.React)
local useLocalization = require(CorePackages.Workspace.Packages.Localization).Hooks.useLocalization

local DropdownReportMenuItem = require(AbuseReportMenu.Components.MenuItems.DropdownReportMenuItem)
local ButtonReportMenuItem = require(AbuseReportMenu.Components.MenuItems.ButtonReportMenuItem)
local FreeCommentsMenuItem = require(AbuseReportMenu.Components.MenuItems.FreeCommentsMenuItem)
local ModalBasedSelectorMenuItem = require(AbuseReportMenu.Components.MenuItems.ModalBasedSelectorMenuItem)
local _Types = require(AbuseReportMenu.Components.Types)
local Constants = require(AbuseReportMenu.Components.Constants)

local ButtonVariant = Foundation.Enums.ButtonVariant

local FFlagHideShortcutsOnReportDropdown = require(AbuseReportMenu.Flags.FFlagHideShortcutsOnReportDropdown)
local FFlagReportFocusNavIEMButtons = require(AbuseReportMenu.Flags.FFlagReportFocusNavIEMButtons)

local function getMenuItemsFromConfigs(arg1, arg2, arg3, tbl1, isSmallPortraitViewport: boolean)
    local menuItemsFromConfigs = ({})
    local var1 = useLocalization(Constants.localizationKeys)

    local onMenuOpenChange = if FFlagHideShortcutsOnReportDropdown then React.useCallback(function(arg4)
        if arg3.onDropdownMenuOpenChange then
            arg3.onDropdownMenuOpenChange(arg4)
        end
    end, { arg3.onDropdownMenuOpenChange }) else nil

    local var3 = if FFlagReportFocusNavIEMButtons then React.useRef(nil) else nil

    if FFlagReportFocusNavIEMButtons then
        React.useEffect(function()
            if arg3.setLastSelectableObjects and var3.current then
                arg3.setLastSelectableObjects({ var3.current })
            end
        end, { var3, arg3.setLastSelectableObjects })
    end

    local tbl2

    if FFlagReportFocusNavIEMButtons then
        tbl2 = {}
        for _, value in tbl1 do
            if value.getIsVisible(arg1) then
                table.insert(tbl2, value)
            end
        end
    else
        tbl2 = tbl1
    end

    for layoutOrder, value2 in tbl2 do
        if not (FFlagReportFocusNavIEMButtons or value2.getIsVisible(arg1)) then
            continue
        end

        local componentType = value2.componentType
        local componentName = value2.componentName
        if componentType == "generic" then
            continue
        end
        if componentType == "freeComments" then
            local createElement = React.createElement
            local var4 = FreeCommentsMenuItem
            local tbl3 = {
                layoutOrder = layoutOrder,
                comment = arg1.comment,
                placeholderText = var1.ReportCommentPlaceholder,
                menuContainerWidth = arg3.menuWidth,
                isSmallPortraitViewport = isSmallPortraitViewport,
                onUpdate = 0,
                ref = 0
            }

            function tbl3.onUpdate(arg4)
                value2.onUpdate(arg4, arg1, arg2, arg3)
            end
            tbl3.ref = if FFlagReportFocusNavIEMButtons then if layoutOrder == #tbl2 then var3 else nil else nil
            menuItemsFromConfigs[componentName] = createElement(var4, tbl3)
        elseif componentType == "button" then
            local iconSrc = value2.getIconSrc(arg3)
            local createElement = React.createElement
            local var4 = ButtonReportMenuItem
            local tbl3 = {
                label = if value2.fieldLabel == "" then value2.fieldLabel else var1[value2.fieldLabel],
                button = 0,
                menuContainerWidth = 0,
                layoutOrder = 0,
                isSmallPortraitViewport = 0
            }
            local createElement2 = React.createElement
            local button = Foundation.Button
            local tbl4 = {
                variant = if value2.variant == "primary" then ButtonVariant.SubEmphasis else ButtonVariant.Subtle,
                text = var1[value2.getButtonLabel(arg3)],
                icon = 0,
                width = 0,
                isDisabled = 0,
                onActivated = 0,
                ref = 0
            }

            if iconSrc == "" then
                iconSrc = nil
            end

            tbl4.icon = iconSrc
            tbl4.width = UDim.new(1, 0)
            tbl4.isDisabled = not (value2.getIsDisabled == nil) and value2.getIsDisabled(arg1, arg3)

            function tbl4.onActivated()
                value2.onClick(arg1, arg2, arg3)
            end
            tbl4.ref = if FFlagReportFocusNavIEMButtons then if layoutOrder == #tbl2 then var3 else nil else nil
            tbl3.button = createElement2(button, tbl4)

            tbl3.menuContainerWidth = arg3.menuWidth
            tbl3.layoutOrder = layoutOrder
            tbl3.isSmallPortraitViewport = isSmallPortraitViewport
            menuItemsFromConfigs[componentName] = createElement(var4, tbl3)
        elseif componentType == "dropdown" then
            local createElement = React.createElement
            local var4 = DropdownReportMenuItem
            local tbl3 = {
                label = var1[value2.fieldLabel],
                placeholderText = var1.ChooseOne,
                layoutOrder = layoutOrder,
                onSelect = 0,
                onMenuOpenChange = 0,
                menuContainerWidth = 0,
                readonlyValue = 0,
                selections = 0,
                isSmallPortraitViewport = 0,
                minHeight = 0,
                ref = 0
            }

            function tbl3.onSelect(arg4)
                value2.onUpdateSelectedOption(arg4, arg1, arg2, arg3)
            end
            tbl3.onMenuOpenChange = onMenuOpenChange
            tbl3.menuContainerWidth = arg3.menuWidth
            tbl3.readonlyValue = var1[value2.readonlyValue]
            tbl3.selections = value2.getMenuItems(arg1)
            tbl3.isSmallPortraitViewport = isSmallPortraitViewport
            tbl3.minHeight = if isSmallPortraitViewport then 0 else Constants.MenuItemHeight
            tbl3.ref = if FFlagReportFocusNavIEMButtons then if layoutOrder == #tbl2 then var3 else nil else nil
            menuItemsFromConfigs[componentName] = createElement(var4, tbl3)
        elseif componentType == "modalSelector" then
            local createElement = React.createElement
            local var4 = ModalBasedSelectorMenuItem
            local tbl3 = {
                label = var1[value2.fieldLabel],
                layoutOrder = layoutOrder,
                onSelect = 0,
                onMenuOpenChange = 0,
                menuContainerWidth = 0,
                selectorHeight = 0,
                selectedValue = 0,
                selections = 0,
                viewportHeight = 0,
                viewportWidth = 0,
                isSmallPortraitViewport = 0,
                placeholderText = 0,
                ref = 0
            }

            function tbl3.onSelect(label, subLabel, identifier)
                value2.onUpdateSelectedOption({ label = label, subLabel = subLabel, identifier = identifier }, arg1, arg2, arg3)
            end
            tbl3.onMenuOpenChange = onMenuOpenChange
            tbl3.menuContainerWidth = arg3.menuWidth
            tbl3.selectorHeight = Constants.MenuItemHeight
            tbl3.selectedValue = if value2.getSelectedValue then var1[value2.getSelectedValue(arg1)] or value2.getSelectedValue(arg1) or nil else nil

            tbl3.selections = value2.getMenuItems(arg1, var1)
            tbl3.viewportHeight = arg3.viewportDimension.height
            tbl3.viewportWidth = arg3.viewportDimension.width
            tbl3.isSmallPortraitViewport = isSmallPortraitViewport
            tbl3.placeholderText = var1.ChooseOne
            tbl3.ref = if FFlagReportFocusNavIEMButtons then if layoutOrder == #tbl2 then var3 else nil else nil
            menuItemsFromConfigs[componentName] = createElement(var4, tbl3)
        end
    end

    return menuItemsFromConfigs
end

return getMenuItemsFromConfigs
