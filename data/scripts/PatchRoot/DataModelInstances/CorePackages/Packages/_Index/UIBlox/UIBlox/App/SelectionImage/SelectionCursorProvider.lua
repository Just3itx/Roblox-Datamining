-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:51:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent

local Roact = require(scriptParentParentParentParent.Roact)
local RoactGamepad = require(scriptParentParentParentParent.RoactGamepad)
local Cryo = require(scriptParentParentParentParent.Cryo)

local CursorKind = require(script.Parent.CursorKind)
local SelectionImageContext = require(script.Parent.SelectionImageContext)
local OnRootedListener = require(script.Parent.OnRootedListener)
local GuiService = game:GetService("GuiService")
local CoreGui = game:GetService("CoreGui")

local var1 = Roact.PureComponent:extend("SelectionCursorProvider")

function var1.init(arg1)
    arg1.ref = Roact.createRef()
    arg1.refs = RoactGamepad.createRefCache()
    arg1.state = {
        mountedCursors = {},
        currentSelection = nil,
        currentCoreSelection = nil
    }

    function arg1.getSelectionCursor(arg2)
        local var2 = CursorKind.isEnumValue(arg2)
        local str1 = tostring(arg2)
        assert(var2, ("Invalid arg #1: expected a CursorKind enum variant, got %s"):format(str1))

        warn("UIBlox's SelectionCursor is deprecated and should not be used anymore.")

        if arg1.state.mountedCursors[arg2] == nil then
            arg1:setState(function(arg3)
                return {
                    mountedCursors = Cryo.Dictionary.join(arg3.mountedCursors, { [arg2] = true })
                }
            end)
        end

        return arg1.refs[arg2]
    end

    function arg1.initSelectionChangedListener(arg2)
        if arg2 == nil then
            return
        end

        if arg1.coreSelectionListener ~= nil then
            arg1.coreSelectionListener:Disconnect()
            arg1.coreSelectionListener = nil
        end
        if arg1.selectionListener ~= nil then
            arg1.selectionListener:Disconnect()
            arg1.selectionListener = nil
        end

        if arg2:IsDescendantOf(CoreGui) then
            arg1.coreSelectionListener = GuiService:GetPropertyChangedSignal("SelectedCoreObject"):Connect(function()
                if arg1.state.currentCoreSelection == nil
                    or GuiService.SelectedCoreObject == nil
                    or arg1.state.currentCoreSelection.SelectionImageObject ~= GuiService.SelectedCoreObject.SelectionImageObject
                then
                    arg1:setState({ currentCoreSelection = GuiService.SelectedCoreObject })
                end
            end)

            return
        end

        arg1.selectionListener = GuiService:GetPropertyChangedSignal("SelectedObject"):Connect(function()
            if arg1.state.currentSelection == nil
                or GuiService.SelectedObject == nil
                or arg1.state.currentSelection.SelectionImageObject ~= GuiService.SelectedObject.SelectionImageObject
            then
                arg1:setState({ currentSelection = GuiService.SelectedObject })
            end
        end)
    end
end

function var1.didMount(arg1)
    arg1.initSelectionChangedListener(arg1.ref:getValue())
end

function var1.willUnmount(arg1)
    if arg1.coreSelectionListener ~= nil then
        arg1.coreSelectionListener:Disconnect()
        arg1.coreSelectionListener = nil
    end
    if arg1.selectionListener ~= nil then
        arg1.selectionListener:Disconnect()
        arg1.selectionListener = nil
    end
end

function var1.render(arg1)
    local tbl1 = ({})
    for k, _ in pairs(arg1.state.mountedCursors) do
        local var2 = k.rawValue()
        local str1 = tostring(var2)

        local isVisible = arg1.refs[k] ~= nil
            and (arg1.state.currentSelection ~= nil and arg1.refs[k].current == arg1.state.currentSelection.SelectionImageObject
                or arg1.state.currentCoreSelection ~= nil and arg1.refs[k].current == arg1.state.currentCoreSelection.SelectionImageObject)

        tbl1[str1] = Roact.createElement(var2, { isVisible = isVisible, cursorRef = arg1.refs[k] })
    end

    return Roact.createElement(SelectionImageContext.Provider, {
        value = arg1.getSelectionCursor
    }, {
        CursorContainer = Roact.createElement("Frame", { Size = UDim2.new(0, 0, 0, 0), Visible = false }, tbl1),
        OnRootedListener = Roact.createElement(OnRootedListener, { onRooted = arg1.initSelectionChangedListener }),
        Children = Roact.createFragment(arg1.props[Roact.Children])
    })
end

return var1
