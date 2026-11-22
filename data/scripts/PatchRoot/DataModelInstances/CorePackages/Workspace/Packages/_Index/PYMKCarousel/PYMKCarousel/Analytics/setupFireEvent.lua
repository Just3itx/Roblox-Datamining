-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T13:21:17Z
-- Luau bytecode version: 14 | Luau type version: 3
local scriptParentParent = script.Parent.Parent
local SocialLuaAnalytics = require(scriptParentParent.dependencies).SocialLuaAnalytics

local DiagActionList = require(script.Parent.DiagActionList)
local EventStreamActionList = require(script.Parent.EventStreamActionList)
return SocialLuaAnalytics.Analytics.FireEvent.createFireEvent({ EventStream = EventStreamActionList, Diag = DiagActionList })
