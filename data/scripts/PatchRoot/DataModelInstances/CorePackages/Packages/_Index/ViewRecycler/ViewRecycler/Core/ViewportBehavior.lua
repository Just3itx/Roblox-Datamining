-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:21:08Z
-- Luau bytecode version: 14 | Luau type version: 3
local FFlagViewRecyclerReact084 = require(script:FindFirstAncestor("ViewRecycler").Flags).FFlagViewRecyclerReact084
local FFlagViewRecyclerReact08 = require(script:FindFirstAncestor("ViewRecycler").Flags).FFlagViewRecyclerReact08

local AutoScroll = require(script.AutoScroll)
local ChatPreset = require(script.ChatPreset)
local PaginationEdges = require(script.PaginationEdges)
local ReachedThreshold = require(script.ReachedThreshold)

local InitialScrollPosition = require(script.InitialScrollPosition)
local ScrollPolicy = require(script.ScrollPolicy)

local tbl1 = {
    ChatPreset = ChatPreset,
    PaginationEdges = PaginationEdges,
    ReachedThreshold = ReachedThreshold,
    AutoScroll = 0,
    createInitialScrollPosition = 0,
    createScrollPolicy = 0
}
if FFlagViewRecyclerReact084 or FFlagViewRecyclerReact08 then
    AutoScroll = nil
end

tbl1.AutoScroll = AutoScroll
if FFlagViewRecyclerReact084 or FFlagViewRecyclerReact08 then
    InitialScrollPosition = nil
end

tbl1.createInitialScrollPosition = InitialScrollPosition

if FFlagViewRecyclerReact084 or FFlagViewRecyclerReact08 then
    ScrollPolicy = nil
end

tbl1.createScrollPolicy = ScrollPolicy
return tbl1
