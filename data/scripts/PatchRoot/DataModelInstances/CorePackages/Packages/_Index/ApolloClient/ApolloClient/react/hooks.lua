-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T02:11:31Z
-- Luau bytecode version: 14 | Luau type version: 3
local tbl1 = {}
local scriptParentParentParent = script.Parent.Parent.Parent
local Object = require(scriptParentParentParent.LuauPolyfill).Object

local useApolloClient = require(script.useApolloClient)
local useQuery = require(script.useQuery)
local useLazyQuery = require(script.useLazyQuery)
local useMutation = require(script.useMutation)

local useReactiveVar = require(script.useReactiveVar)

Object.assign(tbl1, useApolloClient, useQuery, useLazyQuery, useMutation, useReactiveVar)

return tbl1
