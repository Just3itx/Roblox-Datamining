-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T21:31:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SplitPaneParent = script:FindFirstAncestor("SplitPane").Parent

local GuiService = game:GetService("GuiService")

local React = require(SplitPaneParent.React)
local SignalsReact = require(SplitPaneParent.SignalsReact)
local SplitPaneStore = require(script.Parent.Parent.Stores.SplitPaneStore)

local FocusNavigationUtils = require(SplitPaneParent.FocusNavigationUtils)
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum
local useRegistryEntry = FocusNavigationUtils.FocusNavigableSurfaceRegistry.useRegistryEntry

local function getSelectionGroupRowContainer(guiObject: GuiObject)
    local guiObjectParent = guiObject.Parent
    while guiObjectParent ~= nil do
        if guiObjectParent:IsA("ScrollingFrame") then
            return guiObjectParent
        end
        if guiObjectParent:IsA("GuiObject") and guiObjectParent.SelectionGroup then
            return guiObjectParent
        end
        guiObjectParent = guiObjectParent.Parent
    end

    return nil
end

local function getRowBandContainer(guiObject: GuiObject, current)
    local absolutePositionY = guiObject.AbsolutePosition.Y
    local num1 = absolutePositionY + guiObject.AbsoluteSize.Y
    local absoluteSizeY = guiObject.AbsoluteSize.Y

    local guiObjectParent = guiObject.Parent
    local var1 = nil

    while guiObjectParent ~= nil and guiObjectParent ~= current and guiObjectParent:IsA("GuiObject") do
        local absolutePositionY2 = guiObjectParent.AbsolutePosition.Y
        local num2 = absolutePositionY2 + guiObjectParent.AbsoluteSize.Y
        if absolutePositionY2 < absolutePositionY - absoluteSizeY or num1 + absoluteSizeY < num2 then
            break
        end

        local guiObjectParentParent = guiObjectParent.Parent
        var1 = guiObjectParent
        guiObjectParent = guiObjectParentParent
    end
    return var1
end

local function getFocusRowContainer(guiObject: GuiObject, arg1: Instance, current) -- Luacid: Inlined by compiler; 1 call site recovered
    if arg1 ~= nil and guiObject:IsDescendantOf(arg1) then
        return arg1
    elseif guiObject:FindFirstAncestorWhichIsA("ScrollingFrame") ~= nil then
        return (getSelectionGroupRowContainer(guiObject))
    end

    return (getRowBandContainer(guiObject, current))
end

local function hasSelectableToTheRight(selectedCoreObject: GuiObject, focusRowContainer)
    local absolutePositionX = selectedCoreObject.AbsolutePosition.X
    local absolutePositionY = selectedCoreObject.AbsolutePosition.Y
    local var1 = absolutePositionY + selectedCoreObject.AbsoluteSize.Y

    for _, descendant in focusRowContainer:GetDescendants() do
        if descendant == selectedCoreObject or not (descendant:IsA("GuiObject") and descendant.Selectable and descendant.Visible) then
            continue
        end

        local absolutePositionX2 = descendant.AbsolutePosition.X
        local absolutePositionY2 = descendant.AbsolutePosition.Y
        local bool1 = absolutePositionY < absolutePositionY2 + descendant.AbsoluteSize.Y and absolutePositionY2 < var1

        if bool1 and absolutePositionX + 2 < absolutePositionX2 then
            return true
        end
    end

    return false
end

local function useSplitPaneFocusNavBridge(arg1)
    local store = SplitPaneStore.getStore()
    local var1 = SignalsReact.useSignalState(store.getSupportPaneEntryTarget)

    local var2 = useRegistryEntry(FocusNavigableSurfaceIdentifierEnum.HeaderView)

    local var3 = React.useRef(nil)

    React.useEffect(function()
        local function clearOverride() -- Luacid: Inlined by compiler; 4 call sites recovered
            local current = var3.current
            if current == nil then
                return
            end
            if current.object.NextSelectionRight == current.target then
                current.object.NextSelectionRight = nil
            end
            var3.current = nil
        end

        local function onSelectedCoreObjectChanged()
            local isSplitEnabled = store.getIsSplitEnabled(false)
            local current = arg1.current
            local selectedCoreObject = GuiService.SelectedCoreObject

            if not isSplitEnabled
                or selectedCoreObject == nil
                or current == nil
                or var1 == nil
                or not selectedCoreObject:IsDescendantOf(current)
            then
                clearOverride()
                return
            end

            local focusRowContainer = getFocusRowContainer(selectedCoreObject, var2, current)

            if focusRowContainer == nil or hasSelectableToTheRight(selectedCoreObject, focusRowContainer) then
                clearOverride()
                return
            end

            local current2 = var3.current
            if current2 ~= nil and current2.object ~= selectedCoreObject then
                clearOverride()
            end

            if selectedCoreObject.NextSelectionRight ~= nil then
                return
            end

            selectedCoreObject.NextSelectionRight = var1
            var3.current = { object = selectedCoreObject, target = var1 }
        end
        onSelectedCoreObjectChanged()
        local connection = GuiService:GetPropertyChangedSignal("SelectedCoreObject"):Connect(onSelectedCoreObjectChanged)

        return function()
            connection:Disconnect()
            clearOverride()
        end
    end, { var2, var1, arg1 })
end

return useSplitPaneFocusNavBridge
