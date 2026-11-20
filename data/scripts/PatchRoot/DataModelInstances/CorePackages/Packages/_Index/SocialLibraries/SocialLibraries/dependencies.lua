-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:51:21Z
-- Luau bytecode version: 14 | Luau type version: 3
local scriptParentParent = script.Parent.Parent
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local UIBlox = require(scriptParentParent.UIBlox)
local RoduxPresence = require(scriptParentParent.RoduxPresence)
local RoduxFriends = require(scriptParentParent.RoduxFriends)

return {
    Roact = require(scriptParentParent.Roact),
    React = require(scriptParentParent.React),
    UIBlox = UIBlox,
    Foundation = require(scriptParentParent.Foundation),
    RoactFitComponents = require(scriptParentParent.RoactFitComponents),
    GenericPagination = require(scriptParentParent.GenericPagination),
    Cryo = require(scriptParentParent.Cryo),
    RoactNavigation = require(scriptParentParent.RoactNavigation),
    Rodux = require(scriptParentParent.Rodux),
    Lumberyak = require(scriptParentParent.Lumberyak),
    tutils = require(scriptParentParent.tutils),
    t = require(scriptParentParent.t),
    Promise = require(scriptParentParent.Promise),
    Symbol = require(scriptParentParent.Symbol),
    LuauPolyfill = require(scriptParentParent.LuauPolyfill),
    Otter = require(scriptParentParent.Otter),
    llama = require(scriptParentParent.llama),
    RoduxPresence = RoduxPresence.config({ keyPath = "SocialLibraries.Presence" }),
    RoduxFriends = RoduxFriends.config({ keyPath = "SocialLibraries.Friends" }),
    enumerate = require(scriptParentParent.enumerate),
    Players = Players,
    UserInputService = UserInputService,
    Text = require(script.Parent.temp.Text),
    UserModel = require(script.Parent.temp.User)
}
