-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T05:41:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local GuiService = game:GetService("GuiService")
local getInstanceProperties = require(script.Parent.getInstanceProperties)

local function hasGuiBase2dChildren(arg1)
    if arg1 == nil then
        return false
    end

    for _, child in arg1:GetChildren() do
        if child:IsA("GuiBase2d") then
            return true
        end

        if hasGuiBase2dChildren(child) then
            return true
        end
    end

    return false
end

local function getDataModelNode(arg1, tbl1)
    if arg1 == nil then
        return nil
    end

    local isFolder = arg1:IsA("Folder")
    local isGuiBase2d = arg1:IsA("GuiBase2d")

    if not (isFolder or isGuiBase2d) then
        return nil
    end

    if isFolder and not hasGuiBase2dChildren(arg1) then
        return nil
    end

    local children = {}
    for _, child in arg1:GetChildren() do
        local dataModelNode = getDataModelNode(child, tbl1)
        if dataModelNode ~= nil then
            table.insert(children, dataModelNode)
        end
    end

    return {
        Children = children,
        Properties = getInstanceProperties(arg1, tbl1)
    }
end

local function getDataModelRoot(tbl1)
    local currentCamera = game.Workspace.CurrentCamera
    local viewport = currentCamera and { currentCamera.ViewportSize.X, currentCamera.ViewportSize.Y } or { 0, 0 }

    local children = {}
    for _, child in CoreGui:GetChildren() do
        local dataModelNode = getDataModelNode(child, tbl1)
        if dataModelNode ~= nil then
            table.insert(children, dataModelNode)
        end
    end

    local vector2, vector2_2 = GuiService:GetGuiInset()
    return {
        Children = children,
        Properties = {
            Viewport = viewport,
            Name = "CoreGui",
            GuiInset = {
                vector2.X,
                vector2.Y,
                vector2_2.X,
                vector2_2.Y
            }
        }
    }
end
return getDataModelRoot
