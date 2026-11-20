-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:01:04Z
-- Luau bytecode version: 14 | Luau type version: 3
local scriptParent = script.Parent

local React = require(scriptParent.React)
local ReactRoblox = require(scriptParent.ReactRoblox)
local Shared = require(scriptParent.Shared)

local RoactTree = require(script.RoactTree)

return {
    Component = React.Component,
    PureComponent = React.PureComponent,
    createElement = React.createElement,
    createRef = React.createRef,
    forwardRef = React.forwardRef,
    createContext = React.createContext,
    None = React.None,
    mount = RoactTree.mount,
    update = RoactTree.update,
    unmount = RoactTree.unmount,
    createFragment = require(script.createFragment),
    oneChild = require(script.oneChild),
    setGlobalConfig = require(script.setGlobalConfig),
    Portal = require(script.Portal),
    Ref = "ref",
    Children = "children",
    Event = Shared.Event,
    Change = Shared.Change,
    createBinding = React.createBinding,
    joinBindings = React.joinBindings,
    act = ReactRoblox.act
}
