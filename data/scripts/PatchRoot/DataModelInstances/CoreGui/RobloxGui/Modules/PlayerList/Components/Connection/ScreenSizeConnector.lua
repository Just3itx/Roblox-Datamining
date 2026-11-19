-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:50:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)

local scriptParentParentParent = script.Parent.Parent.Parent

local SetScreenSize = require(scriptParentParentParent.Actions.SetScreenSize)

local EventConnection = require(script.Parent.EventConnection)

local var1 = Roact.PureComponent:extend("ScreenSizeConnector")

function var1.init(arg1)
    arg1.state = { layerCollector = nil }

    arg1.folderRef = Roact.createRef()
end

function var1.render(arg1)
    if not arg1.state.layerCollector then
        return Roact.createElement("Folder", { [Roact.Ref] = arg1.folderRef })
    end

    local absoluteSize = arg1.state.layerCollector.AbsoluteSize
    arg1.props.setScreenSize(absoluteSize.X, absoluteSize.Y)
    return Roact.createElement(EventConnection, {
        event = arg1.state.layerCollector:GetPropertyChangedSignal("AbsoluteSize"),
        callback = function()
            absoluteSize = arg1.state.layerCollector.AbsoluteSize
            arg1.props.setScreenSize(absoluteSize.X, absoluteSize.Y)
        end
    })
end

function var1.watchFolderAncestery(arg1)
    if not arg1.folderRef.current or arg1.ancesteryConnection ~= nil then
        return
    end

    local layerCollector = arg1.folderRef.current:FindFirstAncestorWhichIsA("LayerCollector")
    if layerCollector then
        arg1:setState({ layerCollector = layerCollector })
        return
    end

    arg1.ancesteryConnection = arg1.folderRef.current.AncestryChanged:Connect(function()
        layerCollector = arg1.folderRef.current and arg1.folderRef.current:FindFirstAncestorWhichIsA("LayerCollector")

        if layerCollector then
            arg1:setState({ layerCollector = layerCollector })
        end
    end)
end

function var1.didMount(arg1)
    arg1:watchFolderAncestery()
end

function var1.didUpdate(arg1)
    if not arg1.state.layerCollector then
        arg1:watchFolderAncestery()
    elseif arg1.ancesteryConnection then
        arg1.ancesteryConnection:Disconnect()
        arg1.ancesteryConnection = nil
    end
end

function var1.willUnmount(arg1)
    if arg1.ancesteryConnection then
        arg1.ancesteryConnection:Disconnect()
        arg1.ancesteryConnection = nil
    end
end

return RoactRodux.connect(nil, function(arg1) -- name: mapDispatchToProps
    return {
        setScreenSize = function(arg2, arg3)
            return arg1(SetScreenSize(arg2, arg3))
        end
    }
end)(var1)
