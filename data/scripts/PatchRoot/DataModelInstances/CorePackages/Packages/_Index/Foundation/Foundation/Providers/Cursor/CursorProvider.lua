-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T09:50:45Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local CoreGui = require(Foundation.Utility.Wrappers).Services.CoreGui
local GuiService = require(Foundation.Utility.Wrappers).Services.GuiService

local Dash = require(FoundationParent.Dash)
local React = require(FoundationParent.React)
local useRefCache = require(FoundationParent.ReactUtils).useRefCache
local isPluginSecurity = require(Foundation.Utility.isPluginSecurity)

local Cursor = require(script.Parent.Cursors.Cursor)
local CursorComponent = require(script.Parent.CursorComponent)
local CursorContext = require(script.Parent.CursorContext)
local _CursorType = require(Foundation.Enums.CursorType)
local KeyUtilities = require(script.Parent.KeyUtilities)

local _ColorNamespace = require(Foundation.Enums.ColorNamespace)

local _Types = require(Foundation.Components.Types)
local useTokens = require(Foundation.Providers.Style.useTokens)

local function CursorProvider(tbl1)
    local var1, setMountedCursors = React.useState({})
    local ref = React.useRef(nil)
    local var4, var5 = React.useState(nil)
    local refCache = useRefCache()
    local var7 = useTokens()

    local value = React.useMemo(function()
        return {
            refCache = refCache,
            setMountedCursors = setMountedCursors,
            getCursor = function(arg1)
                local var8 = KeyUtilities.mapCursorToKey(arg1, var7)

                setMountedCursors(function(arg2)
                    if arg2[var8] == nil then
                        return Dash.union(arg2, { [var8] = true })
                    end

                    return arg2
                end)

                return refCache[var8]
            end
        }
    end, { refCache, setMountedCursors, var7 })

    local function func1()
        local result = ({})

        for value, _ in var1 do
            local isVisible = not (refCache[value] == nil or var4 == nil) and refCache[value].current == var4
            local tbl2 = string.split(value, " ")
            if #tbl2 == 2 then
                local cursorType, colorNamespace = KeyUtilities.decodeCursorTypeKey(tbl2)

                local createElement = React.createElement
                local var11 = Cursor
                local tbl3 = {
                    ref = refCache[value],
                    isVisible = isVisible,
                    cursorType = cursorType,
                    colorNamespace = colorNamespace
                }
                result[value] = createElement(var11, tbl3)
            else
                local cornerRadius, offset, borderWidth, colorNamespace = KeyUtilities.decodeKey(tbl2)

                local createElement = React.createElement
                local var13 = CursorComponent
                local tbl3 = {
                    ref = refCache[value],
                    isVisible = isVisible,
                    cornerRadius = cornerRadius,
                    offset = offset,
                    borderWidth = borderWidth,
                    colorNamespace = colorNamespace
                }
                result[value] = createElement(var13, tbl3)
            end
        end

        return result
    end

    React.useEffect(function()
        if ref.current == nil or not game:IsAncestorOf(ref.current) then
            return
        end

        local isDescendantOf = isPluginSecurity() and ref.current:IsDescendantOf(CoreGui)

        local function setUpSelectionImageObjectConnection()
            if isDescendantOf then
                return GuiService:GetPropertyChangedSignal("SelectedCoreObject"):Connect(function()
                    if GuiService.SelectedCoreObject == nil then
                        var5(nil)
                        return
                    end
                    var5(GuiService.SelectedCoreObject.SelectionImageObject)
                end)
            end

            return GuiService:GetPropertyChangedSignal("SelectedObject"):Connect(function()
                if GuiService.SelectedObject == nil then
                    var5(nil)
                    return
                end
                var5(GuiService.SelectedObject.SelectionImageObject)
            end)
        end

        local var9 = setUpSelectionImageObjectConnection()
        local connection = ref.current.AncestryChanged:Connect(function()
            var9:Disconnect()
            var9 = setUpSelectionImageObjectConnection()
        end)

        return function()
            var9:Disconnect()
            connection:Disconnect()
        end
    end, {})

    return React.createElement(CursorContext.Provider, { value = value }, {
        Children = React.createElement(React.Fragment, {}, tbl1.children),
        FoundationCursorContainer = React.createElement("Frame", { Size = UDim2.new(0, 0, 0, 0), Visible = false, ref = ref }, (func1()))
    })
end

return CursorProvider
